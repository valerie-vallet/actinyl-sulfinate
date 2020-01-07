 memory, 4500,m;
 file, 1, C6H5SO2.CCSD-T-CBS.int, new;
 file, 2, C6H5SO2.CCSD-T-CBS.wfu, new;

geometry={
14
Energy = -779.8093458132
C     0.1037929    0.7882109    0.0000000 
C     0.0773822    0.1208547   -1.2152787 
C    -0.0035923   -1.2624936   -1.2056659 
C    -0.0420753   -1.9502733    0.0000000 
C    -0.0035923   -1.2624936    1.2056659 
C     0.0773822    0.1208547    1.2152787 
H     0.0987845    0.6810447   -2.1407796 
H    -0.0401349   -1.8039306   -2.1425788 
H    -0.1042776   -3.0315054    0.0000000 
H    -0.0401349   -1.8039306    2.1425788 
H     0.0987845    0.6810447    2.1407796 
S     0.2611487    2.5698345    0.0000000 
O    -0.2417338    3.0763914   -1.2785604 
O    -0.2417338    3.0763914    1.2785604 
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
!closed, 22, 14;
!occ,    23, 14;
!}
!uccsd(t);
!
!ehf(1) = ENERGR(1);
!ecor_ccsdt(1) = ENERGY(1)-ENERGR(1);
!ecor_mp2(1) = EMP2(1)-ENERGR(1);

EHF(1)         =      -777.44527717  AU
ECOR_CCSDT(1)  =        -1.72306847  AU
ECOR_MP2(1)    =        -1.62659537  AU

basis={
  default,aug-cc-pVQZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

{rhf;
closed, 22, 14;
occ,    23, 14;
}
uccsd(t);
ehf(2) = ENERGR(1);
ecor_ccsdt(2) = ENERGY(1)-ENERGR(1);
ecor_mp2(2) = EMP2(1)-ENERGR(1);

extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_ccsdt, method_r=km, method_c=LH4;
extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_mp2, method_r=km, method_c=LH4;
