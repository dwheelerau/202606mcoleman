#!/bin/bash 

# transcoder peptides  
peps="assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.pep"

# min 100AA peptides
seqkit seq -m 100 "$peps" > assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.min100aa.pep
