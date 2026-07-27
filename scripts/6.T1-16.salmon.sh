#!/bin/bash
# mamba activate rnaseq
#out=$(echo $1 | sed '')
# fialed
#adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L001_adtrimmed_R1.fastq.gz \
#adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L001_adtrimmed_R2.fastq.gz \
salmon quant \
  -i salmon_index \
  -l A \
  -1 $1 \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L001_adtrimmed_fixed_R1.fastq.gz \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L002_adtrimmed_R1.fastq.gz \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L003_adtrimmed_R1.fastq.gz \
  -2 $2 \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L001_adtrimmed_fixed_R2.fastq.gz \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L002_adtrimmed_R2.fastq.gz \
		adtrim/T1-16_23L5TCLT3_TCCACACAGA-TTGTCGGATG_L003_adtrimmed_R2.fastq.gz \
  -p 32 \
  -o salmon/T1-16_quant
