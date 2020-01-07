 memory,1000,m;
 file, 1, CH3.CCSD-T-CBS.int, new;
 file, 2, CH3.CCSD-T-CBS.wfu, new;

geometry={
4
Energy = -39.79942409830
C    -0.0000000    0.0000000    0.0000000 
H    -0.5396777    0.9347491    0.0000000 
H    -0.5396777   -0.9347491    0.0000000 
H     1.0793553    0.0000000    0.0000000 
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
