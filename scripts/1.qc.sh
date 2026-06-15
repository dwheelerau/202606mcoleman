#!/bin/bash
fastqc ~/AGTC_WWAI_NAS/GROUPS/BioInformatics/dave/202606mcoleman/AGRF_NXGSQCAGRF26030040-1_23L5TCLT3/*fastq.gz --outdir qc/fastqc/ --threads 100

# create a summary of all of the indiv fastqc results
multiqc qc/fastqc -o qc/multiqc/
