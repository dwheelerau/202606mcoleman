#!/bin/bash  

# sort the bam by coord for IGV viewing
samtools sort -@ 50 assembly/bowtie2.bam -o assembly/bowtie2.coordSorted.bam

# index bam
samtools index assembly/bowtie2.coordSorted.bam

# index assembly
samtools faidx assembly/trinity.Trinity.fasta  
