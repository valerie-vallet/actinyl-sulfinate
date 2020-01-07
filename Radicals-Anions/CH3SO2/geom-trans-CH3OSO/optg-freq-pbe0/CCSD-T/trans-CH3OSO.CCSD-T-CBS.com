 memory,1000,m;
 file, 1, trans-CH3OSO.CCSD-T-CBS.int, new;
 file, 2, trans-CH3OSO.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.2454338284
C     0.4885495   -0.7991136    0.0000000 
H     0.1541685   -1.8338657    0.0000000 
H     1.0894548   -0.6140045    0.8940115 
H     1.0894548   -0.6140045   -0.8940115 
O    -0.6962955   -0.0059759    0.0000000 
S    -0.4022839    1.6110583    0.0000000 
O    -1.7230483    2.2559059    0.0000000 
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
