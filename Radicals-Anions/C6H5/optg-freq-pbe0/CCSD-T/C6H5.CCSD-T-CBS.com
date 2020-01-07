 memory,1000,m;
 file, 1, C6H5.CCSD-T-CBS.int, new;
 file, 2, C6H5.CCSD-T-CBS.wfu, new;

geometry={
11
Energy = -231.3577415319
C     1.2196159   -0.0000000   -0.9268852 
C     1.2067832    0.0000000    0.4683333 
C     0.0000000    0.0000000    1.1553211 
C    -1.2067832    0.0000000    0.4683333 
C    -1.2196159   -0.0000000   -0.9268852 
C    -0.0000000   -0.0000001   -1.5474343 
H     2.1521362    0.0000000   -1.4781619 
H     2.1437595    0.0000000    1.0135964 
H    -0.0000000   -0.0000000    2.2383478 
H    -2.1437594    0.0000000    1.0135964 
H    -2.1521362    0.0000000   -1.4781619 
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
