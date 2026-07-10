#!/bin/bash
tdpath=/home/wheeled/mambaforge/envs/trinity_old/opt/transdecoder/

$tdpath/TransDecoder -t assembly/trinity.Trinity.fasta \
	-O assembly/transdecoder_outdir

## outputs ##
#trinity.Trinity.fasta.transdecoder.pep
#trinity.Trinity.fasta.transdecoder.cds
#trinity.Trinity.fasta.transdecoder.gff3
