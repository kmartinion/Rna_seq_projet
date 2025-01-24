#!/bin/bash
#SBATCH --job-name=sam_bam       # Nom de la tâche
#SBATCH --cpus-per-task=4          # Nombre de cœurs CPU
#SBATCH --mem=64G                  # Mémoire requise par la tâche (en MB)
#SBATCH --array=0-11
#SBATCH --time=24:00:00                # Limite de temps d'exécution de la tâche
#SBATCH --partition=pibu_el8           # Partition
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL    # Notifications envoyées au début, à la fin et en cas d'échec
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/sort_bam.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/sort_bam.out

#  Define (and create) input and output directories
INPUT_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/file_bam"
OUTPUT_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/sort_bam"
TEMP_DIR="/data/users/hkamdoumkemfio/rna_seq_course/output/file_bam/temp"

mkdir -p $TEMP_DIR
mkdir -p $OUTPUT_DIR

# Get the list of BAM files dynamically
FILES=($(ls $INPUT_DIR/*.bam))

# Determine the current BAM file based on SLURM_ARRAY_TASK_ID
CURRENT_FILE=${FILES[$SLURM_ARRAY_TASK_ID]}
BASENAME=$(basename $CURRENT_FILE .bam)
OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}_sorted.bam"

# Run Apptainer with Samtools for sorting
apptainer exec --bind /data/ /containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif samtools sort \
    -m 6G -@ 4 -o $OUTPUT_FILE -T $TEMP_DIR/$BASENAME $CURRENT_FILE


