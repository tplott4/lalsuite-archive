/*
 * Stripped together and modified from ComputeFStat.c in LAL
 * by Bernd Machenschalk for Einstein@Home
 * $Id$
 */

/* current EAH_OPTIMIZATION codes are
   0: "original" version from LAL
   1: Auto-vectorizing common-denominator loop
   2: "mixed" (common-denominator / reciprocal estimate) vectorized AltiVec version
   3: x86 Assembler-coded SSE hot-loop
*/

#ifndef EAH_OPTIMIZATION
#define EAH_OPTIMIZATION 0
#endif

/*---------- INCLUDES ----------*/
#define __USE_ISOC99 1
#include <math.h>

#include <lal/ExtrapolatePulsarSpins.h>

/* GSL includes */
#include <lal/LALGSL.h>
#include <gsl/gsl_vector.h>
#include <gsl/gsl_matrix.h>
#include <gsl/gsl_blas.h>
#include <gsl/gsl_permutation.h>
#include <gsl/gsl_linalg.h>


#include <lal/AVFactories.h>
#include <lal/ComputeFstat.h>

NRCSID( LOCALCOMPUTEFSTATC, "$Id$");

/*---------- local DEFINES ----------*/
#define TRUE (1==1)
#define FALSE (1==0)

#define LD_SMALL4       (1.0e-6)		/**< "small" number for REAL4*/ 
#define OOTWOPI         (1.0 / LAL_TWOPI)	/**< 1/2pi */

#define TWOPI_FLOAT     6.28318530717958f  	/**< single-precision 2*pi */
#define OOTWOPI_FLOAT   (1.0f / TWOPI_FLOAT)	/**< single-precision 1 / (2pi) */ 


/*---------- optimization dependant switches ----------*/

/* probably the fastest version on all platforms */
#define local_sin_cos_2PI_LUT local_sin_cos_2PI_LUT_7tab

/* definitely fastest on PowerPC */
#if (EAH_OPTIMIZATION == 2)
#define SINCOS_FLOOR
#endif


/*----- Macros ----- */
/** convert GPS-time to REAL8 */
#define GPS2REAL8(gps) (1.0 * (gps).gpsSeconds + 1.e-9 * (gps).gpsNanoSeconds )

#define MYSIGN(x) ( ((x) < 0) ? (-1.0):(+1.0) )

/** Simple Euklidean scalar product for two 3-dim vectors in cartesian coords */
#define SCALAR(u,v) ((u)[0]*(v)[0] + (u)[1]*(v)[1] + (u)[2]*(v)[2])

#define SQ(x) ( (x) * (x) )

/* the way of trimming x to the interval [0..1) gives significant differences
   in speed, so we provide some ways here to use in the sin_cos_LUT functions.
   We also record the way we are using for logging */

#if defined(SINCOS_FLOOR)
#define SINCOS_TRIM_X(y,x) \
  y = x - floor(x);
#define SINCOS_ROUND_METHOD 0

#elif defined(SINCOS_INT4)
#define SINCOS_TRIM_X(y,x) \
  y = x-(INT4)x; \
  if ( y < 0.0 ) { y += 1.0; }
#define SINCOS_ROUND_METHOD 4

#elif defined(SINCOS_INT8)
#define SINCOS_TRIM_X(y,x) \
  y = x-(INT8)x; \
  if ( y < 0.0 ) { y += 1.0; }
#define SINCOS_ROUND_METHOD 8

#else
#define SINCOS_TRIM_X(y,x) \
{ \
  REAL8 dummy; \
  y = modf(x, &dummy); \
  if ( y < 0.0 ) { y += 1.0; } \
}
#define SINCOS_ROUND_METHOD 2
#endif

/*----- SWITCHES -----*/

/*---------- internal types ----------*/

/*---------- Global variables ----------*/
#define NUM_FACT 6
static const REAL8 inv_fact[NUM_FACT] = { 1.0, 1.0, (1.0/2.0), (1.0/6.0), (1.0/24.0), (1.0/120.0) };

/* empty initializers  */
static const LALStatus empty_status;

/*---------- internal prototypes ----------*/
int finite(double x);

void LocalComputeFStat ( LALStatus*, Fcomponents*, const PulsarDopplerParams*,
			 const MultiSFTVector*, const MultiNoiseWeights*,
			 const MultiDetectorStateSeries*, const ComputeFParams*,
			 ComputeFBuffer*);

int LocalXLALComputeFaFb (Fcomponents*, const SFTVector*, const PulsarSpins,
			  const SSBtimes*, const AMCoeffs*, const ComputeFParams*);

int local_sin_cos_LUT (REAL4 *sinx, REAL4 *cosx, REAL8 x); 
int local_sin_cos_2PI_LUT_2tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 x);
int local_sin_cos_2PI_LUT_7tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 x);
int local_sin_cos_2PI_LUT_7R4tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 x);


/*==================== FUNCTION DEFINITIONS ====================*/


