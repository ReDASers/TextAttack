#!/bin/bash
#SBATCH -p batch               # queue (partition)
#SBATCH -J TAtest              # job name

#output and error file name (%j expands to jobID)
#SBATCH -o /home/dlee31/my-text-attack/TextAttack/slurm/out/slurm.TAtest.%j.out

#SBATCH -N 1                   # total number of mpi tasks requested
#SBATCH --cpus-per-task 2      # allocate two cores
#SBATCH --mem 16384
#SBATCH --gres=gpu:2           # allocate 2 gpus
##SBATCH -t 00:05:00           # max run time (hh:mm:ss)

#SBATCH --mail-type=end        # email me when the job finishes
#SBATCH --mail-user=dlseven777@gmail.com

source /home/dlee31/.bashrc
module load python/anaconda3/2020.07
conda activate text-attack
python -m /home/dlee31/my-text-attack/TextAttack/textattack
