 memory,1000,m;
 file, 1, cis-CH3OSO.CCSD-T-CBS.int, new;
 file, 2, cis-CH3OSO.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.2488117883
C     0.0550606    0.7832201    0.1319652 
H    -0.3496371    0.3987333    1.0676300 
H     1.1440043    0.8442734    0.1957889 
H    -0.3605053    1.7660003   -0.0780940 
O    -0.3328248   -0.0456631   -0.9665011 
S     0.0260022   -1.6340592   -0.8669394 
O    -0.1821000   -2.1125048    0.5161505 
}
 
basis={
  default,aug-cc-pVTZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

charge=0;
spin=1;

hf;
uccsd(t);

ehf(1) = ENERGR(1);
ecor_ccsdt(1) = ENERGY(1)-ENERGR(1);
ecor_mp2(1) = EMP2(1)-ENERGR(1);

basis={
  default,aug-cc-pVQZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

hf;
uccsd(t);
ehf(2) = ENERGR(1);
ecor_ccsdt(2) = ENERGY(1)-ENERGR(1);
ecor_mp2(2) = EMP2(1)-ENERGR(1);

extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_ccsdt, method_r=km, method_c=LH4;
extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_mp2, method_r=km, method_c=LH4;
