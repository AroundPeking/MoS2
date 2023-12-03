#!/bin/bash

OUTPUTNAME=MoS2
INFOFILE=MoS2_pw

rm $INFOFILE\.dat
#echo "Volume(A^3)     PBE E_tot(eV)     PBE E_coh(meV)     RPA E_tot(eV)     RPA E_coh(meV)" | tee -a $INFOFILE\.dat
printf "%-18s %-23s \n" 'Kpoint' 'PBE E_tot(eV)' |tee -a $INFOFILE\.dat

for i in 4 5 6 7 8 9 10
do   
cd k_$i

  dft=$(echo $(awk '/final etot is/ {print $4}' OUT.ABACUS/running_scf.log | tail -1)) # eV
  #exx=$(echo $(awk '/Etot_without_rpa/ {print $2}' $OUTPUTNAME\.out | tail -1)) #	eV
  kpoint=$(echo "scale=0; ($i)^2" | bc)
  printf "%-18.0f %-23.8f \n" $kpoint $crpa_coh $dft | tee -a ../$INFOFILE\.dat

  cd ..
done

#dos2unix total.dat
