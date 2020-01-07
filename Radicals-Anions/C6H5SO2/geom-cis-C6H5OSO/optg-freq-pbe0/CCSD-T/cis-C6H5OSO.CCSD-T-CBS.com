 memory, 6000,m;
 file, 1, cis-C6H5OSO.CCSD-T-CBS.int, new;
 file, 2, cis-C6H5OSO.CCSD-T-CBS.wfu, new;

geometry={
14
Energy = -779.8246023815
C     0.1442476   -0.1838519   -0.2941563 
C     0.9442367   -0.7401238    0.6900717 
C     1.0386522   -2.1217255    0.7731233 
C     0.3480448   -2.9287604   -0.1187394 
C    -0.4458655   -2.3533858   -1.1008064 
C    -0.5545139   -0.9744775   -1.1916431 
O     0.0680947    1.1974179   -0.4356530 
S    -0.8746221    2.0637768    0.6066489 
H     1.4784906   -0.0952170    1.3739493 
H     1.6601350   -2.5677162    1.5397962 
H     0.4296766   -4.0062369   -0.0503326 
H    -0.9849083   -2.9795551   -1.8010796 
H    -1.1657043   -0.5047727   -1.9517136 
O    -0.4593402    1.8113410    1.9985970 
}
 
!basis={
!  default,aug-cc-pVTZ;
!}
!{cfit,basis_coul=mycoul,basis_exch=myexch}
!
!charge=0;
!spin=1;
!
!{rhf;
!closed, 36;
!occ,    37;
!}
!uccsd(t);
!
ehf(1) = ENERGR(1);
ecor_ccsdt(1) = ENERGY(1)-ENERGR(1);
ecor_mp2(1) = EMP2(1)-ENERGR(1);

EHF(1)         =      -777.47019155;
ECOR_CCSDT(1)  =        -1.71618285;
ECOR_MP2(1)    =        -1.61645343;

basis={
  default,aug-cc-pVQZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

{rhf;
closed, 36;
occ,    37;
}
{uccsd;
 save, 4200.2;
}
{uccsd(t);
 start, 4200.2;
}
ehf(2) = ENERGR(1);
ecor_ccsdt(2) = ENERGY(1)-ENERGR(1);
ecor_mp2(2) = EMP2(1)-ENERGR(1);

extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_ccsdt, method_r=km, method_c=LH4;
extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_mp2, method_r=km, method_c=LH4;
