#!/bin/bash  

rnaspades.py \
  -1 adtrim/all_adtrimmed_R1.fastq.gz \
  -2 adtrim/all_adtrimmed_R2.fastq.gz \
  -t 100 \
  -m 500 \
  -o assembly/rnaspades_out
