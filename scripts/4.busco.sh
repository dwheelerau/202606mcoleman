#!/bin/bash

##
#-i input sequences or folder
#-m analyssis mode ie 'transcriptome'
#-c cores/threads
#-l "arthropoda_odb12.2" #metazoa_odb12.2
#-o outdir_path
## not required as will specify using l
#--download "arthropoda_odb12.2" #metazoa_odb12.2
#--download_path busco-db
##
busco -i transcripts.fa -m transcriptome -l "arthropoda_odb12.2" -o busco_out
