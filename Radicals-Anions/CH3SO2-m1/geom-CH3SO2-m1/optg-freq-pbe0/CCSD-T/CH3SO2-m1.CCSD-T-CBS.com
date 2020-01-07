 memory,1000,m;
 file, 1, CH3SO2-m1.CCSD-T-CBS.int, new;
 file, 2, CH3SO2-m1.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.3236368448
C    -0.7629596    0.0204199    0.0000000 
S     1.0164241    0.5253466    0.0000000 
O     1.5021031   -0.1557369   -1.2578859 
O     1.5021031   -0.1557369    1.2578859 
H    -1.2450599    0.4070891    0.9001801 
H    -0.7611077   -1.0721733    0.0000000 
H    -1.2450599    0.4070891   -0.9001801 
}
 
basis={
  default,aug-cc-pVTZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

charge=-1;
spin=0;

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
