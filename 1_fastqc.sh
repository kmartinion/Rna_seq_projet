#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=05:00:00
#SBATCH --job-name=fastqc
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/output_fastqc_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

# Define (and create) input and output directories
WORKDIR=/data/users/hkamdoumkemfio/rna_seq_course/
OUTDIR=$WORKDIR/output/fastqc

mkdir -p $OUTDIR
# Add the modules
module load FastQC/0.11.9-Java-11

# Make the quality analysis
fastqc -o $OUTDIR --extract  /data/users/hkamdoumkemfio/rna_seq_course/data/reads/*.fastq.gz 
 
