#!/bin/bash  

# --target_orthologs consider one2one or non-electronic
# --tax_scope 6657 for crustations  
# --sensmode ultra-sensitive

# Eggnog mapper with AAs filtered to be min 100AAs long  
peps="assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.min100aa.pep"  
diamonddb="/home/wheeled/mambaforge/envs/busco/lib/python3.12/site-packages/data/eggnog_proteins.dmnd"

diamond blastp \
    --query "$peps" \
    --db "$diamonddb" \
    --out diamond_test.tsv \
    --outfmt 6 \
    --max-target-seqs 5 \
    --threads 64
