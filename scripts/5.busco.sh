#!/bin/bash

### env ###
# mamba activate busco
##########

##
#-i input sequences or folder
#-m analyssis mode ie 'transcriptome'
#-c cores/threads
#-l "arthropoda_odb12.2" #metazoa_odb12.2
#-o outdir_path
## not required as will specify using l
#--download "arthropoda_odb12.2" #metazoa_odb12.2
#--download_path busco-db

# longest ORF per gene
lorf="assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.longest_orf.pep"
 
busco -i $lorf -m proteins -l "arthropoda_odb12.2" -o assembly/busco_out -c 16 
