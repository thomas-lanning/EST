#!/bin/bash

#SBATCH --job-name=loopEcut
#SBATCH --nodes=1
#SBATCH --tasks-per-node=36
#SBATCH --exclusive
#SBATCH --time=00:15:0

#SBATCH --account=dc154
#SBATCH --partition=standard
#SBATCH --qos=standard

NAME='kpoints'

for K in 4 5 6 7 8 9 10 11 12 13 14 15 16
do
cat > ./${NAME}/${NAME}_${K}.in << EOF

 &control
  calculation='scf'
  restart_mode='from_scratch',
  prefix='cspbi3',
  pseudo_dir = './',
  outdir='./${NAME}/cspbi3/'
 /
 &system
  ibrav= 1, 
  celldm(1) = 12.067675236, !this uses the optimal structure in the paper given in the exercise 
  nat= 5,
  ntyp= 3,
  ecutwfc = 60, ! found from loopEcut convergence
  occupations='tetrahedra' !add comma here if uncommenting
!occupations='smearing',
!smearing='methfessel-paxton',
!degauss=0.05,
 /
 &electrons
  conv_thr = 1.0d-8
  mixing_beta = 0.7
 /
 ATOMIC_SPECIES
  Cs 132.9 Cs.pz-hgh.UPF
  Pb 207.2 Pb.pz-hgh.UPF
  I 126.9 I.pz-hgh.UPF
 ATOMIC_POSITIONS
  Cs 0.0 0.0 0.0
  Pb 0.5 0.5 0.5
  I 0.5 0.5 0.0
  I 0.5 0.0 0.5
  I 0.0 0.5 0.5
 K_POINTS {automatic}
  $K $K $K 0 0 0

EOF

#module load epcc-job-env 
module load quantum-espresso
export OMP_NUM_THREADS=1

# put all the data in a folder called ecut
srun -n 36 pw.x -npool 6 -pd .true. < ./${NAME}/${NAME}_${K}.in > ./${NAME}/${NAME}_${K}.out

#display it on sbatch so I know its running
echo ${NAME}_${K}

#grep the energy
grep ! ./${NAME}/${NAME}_${K}.out | grep -o [+-][0-9]*.[0-9]* >> energyKpoints.txt

# this is for the k-points
grep "number of k points=" ./${NAME}/${NAME}_${K}.out >> numberKpoints.txt

done
