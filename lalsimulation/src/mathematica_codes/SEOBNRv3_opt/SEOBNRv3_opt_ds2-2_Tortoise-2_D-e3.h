REAL8 tmp1=x->data[0]*x->data[0];
REAL8 tmp2=x->data[1]*x->data[1];
REAL8 tmp3=x->data[2]*x->data[2];
REAL8 tmp4=tmp1+tmp2+tmp3;
REAL8 tmp9=s1Vec->data[1]+s2Vec->data[1];
REAL8 tmp7=s1Vec->data[0]+s2Vec->data[0];
REAL8 tmp8=tmp7*tmp7;
REAL8 tmp10=tmp9*tmp9;
REAL8 tmp11=s1Vec->data[2]+s2Vec->data[2];
REAL8 tmp12=tmp11*tmp11;
REAL8 tmp13=tmp10+tmp12+tmp8;
REAL8 tmp15=1./sqrt(tmp13);
REAL8 tmp16=tmp15*tmp9;
REAL8 tmp17=0.1+tmp16;
REAL8 tmp20=tmp15*tmp7;
REAL8 tmp21=0.1+tmp20;
REAL8 tmp18=1/tmp13;
REAL8 tmp19=tmp12*tmp18;
REAL8 tmp22=tmp21*tmp21;
REAL8 tmp23=tmp17*tmp17;
REAL8 tmp24=tmp19+tmp22+tmp23;
REAL8 tmp25=1./sqrt(tmp24);
REAL8 tmp26=1./sqrt(tmp4);
REAL8 tmp5=(1.0/(tmp4*tmp4));
REAL8 tmp53=1/tmp4;
REAL8 tmp56=coeffs->KK*eta;
REAL8 tmp57=-1.+tmp56;
REAL8 tmp45=pow(tmp4,-2.5);
REAL8 tmp72=tmp13*tmp13;
REAL8 tmp51=(1.0/sqrt(tmp4*tmp4*tmp4));
REAL8 tmp58=(1.0/(tmp57*tmp57));
REAL8 tmp59=1.*tmp58;
REAL8 tmp60=1.*tmp13*tmp53;
REAL8 tmp61=1/tmp57;
REAL8 tmp62=2.*tmp26*tmp61;
REAL8 tmp63=tmp59+tmp60+tmp62;
REAL8 tmp100=(1.0/sqrt(tmp13*tmp13*tmp13));
REAL8 tmp96=(tmp11*tmp11*tmp11);
REAL8 tmp97=(1.0/(tmp13*tmp13));
REAL8 tmp98=-2.*tmp96*tmp97;
REAL8 tmp99=2.*tmp11*tmp18;
REAL8 tmp101=-2.*tmp100*tmp11*tmp21*tmp7;
REAL8 tmp102=-2.*tmp100*tmp11*tmp17*tmp9;
REAL8 tmp103=tmp101+tmp102+tmp98+tmp99;
REAL8 tmp104=(1.0/sqrt(tmp24*tmp24*tmp24));
REAL8 tmp64=1.*tmp21*tmp25*tmp26*x->data[0];
REAL8 tmp65=1.*tmp17*tmp25*tmp26*x->data[1];
REAL8 tmp66=1.*tmp11*tmp15*tmp25*tmp26*x->data[2];
REAL8 tmp67=tmp64+tmp65+tmp66;
REAL8 tmp86=-1.+m1PlusEtaKK;
REAL8 tmp71=c1k5*tmp13;
REAL8 tmp73=c2k5*tmp72;
REAL8 tmp74=c0k5+tmp71+tmp73;
REAL8 tmp75=1.*tmp45*tmp74;
REAL8 tmp76=c1k4*tmp13;
REAL8 tmp77=c2k4*tmp72;
REAL8 tmp78=c0k4+tmp76+tmp77;
REAL8 tmp79=1.*tmp5*tmp78;
REAL8 tmp80=c1k3*tmp13;
REAL8 tmp81=c0k3+tmp80;
REAL8 tmp82=1.*tmp51*tmp81;
REAL8 tmp83=c1k2*tmp13;
REAL8 tmp84=c0k2+tmp83;
REAL8 tmp85=1.*tmp53*tmp84;
REAL8 tmp87=coeffs->KK*tmp86;
REAL8 tmp88=coeffs->KK+tmp87;
REAL8 tmp89=-2.*m1PlusEtaKK*tmp26*tmp88;
REAL8 tmp90=1.*tmp26;
REAL8 tmp91=log(tmp90);
REAL8 tmp92=1.*coeffs->k5l*tmp45*tmp91;
REAL8 tmp93=1.+tmp75+tmp79+tmp82+tmp85+tmp89+tmp92;
REAL8 tmp68=tmp67*tmp67;
REAL8 tmp69=-tmp68;
REAL8 tmp70=1.+tmp69;
REAL8 tmp113=coeffs->KK*eta*tmp86;
REAL8 tmp114=log(tmp93);
REAL8 tmp115=eta*tmp114;
REAL8 tmp116=1.+tmp113+tmp115;
REAL8 tmp40=tmp1+tmp10+tmp12+tmp2+tmp3+tmp8;
REAL8 tmp14=sqrt(tmp13);
REAL8 tmp121=tmp40*tmp40;
REAL8 tmp122=-(tmp116*tmp13*tmp4*tmp63*tmp70);
REAL8 tmp123=tmp121+tmp122;
REAL8 tmp27=-(tmp17*tmp25*tmp26*x->data[0]);
REAL8 tmp28=1.*tmp21*tmp25*tmp26*x->data[1];
REAL8 tmp29=tmp27+tmp28;
REAL8 tmp30=p->data[2]*tmp29;
REAL8 tmp31=1.*tmp11*tmp15*tmp25*tmp26*x->data[0];
REAL8 tmp32=-(tmp21*tmp25*tmp26*x->data[2]);
REAL8 tmp33=tmp31+tmp32;
REAL8 tmp34=p->data[1]*tmp33;
REAL8 tmp35=-(tmp11*tmp15*tmp25*tmp26*x->data[1]);
REAL8 tmp36=1.*tmp17*tmp25*tmp26*x->data[2];
REAL8 tmp37=tmp35+tmp36;
REAL8 tmp38=p->data[0]*tmp37;
REAL8 tmp39=tmp30+tmp34+tmp38;
REAL8 tmp147=1/tmp123;
REAL8 tmp151=tmp13*tmp68;
REAL8 tmp152=tmp1+tmp151+tmp2+tmp3;
REAL8 tmp153=1/tmp152;
REAL8 tmp126=0.5*tmp103*tmp104*tmp17*tmp26*x->data[0];
REAL8 tmp127=1.*tmp100*tmp11*tmp25*tmp26*tmp9*x->data[0];
REAL8 tmp128=-0.5*tmp103*tmp104*tmp21*tmp26*x->data[1];
REAL8 tmp129=-(tmp100*tmp11*tmp25*tmp26*tmp7*x->data[1]);
REAL8 tmp130=tmp126+tmp127+tmp128+tmp129;
REAL8 tmp132=-0.5*tmp103*tmp104*tmp11*tmp15*tmp26*x->data[0];
REAL8 tmp133=-(tmp100*tmp12*tmp25*tmp26*x->data[0]);
REAL8 tmp134=1.*tmp15*tmp25*tmp26*x->data[0];
REAL8 tmp135=0.5*tmp103*tmp104*tmp21*tmp26*x->data[2];
REAL8 tmp136=1.*tmp100*tmp11*tmp25*tmp26*tmp7*x->data[2];
REAL8 tmp137=tmp132+tmp133+tmp134+tmp135+tmp136;
REAL8 tmp139=0.5*tmp103*tmp104*tmp11*tmp15*tmp26*x->data[1];
REAL8 tmp140=1.*tmp100*tmp12*tmp25*tmp26*x->data[1];
REAL8 tmp141=-(tmp15*tmp25*tmp26*x->data[1]);
REAL8 tmp142=-0.5*tmp103*tmp104*tmp17*tmp26*x->data[2];
REAL8 tmp143=-(tmp100*tmp11*tmp25*tmp26*tmp9*x->data[2]);
REAL8 tmp144=tmp139+tmp140+tmp141+tmp142+tmp143;
REAL8 tmp157=1/tmp70;
REAL8 tmp105=-0.5*tmp103*tmp104*tmp21*tmp26*x->data[0];
REAL8 tmp106=-(tmp100*tmp11*tmp25*tmp26*tmp7*x->data[0]);
REAL8 tmp107=-0.5*tmp103*tmp104*tmp17*tmp26*x->data[1];
REAL8 tmp108=-(tmp100*tmp11*tmp25*tmp26*tmp9*x->data[1]);
REAL8 tmp109=-0.5*tmp103*tmp104*tmp11*tmp15*tmp26*x->data[2];
REAL8 tmp110=-(tmp100*tmp12*tmp25*tmp26*x->data[2]);
REAL8 tmp111=1.*tmp15*tmp25*tmp26*x->data[2];
REAL8 tmp112=tmp105+tmp106+tmp107+tmp108+tmp109+tmp110+tmp111;
REAL8 tmp171=tmp26*tmp29*x->data[1];
REAL8 tmp172=-(tmp26*tmp33*x->data[2]);
REAL8 tmp173=tmp171+tmp172;
REAL8 tmp174=p->data[0]*tmp173;
REAL8 tmp175=tmp26*tmp33*x->data[0];
REAL8 tmp176=-(tmp26*tmp37*x->data[1]);
REAL8 tmp177=tmp175+tmp176;
REAL8 tmp178=p->data[2]*tmp177;
REAL8 tmp179=-(tmp26*tmp29*x->data[0]);
REAL8 tmp180=tmp26*tmp37*x->data[2];
REAL8 tmp181=tmp179+tmp180;
REAL8 tmp182=p->data[1]*tmp181;
REAL8 tmp183=tmp174+tmp178+tmp182;
REAL8 tmp189=tmp183*tmp183;
REAL8 tmp42=2.*c1k5*tmp11;
REAL8 tmp43=4.*c2k5*tmp11*tmp13;
REAL8 tmp44=tmp42+tmp43;
REAL8 tmp46=1.*tmp44*tmp45;
REAL8 tmp47=2.*c1k4*tmp11;
REAL8 tmp48=4.*c2k4*tmp11*tmp13;
REAL8 tmp49=tmp47+tmp48;
REAL8 tmp50=1.*tmp49*tmp5;
REAL8 tmp52=2.*c1k3*tmp11*tmp51;
REAL8 tmp54=2.*c1k2*tmp11*tmp53;
REAL8 tmp55=tmp46+tmp50+tmp52+tmp54;
REAL8 tmp94=1/tmp93;
REAL8 tmp193=p->data[0]*tmp26*x->data[0];
REAL8 tmp194=p->data[1]*tmp26*x->data[1];
REAL8 tmp195=p->data[2]*tmp26*x->data[2];
REAL8 tmp196=tmp193+tmp194+tmp195;
REAL8 tmp197=tmp196*tmp196;
REAL8 tmp185=2.*tmp112*tmp13*tmp67;
REAL8 tmp186=2.*tmp11*tmp68;
REAL8 tmp187=tmp185+tmp186;
REAL8 tmp188=(1.0/(tmp152*tmp152));
REAL8 tmp198=-3.*eta;
REAL8 tmp199=26.+tmp198;
REAL8 tmp200=2.*eta*tmp199*tmp51;
REAL8 tmp201=6.*eta*tmp53;
REAL8 tmp202=1.+tmp200+tmp201;
REAL8 tmp203=log(tmp202);
REAL8 tmp204=1.+tmp203;
REAL8 tmp208=4.+tmp198;
REAL8 tmp211=1./(tmp40*tmp40*tmp40*tmp40);
REAL8 tmp213=(tmp196*tmp196*tmp196*tmp196);
REAL8 tmp214=tmp204*tmp204;
REAL8 tmp210=(tmp4*tmp4*tmp4);
REAL8 tmp212=(tmp63*tmp63*tmp63*tmp63);
REAL8 tmp219=(tmp116*tmp116*tmp116*tmp116);
REAL8 tmp41=4.*tmp11*tmp40;
REAL8 tmp95=-(eta*tmp13*tmp4*tmp55*tmp63*tmp70*tmp94);
REAL8 tmp117=2.*tmp112*tmp116*tmp13*tmp4*tmp63*tmp67;
REAL8 tmp118=-2.*tmp11*tmp116*tmp13*tmp70;
REAL8 tmp119=-2.*tmp11*tmp116*tmp4*tmp63*tmp70;
REAL8 tmp120=tmp117+tmp118+tmp119+tmp41+tmp95;
REAL8 tmp124=(1.0/(tmp123*tmp123));
REAL8 tmp131=p->data[2]*tmp130;
REAL8 tmp138=p->data[1]*tmp137;
REAL8 tmp145=p->data[0]*tmp144;
REAL8 tmp146=tmp131+tmp138+tmp145;
REAL8 tmp223=tmp39*tmp39;
REAL8 tmp191=(1.0/(tmp70*tmp70));
REAL8 tmp150=1/tmp63;
REAL8 tmp154=1/tmp116;
REAL8 tmp155=tmp123*tmp150*tmp153*tmp154*tmp53;
REAL8 tmp229=tmp153*tmp157*tmp189*tmp4;
REAL8 tmp230=tmp116*tmp153*tmp197*tmp204*tmp4*tmp63;
REAL8 tmp231=2.*eta*tmp208*tmp210*tmp211*tmp212*tmp213*tmp214*tmp219;
REAL8 tmp232=tmp147*tmp152*tmp157*tmp223*tmp4;
REAL8 tmp233=1.+tmp229+tmp230+tmp231+tmp232;
REAL8 tmp247=sqrt(tmp4*tmp4*tmp4);
REAL8 tmp249=1/mass1;
REAL8 tmp250=mass2*s1Vec->data[0]*tmp249;
REAL8 tmp251=1/mass2;
REAL8 tmp252=mass1*s2Vec->data[0]*tmp251;
REAL8 tmp253=tmp250+tmp252;
REAL8 tmp246=sqrt(tmp4);
REAL8 tmp158=tmp130*tmp26*x->data[1];
REAL8 tmp159=-(tmp137*tmp26*x->data[2]);
REAL8 tmp160=tmp158+tmp159;
REAL8 tmp161=p->data[0]*tmp160;
REAL8 tmp162=tmp137*tmp26*x->data[0];
REAL8 tmp163=-(tmp144*tmp26*x->data[1]);
REAL8 tmp164=tmp162+tmp163;
REAL8 tmp165=p->data[2]*tmp164;
REAL8 tmp166=-(tmp130*tmp26*x->data[0]);
REAL8 tmp167=tmp144*tmp26*x->data[2];
REAL8 tmp168=tmp166+tmp167;
REAL8 tmp169=p->data[1]*tmp168;
REAL8 tmp170=tmp161+tmp165+tmp169;
REAL8 tmp184=2.*tmp153*tmp157*tmp170*tmp183*tmp4;
REAL8 tmp190=-(tmp157*tmp187*tmp188*tmp189*tmp4);
REAL8 tmp192=2.*tmp112*tmp153*tmp189*tmp191*tmp4*tmp67;
REAL8 tmp205=eta*tmp153*tmp197*tmp204*tmp4*tmp55*tmp63*tmp94;
REAL8 tmp206=-(tmp116*tmp187*tmp188*tmp197*tmp204*tmp4*tmp63);
REAL8 tmp207=2.*tmp11*tmp116*tmp153*tmp197*tmp204;
REAL8 tmp224=-(tmp120*tmp124*tmp152*tmp157*tmp223*tmp4);
REAL8 tmp225=2.*tmp146*tmp147*tmp152*tmp157*tmp39*tmp4;
REAL8 tmp226=tmp147*tmp157*tmp187*tmp223*tmp4;
REAL8 tmp227=2.*tmp112*tmp147*tmp152*tmp191*tmp223*tmp4*tmp67;
REAL8 tmp259=tmp184+tmp190+tmp192+tmp205+tmp206+tmp207+tmp224+tmp225+tmp226+tmp227;
REAL8 tmp209=eta*eta;
REAL8 tmp265=tmp63*tmp63;
REAL8 tmp217=tmp4*tmp4;
REAL8 tmp268=tmp116*tmp116;
REAL8 tmp275=-16.*eta;
REAL8 tmp276=21.*tmp209;
REAL8 tmp277=tmp275+tmp276;
REAL8 tmp281=0.+tmp229+tmp230+tmp232;
REAL8 tmp283=-47.*eta;
REAL8 tmp284=54.*tmp209;
REAL8 tmp285=tmp246*tmp277*tmp281;
REAL8 tmp286=tmp283+tmp284+tmp285;
REAL8 tmp264=(eta*eta*eta);
REAL8 tmp267=1./(tmp152*tmp152*tmp152);
REAL8 tmp299=-6.*eta;
REAL8 tmp300=39.*tmp209;
REAL8 tmp301=tmp299+tmp300;
REAL8 tmp304=16.*eta;
REAL8 tmp305=147.*tmp209;
REAL8 tmp306=tmp246*tmp281*tmp301;
REAL8 tmp307=tmp304+tmp305+tmp306;
REAL8 tmp316=mass2*s1Vec->data[1]*tmp249;
REAL8 tmp317=mass1*s2Vec->data[1]*tmp251;
REAL8 tmp318=tmp316+tmp317;
REAL8 tmp266=-720.*tmp116*tmp188*tmp210*tmp213*tmp214*tmp264*tmp265*tmp55*tmp94;
REAL8 tmp269=720.*tmp187*tmp209*tmp210*tmp213*tmp214*tmp265*tmp267*tmp268;
REAL8 tmp270=-1440.*tmp11*tmp188*tmp209*tmp213*tmp214*tmp217*tmp268*tmp63;
REAL8 tmp271=103.*eta;
REAL8 tmp272=-60.*tmp209;
REAL8 tmp273=tmp271+tmp272;
REAL8 tmp274=2.*tmp246*tmp259*tmp273;
REAL8 tmp278=6.*tmp116*tmp153*tmp197*tmp204*tmp217*tmp259*tmp277*tmp63;
REAL8 tmp279=3.*eta;
REAL8 tmp280=23.+tmp279;
REAL8 tmp282=2.*eta*tmp259*tmp280*tmp281*tmp4;
REAL8 tmp287=6.*eta*tmp153*tmp197*tmp204*tmp247*tmp286*tmp55*tmp63*tmp94;
REAL8 tmp288=-6.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp286*tmp63;
REAL8 tmp289=12.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp286;
REAL8 tmp290=tmp266+tmp269+tmp270+tmp274+tmp278+tmp282+tmp287+tmp288+tmp289;
REAL8 tmp292=1620.*tmp116*tmp188*tmp210*tmp213*tmp214*tmp264*tmp265*tmp55*tmp94;
REAL8 tmp293=-1620.*tmp187*tmp209*tmp210*tmp213*tmp214*tmp265*tmp267*tmp268;
REAL8 tmp294=3240.*tmp11*tmp188*tmp209*tmp213*tmp214*tmp217*tmp268*tmp63;
REAL8 tmp295=-109.*eta;
REAL8 tmp296=51.*tmp209;
REAL8 tmp297=tmp295+tmp296;
REAL8 tmp298=4.*tmp246*tmp259*tmp297;
REAL8 tmp302=-6.*tmp116*tmp153*tmp197*tmp204*tmp217*tmp259*tmp301*tmp63;
REAL8 tmp303=-90.*eta*tmp259*tmp281*tmp4;
REAL8 tmp308=-6.*eta*tmp153*tmp197*tmp204*tmp247*tmp307*tmp55*tmp63*tmp94;
REAL8 tmp309=6.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp307*tmp63;
REAL8 tmp310=-12.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp307;
REAL8 tmp311=tmp292+tmp293+tmp294+tmp298+tmp302+tmp303+tmp308+tmp309+tmp310;
REAL8 tmp336=mass2*s1Vec->data[2]*tmp249;
REAL8 tmp337=mass1*s2Vec->data[2]*tmp251;
REAL8 tmp338=tmp336+tmp337;
REAL8 tmp358=tmp281*tmp281;
REAL8 tmp353=27.*eta;
REAL8 tmp354=-353.+tmp353;
REAL8 tmp355=2.*eta*tmp354;
REAL8 tmp356=-360.*tmp188*tmp209*tmp210*tmp213*tmp214*tmp265*tmp268;
REAL8 tmp357=2.*tmp246*tmp273*tmp281;
REAL8 tmp359=eta*tmp280*tmp358*tmp4;
REAL8 tmp360=6.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp286*tmp63;
REAL8 tmp361=tmp355+tmp356+tmp357+tmp359+tmp360;
REAL8 tmp364=8.+tmp279;
REAL8 tmp365=-112.*eta*tmp364;
REAL8 tmp366=810.*tmp188*tmp209*tmp210*tmp213*tmp214*tmp265*tmp268;
REAL8 tmp367=4.*tmp246*tmp281*tmp297;
REAL8 tmp368=-45.*eta*tmp358*tmp4;
REAL8 tmp369=-6.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp307*tmp63;
REAL8 tmp370=tmp365+tmp366+tmp367+tmp368+tmp369;
REAL8 tmp374=coeffs->d1v2*eta*tmp51*tmp7;
REAL8 tmp375=-8.*tmp7;
REAL8 tmp376=14.*tmp253;
REAL8 tmp377=-36.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp63*tmp7;
REAL8 tmp378=-30.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp253*tmp63;
REAL8 tmp379=3.*tmp246*tmp281*tmp7;
REAL8 tmp380=4.*tmp246*tmp253*tmp281;
REAL8 tmp381=tmp375+tmp376+tmp377+tmp378+tmp379+tmp380;
REAL8 tmp382=0.08333333333333333*eta*tmp26*tmp381;
REAL8 tmp383=-0.013888888888888888*tmp253*tmp361*tmp53;
REAL8 tmp384=0.006944444444444444*tmp370*tmp53*tmp7;
REAL8 tmp385=tmp250+tmp252+tmp374+tmp382+tmp383+tmp384;
REAL8 tmp388=coeffs->d1v2*eta*tmp51*tmp9;
REAL8 tmp389=-8.*tmp9;
REAL8 tmp390=14.*tmp318;
REAL8 tmp391=-36.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp63*tmp9;
REAL8 tmp392=-30.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp318*tmp63;
REAL8 tmp393=3.*tmp246*tmp281*tmp9;
REAL8 tmp394=4.*tmp246*tmp281*tmp318;
REAL8 tmp395=tmp389+tmp390+tmp391+tmp392+tmp393+tmp394;
REAL8 tmp396=0.08333333333333333*eta*tmp26*tmp395;
REAL8 tmp397=-0.013888888888888888*tmp318*tmp361*tmp53;
REAL8 tmp398=0.006944444444444444*tmp370*tmp53*tmp9;
REAL8 tmp399=tmp316+tmp317+tmp388+tmp396+tmp397+tmp398;
REAL8 tmp402=coeffs->d1v2*eta*tmp11*tmp51;
REAL8 tmp403=-8.*tmp11;
REAL8 tmp404=14.*tmp338;
REAL8 tmp405=-36.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp247*tmp63;
REAL8 tmp406=-30.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp338*tmp63;
REAL8 tmp407=3.*tmp11*tmp246*tmp281;
REAL8 tmp408=4.*tmp246*tmp281*tmp338;
REAL8 tmp409=tmp403+tmp404+tmp405+tmp406+tmp407+tmp408;
REAL8 tmp410=0.08333333333333333*eta*tmp26*tmp409;
REAL8 tmp411=-0.013888888888888888*tmp338*tmp361*tmp53;
REAL8 tmp412=0.006944444444444444*tmp11*tmp370*tmp53;
REAL8 tmp413=tmp336+tmp337+tmp402+tmp410+tmp411+tmp412;
REAL8 tmp419=sqrt(tmp152);
REAL8 tmp248=-36.*eta*tmp153*tmp197*tmp204*tmp247*tmp55*tmp63*tmp7*tmp94;
REAL8 tmp254=-30.*eta*tmp153*tmp197*tmp204*tmp247*tmp253*tmp55*tmp63*tmp94;
REAL8 tmp255=36.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp63*tmp7;
REAL8 tmp256=30.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp253*tmp63;
REAL8 tmp257=-72.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp7;
REAL8 tmp258=-60.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp253;
REAL8 tmp260=3.*tmp246*tmp259*tmp7;
REAL8 tmp261=4.*tmp246*tmp253*tmp259;
REAL8 tmp262=tmp248+tmp254+tmp255+tmp256+tmp257+tmp258+tmp260+tmp261;
REAL8 tmp263=0.08333333333333333*eta*tmp26*tmp262;
REAL8 tmp291=-0.013888888888888888*tmp253*tmp290*tmp53;
REAL8 tmp312=0.006944444444444444*tmp311*tmp53*tmp7;
REAL8 tmp313=tmp263+tmp291+tmp312;
REAL8 tmp314=1.*tmp21*tmp25*tmp313;
REAL8 tmp315=-36.*eta*tmp153*tmp197*tmp204*tmp247*tmp55*tmp63*tmp9*tmp94;
REAL8 tmp319=-30.*eta*tmp153*tmp197*tmp204*tmp247*tmp318*tmp55*tmp63*tmp94;
REAL8 tmp320=36.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp63*tmp9;
REAL8 tmp321=30.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp318*tmp63;
REAL8 tmp322=-72.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp9;
REAL8 tmp323=-60.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp318;
REAL8 tmp324=3.*tmp246*tmp259*tmp9;
REAL8 tmp325=4.*tmp246*tmp259*tmp318;
REAL8 tmp326=tmp315+tmp319+tmp320+tmp321+tmp322+tmp323+tmp324+tmp325;
REAL8 tmp327=0.08333333333333333*eta*tmp26*tmp326;
REAL8 tmp328=-0.013888888888888888*tmp290*tmp318*tmp53;
REAL8 tmp329=0.006944444444444444*tmp311*tmp53*tmp9;
REAL8 tmp330=tmp327+tmp328+tmp329;
REAL8 tmp331=1.*tmp17*tmp25*tmp330;
REAL8 tmp332=mass1*tmp251;
REAL8 tmp333=coeffs->d1v2*eta*tmp51;
REAL8 tmp334=14.*mass1*tmp251;
REAL8 tmp335=-36.*eta*tmp11*tmp153*tmp197*tmp204*tmp247*tmp55*tmp63*tmp94;
REAL8 tmp339=-30.*eta*tmp153*tmp197*tmp204*tmp247*tmp338*tmp55*tmp63*tmp94;
REAL8 tmp340=36.*tmp11*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp63;
REAL8 tmp341=30.*tmp116*tmp187*tmp188*tmp197*tmp204*tmp247*tmp338*tmp63;
REAL8 tmp342=-72.*tmp116*tmp12*tmp153*tmp197*tmp204*tmp246;
REAL8 tmp343=-60.*tmp11*tmp116*tmp153*tmp197*tmp204*tmp246*tmp338;
REAL8 tmp344=-36.*tmp116*tmp153*tmp197*tmp204*tmp247*tmp63;
REAL8 tmp345=-30.*mass1*tmp116*tmp153*tmp197*tmp204*tmp247*tmp251*tmp63;
REAL8 tmp346=3.*tmp11*tmp246*tmp259;
REAL8 tmp347=4.*tmp246*tmp259*tmp338;
REAL8 tmp348=3.*tmp246*tmp281;
REAL8 tmp349=4.*mass1*tmp246*tmp251*tmp281;
REAL8 tmp350=-8.+tmp334+tmp335+tmp339+tmp340+tmp341+tmp342+tmp343+tmp344+tmp345+tmp346+tmp347+tmp348+tmp349;
REAL8 tmp351=0.08333333333333333*eta*tmp26*tmp350;
REAL8 tmp352=-0.013888888888888888*tmp290*tmp338*tmp53;
REAL8 tmp362=-0.013888888888888888*mass1*tmp251*tmp361*tmp53;
REAL8 tmp363=0.006944444444444444*tmp11*tmp311*tmp53;
REAL8 tmp371=0.006944444444444444*tmp370*tmp53;
REAL8 tmp372=tmp332+tmp333+tmp351+tmp352+tmp362+tmp363+tmp371;
REAL8 tmp373=1.*tmp11*tmp15*tmp25*tmp372;
REAL8 tmp386=-0.5*tmp103*tmp104*tmp21*tmp385;
REAL8 tmp387=-(tmp100*tmp11*tmp25*tmp385*tmp7);
REAL8 tmp400=-0.5*tmp103*tmp104*tmp17*tmp399;
REAL8 tmp401=-(tmp100*tmp11*tmp25*tmp399*tmp9);
REAL8 tmp414=-0.5*tmp103*tmp104*tmp11*tmp15*tmp413;
REAL8 tmp415=-(tmp100*tmp12*tmp25*tmp413);
REAL8 tmp416=1.*tmp15*tmp25*tmp413;
REAL8 tmp417=tmp314+tmp331+tmp373+tmp386+tmp387+tmp400+tmp401+tmp414+tmp415+tmp416;
REAL8 tmp430=1.*tmp21*tmp25*tmp385;
REAL8 tmp431=1.*tmp17*tmp25*tmp399;
REAL8 tmp432=1.*tmp11*tmp15*tmp25*tmp413;
REAL8 tmp433=tmp430+tmp431+tmp432;
REAL8 tmp420=tmp116*tmp4*tmp63;
REAL8 tmp421=sqrt(tmp420);
REAL8 tmp422=-tmp421;
REAL8 tmp423=tmp116*tmp147*tmp152*tmp4*tmp63;
REAL8 tmp424=sqrt(tmp423);
REAL8 tmp425=tmp419*tmp424;
REAL8 tmp426=tmp422+tmp425;
REAL8 tmp427=1.+tmp229+tmp230+tmp232;
REAL8 tmp428=1./sqrt(tmp427);
REAL8 tmp440=1./sqrt(tmp152);
REAL8 tmp443=1./sqrt(tmp420);
REAL8 tmp449=1./sqrt(tmp423);
REAL8 tmp475=sqrt(tmp427);
REAL8 tmp465=tmp26*tmp385*x->data[0];
REAL8 tmp466=tmp26*tmp399*x->data[1];
REAL8 tmp467=tmp26*tmp413*x->data[2];
REAL8 tmp468=tmp465+tmp466+tmp467;
REAL8 tmp472=sqrt(tmp13*tmp13*tmp13);
REAL8 tmp473=(1.0/sqrt(tmp152*tmp152*tmp152));
REAL8 tmp436=(1.0/sqrt(tmp427*tmp427*tmp427));
REAL8 tmp476=1.+tmp475;
REAL8 tmp478=tmp152*tmp152;
REAL8 tmp479=-(tmp116*tmp147*tmp217*tmp223*tmp478*tmp63);
REAL8 tmp480=tmp189*tmp4;
REAL8 tmp481=1.+tmp229+tmp230+tmp232+tmp475;
REAL8 tmp482=-(tmp152*tmp481*tmp70);
REAL8 tmp483=tmp480+tmp482;
REAL8 tmp484=tmp116*tmp4*tmp483*tmp63;
REAL8 tmp485=tmp479+tmp484;
REAL8 tmp486=tmp468*tmp485;
REAL8 tmp487=tmp116*tmp204*tmp4*tmp63;
REAL8 tmp488=sqrt(tmp487);
REAL8 tmp489=tmp37*tmp385;
REAL8 tmp490=tmp33*tmp399;
REAL8 tmp491=tmp29*tmp413;
REAL8 tmp492=tmp489+tmp490+tmp491;
REAL8 tmp493=-(tmp246*tmp39*tmp419*tmp424*tmp492);
REAL8 tmp494=tmp173*tmp385;
REAL8 tmp495=tmp181*tmp399;
REAL8 tmp496=tmp177*tmp413;
REAL8 tmp497=tmp494+tmp495+tmp496;
REAL8 tmp498=tmp183*tmp246*tmp421*tmp497;
REAL8 tmp499=tmp493+tmp498;
REAL8 tmp500=-(tmp196*tmp421*tmp488*tmp499);
REAL8 tmp501=tmp486+tmp500;
REAL8 tmp503=1/tmp476;
REAL8 tmp444=eta*tmp4*tmp55*tmp63*tmp94;
REAL8 tmp445=2.*tmp11*tmp116;
REAL8 tmp446=tmp444+tmp445;
REAL8 tmp450=-(tmp116*tmp120*tmp124*tmp152*tmp4*tmp63);
REAL8 tmp451=eta*tmp147*tmp152*tmp4*tmp55*tmp63*tmp94;
REAL8 tmp452=tmp116*tmp147*tmp187*tmp4*tmp63;
REAL8 tmp453=2.*tmp11*tmp116*tmp147*tmp152;
REAL8 tmp454=tmp450+tmp451+tmp452+tmp453;
REAL8 tmp461=tmp26*tmp313*x->data[0];
REAL8 tmp462=tmp26*tmp330*x->data[1];
REAL8 tmp463=tmp26*tmp372*x->data[2];
REAL8 tmp464=tmp461+tmp462+tmp463;
REAL8 tmp568=coeffs->k5l*tmp91;
REAL8 tmp569=c0k5+tmp568+tmp71+tmp73;
REAL8 tmp541=tmp313*tmp37;
REAL8 tmp542=tmp33*tmp330;
REAL8 tmp543=tmp29*tmp372;
REAL8 tmp544=tmp144*tmp385;
REAL8 tmp545=tmp137*tmp399;
REAL8 tmp546=tmp130*tmp413;
REAL8 tmp547=tmp541+tmp542+tmp543+tmp544+tmp545+tmp546;
REAL8 tmp552=tmp173*tmp313;
REAL8 tmp553=tmp181*tmp330;
REAL8 tmp554=tmp177*tmp372;
REAL8 tmp555=tmp160*tmp385;
REAL8 tmp556=tmp168*tmp399;
REAL8 tmp557=tmp164*tmp413;
REAL8 tmp558=tmp552+tmp553+tmp554+tmp555+tmp556+tmp557;
REAL8 tmp536=1./sqrt(tmp487);
REAL8 tmp537=eta*tmp204*tmp4*tmp55*tmp63*tmp94;
REAL8 tmp538=2.*tmp11*tmp116*tmp204;
REAL8 tmp539=tmp537+tmp538;
REAL8 tmp524=0.5*tmp259*tmp428;
REAL8 tmp525=tmp184+tmp190+tmp192+tmp205+tmp206+tmp207+tmp224+tmp225+tmp226+tmp227+tmp524;
REAL8 tmp619=tmp183*tmp196*tmp246*tmp468*tmp488;
REAL8 tmp620=-(tmp116*tmp197*tmp204*tmp4*tmp497*tmp63);
REAL8 tmp621=tmp152*tmp481*tmp497;
REAL8 tmp622=tmp619+tmp620+tmp621;
REAL8 tmp474=1/tmp427;
REAL8 tmp566=2.*tmp123*tmp14;
REAL8 tmp567=4.*tmp246*tmp40;
REAL8 tmp570=1.*tmp45*tmp569;
REAL8 tmp571=1.+tmp570+tmp79+tmp82+tmp85+tmp89;
REAL8 tmp572=1/tmp571;
REAL8 tmp573=-2.*m1PlusEtaKK*tmp88;
REAL8 tmp574=2.*tmp84;
REAL8 tmp575=3.*tmp81;
REAL8 tmp576=4.*tmp78;
REAL8 tmp577=5.*tmp26*tmp569;
REAL8 tmp578=tmp576+tmp577;
REAL8 tmp579=1.*tmp26*tmp578;
REAL8 tmp580=tmp575+tmp579;
REAL8 tmp581=1.*tmp26*tmp580;
REAL8 tmp582=tmp574+tmp581;
REAL8 tmp583=1.*tmp26*tmp582;
REAL8 tmp584=tmp573+tmp583;
REAL8 tmp585=-(eta*tmp572*tmp584*tmp63);
REAL8 tmp586=2.*tmp116*tmp246*tmp63;
REAL8 tmp587=1.*tmp61;
REAL8 tmp588=1.*tmp13*tmp26;
REAL8 tmp589=tmp587+tmp588;
REAL8 tmp590=-2.*tmp116*tmp589;
REAL8 tmp591=tmp585+tmp586+tmp590;
REAL8 tmp592=-(tmp13*tmp591*tmp70);
REAL8 tmp593=tmp567+tmp592;
REAL8 tmp594=-2.*tmp14*tmp246*tmp593;
REAL8 tmp595=tmp566+tmp594;
REAL8 tmp477=(1.0/(tmp476*tmp476));
REAL8 tmp628=-(tmp183*tmp39*tmp4*tmp419*tmp421*tmp424*tmp492);
REAL8 tmp629=tmp116*tmp147*tmp217*tmp223*tmp478*tmp497*tmp63;
REAL8 tmp630=tmp116*tmp4*tmp622*tmp63*tmp70;
REAL8 tmp631=tmp628+tmp629+tmp630;
REAL8 tmp505=1./(tmp123*tmp123*tmp123);
REAL8 tmp508=pow(tmp152,-2.5);
REAL8 tmp513=(1.0/sqrt(tmp420*tmp420*tmp420));
REAL8 tmp515=(1.0/sqrt(tmp423*tmp423*tmp423));
REAL8 tmp679=tmp153*tmp246;
REAL8 tmp680=-tmp536;
REAL8 tmp681=tmp679+tmp680;
REAL8 tmp668=-(tmp116*tmp4*tmp63);
REAL8 tmp669=tmp1+tmp10+tmp12+tmp2+tmp3+tmp668+tmp8;
REAL8 tmp689=-4.*tmp116*tmp247*tmp63;
REAL8 tmp690=tmp40*tmp591;
REAL8 tmp691=tmp689+tmp690;
REAL8 tmp692=0.5*tmp147*tmp150*tmp154*tmp40*tmp53*tmp691;
REAL8 tmp693=tmp679+tmp692;
REAL8 tmp670=2.*tmp475;
REAL8 tmp671=1.+tmp670;
REAL8 tmp239=(1.0/(tmp116*tmp116));
REAL8 tmp672=-(tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp67*tmp671*tmp70);
REAL8 tmp673=tmp204*tmp217*tmp265*tmp268;
REAL8 tmp674=1./sqrt(tmp673);
REAL8 tmp675=-2.*tmp116*tmp4*tmp63;
REAL8 tmp676=tmp488*tmp591;
REAL8 tmp677=tmp675+tmp676;
REAL8 tmp678=-0.5*tmp246*tmp39*tmp419*tmp424*tmp476*tmp497*tmp674*tmp677;
REAL8 tmp682=tmp183*tmp246*tmp421*tmp492*tmp681;
REAL8 tmp683=-(tmp13*tmp153*tmp196*tmp67*tmp70);
REAL8 tmp684=tmp183*tmp246*tmp681;
REAL8 tmp685=-(tmp13*tmp153*tmp67);
REAL8 tmp686=tmp13*tmp147*tmp153*tmp40*tmp669*tmp67;
REAL8 tmp687=tmp685+tmp686;
REAL8 tmp688=tmp196*tmp687*tmp70;
REAL8 tmp694=-(tmp183*tmp246*tmp693);
REAL8 tmp695=tmp684+tmp688+tmp694;
REAL8 tmp696=tmp475*tmp695;
REAL8 tmp697=tmp683+tmp696;
REAL8 tmp698=tmp421*tmp492*tmp697;
REAL8 tmp699=tmp246*tmp39*tmp419*tmp424*tmp497*tmp671*tmp693;
REAL8 tmp700=tmp682+tmp698+tmp699;
REAL8 tmp701=tmp421*tmp700;
REAL8 tmp702=tmp678+tmp701;
REAL8 tmp703=tmp488*tmp702;
REAL8 tmp704=tmp672+tmp703;
REAL8 tmp706=1/tmp481;
REAL8 tmp242=(1.0/(tmp63*tmp63));
REAL8 tmp636=2.*eta*tmp246*tmp55*tmp63*tmp94;
REAL8 tmp637=-2.*eta*tmp55*tmp589*tmp94;
REAL8 tmp638=4.*c1k2*tmp11;
REAL8 tmp639=6.*c1k3*tmp11;
REAL8 tmp640=4.*tmp49;
REAL8 tmp641=5.*tmp26*tmp44;
REAL8 tmp642=tmp640+tmp641;
REAL8 tmp643=1.*tmp26*tmp642;
REAL8 tmp644=tmp639+tmp643;
REAL8 tmp645=1.*tmp26*tmp644;
REAL8 tmp646=tmp638+tmp645;
REAL8 tmp647=-(eta*tmp26*tmp572*tmp63*tmp646);
REAL8 tmp648=(1.0/(tmp571*tmp571));
REAL8 tmp649=eta*tmp55*tmp584*tmp63*tmp648;
REAL8 tmp650=-2.*eta*tmp11*tmp53*tmp572*tmp584;
REAL8 tmp651=0.+tmp636+tmp637+tmp647+tmp649+tmp650;
REAL8 tmp715=2.*tmp11;
REAL8 tmp716=-(eta*tmp4*tmp55*tmp63*tmp94);
REAL8 tmp717=-2.*tmp11*tmp116;
REAL8 tmp718=tmp715+tmp716+tmp717;
REAL8 tmp750=-(tmp187*tmp188*tmp246);
REAL8 tmp751=(1.0/sqrt(tmp487*tmp487*tmp487));
REAL8 tmp752=0.5*tmp539*tmp751;
REAL8 tmp753=tmp750+tmp752;
REAL8 tmp773=-4.*eta*tmp247*tmp55*tmp63*tmp94;
REAL8 tmp774=tmp40*tmp651;
REAL8 tmp775=-8.*tmp11*tmp116*tmp246;
REAL8 tmp776=2.*tmp11*tmp591;
REAL8 tmp777=tmp773+tmp774+tmp775+tmp776;
REAL8 tmp778=0.5*tmp147*tmp150*tmp154*tmp40*tmp53*tmp777;
REAL8 tmp779=-0.5*tmp120*tmp124*tmp150*tmp154*tmp40*tmp53*tmp691;
REAL8 tmp780=-0.5*eta*tmp147*tmp150*tmp239*tmp40*tmp53*tmp55*tmp691*tmp94;
REAL8 tmp781=-(tmp11*tmp147*tmp154*tmp242*tmp40*tmp5*tmp691);
REAL8 tmp782=1.*tmp11*tmp147*tmp150*tmp154*tmp53*tmp691;
REAL8 tmp783=tmp750+tmp778+tmp779+tmp780+tmp781+tmp782;
REAL8 tmp156=1./sqrt(tmp155);
REAL8 tmp237=sqrt(tmp233);
REAL8 ds000001=(1.*eta*(2.*tmp14*tmp146*tmp147*tmp4-2.*tmp120*tmp124*tmp14*tmp39*tmp4+2.*tmp11*tmp147*tmp15*tmp39*tmp4+2.*tmp14*tmp147*tmp246*tmp417+tmp147*tmp157*tmp246*tmp39*tmp417*tmp419*tmp426*tmp428-2.*tmp120*tmp124*tmp14*tmp246*tmp433+2.*tmp11*tmp147*tmp15*tmp246*tmp433+tmp146*tmp147*tmp157*tmp246*tmp419*tmp426*tmp428*tmp433-tmp120*tmp124*tmp157*tmp246*tmp39*tmp419*tmp426*tmp428*tmp433-0.5*tmp147*tmp157*tmp246*tmp259*tmp39*tmp419*tmp426*tmp433*tmp436+0.5*tmp147*tmp157*tmp187*tmp246*tmp39*tmp426*tmp428*tmp433*tmp440+tmp147*tmp157*tmp246*tmp39*tmp419*tmp428*tmp433*(0.5*tmp187*tmp424*tmp440-0.5*tmp443*tmp446+0.5*tmp419*tmp449*tmp454)+2.*coeffs->dheffSSv2*eta*s2Vec->data[2]*tmp5-0.5*(2.*tmp313*tmp385+2.*tmp330*tmp399+2.*tmp372*tmp413-6.*tmp464*tmp468)*tmp51-2.*tmp112*tmp116*tmp124*tmp247*tmp428*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp63-0.25*tmp124*tmp157*tmp259*tmp443*tmp449*tmp473*tmp474*tmp477*tmp488*tmp595*tmp631-0.25*tmp124*tmp157*tmp259*tmp436*tmp443*tmp449*tmp473*tmp488*tmp503*tmp595*tmp631-tmp120*tmp157*tmp428*tmp443*tmp449*tmp473*tmp488*tmp503*tmp505*tmp595*tmp631-0.75*tmp124*tmp157*tmp187*tmp428*tmp443*tmp449*tmp488*tmp503*tmp508*tmp595*tmp631-0.25*tmp124*tmp157*tmp428*tmp446*tmp449*tmp473*tmp488*tmp503*tmp513*tmp595*tmp631-0.25*tmp124*tmp157*tmp428*tmp443*tmp454*tmp473*tmp488*tmp503*tmp515*tmp595*tmp631+0.25*tmp124*tmp157*tmp428*tmp443*tmp449*tmp473*tmp503*tmp536*tmp539*tmp595*tmp631+2.*tmp112*tmp147*tmp191*tmp246*tmp39*tmp419*tmp426*tmp428*tmp433*tmp67-4.*tmp11*tmp116*tmp124*tmp246*tmp428*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp67+1.*tmp116*tmp124*tmp247*tmp259*tmp443*tmp449*tmp472*tmp473*tmp474*tmp477*tmp501*tmp63*tmp67-6.*tmp11*tmp116*tmp124*tmp14*tmp247*tmp428*tmp443*tmp449*tmp473*tmp501*tmp503*tmp63*tmp67+1.*tmp116*tmp124*tmp247*tmp259*tmp436*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp63*tmp67+4.*tmp116*tmp120*tmp247*tmp428*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp505*tmp63*tmp67+3.*tmp116*tmp124*tmp187*tmp247*tmp428*tmp443*tmp449*tmp472*tmp501*tmp503*tmp508*tmp63*tmp67+1.*tmp116*tmp124*tmp247*tmp428*tmp446*tmp449*tmp472*tmp473*tmp501*tmp503*tmp513*tmp63*tmp67+1.*tmp116*tmp124*tmp247*tmp428*tmp443*tmp454*tmp472*tmp473*tmp501*tmp503*tmp515*tmp63*tmp67+1.*tmp112*tmp124*tmp191*tmp428*tmp443*tmp449*tmp473*tmp488*tmp503*tmp595*tmp631*tmp67+0.5*tmp124*tmp157*tmp428*tmp443*tmp449*tmp473*tmp488*tmp503*tmp631*(2.*tmp120*tmp14+2.*tmp11*tmp123*tmp15-2.*tmp11*tmp15*tmp246*tmp593-2.*tmp14*tmp246*(8.*tmp11*tmp246+2.*tmp112*tmp13*tmp591*tmp67-2.*tmp11*tmp591*tmp70-tmp13*tmp651*tmp70))-2.*tmp11*tmp153*tmp154*tmp157*tmp242*tmp424*tmp5*tmp704*tmp706-tmp150*tmp154*tmp157*tmp187*tmp188*tmp424*tmp53*tmp704*tmp706+0.5*tmp150*tmp153*tmp154*tmp157*tmp449*tmp454*tmp53*tmp704*tmp706+2.*tmp112*tmp150*tmp153*tmp154*tmp191*tmp424*tmp53*tmp67*tmp704*tmp706-2.*eta*tmp124*tmp247*tmp428*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp55*tmp63*tmp67*tmp94-eta*tmp150*tmp153*tmp157*tmp239*tmp424*tmp53*tmp55*tmp704*tmp706*tmp94-2.*tmp116*tmp124*tmp247*tmp428*tmp443*tmp449*tmp472*tmp473*tmp503*tmp63*tmp67*(tmp464*tmp485-0.5*tmp196*tmp443*tmp446*tmp488*tmp499-0.5*tmp196*tmp421*tmp499*tmp536*tmp539-tmp196*tmp421*tmp488*(-(tmp146*tmp246*tmp419*tmp424*tmp492)-0.5*tmp187*tmp246*tmp39*tmp424*tmp440*tmp492-0.5*tmp246*tmp39*tmp419*tmp449*tmp454*tmp492+tmp170*tmp246*tmp421*tmp497+0.5*tmp183*tmp246*tmp443*tmp446*tmp497-tmp246*tmp39*tmp419*tmp424*tmp547+tmp183*tmp246*tmp421*tmp558)+tmp468*(-2.*tmp11*tmp116*tmp147*tmp223*tmp4*tmp478+2.*tmp11*tmp116*tmp483-2.*tmp116*tmp147*tmp152*tmp187*tmp217*tmp223*tmp63+tmp116*tmp120*tmp124*tmp217*tmp223*tmp478*tmp63-2.*tmp116*tmp146*tmp147*tmp217*tmp39*tmp478*tmp63+tmp116*tmp4*tmp63*(2.*tmp170*tmp183*tmp4+2.*tmp112*tmp152*tmp481*tmp67-tmp187*tmp481*tmp70-tmp152*tmp525*tmp70)-eta*tmp147*tmp217*tmp223*tmp478*tmp55*tmp63*tmp94+eta*tmp4*tmp483*tmp55*tmp63*tmp94))+0.5*tmp124*tmp157*tmp428*tmp443*tmp449*tmp473*tmp488*tmp503*tmp595*(-(tmp146*tmp183*tmp4*tmp419*tmp421*tmp424*tmp492)-tmp170*tmp39*tmp4*tmp419*tmp421*tmp424*tmp492-0.5*tmp183*tmp187*tmp39*tmp4*tmp421*tmp424*tmp440*tmp492-0.5*tmp183*tmp39*tmp4*tmp419*tmp424*tmp443*tmp446*tmp492-0.5*tmp183*tmp39*tmp4*tmp419*tmp421*tmp449*tmp454*tmp492+2.*tmp11*tmp116*tmp147*tmp223*tmp4*tmp478*tmp497-tmp183*tmp39*tmp4*tmp419*tmp421*tmp424*tmp547+2.*tmp116*tmp147*tmp152*tmp187*tmp217*tmp223*tmp497*tmp63-tmp116*tmp120*tmp124*tmp217*tmp223*tmp478*tmp497*tmp63+2.*tmp116*tmp146*tmp147*tmp217*tmp39*tmp478*tmp497*tmp63+tmp116*tmp147*tmp217*tmp223*tmp478*tmp558*tmp63-2.*tmp112*tmp116*tmp4*tmp622*tmp63*tmp67+2.*tmp11*tmp116*tmp622*tmp70+eta*tmp147*tmp217*tmp223*tmp478*tmp497*tmp55*tmp63*tmp94+eta*tmp4*tmp55*tmp622*tmp63*tmp70*tmp94+tmp116*tmp4*tmp63*tmp70*(tmp183*tmp196*tmp246*tmp464*tmp488+tmp170*tmp196*tmp246*tmp468*tmp488-2.*tmp11*tmp116*tmp197*tmp204*tmp497+tmp187*tmp481*tmp497+tmp152*tmp497*tmp525+0.5*tmp183*tmp196*tmp246*tmp468*tmp536*tmp539+tmp152*tmp481*tmp558-tmp116*tmp197*tmp204*tmp4*tmp558*tmp63-eta*tmp197*tmp204*tmp4*tmp497*tmp55*tmp63*tmp94))-0.5*tmp237*(-2.*tmp11*tmp123*tmp153*tmp154*tmp242*tmp5+tmp120*tmp150*tmp153*tmp154*tmp53-tmp123*tmp150*tmp154*tmp187*tmp188*tmp53-eta*tmp123*tmp150*tmp153*tmp239*tmp53*tmp55*tmp94)*(1.0/sqrt(tmp155*tmp155*tmp155))-tmp150*tmp153*tmp154*tmp157*tmp424*tmp525*tmp53*tmp704*(1.0/(tmp481*tmp481))+tmp150*tmp153*tmp154*tmp157*tmp424*tmp53*tmp706*(2.*tmp112*tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp671*tmp68-tmp13*tmp147*tmp246*tmp259*tmp39*tmp40*tmp421*tmp424*tmp428*tmp440*tmp468*tmp669*tmp67*tmp70-tmp112*tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp671*tmp70-tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp464*tmp669*tmp67*tmp671*tmp70-2.*tmp11*tmp13*tmp147*tmp246*tmp39*tmp421*tmp424*tmp440*tmp468*tmp669*tmp67*tmp671*tmp70-tmp13*tmp146*tmp147*tmp246*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp67*tmp671*tmp70+tmp120*tmp124*tmp13*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp67*tmp671*tmp70-2.*tmp11*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp669*tmp67*tmp671*tmp70-0.5*tmp13*tmp147*tmp246*tmp39*tmp40*tmp424*tmp440*tmp443*tmp446*tmp468*tmp669*tmp67*tmp671*tmp70-0.5*tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp440*tmp449*tmp454*tmp468*tmp669*tmp67*tmp671*tmp70+0.5*tmp13*tmp147*tmp187*tmp246*tmp39*tmp40*tmp421*tmp424*tmp468*tmp473*tmp669*tmp67*tmp671*tmp70+0.5*tmp536*tmp539*tmp702-tmp13*tmp147*tmp246*tmp39*tmp40*tmp421*tmp424*tmp440*tmp468*tmp67*tmp671*tmp70*tmp718+tmp488*(-0.25*tmp246*tmp259*tmp39*tmp419*tmp424*tmp428*tmp497*tmp674*tmp677-0.5*tmp146*tmp246*tmp419*tmp424*tmp476*tmp497*tmp674*tmp677-0.25*tmp187*tmp246*tmp39*tmp424*tmp440*tmp476*tmp497*tmp674*tmp677-0.25*tmp246*tmp39*tmp419*tmp449*tmp454*tmp476*tmp497*tmp674*tmp677-0.5*tmp246*tmp39*tmp419*tmp424*tmp476*tmp558*tmp674*tmp677+0.5*tmp443*tmp446*tmp700+tmp421*(tmp170*tmp246*tmp421*tmp492*tmp681+0.5*tmp183*tmp246*tmp443*tmp446*tmp492*tmp681+tmp183*tmp246*tmp421*tmp547*tmp681+1.*tmp246*tmp259*tmp39*tmp419*tmp424*tmp428*tmp497*tmp693+tmp146*tmp246*tmp419*tmp424*tmp497*tmp671*tmp693+0.5*tmp187*tmp246*tmp39*tmp424*tmp440*tmp497*tmp671*tmp693+0.5*tmp246*tmp39*tmp419*tmp449*tmp454*tmp497*tmp671*tmp693+tmp246*tmp39*tmp419*tmp424*tmp558*tmp671*tmp693+0.5*tmp443*tmp446*tmp492*tmp697+tmp421*tmp547*tmp697+tmp183*tmp246*tmp421*tmp492*tmp753+tmp246*tmp39*tmp419*tmp424*tmp497*tmp671*tmp783+tmp421*tmp492*(2.*tmp112*tmp13*tmp153*tmp196*tmp68+0.5*tmp259*tmp428*tmp695-tmp112*tmp13*tmp153*tmp196*tmp70-2.*tmp11*tmp153*tmp196*tmp67*tmp70+tmp13*tmp187*tmp188*tmp196*tmp67*tmp70+tmp475*(tmp170*tmp246*tmp681-2.*tmp112*tmp196*tmp67*tmp687-tmp170*tmp246*tmp693+tmp196*tmp70*(-(tmp112*tmp13*tmp153)+tmp112*tmp13*tmp147*tmp153*tmp40*tmp669-2.*tmp11*tmp153*tmp67+tmp13*tmp187*tmp188*tmp67+2.*tmp11*tmp13*tmp147*tmp153*tmp669*tmp67-tmp120*tmp124*tmp13*tmp153*tmp40*tmp669*tmp67+2.*tmp11*tmp147*tmp153*tmp40*tmp669*tmp67-tmp13*tmp147*tmp187*tmp188*tmp40*tmp669*tmp67+tmp13*tmp147*tmp153*tmp40*tmp67*tmp718)+tmp183*tmp246*tmp753-tmp183*tmp246*tmp783)))-0.5*tmp246*tmp39*tmp419*tmp424*tmp476*tmp497*tmp674*(-4.*tmp11*tmp116+0.5*tmp536*tmp539*tmp591+tmp488*tmp651-2.*eta*tmp4*tmp55*tmp63*tmp94)+0.25*tmp246*tmp39*tmp419*tmp424*tmp476*tmp497*tmp677*(4.*tmp11*tmp204*tmp268*tmp4*tmp63+2.*eta*tmp116*tmp204*tmp217*tmp265*tmp55*tmp94)*(1.0/sqrt(tmp673*tmp673*tmp673))))+(0.5*tmp156*(tmp184+tmp190+tmp192+tmp205+tmp206+tmp207+tmp224+tmp225+tmp226+tmp227+8.*tmp208*tmp209*tmp210*tmp211*tmp212*tmp213*tmp214*tmp55*tmp94*(tmp116*tmp116*tmp116)-16.*eta*tmp11*tmp208*tmp210*tmp212*tmp213*tmp214*tmp219*pow(tmp40,-5.)+16.*eta*tmp11*tmp208*tmp211*tmp213*tmp214*tmp217*tmp219*(tmp63*tmp63*tmp63)))/sqrt(tmp233)))/sqrt(1.+2.*eta*(-1.+tmp156*tmp237+2.*tmp14*tmp147*tmp39*tmp4+2.*tmp14*tmp147*tmp246*tmp433+tmp147*tmp157*tmp246*tmp39*tmp419*tmp426*tmp428*tmp433+0.5*tmp124*tmp157*tmp428*tmp443*tmp449*tmp473*tmp488*tmp503*tmp595*tmp631-2.*tmp116*tmp124*tmp247*tmp428*tmp443*tmp449*tmp472*tmp473*tmp501*tmp503*tmp63*tmp67+tmp150*tmp153*tmp154*tmp157*tmp424*tmp53*tmp704*tmp706+coeffs->dheffSSv2*eta*tmp5*(s1Vec->data[0]*s1Vec->data[0]+s1Vec->data[1]*s1Vec->data[1]+s1Vec->data[2]*s1Vec->data[2]+s2Vec->data[0]*s2Vec->data[0]+s2Vec->data[1]*s2Vec->data[1]+s2Vec->data[2]*s2Vec->data[2])-0.5*tmp51*(tmp385*tmp385+tmp399*tmp399+tmp413*tmp413-3.*(tmp468*tmp468))));
