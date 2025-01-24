#!/bin/bash
#SBATCH --job-name=sam_bam       # Nom de la tâche
#SBATCH --cpus-per-task=1           # Nombre de cœurs CPU
#SBATCH --mem=4G                  # Mémoire requise par la tâche (en MB)
#SBATCH --array=0-11
#SBATCH --time=24:00:00                # Limite de temps d'exécution de la tâche
#SBATCH --partition=pibu_el8           # Partition
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL    # Notifications envoyées au début, à la fin et en cas d'échec
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/sam_bam.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/sam_bam.out

# Define (and create) input and output directories
SAM_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/mapping/"
BAM_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/file_bam"
CONTAINER="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"
mkdir -p $BAM_DIR

# List of samples
SAMPLES=(HER21 HER22 HER23 TNBC1 TNBC2 TNBC3 NonTNBC1 NonTNBC2 NonTNBC3 Normal1 Normal2 Normal3)

# Get the current sample
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID]}
SAM_FILE=${SAM_DIR}/${SAMPLE}.sam
BAM_FILE=${BAM_DIR}/${SAMPLE}.bam

# Convert SAM to BAM
apptainer exec --bind /data/ $CONTAINER \
samtools view -hbS $SAM_FILE > $BAM_FILE

