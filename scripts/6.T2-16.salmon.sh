#!/bin/bash
# mamba activate rnaseq
#out=$(echo $1 | sed '')
salmon quant \
  -i salmon_index \
  -l A \
  -1 $1 \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L001_adtrimmed_R1.fastq.gz \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L002_adtrimmed_R1.fastq.gz \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L003_adtrimmed_R1.fastq.gz \
  -2 $2 \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L001_adtrimmed_R2.fastq.gz \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L002_adtrimmed_R2.fastq.gz \
		adtrim/T2-16_23L5TCLT3_AAGTGTTAGG-GCTAGTTCCG_L003_adtrimmed_R2.fastq.gz \
  -p 16 \
  -o salmon/T2-16_quant
