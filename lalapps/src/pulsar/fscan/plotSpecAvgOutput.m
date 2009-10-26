function plotSpecAvgOutput(filename,outputFileName,chanName,effTBase,deltaFTicks,taveFlag,effTBaseFull,thresholdSNR,coinDF,pulsar,referenceFile)
%
% fileName       -- the name of the file with data to input; this file is the output from spec_avg.
% outputFileName -- base name of the output spectrogram files; will append .pdf and .png to this name.
% chanName       -- the name of the channel used to generate the spectrogram data.
% effTBase       -- the effective time base line: 1/effTBase gives the frequency resolution of the plot.
%                   so that a effTBase of 10 seconds means deltaF = 0.1 Hz.
% deltaFTicks    -- the change in frequency between major tick marks (e.g., 5 Hz).
% taveFlag       -- if > 0 then produce StackSlide style time average output without sliding.
%                   The spectrograms is given as subplot(2,1,1) and this spectrum as subplot(2,1,2).
%                   Also, .txt is appended to the plot name, and f versus the normalized averaged
%                   power is output into this text file.
% effTBaseFull   -- 1/effTBaseFull gives the frequency resolution of the average normalized spectra plots. This value is the timbaseline of the sfts.
% thresholdSNR   -- if > 0 then look for coincident lines with the referenceFile spectra above this threshold.
% coinDF         -- window in frequency to use when looking for coincident lines.
% referenceFile  -- base name of the reference file output by spec_avg; will append _timeaverage to this name.
%pulsar          --can be 1 or zero, if 1 then assume need to overplot the freq of GW from a source on specgram

% Convert relevant strings to numbers.
if (ischar(effTBase))
    effTBase=str2num(effTBase);
end
if (ischar(deltaFTicks))
    deltaFTicks=str2num(deltaFTicks);
end
if (ischar(taveFlag))
    taveFlag=str2num(taveFlag);
end
if (ischar(effTBaseFull))
    effTBaseFull=str2num(effTBaseFull);
end
if (ischar(thresholdSNR))
    thresholdSNR=str2num(thresholdSNR);
end
if (ischar(coinDF))
    coinDF=str2num(coinDF);
end
if (ischar(pulsar))
    pulsar=str2num(pulsar);
end


xIn = load(filename);%cg; loads the contents of the file into Xin, this should be a matlab binary file according to matlab help, but hte file is ascii!?!?!?!?  Does not seam to matter.  This line loads my test1 data for 3 SFTs into Xin no probs.  Typing in on the command line you need to put the filename in 'filename'.  Xin is then a 3 by 100 array of doubles.
xlen=length(xIn(:,1));
ylen=length(xIn(1,:));
y = flipud(transpose((xIn)));%cg; flipud flipes the array/matrix upside down, i.e. reverses the row direction of the array.  Transpose obvisouly transposes the array.  So the array gets put up on its side and then turned upside down.  This is so the values appear in the correct way when displaying the array as an image, which is what imagesc does.


%cg;these lines get the relvant info out of the file name
%---------------
undrscr = findstr('_',filename);                                 
fStart = str2num(filename((undrscr(1)+1):(undrscr(2)-1)));      % start frequency 
fEnd = str2num(filename((undrscr(2)+1):(undrscr(3)-1)));        % end frequency
tStart = str2num(filename((undrscr(4)+1):(undrscr(5)-1)))      % start time
tEnd = str2num(filename((undrscr(5)+1):end))                   % end time
%----------------

% calculate characteristic values   cg;  calculates a cutoffval for the data so really loud stuff does not dominate.

y_temp1 = y;%make a copy of y that we can edit.
y_temp3 = y;%copy of y needed for crab stuff that is completely intact.

%this little section gets rid of the cols of zeros for the cutoffval calc, without this the median value and therefore the cuttoffval will be calculated incorrectly and can be zero.
ycols=(1:xlen);%create a vector, elements are the column indicies of y
yzeros=find( sum(y(:,ycols)) == 0 );%find all the column indices where the sum of the columns are zero.
y_temp1(:,yzeros)=[];%get rid of all the columns where the sum of the columns are zero.
%ynocols=length(y_temp1(1,:))%use for bug checking.
%y_temp1 is an array with all the gaps taken out, so just data no zeros.

y_temp2 = [ ];%makes Y-temp2 into a vector, data is put in column by column.
for ii=1:length(y_temp1(:,1));
  y_temp2 = [y_temp2,y_temp1(ii,:)];
