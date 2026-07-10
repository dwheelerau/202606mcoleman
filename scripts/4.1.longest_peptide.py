#!/usr/bin/env python
from Bio import SeqIO
import csv

# holds longest open reading frame
lorf_dict = {}

# log output for checking
check_f = open('logs/trans_lengths.txt', 'w')
csv_writer = csv.writer(check_f)

# the trinity output
with open('assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.pep') as rf:
    for rec in SeqIO.parse(rf, 'fasta'):
        # TRINITY_DN0_c0_g1_i1.p1
        gene = '_'.join(rec.id.split('_')[:-1])
        # log to file for checking
        csv_writer.writerow([gene, rec.id, len(rec)])
        # first entry just record details
        if gene not in lorf_dict:
            # store this transc id and its length
            lorf_dict[gene] = (rec, len(rec))
        else:
            # already in dict, check if it is longer, if so replace
            if len(rec) > lorf_dict[gene][1]:
                lorf_dict[gene] = (rec, len(rec))

# tidy up
check_f.close()        

# write output
with open('assembly/transdecoder_outdir/trinity.Trinity.fasta.transdecoder.longest_orf.pep', 'w') as wf:
    for gene in lorf_dict:
        rec = lorf_dict[gene][0]
        SeqIO.write(rec, wf, 'fasta')
