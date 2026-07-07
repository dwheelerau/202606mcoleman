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
`trinity.Trinity.fasta`. The output file is described [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Output-of-Trinity-Assembly). Here is a description of the 
way the fasta headers are created to cluster transcripts into putative genes.

```
the accession 'TRINITY_DN1000_c115_g5_i1' indicates Trinity read cluster 'TRINITY_DN1000_c115', gene 'g5', and isoform 'i1'. Because a given run of trinity involves many many clusters of reads, each of which are assembled separately, and because the 'gene' numberings are unique within a given processed read cluster, the 'gene' identifier should be considered an aggregate of the read cluster and corresponding gene identifier, which in this case would be 'TRINITY_DN1000_c115_g5'.

So, in summary, the above example corresponds to 'gene id: TRINITY_DN1000_c115_g5' encoding 'isoform id: TRINITY_DN1000_c115_g5_i1'.
```
So looking at our `trinity.Trinity.fasta` final assembly file.       
```
>TRINITY_DN25858_c0_g1_i1 len=859 path=[2:0-63 6:64-87 7:88-99 8:100-202 9:203-218 11:219-263 15:264-301 17:302-344 18:345-385 21:386-459 23:460-494 24:495-530 26:531-674 28:675-731 29:732-858]
>TRINITY_DN25858_c0_g1_i10 len=1042 path=[3:0-134 5:135-244 6:245-268 7:269-280 8:281-383 9:384-399 11:400-444 15:445-482 17:483-525 18:526-566 21:567-640 23:641-675 24:676-711 26:712-855 27:856-857 28:858-914 29:915-1041]
>TRINITY_DN25858_c0_g1_i17 len=956 path=[0:0-60 5:61-170 6:171-194 8:195-297 9:298-313 11:314-358 15:359-396 17:397-439 18:440-480 21:481-554 23:555-589 25:590-625 26:626-769 27:770-771 28:772-828 29:829-955]
```
This represents three transcripts from cluster `TRINITY_DN25858_c0` gene
`g1` and isoforms `i1`, `i10`, and `i17`. And for this cluster the gene ID
can be considered to be: `TRINITY_DN25858_c0_g1_i1`.  

The actual assembled transcript assembles can be viewed with [bandage](https://rrwick.github.io/Bandage/).  

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



