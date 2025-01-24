# RNA-seq Workflow: Differential Gene Expression Analysis

## Project Description

This workflow detects differentially expressed (DE) genes from bulk RNA-seq data. Starting from Illumina sequencing data (FASTQ files), the analysis aims to produce:
1. Lists of DE genes between experimental groups.
2. Gene Ontology (GO) terms enriched for DE genes.

The dataset includes 3 replicates from 3 subtypes of human breast tumors and 3 healthy samples (accession: GSE52194). 

---

## Workflow Steps

### 1. Getting Started
- **Setup**: Create a working directory under `/data/users/<username>`. Organize outputs by analysis step or tool.
- **Reproducibility**: Use Bash or R scripts to document the process, including tool versions and reference genome details.
- **Containers**: Use preconfigured container images for tools to ensure portability and reproducibility. Containers are available under `/containers/apptainer/`.

| Tool           | Container Path                                                   |
|----------------|------------------------------------------------------------------|
| FastQC         | `/containers/apptainer/fastqc-0.12.1.sif`                        |
| Hisat2         | `/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif`     |
| Samtools       | `/containers/apptainer/hisat2_samtools_408dfd02f175cd88.sif`     |
| FeatureCounts  | `/containers/apptainer/subread_2.0.1–hed695b0_0.sif`            |

---

### 2. Quality Checks
- **Tool**: Run FastQC on raw reads.
- **Objectives**:
  - Assess the number of reads per sample.
  - Examine base quality along read lengths and between paired mates.
  - Detect adapter sequences or issues requiring correction.
- **Expected Outputs**: FastQC HTML reports.

---

### 3. Mapping Reads to the Reference Genome
- **Tools**: Hisat2, Samtools.
- **Steps**:
  1. Download the latest reference genome and annotation from Ensembl FTP.
  2. Index the reference genome using Hisat2.
  3. Map reads to the genome.
  4. Convert, sort, and index SAM/BAM files using Samtools.
- **Analysis**:
  - Alignment rates across samples.
  - Concordantly aligned reads.
  - Multimapped reads and their impact on downstream analysis.

---

### 4. Counting Reads per Gene
- **Tool**: FeatureCounts.
- **Inputs**: BAM files and genome annotation (GTF).
- **Outputs**: Gene count table for all samples.
- **Analysis**:
  - Proportion of reads overlapping annotated genes.
  - Average unassigned reads due to ambiguity.

---

### 5. Exploratory Data Analysis
- **Tools**: RStudio, DESeq2.
- **Steps**:
  1. Create a `DESeqDataSet` object from FeatureCounts output.
  2. Perform variance-stabilizing transformation (VST) or rlog transformation.
  3. Use PCA to assess clustering of samples by gene expression profiles.
- **Objectives**:
  - Visualize clustering of samples.
  - Comment on clustering patterns and their implications.

---

### 6. Differential Expression Analysis
- **Tool**: DESeq2.
- **Steps**:
  1. Extract DE results for a pairwise comparison.
  2. Identify DE genes (adjusted p-value < 0.05).
  3. Analyze the number of upregulated vs. downregulated genes.
  4. Investigate expression of key genes from the original publication.
- **Outputs**:
  - DE genes table.
  - Normalized counts for selected genes.

---

### 7. Overrepresentation Analysis
- **Tool**: ClusterProfiler.
- **Steps**:
  1. Perform GO enrichment analysis using `clusterProfiler::enrichGO`.
  2. Specify parameters:
     - `gene`: DE gene IDs.
     - `universe`: All measured gene IDs.
     - `OrgDb`: Annotation package (`org.Hs.eg.db`).
     - `ont`: Ontology (BP, MF, CC, or ALL).
  3. Visualize results.
- **Objectives**:
  - Identify enriched GO terms.
  - Discuss biological relevance based on sample characteristics.

---

## Resource Allocation
Below are suggested Slurm resource settings for tools run on the IBU cluster:

| Tool               | CPU | Memory (MB) | Time (hours) |
|--------------------|-----|-------------|--------------|
| FastQC             | 1   | 1000        | 1            |
| Hisat2 (indexing)  | 1   | 8000        | 3            |
| Hisat2 (mapping)   | 4   | 8000        | 13           |
| Samtools (view)    | 1   | 4000        | 1            |
| Samtools (sort)    | 4   | 25000       | 2            |
| Samtools (index)   | 1   | 4000        | 1            |
| FeatureCounts      | 4   | 4000        | 13           |

---

## References
- Eswaran et al., 2012. Gene Expression Omnibus (GEO) accession: GSE52194.
- Tools used: FastQC, Hisat2, Samtools, FeatureCounts, DESeq2, ClusterProfiler.



