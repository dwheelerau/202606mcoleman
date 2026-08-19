#!/bin/bash  

# --target_orthologs consider one2one or non-electronic
# --tax_scope 6657 for crustations  
# --sensmode ultra-sensitive

# Eggnog mapper with AAs filtered to be min 100AAs long  
peps="assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.min100aa.pep"  

emapper.py -i "$peps" \
	--itype proteins \
	--cpu 32 \
	--sensmode sensitive \
	--target_orthologs all \
	--tax_scope auto \
	-m diamond \
	-o prawn_annotations3 \
	--report_orthologs \
	2>&1 | tee logs/emapper_run3.log

#--pfam_realign realign \

