#!/bin/bash
# mamba activate rnaseq
#out=$(echo $1 | sed '')
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L001_adtrimmed_R1.fastq.gz
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L001_adtrimmed_R2.fastq.gz
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L002_adtrimmed_R1.fastq.gz
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L002_adtrimmed_R2.fastq.gz
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L003_adtrimmed_R1.fastq.gz
T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L003_adtrimmed_R2.fastq.gz
salmon quant \
  -i salmon_index \
  -l A \
  -1 $1 \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L001_adtrimmed_R1.fastq.gz \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L002_adtrimmed_R1.fastq.gz \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L003_adtrimmed_R1.fastq.gz \
  -2 $2 \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L001_adtrimmed_R2.fastq.gz \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L002_adtrimmed_R2.fastq.gz \
		adtrim/T2-8_23L5TCLT3_AATCCAATTG-CATGTAGAGG_L003_adtrimmed_R2.fastq.gz \
  -p 32 \
  -o salmon/T2-8_quant