/** Function to compute a vector of Fstatistic values for a number of frequency bins.
    This function is simply a wrapper for LocalComputeFstat() which is called repeatedly for
    every frequency value.  The output, i.e. fstatVector must be properly allocated
    before this function is called.  The values of the start frequency, the step size
    in the frequency and the number of frequency values for which the Fstatistic is 
    to be calculated are read from fstatVector.  The other parameters are not checked and 
    they must be correctly set outside this function. 
*/
void LocalComputeFStatFreqBand ( LALStatus *status, 
				 REAL8FrequencySeries *fstatVector, /**< [out] Vector of Fstat values */
				 const PulsarDopplerParams *doppler,/**< parameter-space point to compute F for */
				 const MultiSFTVector *multiSFTs, /**< normalized (by DOUBLE-sided Sn!) data-SFTs of all IFOs */
				 const MultiNoiseWeights *multiWeights,	/**< noise-weights of all SFTs */
				 const MultiDetectorStateSeries *multiDetStates,/**< 'trajectories' of the different IFOs */
				 const ComputeFParams *params	/**< addition computational params */
				 )
{

  UINT4 numDetectors, numBins, k;	
  REAL8 deltaF;
  Fcomponents Fstat;
  PulsarDopplerParams thisPoint;
  ComputeFBuffer cfBuffer = empty_ComputeFBuffer;

  INITSTATUS( status, "LocalComputeFStatFreqBand", LOCALCOMPUTEFSTATC );
  ATTATCHSTATUSPTR (status);

  ASSERT ( multiSFTs, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( doppler, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( multiDetStates, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( params, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );

  numDetectors = multiSFTs->length;
  ASSERT ( multiDetStates->length == numDetectors, status, COMPUTEFSTATC_EINPUT, COMPUTEFSTATC_MSGEINPUT );
  ASSERT ( fstatVector, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( fstatVector->data, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( fstatVector->data->data, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( fstatVector->data->length > 0, status, COMPUTEFSTATC_EINPUT, COMPUTEFSTATC_MSGEINPUT );

  {
    static int first = !0;
    if (first) {
      fprintf(stderr,"\n$Id$ E@HOPT:%d SCTRIM:%d\n",
	      EAH_OPTIMIZATION,SINCOS_ROUND_METHOD);
      first = 0;
    }
  }

  /** something to improve/cleanup -- the start frequency is available both 
      from the fstatvector and from the input doppler point -- they could be inconsistent
      or the user of this function could misunderstand */

  /* copy values from 'doppler' to local variable 'thisPoint' */
  thisPoint = *doppler;

  numBins = fstatVector->data->length;
  deltaF = fstatVector->deltaF;

  /* loop over frequency values and fill up values in fstatVector */
  for ( k = 0; k < numBins; k++) {
 
    TRY (LocalComputeFStat ( status->statusPtr, &Fstat, &thisPoint, multiSFTs, multiWeights, 
			     multiDetStates, params, &cfBuffer ), status);

    fstatVector->data->data[k] = Fstat.F;
      
    thisPoint.fkdot[0] += deltaF;
  }

  XLALEmptyComputeFBuffer ( cfBuffer );

  DETATCHSTATUSPTR (status);
  RETURN (status);

} /* ComputeFStatFreqBand() */




/** Function to compute (multi-IFO) F-statistic for given parameter-space point ::psPoint,
 *  normalized SFT-data (normalized by <em>double-sided</em> PSD Sn), noise-weights
 *  and detector state-series 
 *
 * NOTE: for better efficiency some quantities that need to be recomputed only for different 
 * sky-positions are buffered in \a cfBuffer if given. 
 * - In order to 'empty' this buffer (at the end) use XLALEmptyComputeFBuffer()
 * - You CAN pass NULL for the \a cfBuffer if you don't want to use buffering (slower).
 *
 * NOTE2: there's a spaceholder for binary-pulsar parameters in \a psPoint, but this 
 * it not implemented yet.
 *
 */
void
LocalComputeFStat ( LALStatus *status, 
		    Fcomponents *Fstat,                 /**< [out] Fstatistic + Fa, Fb */
		    const PulsarDopplerParams *doppler, /**< parameter-space point to compute F for */
		    const MultiSFTVector *multiSFTs,    /**< normalized (by DOUBLE-sided Sn!) data-SFTs of all IFOs */
		    const MultiNoiseWeights *multiWeights,/**< noise-weights of all SFTs */
		    const MultiDetectorStateSeries *multiDetStates,/**< 'trajectories' of the different IFOs */
		    const ComputeFParams *params,       /**< addition computational params */
		    ComputeFBuffer *cfBuffer            /**< CF-internal buffering structure */
		    )
{
  Fcomponents retF = empty_Fcomponents;
  UINT4 X, numDetectors;	
  MultiSSBtimes *multiSSB = NULL;
  MultiAMCoeffs *multiAMcoef = NULL;
  REAL8 Ad, Bd, Cd, Dd_inv;

  INITSTATUS( status, "LocalComputeFStat", LOCALCOMPUTEFSTATC );
  ATTATCHSTATUSPTR (status);

  /* check input */
  ASSERT ( Fstat, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( multiSFTs, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( doppler, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( multiDetStates, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );
  ASSERT ( params, status, COMPUTEFSTATC_ENULL, COMPUTEFSTATC_MSGENULL );

  numDetectors = multiSFTs->length;
  ASSERT ( multiDetStates->length == numDetectors, status, COMPUTEFSTATC_EINPUT, COMPUTEFSTATC_MSGEINPUT );
  if ( multiWeights ) {
    ASSERT ( multiWeights->length == numDetectors , status, COMPUTEFSTATC_EINPUT, COMPUTEFSTATC_MSGEINPUT );
  }

  if ( doppler->orbit ) {
    LALPrintError ("\nSorry, binary-pulsar search not yet implemented in LALComputeFStat()\n\n");
    ABORT ( status, COMPUTEFSTATC_EINPUT, COMPUTEFSTATC_MSGEINPUT );
  }

  /* check if that skyposition SSB+AMcoef were already buffered */
  if ( cfBuffer 
       && ( cfBuffer->multiDetStates == multiDetStates )
       && ( cfBuffer->Alpha == doppler->Alpha )
       && ( cfBuffer->Delta == doppler->Delta ) 
       && cfBuffer->multiSSB
       && cfBuffer->multiAMcoef )
    { /* yes ==> reuse */
      multiSSB = cfBuffer->multiSSB;
      multiAMcoef = cfBuffer -> multiAMcoef;
    }
  else 
    {
      SkyPosition skypos;
      skypos.system =   COORDINATESYSTEM_EQUATORIAL;
      skypos.longitude = doppler->Alpha;
      skypos.latitude  = doppler->Delta;
      /* compute new AM-coefficients and SSB-times */
      TRY ( LALGetMultiSSBtimes ( status->statusPtr, &multiSSB, multiDetStates, skypos, doppler->refTime, params->SSBprec ), status );

      LALGetMultiAMCoeffs ( status->statusPtr, &multiAMcoef, multiDetStates, skypos );
      BEGINFAIL ( status ) {
	XLALDestroyMultiSSBtimes ( multiSSB );
      } ENDFAIL (status);

      /* noise-weigh Antenna-patterns and compute A,B,C */
      if ( XLALWeighMultiAMCoeffs ( multiAMcoef, multiWeights ) != XLAL_SUCCESS ) {
	LALPrintError("\nXLALWeighMultiAMCoeffs() failed with error = %d\n\n", xlalErrno );
	ABORT ( status, COMPUTEFSTATC_EXLAL, COMPUTEFSTATC_MSGEXLAL );
      }

      /* store these in buffer if available */
      if ( cfBuffer )
	{
	  XLALEmptyComputeFBuffer ( *cfBuffer );
	  cfBuffer->multiSSB = multiSSB;
	  cfBuffer->multiAMcoef = multiAMcoef;
	  cfBuffer->Alpha = doppler->Alpha;
	  cfBuffer->Delta = doppler->Delta;
	  cfBuffer->multiDetStates = multiDetStates ;
	} /* if cfBuffer */

    } /* if no buffer, different skypos or different detStates */

  Ad = multiAMcoef->Mmunu.Ad;
  Bd = multiAMcoef->Mmunu.Bd;
  Cd = multiAMcoef->Mmunu.Cd;
  Dd_inv = 1.0 / (Ad * Bd - Cd * Cd );

  /* ----- loop over detectors and compute all detector-specific quantities ----- */
  for ( X=0; X < numDetectors; X ++)
    {
      Fcomponents FcX = empty_Fcomponents;	/* for detector-specific FaX, FbX */

      if ( params->upsampling > 1) 
	{
	  if ( XLALComputeFaFbXavie (&FcX, multiSFTs->data[X], doppler->fkdot, multiSSB->data[X], multiAMcoef->data[X], params) != 0)
	    {
	      LALPrintError ("\nXALComputeFaFbXavie() failed\n");
	      ABORT ( status, COMPUTEFSTATC_EXLAL, COMPUTEFSTATC_MSGEXLAL );
	    }
	}
      else
	{
	  if ( LocalXLALComputeFaFb (&FcX, multiSFTs->data[X], doppler->fkdot, multiSSB->data[X], multiAMcoef->data[X], params) != 0)
	    {
	      LALPrintError ("\nLocalXALComputeFaFb() failed\n");
	      ABORT ( status, COMPUTEFSTATC_EXLAL, COMPUTEFSTATC_MSGEXLAL );
	    }
	}

#ifndef LAL_NDEBUG
      if ( !finite(FcX.Fa.re) || !finite(FcX.Fa.im) || !finite(FcX.Fb.re) || !finite(FcX.Fb.im) ) {
	LALPrintError("LocalXLALComputeFaFb() returned non-finite: Fa=(%f,%f), Fb=(%f,%f)\n", 
		      FcX.Fa.re, FcX.Fa.im, FcX.Fb.re, FcX.Fb.im );
	ABORT (status,  COMPUTEFSTATC_EIEEE,  COMPUTEFSTATC_MSGEIEEE);
      }
#endif
 		 
      /* Fa = sum_X Fa_X */
      retF.Fa.re += FcX.Fa.re;
      retF.Fa.im += FcX.Fa.im;

      /* Fb = sum_X Fb_X */ 		  
      retF.Fb.re += FcX.Fb.re;
      retF.Fb.im += FcX.Fb.im;
  		  
    } /* for  X < numDetectors */
 
  /* ----- compute final Fstatistic-value ----- */

  /* NOTE: the data MUST be normalized by the DOUBLE-SIDED PSD (using LALNormalizeMultiSFTVect),
   * therefore there is a factor of 2 difference with respect to the equations in JKS, which 
   * where based on the single-sided PSD.
   */ 
 		       
  retF.F = Dd_inv * (  Bd * (SQ(retF.Fa.re) + SQ(retF.Fa.im) ) 
                     + Ad * ( SQ(retF.Fb.re) + SQ(retF.Fb.im) )
                     - 2.0 * Cd *( retF.Fa.re * retF.Fb.re + retF.Fa.im * retF.Fb.im )  
		   );

  (*Fstat) = retF;

  /* free memory if no buffer was available */
  if ( !cfBuffer )
    {
      XLALDestroyMultiSSBtimes ( multiSSB );
      XLALDestroyMultiAMCoeffs ( multiAMcoef );
    } /* if !cfBuffer */

  DETATCHSTATUSPTR (status);
  RETURN (status);

} /* LocalComputeFStat() */


/** Revamped version of LALDemod() (based on TestLALDemod() in CFS).
 * Compute JKS's Fa and Fb, which are ingredients for calculating the F-statistic.
 */
int
LocalXLALComputeFaFb ( Fcomponents *FaFb,
		       const SFTVector *sfts,
		       const PulsarSpins fkdot,
		       const SSBtimes *tSSB,
		       const AMCoeffs *amcoe,
		       const ComputeFParams *params)       /**< addition computational params */
{ 
  UINT4 alpha;                 	/* loop index over SFTs */
  UINT4 spdnOrder;		/* maximal spindown-orders */
  UINT4 numSFTs;		/* number of SFTs (M in the Notes) */
  COMPLEX16 Fa, Fb;
  REAL8 f;			/* !! MUST be REAL8, or precision breaks down !! */
  REAL8 Tsft; 			/* length of SFTs in seconds */
  INT4 freqIndex0;		/* index of first frequency-bin in SFTs */
  INT4 freqIndex1;		/* index of last frequency-bin in SFTs */

  REAL4 *a_al, *b_al;		/* pointer to alpha-arrays over a and b */
  REAL8 *DeltaT_al, *Tdot_al;	/* pointer to alpha-arrays of SSB-timings */
  SFTtype *SFT_al;		/* SFT alpha  */
  UINT4 Dterms = params->Dterms;
  
  REAL8 norm = OOTWOPI; 

  /* ----- check validity of input */
#ifndef LAL_NDEBUG
  if ( !FaFb ) {
    LALPrintError ("\nOutput-pointer is NULL !\n\n");
    XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EINVAL);
  }

  if ( !sfts || !sfts->data ) {
    LALPrintError ("\nInput SFTs are NULL!\n\n");
    XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EINVAL);
  }
  
  if ( !tSSB || !tSSB->DeltaT || !tSSB->Tdot || !amcoe || !amcoe->a || !amcoe->b || !params)
    {
      LALPrintError ("\nIllegal NULL in input !\n\n");
      XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EINVAL);
    }

  if ( PULSAR_MAX_SPINS > NUM_FACT )
    {
      LALPrintError ("\nInverse factorials table only up to order s=%d, can't handle %d spin-order\n\n",
		     NUM_FACT, PULSAR_MAX_SPINS - 1 );
      XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EINVAL);
    }
#endif

  if ( params->upsampling > 1 ) {
    fprintf (stderr, "\n===== WARNING: LocalXLALComputeFaFb() should not be used with upsampled-SFTs!\n");
    XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EINVAL);
  }

  /* ----- prepare convenience variables */
  numSFTs = sfts->length;
  Tsft = 1.0 / sfts->data[0].deltaF;
  {
    REAL8 dFreq = sfts->data[0].deltaF;
    freqIndex0 = (UINT4) ( sfts->data[0].f0 / dFreq + 0.5); /* lowest freqency-index */
    freqIndex1 = freqIndex0 + sfts->data[0].data->length;
  }

  /* find highest non-zero spindown-entry */
  for ( spdnOrder = PULSAR_MAX_SPINS - 1;  spdnOrder > 0 ; spdnOrder --  )
    if ( fkdot[spdnOrder] )
      break;

  f = fkdot[0];

  Fa.re = 0.0f;
  Fa.im = 0.0f;
  Fb.re = 0.0f;
  Fb.im = 0.0f;

  a_al = amcoe->a->data;	/* point to beginning of alpha-arrays */
  b_al = amcoe->b->data;
  DeltaT_al = tSSB->DeltaT->data;
  Tdot_al = tSSB->Tdot->data;
  SFT_al = sfts->data;

  /* Loop over all SFTs  */
  for ( alpha = 0; alpha < numSFTs; alpha++ )
    {
      REAL4 a_alpha, b_alpha;

      INT4 kstar;		/* central frequency-bin k* = round(xhat_alpha) */
      INT4 k0, k1;

      COMPLEX8 *Xalpha = SFT_al->data->data; /* pointer to current SFT-data */
      COMPLEX8 *Xalpha_l; 	/* pointer to frequency-bin k in current SFT */
      REAL4 s_alpha, c_alpha;	/* sin(2pi kappa_alpha) and (cos(2pi kappa_alpha)-1) */
      REAL4 realQ, imagQ;	/* Re and Im of Q = e^{-i 2 pi lambda_alpha} */
      REAL4 realXP, imagXP;	/* Re/Im of sum_k X_ak * P_ak */
      REAL4 realQXP, imagQXP;	/* Re/Im of Q_alpha R_alpha */

      REAL8 lambda_alpha, kappa_max, kappa_star;

      /* ----- calculate kappa_max and lambda_alpha */
      {
	UINT4 s; 		/* loop-index over spindown-order */
	REAL8 phi_alpha, Dphi_alpha, DT_al;
	REAL8 Tas;	/* temporary variable to calculate (DeltaT_alpha)^s */

	/* init for s=0 */
	phi_alpha = 0.0;
	Dphi_alpha = 0.0;
	DT_al = (*DeltaT_al);
	Tas = 1.0;		/* DeltaT_alpha ^ 0 */

	for (s=0; s <= spdnOrder; s++)
	  {
	    REAL8 fsdot = fkdot[s];
	    Dphi_alpha += fsdot * Tas * inv_fact[s]; 	/* here: DT^s/s! */
	    Tas *= DT_al;				/* now: DT^(s+1) */
	    phi_alpha += fsdot * Tas * inv_fact[s+1];
	  } /* for s <= spdnOrder */

	/* Step 3: apply global factors to complete Dphi_alpha */
	Dphi_alpha *= Tsft * (*Tdot_al);		/* guaranteed > 0 ! */

	lambda_alpha = phi_alpha - 0.5 * Dphi_alpha;
	
	/* real- and imaginary part of e^{-i 2 pi lambda_alpha } */
	if ( local_sin_cos_2PI_LUT ( &imagQ, &realQ, - lambda_alpha ) ) {
	  XLAL_ERROR ( "LocalXLALComputeFaFb", XLAL_EFUNC);
	}

	kstar = (INT4) (Dphi_alpha + 0.5);	/* k* = round(Dphi_alpha*chi) for positive Dphi */
	kappa_star = Dphi_alpha - 1.0 * kstar;
	kappa_max = kappa_star + 1.0 * Dterms;

	/* ----- check that required frequency-bins are found in the SFTs ----- */
	k0 = kstar - Dterms;	
	k1 = k0 + 2 * Dterms;
	if ( (k0 < freqIndex0) || (k1 > freqIndex1) ) 
	  {
	    LALPrintError ("Required frequency-bins [%d, %d] not covered by SFT-interval [%d, %d]\n\n",
			   k0, k1, freqIndex0, freqIndex1 );
	    XLAL_ERROR("LocalXLALComputeFaFb", XLAL_EDOM);
	  }

      } /* compute kappa_star, lambda_alpha */

      /* NOTE: sin[ 2pi (Dphi_alpha - k) ] = sin [ 2pi Dphi_alpha ], therefore
       * the trig-functions need to be calculated only once!
       * We choose the value sin[ 2pi(Dphi_alpha - kstar) ] because it is the 
       * closest to zero and will pose no numerical difficulties !
       */
      local_sin_cos_2PI_LUT ( &s_alpha, &c_alpha, kappa_star );
      c_alpha -= 1.0f; 

      /* ---------- calculate the (truncated to Dterms) sum over k ---------- */

      /* ---------- ATTENTION: this the "hot-loop", which will be 
       * executed many millions of times, so anything in here 
       * has a HUGE impact on the whole performance of the code.
       * 
       * DON'T touch *anything* in here unless you really know 
       * what you're doing !!
       *------------------------------------------------------------
       */

      Xalpha_l = Xalpha + k0 - freqIndex0;  /* first frequency-bin in sum */

      realXP = 0;
      imagXP = 0;

      /* if no danger of denominator -> 0 */
      if ( ( kappa_star > LD_SMALL4 ) || (kappa_star < -LD_SMALL4) )	

#if (EAH_OPTIMIZATION == 1)
	/* vectorization with common denominator */
	{ 

	  REAL4 *Xal;
	  REAL4 U_alpha, V_alpha;
	  UINT4 l, ve;
	  REAL4 STn[4];
	  REAL4 pn[4];
	  REAL4 qn[4];
	  REAL4 q_n;

          Xal = (REAL4*)(Xalpha_l + 1);
          STn[0] = Xalpha_l[0].re;
          STn[1] = Xalpha_l[0].im;
          STn[2] = Xalpha_l[1].re;
          STn[3] = Xalpha_l[1].im;
          pn[0] = kappa_max;
          pn[1] = kappa_max;
          pn[2] = kappa_max - 1.0f;
          pn[3] = kappa_max - 1.0f;

	  for( ve=0; ve<4; ve++ )
            qn[ve] = pn[ve];

	  for ( l = 1; l <= Dterms; l++ ) {
	    for( ve=0; ve<4; ve++ ) {
	      pn[ve] = pn[ve] - 1.0f;                        /* p_(n+1) */
	      STn[ve] = pn[ve] * STn[ve] + qn[ve] * Xal[ve]; /* S_(n+1) */
	      qn[ve] *= pn[ve];		                     /* q_(n+1) */
	    }
	    Xal += 4;
          }
	  
	  q_n = qn[0] * qn[2];
	  U_alpha = (STn[0] * qn[2] + STn[2] * qn[0]) / q_n;
	  V_alpha = (STn[1] * qn[2] + STn[3] * qn[0]) / q_n;

	  realXP = s_alpha * U_alpha - c_alpha * V_alpha;
	  imagXP = c_alpha * U_alpha + s_alpha * V_alpha;
	  
	}

#elif (EAH_OPTIMIZATION == 2)

        {
	  /* THIS IS DANGEROUS!! It relies on current implementation of COMPLEX8 type!! */
	  REAL4 *Xalpha_kR4 = (REAL4*)(Xalpha_l + 1);
	
	  /* temporary variables to prevent double calculations */
	  /*
	    REAL4 tsin2pi = s_alpha * (REAL4)OOTWOPI;
	    REAL4 tcos2pi = c_alpha * (REAL4)OOTWOPI;
	  */
	  REAL4 XRes, XIms;
	  REAL8 combAF;

	  /* The main idea of the vectorization is that

	  [0] of a vector holds the real part of an even-index element
	  [1] of a vector holds the imaginary part of an even-index element
	  [2] of a vector holds the real part of an odd-index element
	  [3] of a vector holds the imaginary part of an odd-index element
	  
	  The calculations for the four vector elements are performed independently
	  possibly using vector-operations, and the sumsfor even- and odd-indexed
	  element are combined at the very end.

	  There was added a double-precision part that calculates the "inner"
	  elements of the loop (that contribute the most to the result) in
	  double precision. If vectorized, a complex calculation (i.e. two
	  real ones) should be performed on a 128Bit vector unit capable of double
	  precision, such as SSE or AltiVec
	  */

	  float XsumR[4]  __attribute__ ((aligned (16))); /* aligned for vector output */
	  float XsumS[4]  __attribute__ ((aligned (16))); /* aligned for vector output */
	  float aFreq[4]  __attribute__ ((aligned (16))); /* aligned for vector output */
	  /* the following vectors actually become registers in the AVUnit */
	  vector unsigned char perm;     /* holds permutation pattern for unaligned memory access */
	  vector float load0, load1, load2, load3, load4;  /* temp registers for unaligned memory access */
	  vector float load5, load6, load7, load8, load9; /**/
	  vector float fdval, reTFreq;              /* temporary variables */
	  vector float aFreqV = {1,1,1,1};
	  vector float zero  = {0,0,0,0};
	  vector float Xsum  = {0,0,0,0};           /* collects the sums */
	  vector float XsumV = {0,0,0,0};           /* collects the sums */
	  vector float four2 = {2,2,2,2};           /* vector constants */
	  vector float skip  = {6,6,6,6};
	  vector float tFreq = {((float)(kappa_max - 1)), /* tempFreq as vector */
				((float)(kappa_max - 1)),
				((float)(kappa_max - 2)),
				((float)(kappa_max - 2)) };

	  /* REAL4 tFreqS, aFreqS = 1;      /* tempFreq and accFreq for double precision */
	  /* REAL4 XsumS[2] = {0,0};        /* partial sums */

	  /* Vectorized version of the Kernel loop */
	  /* This loop has now been unrolled manually */
	  {
	    /* single precision vector "loop" (isn't actually a loop anymore) */
#define VEC_LOOP_RE(n,a,b)\
	      perm    = vec_lvsl(0,(Xalpha_kR4+(n)));\
              load##b = vec_ld(0,(Xalpha_kR4+(n)+4));\
	      fdval   = vec_perm(load##a,load##b,perm);\
	      reTFreq = vec_re(tFreq);\
	      tFreq   = vec_sub(tFreq,four2);\
	      Xsum    = vec_madd(fdval, reTFreq, Xsum);

#define VEC_LOOP_AV(n,a,b)\
	      perm    = vec_lvsl(0,(Xalpha_kR4+(n)));\
              load##b = vec_ld(0,(Xalpha_kR4+(n)+4));\
	      fdval   = vec_perm(load##a,load##b,perm);\
              fdval   = vec_madd(fdval,aFreqV,zero);\
	      XsumV   = vec_madd(XsumV, aFreqV, fdval);\
              aFreqV  = vec_madd(aFreqV,tFreq,zero);\
	      tFreq   = vec_sub(tFreq,four2);

	      /* non-vectorizing double-precision "loop" */
#define VEC_LOOP_S(n)\
              XsumS[0] = XsumS[0] * tFreqS + aFreqS * Xalpha_kR4[n];\
              XsumS[1] = XsumS[1] * tFreqS + aFreqS * Xalpha_kR4[n+1];\
	      aFreqS *= tFreqS;\
              tFreqS -= 1.0;

	    /* init the memory access */
	    load0 = vec_ld(0,(Xalpha_kR4));
	  
	    /* six single-precision calculations first */
	    VEC_LOOP_RE(0,0,1);
	    VEC_LOOP_RE(4,1,2);
	    VEC_LOOP_RE(8,2,3);
	  
	    /* six single-precision common-denominator calculations */
	    VEC_LOOP_AV(12,3,4);
	    VEC_LOOP_AV(16,4,5);
	    VEC_LOOP_AV(20,5,6);

	    /* the rest is done in single precision again */

	    VEC_LOOP_RE(24,6,7);
	    VEC_LOOP_RE(32,7,8);
	    VEC_LOOP_RE(36,8,9); 
	  }
	  
	  /* output the vector */
	  vec_st(Xsum,0,XsumR);
	  vec_st(XsumV,0,XsumS);
	  vec_st(aFreqV,0,aFreq);
	
	  /* conbination of the four partial sums: */
	  combAF  = 1.0 / (aFreq[0] * aFreq[2]);
	  XRes = (XsumS[0] * aFreq[2] + XsumS[2] * aFreq[0]) * combAF + XsumR[0] + XsumR[2];
	  XIms = (XsumS[1] * aFreq[3] + XsumS[3] * aFreq[1]) * combAF + XsumR[1] + XsumR[3];

	  realXP = s_alpha * XRes - c_alpha * XIms;
	  imagXP = c_alpha * XRes + s_alpha * XIms;
	} /* if x cannot be close to 0 */

#elif (EAH_OPTIMIZATION == 3)

        {
          COMPLEX8 XSums __attribute__ ((aligned (16))); /* sums of Xa.re and Xa.im for SSE */

	  REAL4 kappa_m = kappa_max; /* single precision version of kappa_max */

          /* vector constants */
          /* having these not aligned will crash the assembler code */
          static REAL4 V0011[4] __attribute__ ((aligned (16))) = { 0,0,1,1 };
          static REAL4 V2222[4] __attribute__ ((aligned (16))) = { 2,2,2,2 };

	  /* hand-coded SSE version from Akos */

          __asm __volatile
	    (
	     /* -------------------------------------------------------------------; */
	     /* Prepare common divisor method for 4 values ( two Re-Im pair ) */
	     /*  Im1, Re1, Im0, Re0 */
	     "MOVSS	%[kappa_m],%%xmm2   	\n\t"	/* X2:  -   -   -   C */
	     "MOVLPS	0(%[Xa]),%%xmm1   	\n\t"	/* X1:  -   -  Y00 X00 */
	     "MOVHPS	8(%[Xa]),%%xmm1   	\n\t"	/* X1: Y01 X01 Y00 X00 */
	     "SHUFPS	$0,%%xmm2,%%xmm2   	\n\t"	/* X2:  C   C   C   C */
	     "MOVAPS	%[V2222],%%xmm7   	\n\t"	/* X7:  2   2   2   2 */
	     "SUBPS	%[V0011],%%xmm2   	\n\t"	/* X2: C-1 C-1  C   C */
	     /* -------------------------------------------------------------------; */
	     "MOVAPS	%%xmm2,%%xmm0   	\n\t"	/* X0: C-1 C-1  C   C */
	     /* -------------------------------------------------------------------; */
	     /* xmm0: collected denumerators -> a new element will multiply by this */
	     /* xmm1: collected numerators -> we will divide it by the denumerator last */
	     /* xmm2: current denumerator ( counter type ) */
	     /* xmm3: current numerator ( current Re,Im elements ) */
	     /* -------------------------------------------------------------------; */
	     /*  Im3, Re3, Im2, Re2 */
	     "MOVLPS	16(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y02 X02 */
	     "MOVHPS	24(%[Xa]),%%xmm3   	\n\t"	/* X3: Y03 X03 Y02 X02 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C-3 C-3 C-2 C-2 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im5, Re5, Im4, Re4 */
	     "MOVLPS	32(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y04 X04 */
	     "MOVHPS	40(%[Xa]),%%xmm3   	\n\t"	/* X3: Y05 X05 Y04 X04 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C-5 C-5 C-4 C-4 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im7, Re7, Im6, Re6 */
	     "MOVLPS	48(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y06 X06 */
	     "MOVHPS	56(%[Xa]),%%xmm3   	\n\t"	/* X3: Y07 X07 Y06 X06 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C-7 C-7 C-6 C-6 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im9, Re9, Im8, Re8 */
	     "MOVLPS	64(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y08 X08 */
	     "MOVHPS	72(%[Xa]),%%xmm3   	\n\t"	/* X3: Y09 X09 Y08 X08 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C-9 C-9 C-8 C-8 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im11, Re11, Im10, Re10 */
	     "MOVLPS	80(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y10 X10 */
	     "MOVHPS	88(%[Xa]),%%xmm3   	\n\t"	/* X3: Y11 X11 Y10 X10 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C11 C11 C10 C10 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im13, Re13, Im12, Re12 */
	     "MOVLPS	96(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y12 X12 */
	     "MOVHPS	104(%[Xa]),%%xmm3   	\n\t"	/* X3: Y13 X13 Y12 X12 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C13 C13 C12 C12 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /*  Im15, Re15, Im14, Re14 */
	     "MOVLPS	112(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y14 X14 */
	     "MOVHPS	120(%[Xa]),%%xmm3   	\n\t"	/* X3: Y15 X15 Y14 X14 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C15 C15 C14 C14 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /* Save the upper half, because the 18th element */
	     /* operation will destroy the register content */
	     "MOVHLPS   %%xmm0,%%xmm6   	\n\t"	/* X6:  -   -  SCh SCh */
	     "MOVHLPS   %%xmm1,%%xmm5   	\n\t"	/* X5:  -   -  SYh SXh */
	     /* -------------------------------------------------------------------; */
	     /* The 17th element ( only a half of a pair ) */
	     /*  dummy, dummy, Im16, Re16 */
	     "MOVLPS	128(%[Xa]),%%xmm3   	\n\t"	/* X3:  -   -  Y14 X14 */
	     "SUBPS	%%xmm7,%%xmm2   	\n\t"	/* X2: C17 C17 C16 C16 */
	     "MULPS	%%xmm0,%%xmm3   	\n\t"	/* X3: Xnew*Ccol */
	     "MULPS	%%xmm2,%%xmm1   	\n\t"	/* X1: Xold*Cnew */
	     "MULPS	%%xmm2,%%xmm0   	\n\t"	/* X0: Ccol=Ccol*Cnew */
	     "ADDPS	%%xmm3,%%xmm1   	\n\t"	/* X1: Xold=Xold*Cnew+Xnew*Ccol */
	     /* -------------------------------------------------------------------; */
	     /* Prepare for double division */
	     /* ( dual division on both half with their own common divisior ) */
	     "MOVLHPS   %%xmm0,%%xmm6   	\n\t"	/* X6: SCl SCl SCh SCh; CD */
	     "MOVLHPS   %%xmm1,%%xmm5   	\n\t"	/* X5: SYl SXl SYh SXh; MULADDS */
	     /* -------------------------------------------------------------------; */
	     /* Four divisions at once ( two for real parts and two for imaginary parts ) */
	     "DIVPS	%%xmm6,%%xmm5   	\n\t"	/* X4: Y0G X0G Y1F X1F */
	     /* -------------------------------------------------------------------; */
	     /* So we have to add the two real and two imaginary parts */
	     "MOVHLPS   %%xmm5,%%xmm4	        \n\t"	/* X3:  -   -  Y0G X0G */
	     "ADDPS	%%xmm5,%%xmm4   	\n\t"	/* X3:  -   -  YOK XOK */
	     /* -------------------------------------------------------------------; */
	     /* Save values for FPU part */
	     "MOVLPS	%%xmm4,%[XSums]   	\n\t"	/*  */

	     /* interface */
	     :
	     /* output  (here: to memory)*/
	     [XSums]      "=m" (XSums)

	     :
	     /* input */
	     [Xa]          "r"  (Xalpha_l),
	     [kappa_m]     "m"  (kappa_m),

	     /* constants */
	     [V0011]       "m"  (V0011[0]),
	     [V2222]       "m"  (V2222[0])

	     :
	     /* clobbered registers */
#ifndef IGNORE_XMM_REGISTERS
	     "xmm0","xmm1","xmm2","xmm3","xmm4","xmm5","xmm6","xmm7"
#endif
	     );

	  realXP = s_alpha * XSums.re - c_alpha * XSums.im;
	  imagXP = c_alpha * XSums.re + s_alpha * XSums.im;

	}

#else

	{ 
	  /* improved hotloop algorithm by Fekete Akos: 
	   * take out repeated divisions into a single common denominator,
	   * plus use extra cleverness to compute the nominator efficiently...
	   */
	  REAL4 Sn = (*Xalpha_l).re;
	  REAL4 Tn = (*Xalpha_l).im;
	  REAL4 pn = kappa_max;
	  REAL4 qn = pn;
	  REAL4 U_alpha, V_alpha;
	  
	  /* recursion with 2*Dterms steps */
	  UINT4 l;
	  for ( l = 1; l <= 2*Dterms; l ++ )
	    {
	      Xalpha_l ++;
	      
	      pn = pn - 1.0f; 			/* p_(n+1) */
	      Sn = pn * Sn + qn * (*Xalpha_l).re;	/* S_(n+1) */
	      Tn = pn * Tn + qn * (*Xalpha_l).im;	/* T_(n+1) */
	      qn *= pn;				/* q_(n+1) */
	    } /* for l <= 2*Dterms */
	  
	  U_alpha = Sn / qn;
	  V_alpha = Tn / qn;

	  realXP = s_alpha * U_alpha - c_alpha * V_alpha;
	  imagXP = c_alpha * U_alpha + s_alpha * V_alpha;
	}

#endif

      /* if |remainder| > LD_SMALL4 */
      else
	{ /* otherwise: lim_{rem->0}P_alpha,k  = 2pi delta_{k,kstar} */
	  realXP = TWOPI_FLOAT * Xalpha_l[Dterms].re;
	  imagXP = TWOPI_FLOAT * Xalpha_l[Dterms].im;
	} /* if |remainder| <= LD_SMALL4 */
      
      realQXP = realQ * realXP - imagQ * imagXP;
      imagQXP = realQ * imagXP + imagQ * realXP;
      
      /* we're done: ==> combine these into Fa and Fb */
      a_alpha = (*a_al);
      b_alpha = (*b_al);

      Fa.re += a_alpha * realQXP;
      Fa.im += a_alpha * imagQXP;
      
      Fb.re += b_alpha * realQXP;
      Fb.im += b_alpha * imagQXP;


      /* advance pointers over alpha */
      a_al ++;
      b_al ++;
      DeltaT_al ++;
      Tdot_al ++;
      SFT_al ++;

    } /* for alpha < numSFTs */
      
  /* return result */
  FaFb->Fa.re = norm * Fa.re;
  FaFb->Fa.im = norm * Fa.im;
  FaFb->Fb.re = norm * Fb.re;
  FaFb->Fb.im = norm * Fb.im;

  return XLAL_SUCCESS;

} /* LocalXLALComputeFaFb() */



/** Calculate sin(x) and cos(x) to roughly 1e-7 precision using 
 * a lookup-table and Taylor-expansion.
 *
 * NOTE: this function will fail for arguments larger than
 * |x| > INT4_MAX = 2147483647 ~ 2e9 !!!
 *
 * return = 0: OK, nonzero=ERROR
 */
int
local_sin_cos_LUT_2tab (REAL4 *sinx, REAL4 *cosx, REAL8 x)
{
  return local_sin_cos_2PI_LUT ( sinx, cosx, x * OOTWOPI );
} /* local_sin_cos_LUT() */




#define LUT_RES         64      /* resolution of lookup-table */
#define LUT_RES_F	(1.0 * LUT_RES)
#define OO_LUT_RES	(1.0 / LUT_RES)

#define X_TO_IND	(1.0 * LUT_RES * OOTWOPI )
#define IND_TO_X	(LAL_TWOPI * OO_LUT_RES)
int
local_sin_cos_2PI_LUT_2tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 x)
{
  REAL8 xt;
  INT4 i0;
  REAL8 d, d2;
  REAL8 ts, tc;

  static BOOLEAN firstCall = TRUE;
  static REAL4 sinVal[LUT_RES+1], cosVal[LUT_RES+1];
  static REAL8 const oo_lut_res = OO_LUT_RES;

  /* the first time we get called, we set up the lookup-table */
  if ( firstCall )
    {
      UINT4 k;

      for (k=0; k <= LUT_RES; k++)
        {
          sinVal[k] = sin( LAL_TWOPI * k * oo_lut_res );
          cosVal[k] = cos( LAL_TWOPI * k * oo_lut_res );
        }
      firstCall = FALSE;
    }

  /* we only need the fractional part of 'x', which is number of cylces,
   * this was previously done using
   *   xt = x - (INT4)x;
   * which is numerically unsafe for x > LAL_INT4_MAX ~ 2e9
   * for saftey we therefore rather use modf(), even if that 
   * will be somewhat slower... 
   */

  SINCOS_TRIM_X (xt,x);

#ifndef LAL_NDEBUG
  if ( xt < 0.0 || xt > 1.0 )
    {
      LALPrintError("\nFailed numerica in local_sin_cos_2PI_LUT(): xt = %f not in [0,1)\n\n", xt );
      return XLAL_FAILURE;
    }
#endif

  i0 = (INT4)( xt * LUT_RES_F + 0.5 );	/* i0 in [0, LUT_RES ] */
  d = d2 = LAL_TWOPI * (xt - oo_lut_res * i0);
  d2 *= 0.5 * d;

  ts = sinVal[i0];
  tc = cosVal[i0];
   
  /* use Taylor-expansions for sin/cos around LUT-points */
  (*sin2pix) = ts + d * tc - d2 * ts;
  (*cos2pix) = tc - d * ts - d2 * tc;

  return XLAL_SUCCESS;
} /* local_sin_cos_2PI_LUT() */




int local_sin_cos_2PI_LUT_7tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 xin) {

  /* Lookup tables for fast sin/cos calculation */
  static REAL8 sinVal[LUT_RES+1];
  static REAL8 sinVal2PI[LUT_RES+1];
  static REAL8 sinVal2PIPI[LUT_RES+1];
  static REAL8 cosVal[LUT_RES+1];
  static REAL8 cosVal2PI[LUT_RES+1];
  static REAL8 cosVal2PIPI[LUT_RES+1];
  static REAL8 diVal[LUT_RES+1];

  static BOOLEAN tabs_empty = 1; /* reset after initializing the sin/cos tables */

  UINT4 i; /* array index */
  REAL8 d, d2; /* intermediate value  */
  REAL8 x; /* x limited to [0..1) */

  /* res=10*(params->mCohSFT); */
  /* This size LUT gives errors ~ 10^-7 with a three-term Taylor series */
  /* using three tables with values including PI is simply faster */
  if ( tabs_empty ) {
    for (i=0; i <= LUT_RES; i++) {
      sinVal[i]      = sin((LAL_TWOPI*i)/(LUT_RES));
      sinVal2PI[i]   = sinVal[i]    * LAL_TWOPI;
      sinVal2PIPI[i] = sinVal2PI[i] * LAL_PI;
      cosVal[i]      = cos((LAL_TWOPI*i)/(LUT_RES));
      cosVal2PI[i]   = cosVal[i]    * LAL_TWOPI;
      cosVal2PIPI[i] = cosVal2PI[i] * LAL_PI;
    }

    /* this additional table saves another "costly" division in sin/cos calculation */
    for (i=0; i <= LUT_RES; i++)
      diVal[i] = (REAL8)i/(REAL8)(LUT_RES);

    tabs_empty = 0;
  }

  SINCOS_TRIM_X (x,xin);

  i = x * LUT_RES + .5; /* round-to-nearest */
  d = x - diVal[i];
#if 1
  (*sin2pix) = sinVal[i] + d * (cosVal2PI[i] - d * sinVal2PIPI[i]);
  (*cos2pix) = cosVal[i] - d * (sinVal2PI[i] + d * cosVal2PIPI[i]);
#else
  d2 = d*d;
  (*sin2pix) = sinVal[i] + d * cosVal2PI[i] - d2 * sinVal2PIPI[i];
  (*cos2pix) = cosVal[i] - d * sinVal2PI[i] - d2 * cosVal2PIPI[i];
#endif

  return XLAL_SUCCESS;
}



/* Single-precision version, to be validated */

int local_sin_cos_2PI_LUT_7R4tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 xin) {

  /* Lookup tables for fast sin/cos calculation */
  static REAL4 sinVal[LUT_RES+1];
  static REAL4 sinVal2PI[LUT_RES+1];
  static REAL4 sinVal2PIPI[LUT_RES+1];
  static REAL4 cosVal[LUT_RES+1];
  static REAL4 cosVal2PI[LUT_RES+1];
  static REAL4 cosVal2PIPI[LUT_RES+1];
  static REAL4 diVal[LUT_RES+1];

  static BOOLEAN tabs_empty = 1; /* reset after initializing the sin/cos tables */

  UINT4 i; /* array index */
  REAL4 d, d2; /* intermediate value  */
  REAL4 x; /* x limited to [0..1) */

  /* res=10*(params->mCohSFT); */
  /* This size LUT gives errors ~ 10^-7 with a three-term Taylor series */
  /* using three tables with values including PI is simply faster */
  if ( tabs_empty ) {

    for (i=0; i <= LUT_RES; i++) {
      sinVal[i]      = sin((LAL_TWOPI*i)/(LUT_RES));
      sinVal2PI[i]   = sinVal[i]    * LAL_TWOPI * -1.0;
      sinVal2PIPI[i] = sinVal2PI[i] * LAL_PI;
      cosVal[i]      = cos((LAL_TWOPI*i)/(LUT_RES));
      cosVal2PI[i]   = cosVal[i]    * LAL_TWOPI;
      cosVal2PIPI[i] = cosVal2PI[i] * LAL_PI * -1.0;
    }

    /* this additional table saves another "costly" division in sin/cos calculation */
    for (i=0; i <= LUT_RES; i++)
      diVal[i] = (REAL4)i/(REAL4)(LUT_RES);

    tabs_empty = 0;
  }

  SINCOS_TRIM_X (x,xin);

  i = x * LUT_RES + .5; /* round-to-nearest */
  d = x - diVal[i];
#if 1
  (*sin2pix) = sinVal[i] + d * (cosVal2PI[i] + d * sinVal2PIPI[i]);
  (*cos2pix) = cosVal[i] + d * (sinVal2PI[i] + d * cosVal2PIPI[i]);
#else
  d2 = d*d;
  (*sin2pix) = sinVal[i] + d * cosVal2PI[i] + d2 * sinVal2PIPI[i];
  (*cos2pix) = cosVal[i] + d * sinVal2PI[i] + d2 * cosVal2PIPI[i];
#endif

  return XLAL_SUCCESS;
}


/* Not used or tested (yet). This features a table construction so
   that the calculation that can easily be vectorized (might help...) */

#if 0

int local_sin_cos_2PI_LUT_7R4V2tab (REAL4 *sin2pix, REAL4 *cos2pix, REAL8 xin) {

  /* Lookup tables for fast sin/cos calculation */
  static REAL4 scTab[LUT_RES+1][2];
  static REAL4 scTab2PI[LUT_RES+1][2];
  static REAL4 scTab2PIPI[LUT_RES+1][2];
  static REAL4 diVal[LUT_RES+1];

  static BOOLEAN tabs_empty = 1; /* reset after initializing the sin/cos tables */

#ifndef SINCOS_VE
#define SINCOS_VE 2
#endif

  UINT4 i; /* array index */
  REAL4 d, d2; /* intermediate value  */
  REAL4 x; /* x limited to [0..1) */
  REAL4 sincos[SINCOS_VE];
  int ve;

  /* res=10*(params->mCohSFT); */
  /* This size LUT gives errors ~ 10^-7 with a three-term Taylor series */
  /* using three tables with values including PI is simply faster */
  if ( tabs_empty ) {
    REAL4 r_lut_res = 1.0f / (REAL4)(LUT_RES);

    for (i=0; i <= LUT_RES; i++) {
      scTab[i][0]      = sin((LAL_TWOPI*i)/(LUT_RES));
      scTab2PI[i][1]   = scTab[i][0]    * LAL_TWOPI * -1.0;
      scTab2PIPI[i][0] = scTab2PI[i][1] * LAL_PI;
      scTab[i][1]      = cos((LAL_TWOPI*i)/(LUT_RES));
      scTab2PI[i][0]   = scTab[i][1]    * LAL_TWOPI;
      scTab2PIPI[i][1] = scTab2PI[i][0] * LAL_PI * -1.0;

      diVal[i] = (REAL4)i * r_lut_res;
    }

    tabs_empty = 0;
  }

  SINCOS_TRIM_X (x,xin);

  i = x * LUT_RES + .5; /* round-to-nearest */
  d = x - diVal[i];
#if 1
  for (ve=0; ve < SINCOS_VE; ve++)
    sincos[ve] = scTab[i][ve] + d * (scTab2PI[i][ve] + d * scTab2PIPI[i][ve]);
#else
  d2 = d*d;
  for (ve=0; ve < SINCOS_VE; ve++)
    sincos[ve] = scTab[i][ve] + d * scTab2PI[i][ve] + d2 * scTab2PIPI[i][ve];
#endif

  (*sin2pix) = sincos[0];
  (*cos2pix) = sincos[1];

  return XLAL_SUCCESS;
}

#endif /* #if 0 */