end

%get NumBinsAvg from file.
filename_numbins=sprintf('%s_numbins',filename);
NumBinsAvg = load(filename_numbins);

mediany = median(y_temp2);

cutoffval = median(y_temp2) + (5*(median(y_temp2)/sqrt(NumBinsAvg)) );%cg; this cut off value is used in the loop below to get rid of any outliers.  Not sure about the formula used for this calc.  But be aware, will need to change the value being sqrt'ed.Old value is 180, changed to NumBinsAvg, which is the number of bins over which the power values have been averaged in the c code.
%maximum = max(max(y));
%minimum = min(min(y));
     
% replace every value more than three stddeviations away from mean-value

for ii=1:length(y(:,1));
       for jj=1:length(y(1,:));
           if y(ii,jj)>= cutoffval;
               y(ii,jj)= cutoffval;
           end
       end
end

%-------------------------
%get dates etc.

filename_date=sprintf('%s_date',filename);
fid_date = fopen(filename_date);
%datein=textscan(fid_date, '%d %d');%once you have used textscan you are at the bottom of the file.
datein=textscan(fid_date, '%d %d %d %d %d %d %d');
fclose(fid_date);

filename_time=sprintf('%s_timestamps',filename);
fid_times = fopen(filename_time);
timesin=textscan(fid_times, '%d %d');
fclose(fid_times);
timesin=double(timesin{2});

utcdate={};

for ii=1:xlen;
  utcdate(ii)={sprintf('%d-%d-%d',datein{2}(ii),datein{3}(ii), datein{4}(ii) )};
  utctime(ii)={sprintf(' %d:%d:%d',datein{5}(ii),datein{6}(ii), datein{7}(ii) )};
end


%get the start and end UTC time and date for the title
startDateTime = sprintf('%d/%d/%d %d:%d:%d',datein{2}(1),datein{3}(1), datein{4}(1), datein{5}(1),datein{6}(1), datein{7}(1) );
endDateTime = sprintf('%d/%d/%d %d:%d:%d',datein{2}(xlen),datein{3}(xlen),datein{4}(xlen),datein{5}(xlen),datein{6}(xlen), datein{7}(xlen) );
StStart = sprintf('%d',tStart);
StEnd = sprintf('%d',tEnd);

%-------------------------
%cg; plot the spectrogram 

figure(1);%cg; creates a figure graphics object,

%---------------------------
%colormapping

ymax=(max(max(y)));%find max and min values (min must not be zero).
ymin=(min(min(y_temp1)));
yrange=ymax-ymin;


log=0;%decide to plot log colour axis or not.

if (log == 1)
    indexdata=log10(y);%indexdata is log of y, note that zeros will become -ve infinity, as long as this is less than 1 it will get assigned to first colour in cmap1, as it should be, i.e. not need to change these values to 1.
    imagesc(indexdata);
else
    imagesc(y);
    cymin=ymin-(yrange/254);%works out the size of a cbar slot assuming 254 slots (not 256) for yrange of data
    caxis([cymin ymax]);%ensures that all data bar the zeros are scaled to slots 2 and above, and only one slot is used ymin and below (i.e. zeros)
end

cmap1=colormap(jet(256));%three by 256 matrix.
cmap1(1,1,1)=0.85;%these three lines reset the first index in the colormap to white.
cmap1(1,2,1)=0.85;
cmap1(1,3,1)=0.85;

colormap(cmap1);
colorbar('eastoutside');
%-------------------------------------------
%deal with the Y axis

ylabel('frequency [Hz]','FontSize',13);

%calc y axis ticks and labels
% Show ticks every deltaFTicks Hz:
deltaFTicks;
fRange=fEnd-fStart;
numbins=effTBase*fRange; % this is the total number of bins in the matrix passed from spec_avg.c
allf=(fStart:deltaFTicks:fEnd); %creates a 1D array with every freq between start and end in it, in ascending order.
vecFLabels = allf( (mod(allf,deltaFTicks)==0)|(allf == fEnd)|(allf==fStart) ); %keeps fStart and fEnd, plus any values that are integer multiples of deltaFTicks.

