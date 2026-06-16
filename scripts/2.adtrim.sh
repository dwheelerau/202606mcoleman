#!/bin/bash 
adapters="/home/wheeled/mambaforge/pkgs/bbmap-39.81-h9b5c0a0_1/share/bbmap/resources/adapters.fa"
data="/home/wheeled/AGTC_WWAI_NAS/gROUPS/BioInformatics/dave/202606mcoleman/AGRF_NXGSQCAGRF26030040-1_23L5TCLT3"

for r1 in $data/*_R1.fastq.gz
do
    r2=$(echo $r1 | sed 's/_R1/_R2/')
    out_r1=$(echo $r1 | sed 's/_R1.fastq.gz/_adtrimmed_R1.fastq.gz/')
	out_r1_fname=$(basename $out_r1)
    out_r2=$(echo $r2 | sed 's/_R2.fastq.gz/_adtrimmed_R2.fastq.gz/')
	out_r2_fname=$(basename $out_r2)
    echo $out_r1
    /home/wheeled/mambaforge/envs/rnaseq/opt/bbmap-39.81-1/bbduk.sh -Xmx100g in1="$r1" in2="$r2" out1="adtrim/$out_r1_fname" out2="adtrim/$out_r2_fname" ref="$adapters" ktrim=r k=23 mink=11 hdist=1 tpe tbo
done
