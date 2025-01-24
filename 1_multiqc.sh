#!/usr/bin/env bash

#SBATCH --cpus-per-task=8
#SBATCH --mem=40G
#SBATCH --time=05:00:00
#SBATCH --job-name=multiqc
#SBATCH --output=/data/users/hkamdoumkemfio/rna_seq_course/output/log/output_multiqc_%j.o
#SBATCH --error=/data/users/hkamdoumkemfio/rna_seq_course/output/log/error_multiqc_%j.e
#SBATCH --partition=pibu_el8

# Define working and output directories
WORKDIR=/data/users/hkamdoumkemfio/rna_seq_course/output/fastqc
OUTPUTDIR=/data/users/hkamdoumkemfio/rna_seq_course/output/multiQC

# Change to the working directory
cd $WORKDIR

# Create the output directory if it doesn't exist
mkdir -p $OUTPUTDIR

# Run MultiQC using Apptainer
apptainer exec \
--bind $WORKDIR:$WORKDIR --bind $OUTPUTDIR:$OUTPUTDIR \
/containers/apptainer/multiqc-1.19.sif \
multiqc $WORKDIR -o $OUTPUTDIR