%work out the bin numbers associated with these freq values.  effTBase=bins per hz.
vecTicks=((vecFLabels-fStart)*effTBase)+1;
numTicks=length(vecTicks);
vecTicks(numTicks)=vecTicks(numTicks)-1;
%---------------------------------------------
%deal with the x axis
xlabel('Time in days since start date','FontSize',13);
%calc x axis ticks and labels.  Show a label every tenth of the width, and the first and last sft.
deltaxticks=round(xlen/10); %rounds to nearest whole number to zero.
if (deltaxticks < 1 )%if in the inlikely circumstance there are less than 3 sfts, this will catch the error.
    deltaxticks= 1;
end
xticks = (1:deltaxticks:xlen);%creates an array from 1 to xlen with deltaxticks intervals.
xnumticks= length(xticks);
%xticks(xnumticks)=xlen;  %makes sure the last x tick is at the end of the specgram.

list_days=(timesin-timesin(1))/86400; %converts the gps seconds into days, does not take into account leap seconds, but good enough for this plot.

for kk=1:xnumticks;
    subsc=(xticks(kk));
    %xlabs(kk)= strcat(utcdate(subsc) ,utctime(subsc));
    days = num2str( (double(list_days(subsc))),'%4.2f\n');
    xlabs{kk}= days;
end

%  tStart
%  timesin{2}(46)
%  timesin{2}(46) - tStart
%  xlabs = num2str(xlabs,'%2.1f\n')
%  cellxlabs=cellstr(xlabs)

%--------------------------------------------
%set the ticks and labels for the X Y axis
set(gca, 'YTick', vecTicks);%cg; gca is current axis handle.
set(gca, 'YTickLabel', fliplr(vecFLabels));

set(gca, 'XTick', xticks);
set(gca, 'XTickLabel', xlabs);
%-------------------------------------------
%do the titles

titleString = sprintf('Spectrogram for %s;  %s to %s UTC.' ,chanName,startDateTime,endDateTime);
title(titleString,'Interpreter','none');

%-------------------------------------------
%now plot the crab frequency of this image.

if (pulsar ~= 0) %only run if pulsar is not 0
    %need to load in the crab file.
    filename_crab=sprintf('%s_crab',filename);
    crab=load(filename_crab);%load in all the data from the crab output file
    crabF = crab(:,3);%pick out the GW observed crab frequency
    crabF=crabF';%transpose so this is 1 row deep by x no of cols, needed for sub2ind later.
    hold on;
    sftno=(1:xlen);
    
    %convert crabF so that it appears at correct place on plot
    newcrabF=numbins+1-((crabF-fStart)*effTBase);
    plot(sftno,newcrabF, 'Color', [0,0,0], 'linestyle', '--');
    
    %produce a specgram plot centered on the crab frequency
    %------------------------------------------------------
    %effTBase is the frequency resolution., need to work out the number of bins either side of the crab bin to grab, this should be 1/60hz wide in total.Work out number of bins equalt to 1/120Hz
    %this needs to come before the chunk of code that plots the crab freq over the specgram as the zeros are needed.
    freqres=1/effTBase
    winbins=round( (1/60)/freqres );%works out how many bins are equivlent to 1/60 hz
%      if (winbins < 1 ), winbins=1, end;%just needed for testing, but will need a check that freqres is suffient for the window size.
    %spec_crab needs as many rows as bins are needed to cover the 1/60hz window.
    spec_crab=zeros(1,xlen);%creates a matrix with winbins number of rows and no of cols equal to the no of sfts.  This will be matrix used for specgram plot centred on the crab freq.
    %spec_crab_plot=zeros(winbins,xlen);
    winwidth=(winbins-1)/2%the number of bins each side of the bin the crab freq is in to use in order to get a 1/60hz window width.
    %open a file for writing the raw output of spec_crab.
    outputFileName3 = sprintf('%s_crab',outputFileName);
    outputFileName4 = sprintf('%s_crab_spec',outputFileName);
    fid_cspec=fopen(outputFileName4,'w');
    
    for ii=1:xlen;%do for all sfts
        count=1;
        ii
        for jj=-winwidth:winwidth;%for each sft use number of bins needed for 1/60 hz window.
        newcrabF(ii)
        bin_num=(fix(newcrabF(ii)) )+jj%finds the bin number to look at.
        if (bin_num<0), bin_mum=0, end;
        if (bin_num>ylen), bin_num=ylen, end;
        count
        bin_freq=(( (numbins+1-bin_num)*freqres )+fStart) + freqres/2;
        deltaF=abs(bin_freq-crabF(ii));
        w=sinc(deltaF);
        spec_crab(ii)=spec_crab(ii)+w*(y_temp3(bin_num,ii));
