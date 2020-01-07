 memory, 9000,m;
 file, 1, C6H5SO2.CCSD-T-CBS.int, new;
 file, 2, C6H5SO2.CCSD-T-CBS.wfu, old;

geometry={
14
Energy = -779.8998044460
C     0.1215577   -0.1476652   -0.0118528 
C    -0.1002980   -0.7778853   -1.2278689 
C    -0.2184238   -2.1606394   -1.2860790 
C    -0.1126922   -2.9186628   -0.1257298 
C     0.1006086   -2.2853574    1.0932416 
C     0.2179130   -0.9025314    1.1484708 
H    -0.2066866   -0.1587428   -2.1126560 
H    -0.4033484   -2.6516669   -2.2368529 
H    -0.2062157   -3.9987747   -0.1697407 
H     0.1652842   -2.8739944    2.0035095 
H     0.3556378   -0.3801275    2.0895072 
S     0.3709117    1.6853151    0.0511224 
O    -0.4932257    2.1393067   -1.0979180 
O    -0.1923660    2.0124158    1.4108605 
}

 charge=-1;
 spin=0;
 
 basis={
   default,aug-cc-pVTZ;
 }
 {cfit,basis_coul=mycoul,basis_exch=myexch}
 
 {rhf;
 }
 ccsd(t);
 
 ehf(1) = ENERGR(1);
 ecor_ccsdt(1) = ENERGY(1)-ENERGR(1);
 ecor_mp2(1) = EMP2(1)-ENERGR(1);

basis={
  default,aug-cc-pVQZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

{rhf;
}
ccsd(t);
ehf(2) = ENERGR(1);
ecor_ccsdt(2) = ENERGY(1)-ENERGR(1);
ecor_mp2(2) = EMP2(1)-ENERGR(1);

extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_ccsdt, method_r=km, method_c=LH4;
extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_mp2, method_r=km, method_c=LH4;
