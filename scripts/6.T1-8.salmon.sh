#!/bin/bash
# mamba activate rnaseq
#out=$(echo $1 | sed '')
salmon quant \
  -i salmon_index \
  -l A \
  -1 $1 \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L001_adtrimmed_R1.fastq.gz \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L002_adtrimmed_R1.fastq.gz \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L003_adtrimmed_R1.fastq.gz \
  -2 $2 \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L001_adtrimmed_R2.fastq.gz \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L002_adtrimmed_R2.fastq.gz \
		adtrim/T1-8_23L5TCLT3_GTTGGATGAA-TTCCAGGTAA_L003_adtrimmed_R2.fastq.gz \
  -p 16 \
  -o salmon/T1-8_quant
