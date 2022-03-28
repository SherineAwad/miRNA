

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.0.2-brightgreen.svg)](https://snakemake.github.io)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)


Snakemake Workflow for  miRNA detection  
===========================================

This is a snakemake pipeline to detect miRNA in samples.

#### Edit the configfile 

You will need to edit your config file as described below:

| Config Variable      | Description                                                      |
| ---------------------| -----------------------------------------------------------------|
| SAMPLES              | name of file containing your samples names, default: samples.tsv |
| GENOME               | Path to your genome file                                         |
| PREFIX               | Name of the prefix of the genome to align to "mature"            |
| miRNA                | default is "mature.fa" pulled automatically from mirbase         |
| PAIRED               | True if your samples are paired, false otherwise                 |

The pipeline takes samples with a suffix 'r_1.fq.gz' and 'r_2.fq.gz' if the samples are paired. Or it takes samples with suffix 'fq.gz' if the samples is single-end reads. 

Regardless your samples are paired, single-ended, samples names should be **samples.tsv** without the suffix.

The pipeline uses by default "mature.fa" from mirbase. 

### Run the pipeline 

    snakemake -jn 

where n is the number of cores for example for 10 cores use:


    snakemake -j10 

### Use conda 

For less froodiness, use conda:


    snakemake -jn --use-conda 


For example, for 10 cores use: 

    snakemake -j10 --use-conda 

This will pull automatically the same versiosn of tools we used. Conda has to be installed in the system, in addition to snakemake. 


### Dry Run


For a dry run use: 
  
  
    snakemake -j1 -n 


and to print command in dry run use: 

  
    snakemake -j1 -n -p 


### Use Corresponding configfile:


Just update your config file to include all your sample names, edit your interval.list file to include your intervals of interest, your path, etc for example: 

  
    snakemake -j1 --configfile config-WES.yaml 
  
or: 


    snakemake -j1 configfile config-WGS.yaml 



