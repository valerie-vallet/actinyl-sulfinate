 memory,1000,m;
 file, 1, SO2.CCSD-T-CBS.int, new;
 file, 2, SO2.CCSD-T-CBS.wfu, new;

geometry={
3
Energy = -548.3988351505
O    -1.2383410    0.0000000    0.2470016 
S     0.0000000    0.0000000   -0.4940032 
O     1.2383410    0.0000000    0.2470016 
}
 
basis={
  default,aug-cc-pVTZ;
}
{cfit,basis_coul=mycoul,basis_exch=myexch}

{hf;
closed, 8, 5, 2, 1;
wf, 32, 1, 0;
}
uccsd(t);

{hf;
closed, 8, 5, 2, 1;
occ,    9, 5, 2, 1;
wf, 33, 1, 1;
}
uccsd(t);

{hf;
closed, 8, 5, 2, 1;
occ,    8, 6, 2, 1;
wf, 33, 2, 1;
}
uccsd(t);

{hf;
closed, 8, 5, 2, 1;
occ,    8, 5, 3, 1;
wf, 33, 3, 1;
}
uccsd(t);

{hf;
closed, 8, 5, 2, 1;
occ,    8, 5, 2, 2;
wf, 33, 4, 1;
}
uccsd(t);


!ehf(1) = ENERGR(1);
!ecor_ccsdt(1) = ENERGY(1)-ENERGR(1);
!ecor_mp2(1) = EMP2(1)-ENERGR(1);
!
!basis={
!  default,aug-cc-pVQZ;
!}
!{cfit,basis_coul=mycoul,basis_exch=myexch}
!
!hf;
!uccsd(t);
!ehf(2) = ENERGR(1);
!ecor_ccsdt(2) = ENERGY(1)-ENERGR(1);
!ecor_mp2(2) = EMP2(1)-ENERGR(1);
!
!extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_ccsdt, method_r=km, method_c=LH4;
!extrapolate, basis=avtz:avqz, eref=ehf, ecorr=ecor_mp2, method_r=km, method_c=LH4;
