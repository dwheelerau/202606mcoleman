#!/bin/bash  

# env trinity_old
# note had issues with version of salmon so I moved from env: rnaseq
# to the above.  

Trinity --seqType fq --max_memory 700G --left adtrim/all_adtrimmed_R1.fastq.gz --right adtrim/all_adtrimmed_R2.fastq.gz --CPU 24 --output assembly/trinity
