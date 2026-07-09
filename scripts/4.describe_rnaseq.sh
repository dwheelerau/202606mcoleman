#!/bin/bash 

#https://github.com/trinityrnaseq/trinityrnaseq/wiki/RNA-Seq-Read-Representation-by-Trinity-Assembly
bowtie2-build assembly/trinity.Trinity.fasta assembly/trinity.Trinity.fasta

# PE read mapping 
bowtie2 -p 50 -q --no-unal -k 20 -x assembly/trinity.Trinity.fasta -1 adtrim/all_adtrimmed_R1.fastq.gz -2 adtrim/all_adtrimmed_R2.fastq.gz 2>logs/align_stats.txt | samtools view -@50 -Sb -o assembly/bowtie2.bam 

# report
cat 2>&1 logs/align_stats.txt > logs/align_summary.txt
