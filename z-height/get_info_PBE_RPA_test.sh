#!/bin/bash

OUTPUTNAME=MoS2
INFOFILE=MoS2_pw

rm $INFOFILE\.dat
#echo "Volume(A^3)     PBE E_tot(eV)     PBE E_coh(meV)     RPA E_tot(eV)     RPA E_coh(meV)" | tee -a $INFOFILE\.dat
printf "%-18s %-23s \n" 'lat_cons(A)' 'PBE E_tot(eV)' |tee -a $INFOFILE\.dat

for i in 2.5 2.8 2.9 3.0 3.1 3.2 3.25 3.3 3.4 3.5 3.6 3.7 3.8 3.9 4.0 5.0
do   
cd d_$i

  dft=$(echo $(awk '/final etot is/ {print $4}' OUT.ABACUS/running_scf.log | tail -1)) # eV
  #exx=$(echo $(awk '/Etot_without_rpa/ {print $2}' $OUTPUTNAME\.out | tail -1)) #	eV
  kpoint=$(echo "scale=0; ($i)" | bc)
  printf "%-18.2f %-23.8f \n" $kpoint $crpa_coh $dft | tee -a ../$INFOFILE\.dat

  cd ..
done

#dos2unix total.dat