%          cout1=y_temp3(bin_num,ii);%use y_temp3 if you want real values of y that have not had cut-off applied.
%          cout2=y(bin_num,ii);%use y if you want values of y that have had cut-off applied.
%          spec_crab(count,ii)=cout1;
%          spec_crab_plot(count,ii)=cout2;
        
        count =count+1;
        end
        fprintf(fid_cspec,'%1.6e\t',spec_crab(ii));
        fprintf(fid_cspec,'\n');
    end

    
    fclose(fid_cspec);
end
%-------------------------------------------
%cg, now print the outputs to a file.
print('-dpng',[outputFileName '.png']);
set(gcf, 'PaperUnits', 'centimeters');
set(gcf, 'PaperOrientation', 'landscape');
%set (gcf, 'PaperOrientation', 'landscape', 'PaperType', 'A4', 'PaperPosition', [0 0 30 20] );
set (gcf, 'PaperType', 'A4', 'PaperPosition', [0 0 30 20] );
print('-dpdf', '-painters', '-r300','-loose', [outputFileName '.pdf'])

filename_fig=sprintf('%s.fig',filename);
saveas(1,filename_fig);
filename_mat=sprintf('%s.mat',filename);
save (filename_mat,'y');

delete(1);%closes the figures.
%-------------------------------------------
%create extra specgram zoomed in and centred on the crab freq.
if (pulsar ~= 0)%if we set the option to run the crab stuff.
    
    figure(3);
    
    %do rest of image stuff
    %-------------------------
    %crab_means=mean(spec_crab_plot, 1);%computes the mean of each row and sticks it into the 1d array cab_means.
    plot(list_days, spec_crab);%makes a plot with y axis in log scale.
    
    set(gca, 'XTick', xticks);
    set(gca, 'XTickLabel', xlabs);
    xlabel('Time in days since start date','FontSize',13);
    
%      yticks = (1:winbins);
%      ylabs=(winwidth:-1:-winwidth).*freqres
%      set(gca, 'YTick', yticks);
%      set(gca, 'YTickLabel', ylabs);
      ylabel('Spectral power density','FontSize',13);

    
    titleString2 = sprintf('Noise in 1/60 Hz band at Crab frequency, %s to %s UTC.' ,startDateTime,endDateTime);
    title(titleString2,'Interpreter','none');
    
%      colormap(cmap2);
%      colorbar('eastoutside');
    
    
    print('-dpng',[outputFileName3 '.png']);
    set(gcf, 'PaperUnits', 'centimeters');
    set (gcf, 'PaperOrientation', 'landscape', 'PaperType', 'A4', 'PaperPosition', [0 0 30 20] );
    print('-dpdf','-loose',[outputFileName3 '.pdf'])
    
    filename_fig=sprintf('%s_crab.fig',filename);
    saveas(3,filename_fig);
    filename_mat=sprintf('%s_crab.mat',filename);
    save (filename_mat,'spec_crab');
    
    delete(3);
end
%-------------------------------------------

%Now work on the normalised average power plot.

if (taveFlag > 0) %cg; the code below only executes if taveFlag > 0, this bit plots the normalised average power
  %subplot(2,1,2)cg; if printing the specgram and graph seperately, dont need this line.
  figure(2);
%cg; this bit creates the other two text files, these both have the suffix .txt on the end.
% Produce StackSlide style time average output without sliding:
  timeaverageFileName = sprintf('%s_timeaverage',filename);
  [fk, xout] = textread(timeaverageFileName,'%f %f');
  outputTextFile = sprintf('%s.txt',filename);
  outputSortedTextFile = sprintf('%s_sorted.txt',outputFileName);
  [xoutSorted,iSorted] = sort(xout,'descend');
  fSorted = fk(iSorted);
  fid = fopen(outputTextFile,'w');
  fid2 = fopen(outputSortedTextFile,'w');
  kMax = length(xout);
  for k = 1:kMax
      fprintf(fid,'%f %f\n',fk(k),xout(k));
      fprintf(fid2,'%f %f\n',fSorted(k),xoutSorted(k));
  end
  stdev_xout = std(xout);
  meanval_xout = mean(xout);
  % Read in timestamps file to find the number of SFTs used:
  timestampFileName = sprintf('%s_timestamps',filename);
  [ntmp, ttmp] = textread(timestampFileName,'%f %f');
  % Computed expected 5 sigma cutoff for gaussian noise:
  cutoffmax = 1.0 + 5.0/sqrt(length(ntmp));
  % avoid too small of a maximum cutoff:
  if cutoffmax < 4;
     cutoffmax = 4;
  end
  % compute cutoff from data, but do not exceed cutoffmax:
  cutoff = meanval_xout+(5*stdev_xout);
  if cutoff > cutoffmax;
    cutoff = cutoffmax;
  end
  for jj=1:length(xout);
      if xout(jj)>=cutoff;%cg; xout is one of the properties plotted.
          xout(jj)=cutoff;
      end
  end
