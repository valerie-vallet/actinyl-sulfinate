 memory, 9000,m;
 file, 1, cis-C6H5OSO-m1.CCSD-T-CBS.int, new;
 file, 2, cis-C6H5OSO-m1.CCSD-T-CBS.wfu, new;

geometry={
14
Energy = -779.8802853997
C    -0.4854951   -0.3401592   -0.0222894 
C     0.8836011   -0.5567974    0.1911379 
C     1.3905940   -1.8464323    0.1523252 
C     0.5739709   -2.9427438   -0.0999453 
C    -0.7807086   -2.7268695   -0.3233010 
C    -1.3048553   -1.4452641   -0.2891672 
O    -1.0625940    0.8620013   -0.0008769 
S    -0.1495837    2.2403505    0.6870611 
H     1.5238587    0.3007010    0.3528593 
H     2.4535525   -1.9957163    0.3149466 
H     0.9861177   -3.9451192   -0.1281369 
H    -1.4394347   -3.5665433   -0.5224782 
H    -2.3608413   -1.2681772   -0.4582637 
O     0.9910099    2.5666033   -0.2878713 
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
