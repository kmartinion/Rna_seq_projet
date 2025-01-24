#!/bin/bash

#SBATCH --time=6:00:00
#SBATCH --partition=pibu_el8
#SBATCH --mem=16G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=hisat2_indexing
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/index.err
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/index.out
#SBATCH --mail-user=hansdoum@gmail.com    
#SBATCH --mail-type=BEGIN,END,FAIL


# Define (and create) input and output directories

CONTAINER="/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif"    # Container path
REFERENCE=/data/users/hkamdoumkemfio/rna_seq_course/data/Homo_sapiens.GRCh38.dna.primary_assembly.fa    # Reference genome
OUTDIR=/data/users/hkamdoumkemfio/rna_seq_course/output/index


mkdir -p $OUTDIR

# Build reference hisat2 index
apptainer exec --bind /data/ $CONTAINER hisat2-build -p 8 $REFERENCE $OUTDIR/genome_index