%cg; Plot the normalised average power vs freq
%-------------------------------------------------
%cg; this uses the blah_blah_blah_timeaverage file output fropm spec_avg.c
  plot(fk,xout)
  titleString = sprintf('Spectrum for %s; averaged over %s  to  %s UTC.' ,chanName,startDateTime,endDateTime);;
  title(titleString,'Interpreter','none');
  ylabel('Normalized Average Power');
  xlabel('Frequency (Hz)');
  
  fclose(fid);
  fclose(fid2);

    if (thresholdSNR > 0)%only look for lines if threshold SNR has been set.
    % input the reference file and look for coincidence lines above thresholdSNR
    %----------------------------------------------------------------------------
    timeaverageFileNameRef = sprintf('%s_timeaverage',referenceFile);
    [fRef, xRef] = textread(timeaverageFileNameRef,'%f %f');
    %set up file for outputting coindcident lines
    %---------------------------------------------
    outputTextFileLines = sprintf('%s_coincident_lines.txt',outputFileName);
    fid3 = fopen(outputTextFileLines,'w');
    fprintf(fid3,'\n       COINCIDENT LINES       \n');
    fprintf(fid3,' \n');
    fprintf(fid3,'             INPUT                             REFERENCE          \n');
    fprintf(fid3,' Freq. (Hz)   Power      SNR       Freq. (Hz)   Power      SNR    \n');
    fprintf(fid3,' \n');
    %----------------------------------------------
    %set up file for new lines
    %----------------------------------------------
    outputTextFileNewLines = sprintf('%s_new_lines.txt',outputFileName);
    fid4 = fopen(outputTextFileNewLines,'w');
    fprintf(fid4,'\n       NEW LINES       \n');
    fprintf(fid4,' \n');
    fprintf(fid4,'             INPUT                 \n');
    fprintf(fid4,' Freq. (Hz)   Power      SNR       \n');
    fprintf(fid4,' \n');
    %----------------------------------------------
    %set up file for old lines
    %----------------------------------------------
    outputTextFileOldLines = sprintf('%s_old_lines.txt',outputFileName);
    fid5 = fopen(outputTextFileOldLines,'w');
    fprintf(fid5,'\n       OLD LINES       \n');
    fprintf(fid5,' \n');
    fprintf(fid5,'             INPUT                 \n');
    fprintf(fid5,' Freq. (Hz)   Power      SNR       \n');
    fprintf(fid5,' \n');
    %----------------------------------------------
    %get variables ready for line finding.
    %-------------------------------------
    xoutMean = mean(xout);
    oneOverxoutSTD = 1.0/std(xout);
    xRefMean = mean(xRef);
    oneOverxRefSTD = 1.0/std(xRef);
    SNRout = (xout - xoutMean)*oneOverxoutSTD;%SNR of current data
    SNRRef = (xRef - xRefMean)*oneOverxRefSTD;%SNR of reference data
    lengthSNRout = length(SNRout);
    skip = 0;
    iMax = 0;   
    coincidenceBins = ceil(coinDF*effTBaseFull); %coinDF -- window in frequency to use when looking for coincident lines.  This maybe works out the number of bins over which to compare lines.
    
    %now find the lines...
    for j = 1:lengthSNRout  %this loop checks every element in the timeaverage files, i.e. every line.
	if (skip == 0)%if true look for coincident lines.
	    jMin = j - coincidenceBins;%finds the earliest bin for which to compare
	    if (jMin < 1); jMin = 1; end;%makes sure that jmin cant be less than 1.
	    jMax = j + coincidenceBins;%finds the latest bin for which to compare
	    if (jMax > lengthSNRout); jMax = lengthSNRout; end;%makes sure that jmax cant be off the end of the file.
	    [SNRoutmax, iMaxout] = max(SNRout(jMin:jMax));%finds the peak in the current window, and finds the bin number relative to j of this peak. Current data
	    iMaxout = jMin + iMaxout - 1;%finds position of peak in terms of j.
	    [SNRRefmax, iMaxRef] = max(SNRRef(jMin:jMax));%finds the peak in ref data in current window and bin number
	    iMaxRef = jMin + iMaxRef - 1;%finds position of peak in terms of j.
	    if ( (SNRoutmax >= thresholdSNR) && (SNRRefmax >= thresholdSNR) )%if both peaks are above the threshoild SNR it is a coincident line.
	    skip = 1;%dont check for lines again until outside of window
	    fprintf(fid3,' %11.6f  %9.4f  %7.2f    %11.6f  %9.4f  %7.2f\n',fk(iMaxout),xout(iMaxout),SNRoutmax,fRef(iMaxRef),xRef(iMaxRef),SNRRefmax);
	    %add this entry to the lines array
