#!/bin/bash  

# mamba activate rnaseq

salmon index -t assembly/trinity.Trinity.fasta -i salmon_index -p 36
