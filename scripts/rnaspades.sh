#!/bin/bash  

rnaspades.py \
  -1 all_samples_R1.fastq.gz \
  -2 all_samples_R2.fastq.gz \
  -t 32 \
  -m 250 \
  -o assembly/rnaspades_out
