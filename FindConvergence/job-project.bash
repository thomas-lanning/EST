#!/bin/bash --login
#   Insert your SLURM commands here

# Load the Quantum Espresso module
module add quantum-espresso


# SCF calculation

srun pw.x -nband 1 -ntg 1 -inp CsPbI3.scf.in > CsPbI3.scf.out

# non-SCF DOS calculation
srun -n 24 pw.x -nband 1 -ntg 1 -inp CsPbI3.nscf.in > CsPbI3.nscf.out

# Postprocessing to extract eigenvalues and write DOS file
srun -n 1 dos.x -nband 1 -ntg 1 -inp CsPbI3.pp_dos.in > CsPbI3.pp_dos.out

# Band structure calculation
srun -n 24 pw.x -nband 1 -ntg 1 -inp CsPbI3.bands.in > CsPbI3.bands.out

# Postprocessing using band.x
srun -n 1 bands.x -nband 1 -ntg 1 -inp CsPbI3.pp_bands.in > CsPbI3.pp_bands.out

