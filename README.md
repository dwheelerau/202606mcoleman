# 202606mcoleman  

## Introduction  
Reference free RNAseq project. Check that the species is Metapenaeus macleayi (Eastern
school prawn).  

## 1. Raw data and QC  
- fastqc  
- multiqc  
- adaptor trimming?

## 2. Transcript assembly  
- rnaSPAdes

Had a memory allocation issue that crashed it out on the second k-mer
paramater run. See github issue thread `https://github.com/ablab/spades/issues/871#issuecomment-965639427`. I incrased the max map count to 262144 as 
per the issue thread but AI recommends that this can be set higher. AI
also says to reduce the thread count, which makes sense, so I reduced it
from 100 to 24. See run1 logfile. 

I still had issues with memory allocation, so I switched to Trinity. This
ran successfully, generating a final assembled transcript file 
``. The output file is described [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Output-of-Trinity-Assembly). Here is a description of the 
way the fasta headers are created to cluster transcripts into putative genes.

```
the accession 'TRINITY_DN1000_c115_g5_i1' indicates Trinity read cluster 'TRINITY_DN1000_c115', gene 'g5', and isoform 'i1'. Because a given run of trinity involves many many clusters of reads, each of which are assembled separately, and because the 'gene' numberings are unique within a given processed read cluster, the 'gene' identifier should be considered an aggregate of the read cluster and corresponding gene identifier, which in this case would be 'TRINITY_DN1000_c115_g5'.

So, in summary, the above example corresponds to 'gene id: TRINITY_DN1000_c115_g5' encoding 'isoform id: TRINITY_DN1000_c115_g5_i1'.
```
So looking at our `` final assembly file.       

## 3. Evaluate assembly with BUSCO in transcription mode
- Animalia → Arthropoda → Crustacea → Decapoda → Penaeidae, so the natural first-choice lineage is arthropoda (or arthropoda_odb12  
- arthropoda / arthropoda_odb12 primary report  
- metazoa / metazoa_odb12
```
# transcriptome mode
busco -i rnaspades_transcripts.fasta -m transcriptome -l arthropoda_odb12 -o busco_arthropoda -c 16 --force
```
- may want to filter transcriptome to only include longest trans per loci ie remove alt splice redundancy.  
- for the above I could use the transdecoder based outputs for a protein busco.  

## 4. Annotation of coding regions (optional at this stage) 
Could leave this to after we have a list of DEGs to simplify the analysis
- TransDecoder
- DIAMOND
- eggNOG-mapper

## 5. Salmon + tximport + edgeR  
Referenc free RNAseq



