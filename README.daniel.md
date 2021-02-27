# Installing virtual environment
There were issues trying to do a simple pip3 install -r requirements.txt with standard python. 
I was successful with anaconda.
Following are the commands I used to get the environment up and running on `redas-lab2.patanjali.hpcc.uh.edu`
1. `ssh dlee31@redas-lab2.patanjali.hpcc.uh.edu`
2. First, clone the git repo
   - `git clone https://github.com/ReDASers/TextAttack.git`
    
2. Load module to access anaconda.
   - The default anaconda module (`python/anaconda3/5.0.1`) does not allow for local creation of conda environments. 
   - I used `module load python/anaconda3/2020.07`.
   
3. In addition, you may need to init your shell to allow for `conda` commands.
   - `conda init bash`
   - `source ~/.bashrc`
    
4. Create conda environment. I named it `text-attack`
   - `conda create --name text-attack python=3.6`
    
5. Activate environment
   - `conda activate text-attack`
    
6. Install requirements.txt
   - make sure you have the conda environment activated
   - and also make sure to be in the cloned git repo.
   - `pip install -r requirements.txt`
    
7. Run simple test
   - on first run this should download necessary packages (i.e. punkt for nltk, word embeddings, etc.)
   - then you should receive the default help message.
```text
usage: [python -m] texattack <command> [<args>]

positional arguments:
  {attack,attack-resume,augment,benchmark-recipe,eval,list,train,peek-dataset}
                        textattack command helpers
    attack              run an attack on an NLP model
    attack-resume       resume a checkpointed attack
    augment             augment text data
    benchmark-recipe    benchmark a recipe
    eval                evaluate a model with TextAttack
    list                list features in TextAttack
    train               train a model for sequence classification
    peek-dataset        show main statistics about a dataset

optional arguments:
  -h, --help            show this help message and exit
```

# Running with slurm
Although small test runs are OK on the login nodes for patanjali.hpcc.uh.edu, 
you should not run anything that involves heavy computations.
For actually experiments, use the SLURM batch service. 
This will put your code on a compute node and give access to powerful GPU nodes.

- Create a bash shell script. Below are some common options for SLURM
```shell
#!/bin/bash
#SBATCH -p batch               # queue (partition)
#SBATCH -J TAtest              # job name

#output and error file name (%j expands to jobID)
#SBATCH -o /home/dlee31/my-text-attack/TextAttack/slurm.TAtest.%j.out

#SBATCH -N 1                   # total number of mpi tasks requested
#SBATCH --cpus-per-task 2      # allocate two cores
#SBATCH --mem 16384
#SBATCH --gres=gpu:2           # allocate 2 gpus
##SBATCH -t 00:05:00           # max run time (hh:mm:ss)

#SBATCH --mail-type=end        # email me when the job finishes
#SBATCH --mail-user=dlseven777@gmail.com

# Slurm automatically allocates a scratch directory for the job
# TMPDIR points to the location of the scratch directory
# When the job ends, Slurm removes the directory
```
- You need load modules
```shell
module load python/anaconda3/2020.07
```
- Activate conda environment
```shell
conda activate text-attack
```
- Execute command
```shell
python -m /home/dlee31/my-text-attack/TextAttack/textattack
```
- Final SLURM script should look like this
```shell
#!/bin/bash
#SBATCH -p batch               # queue (partition)
#SBATCH -J TAtest              # job name

#output and error file name (%j expands to jobID)
#SBATCH -o /home/dlee31/my-text-attack/TextAttack/slurm.TAtest.%j.out

#SBATCH -N 1                   # total number of mpi tasks requested
#SBATCH --cpus-per-task 2      # allocate two cores
#SBATCH --mem 16384
#SBATCH --gres=gpu:2           # allocate 2 gpus
##SBATCH -t 00:05:00           # max run time (hh:mm:ss)

#SBATCH --mail-type=end        # email me when the job finishes
#SBATCH --mail-user=dlseven777@gmail.com

module load python/anaconda3/2020.07
conda activate text-attack
python -m /home/dlee31/my-text-attack/TextAttack/textattack
```


