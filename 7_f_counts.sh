#!/bin/bash
#SBATCH --job-name=counts      # Nom de la tâche
#SBATCH --cpus-per-task=4         # Nombre de cœurs CPU
#SBATCH --ntasks=1 
#SBATCH --mem=64G                  # Mémoire requise par la tâche (en MB)
#SBATCH --array=0-11
#SBATCH --time=72:00:00                # Limite de temps d'exécution de la tâche
#SBATCH --partition=pibu_el8           # Partition
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL    # Notifications envoyées au début, à la fin et en cas d'échec
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/count.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/count.out

# Define (and create) input and output directories
CONTAINER="/containers/apptainer/subread_2.0.1--hed695b0_0.sif"  # Path to Apptainer container
ANNOTATION="/data/users/hkamdoumkemfio/rna_seq_course/data/Homo_sapiens.GRCh38.113.gtf"  # Annotation file
BAM="/data/users/hkamdoumkemfio/rna_seq_course/output/sort_bam"   # Directory containing sorted BAM files
OUTPUT="/data/users/hkamdoumkemfio/rna_seq_course/output/counts/count.txt" # Output file for counts




# Run featureCounts with bind mounts
apptainer exec --bind /data:/data $CONTAINER featureCounts -T 4 -p -Q 10 -a $ANNOTATION -o $OUTPUT $BAM/*.bam