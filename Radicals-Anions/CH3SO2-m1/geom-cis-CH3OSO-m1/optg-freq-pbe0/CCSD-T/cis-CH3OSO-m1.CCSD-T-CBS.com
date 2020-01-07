 memory,1000,m;
 file, 1, cis-CH3OSO-m1.CCSD-T-CBS.int, new;
 file, 2, cis-CH3OSO-m1.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.2852748599
C     0.0534563    0.8045795    0.0999753 
H    -0.2332563    0.3971238    1.0777226 
H     1.1463118    0.9382777    0.0927615 
H    -0.4293182    1.7823213   -0.0289702 
O    -0.3671587   -0.0299919   -0.9425128 
S     0.2481104   -1.6463957   -0.7784432 
O    -0.4181454   -2.2459146    0.4794668 
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
