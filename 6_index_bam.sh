#!/bin/bash
#SBATCH --job-name=sam_bam       # Nom de la tâche
#SBATCH --cpus-per-task=1          # Nombre de cœurs CPU
#SBATCH --ntasks=1 
#SBATCH --mem=4G                  # Mémoire requise par la tâche (en MB)
#SBATCH --array=0-11
#SBATCH --time=24:00:00                # Limite de temps d'exécution de la tâche
#SBATCH --partition=pibu_el8           # Partition
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL    # Notifications envoyées au début, à la fin et en cas d'échec
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/index_bam.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/index_bam.out

# Define (and create) input and output directories
CONTAINER_PATH="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"
DATA_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/sort_bam"

# Get the BAM file 
BAM_FILES=($(ls $DATA_DIR/*.bam))
BAM_FILE=${BAM_FILES[$SLURM_ARRAY_TASK_ID]}

# Run samtools index 
apptainer exec --bind $DATA_DIR $CONTAINER_PATH samtools index $BAM_FILE