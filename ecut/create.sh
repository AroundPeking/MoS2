#!/bin/bash
OUTPUTNAME=MoS2

#for i in 1.2 1.3 1.4 1.5 1.6 1.7 1.8 1.9 2.0 2.5 3.0
for i in 50 100 200
do
  rm -r e_$i 
  mkdir e_$i && cd e_$i
  cp ../template/INPUT .
  cp ../template/KPT .
  cp ../template/STRU .
  cp ../template/Mo_ONCV_PBE-1.0.upf .
  cp ../template/S_ONCV_PBE-1.0.upf .
  #cp ../template/C_gga_8au_100Ry_2s2p1d.orb .
  cp ../template/run_HR.sh .
 
  #half_a=$(echo "scale=8; e(1/3*l(($i*4)))/2" | bc -l) #i=volume=(a^3)/4,here we need a/2 so =[(4i)^(1/3)]/2
# half_a=$(echo "scale=8; ($i)/2" | bc) #this i represent lattice contant 
  sed -i "s/cutoff/$(echo "scale=0; $i" | bc)/g" INPUT
#  sed -i "s/k_grid 8 8 1/k_grid $KPOINT $KPOINT $KPOINT/g" control.in

  #sed -i "s/PBS -N ysx_3z/PBS -N V_$i/g" run.pbs
  #sed -i "s/PBS -l nodes=1:ppn=2/PBS -l nodes=$NODE:ppn=$CORE/g" run.pbs
  #sed -i "s/aims.out/$OUTPUTNAME\.out/g" run.pbs
  #qsub run.pbs
#  sed -i "s/SBATCH -N 3/#SBATCH -N $NODE/g" run.sh
#  sed -i "s/SBATCH -n 72/#SBATCH -n $CORE/g" run.sh
#  sbatch run_BSCC2.sh 
   sbatch run_HR.sh
  cd ..
done
