 memory,1600,m;
 file, 1, UO2NO3DBPTBP-nitrate.int, new;
 file, 2, UO2NO3DBPTBP-nitrate.wfu, new;

gprint,basis;
geomtyp=xyz;

geometry={
   20
scf done: -2032.768756
 C    -3.178673    -0.200705    -0.216060
 S    -1.792622    -1.362415    -0.420169
 O    -0.862121    -0.606574    -1.363271
Pu     1.040363    -0.209332     0.261818
 O     3.373571     0.669826     0.774992
 S     3.693583     1.166112    -0.637684
 O     2.487348     0.870440    -1.525466
 O    -1.126446    -1.322838     0.957223
 O     1.721628    -1.780461    -0.095601
 O     0.373226     1.356642     0.696136
 C    -4.464346    -0.675225    -0.409382
 C    -5.548056     0.182772    -0.260211
 C    -5.331812     1.509095     0.080054
 C    -4.035304     1.977852     0.271182
 C    -2.952113     1.127034     0.123641
 H    -4.614361    -1.716298    -0.677931
 H    -6.557405    -0.183705    -0.411265
 H    -6.173543     2.182779     0.196059
 H    -3.870042     3.016245     0.536178
 H    -1.934977     1.474922     0.268844
}

include, basis;
! Use minimal basis set
basis={
  ecp, Pu, ECP60MWB;
  S=MINAO;
  O=MINAO;
  C=MINAO;
  H=MINAO;
  s, Pu, ECP60MWB_SEG; 2C; ! 5s, 6s
  p, Pu, ECP60MWB_SEG; 2C; ! 5p, 6p
  d, Pu, ECP60MWB_SEG; 1C; ! 5d
  f, Pu, ECP60MWB_SEG; 1C; ! 5f
}

charge=-1;

{mcscf;
 closed, 76;
 occ   , 81;
}
{pop; individual;}

include, basis;

{mcscf;
 closed, 76;
 occ   , 81;
}

{rs2;}
