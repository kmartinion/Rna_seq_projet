#!/bin/bash
#SBATCH --job-name=mapping       # Nom de la tâche
#SBATCH --cpus-per-task=4            # Nombre de cœurs CPU
#SBATCH --mem=8G                  # Mémoire requise par la tâche (en MB)
#SBATCH --array=0-11
#SBATCH --time=24:00:00                # Limite de temps d'exécution de la tâche
#SBATCH --partition=pibu_el8           # Partition
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL    # Notifications envoyées au début, à la fin et en cas d'échec
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/mapp.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/mapp.out

# # Define (and create) input and output directories

CONTAINER="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"  # Container path
REFERENCE="/data/users/hkamdoumkemfio/rna_seq_course/output/index/genome_index"           # Reference genome index path
READS_OUTPUT="/data/users/hkamdoumkemfio/rna_seq_course/data/reads/"           # Directory containing FASTQ files
OUTPUT="/data/users/hkamdoumkemfio/rna_seq_course/output/mapping/"   # Directory for output SAM files
THREADS=4                                                              # Number of threads

mkdir -p $OUTPUT

# List of samples
SAMPLES=(HER21 HER22 HER23 TNBC1 TNBC2 TNBC3 NonTNBC1 NonTNBC2 NonTNBC3 Normal1 Normal2 Normal3)

# Get the sample for the current array task
SAMPLE=${SAMPLES[$SLURM_ARRAY_TASK_ID]}

# Define input and output files
READ_1=${READS_OUTPUT}${SAMPLE}_R1.fastq.gz
READ_2=${READS_OUTPUT}${SAMPLE}_R2.fastq.gz
SAM_FILE=${OUTPUT_OUTPUT}${SAMPLE}.sam


# Run HISAT2 mapping
apptainer exec --bind /data/ $CONTAINER \
hisat2 -x $REFERENCE -1 $READ_1 -2 $READ_2 -S $SAM_FILE -p $THREADS


