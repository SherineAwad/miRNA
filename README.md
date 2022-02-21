

[![Snakemake](https://img.shields.io/badge/snakemake-≥6.0.2-brightgreen.svg)](https://snakemake.github.io)
[![License](https://img.shields.io/badge/License-BSD_3--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)


Snakemake Workflow for lncRNA  
==========================================

This is a snakemake pipeline to differentiate lncRNAs from mRNAs.

Your samples names should be listed by default in **samples.tsv** file. You can change this file name in *config file* if needed by editing the **SAMPLES** entry in the *config file*.
The pipeline takes samples in  **fasta format** as input. The **samples.tsv** should contain your samples names without the ".fa" suffix. 


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


### References 

1. Li, A., Zhang, J., & Zhou, Z. (2014). PLEK: a tool for predicting long non-coding RNAs and messenger RNAs based on an improved k-mer scheme. BMC bioinformatics, 15(1), 1-10.