%  	    out=1;
%  	    ii=1;
%  	    while (ii < 11) && (out > 0)
%  		if fk(iMaxout) > snrlines(ii)
%  		    snrlines(ii) = fk(iMaxout);
%  		    snrfreqs = xout(iMaxout);
%  		    out = 0;
%  		end
%  		ii=ii+1;
%  	    end
	    %snrlines(j)=fk(iMaxout);
	    %snrfreqs(j)=xout(iMaxout);
	    elseif ( (SNRoutmax >= thresholdSNR) && (SNRRefmax < thresholdSNR) )%if current line is above thresh SNR but reference is not, it is a new line
	    skip = 1;%dont check for lines again until outside of window
	    fprintf(fid4,' %11.6f  %9.4f  %7.2f\n',fk(iMaxout),xout(iMaxout),SNRoutmax);
%  	    out=1;
%  	    ii=1;
%  	    while (ii < 11) && (out > 0)
%  		if fk(iMaxout) > snrlines(ii)
%  		    snrlines(ii) = fk(iMaxout);
%  		    snrfreqs = xout(iMaxout);
%  		    out = 0;
%  		end
%  		ii=ii+1;
%  	    end
	    %snrlines(j)=fk(iMaxout);
	    %snrfreqs(j)=xout(iMaxout);
	    elseif ( (SNRoutmax < thresholdSNR) && (SNRRefmax >= thresholdSNR) )%if current line is above thresh SNR but reference is not, it is a new line
	    skip = 1;%dont check for lines again until outside of window
	    fprintf(fid5,' %11.6f  %9.4f  %7.2f\n',fk(iMaxout),xout(iMaxout),SNRoutmax);
	    end
	else%if skip !=0, a coincident line has been found, so dont check the next bin until we are outisde of the window.
	    if ((j - iMaxRef) > coincidenceBins) && ((j - iMaxout) > coincidenceBins); skip = 0; end;%if this is true, it will look for coincident lines in the next bin, if not it will skip the next bin.  Is true when j is outisde of window where coincident line ahs been found.
	end
    end
    fclose(fid3);
    fclose(fid4);
    fclose(fid5);
    end
    %---------
    %now find and print to file the top ten lines in the lines array.
    
%      outputtopten = sprintf('%s_topten.txt',outputFileName);
%      [snrlinesSorted,iSorted] = sort(snrlines,'descend');
%      snrfreqsSorted = snrfreqs(iSorted);
%      fid = fopen(outputtopten,'w');
%      for k = 1:10
%  	if (snrlinesSorted(k) > 0)
%  	fprintf(fid,'%f %f\n',snrlinesSorted(k),snrfreqsSorted(k));
%  	end
%      end

    %---------------------------------------------------------------------------------
  
  outputFileName2 = sprintf('%s_2',outputFileName);
	
  print('-dpng',[outputFileName2 '.png'])
  set(gcf, 'PaperUnits', 'centimeters');
  set (gcf, 'PaperOrientation', 'landscape', 'PaperType', 'A4', 'PaperPosition', [0 0 30 20] );
  print('-dpdf','-loose',[outputFileName2 '.pdf'])
  delete(2);
end

%-------------------------------------------
%cg; this bit just does the final outputs, the png file and the pdf file of the spectrogram

%  print('-dpng',[outputFileName '.png'])
%  set(gcf, 'PaperOrientation', 'landscape');
%  set(gcf, 'PaperPosition', [0 0 11 8.5]);
%  print('-dpdf','-loose',[outputFileName '.pdf'])






return;
