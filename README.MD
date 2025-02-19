The folders contain:

Clean/
	has a clean version of the code which you can copy to make your own calculations. This is a template I started from

Data/
	has several different folders:
	• PZ/, PBE/, PBEsol/ and vdw-DF2/
		contains the convergence testing values for plane wave cutoff "energyEcut.txt and for k-point called energyKpoints.txt. All other files are DOS convergence testing, where the numbers are the end of the file signify the k-point grid used in the nscf calculation. Only raw data is available here
	• same_path_as_paper
		contains the different band structures for different functionals with a 16k-point grid. Also contains the screenshot of the path from the paper found in the bibliography. 

FindConvergence/
	contains the files you can use to run your own convergence tests for plane wave cutoff and k-point grid in SCF step. Important files are those starting with loop and ending with slurm

Pics/
	contains all the images used in the report


