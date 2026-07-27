#!/bin/bash
# mamba activate rnaseq
#out=$(echo $1 | sed '')
salmon quant \
  -i salmon_index \
  -l A \
  -1 $1 \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L001_adtrimmed_R1.fastq.gz \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L002_adtrimmed_R1.fastq.gz \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L003_adtrimmed_R1.fastq.gz \
  -2 $2 \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L001_adtrimmed_R2.fastq.gz \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L002_adtrimmed_R2.fastq.gz \
		adtrim/T1-5_23L5TCLT3_CTTATTGGCC-GATAACAAGT_L003_adtrimmed_R2.fastq.gz \
  -p 16 \
  -o salmon/T1-5_quant
