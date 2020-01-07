 memory,1000,m;
 file, 1, trans-CH3OSO-m1.CCSD-T-CBS.int, new;
 file, 2, trans-CH3OSO-m1.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.2785215898
C     0.4563908   -0.8082214    0.0000000 
H     0.2128308   -1.8769436    0.0000000 
H     1.0772908   -0.5950375    0.8894573 
H     1.0772908   -0.5950375   -0.8894573 
O    -0.7260544   -0.0890595    0.0000000 
S    -0.3588610    1.6481105    0.0000000 
O    -1.7388878    2.3161889    0.0000000 
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
