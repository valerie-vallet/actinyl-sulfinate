 memory,1000,m;
 file, 1, CH3SO2.CCSD-T-CBS.int, new;
 file, 2, CH3SO2.CCSD-T-CBS.wfu, new;

geometry={
7
Energy = -588.2388577192
C    -0.7787972   -0.0037135    0.0000000 
S     0.9865369    0.3897771    0.0000000 
O     1.5341622   -0.0789593   -1.2746795 
O     1.5341622   -0.0789593    1.2746795 
H    -1.2115483    0.4197440    0.9025796 
H    -0.8465243   -1.0913355    0.0000000 
H    -1.2115483    0.4197440   -0.9025796 
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
