# 202606mcoleman  

## Introduction  
Reference free RNAseq project. Check that the species is Metapenaeus macleayi (Eastern
school prawn).  

Closely related species with resources (according to AI two marked as good):
- Penaeus monodon (black tiger shrimp) **good**
- Litopenaeus vannamei (Pacific white shrimp) **good**
- Fenneropenaeus chinensis
- Marsupenaeus japonicus

## 1. Raw data and QC  
- fastqc  
- multiqc  

## 2. Adaptor trimming with bbduk   
- adaptor trimming with bbduk see scripts  

## 3. Transcript assembly using trinity  
The final assembled transcript file  `trinity.Trinity.fasta`. 
The output file is described [here](https://github.com/trinityrnaseq/trinityrnaseq/wiki/Output-of-Trinity-Assembly). 
Here is a description of the way the fasta headers are created to cluster transcripts into putative genes.

```
the accession 'TRINITY_DN1000_c115_g5_i1' indicates Trinity read cluster 'TRINITY_DN1000_c115', gene 'g5', and isoform 'i1'. Because a given run of trinity involves many many clusters of reads, each of which are assembled separately, and because the 'gene' numberings are unique within a given processed read cluster, the 'gene' identifier should be considered an aggregate of the read cluster and corresponding gene identifier, which in this case would be 'TRINITY_DN1000_c115_g5'.
```
So, in summary, the above example corresponds to 'gene id: TRINITY_DN1000_c115_g5' encoding 'isoform id: TRINITY_DN1000_c115_g5_i1'.

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

### Evaluating the assembly by mapping back the raw data  
The trinity manual outlines a number of QC steps that can be taken to 
check the quality of the assembly. The first is to map back raw reads to
the assembled transcripts. The goal is to count the number of proper pairs,
improper or orphan read alignments. These are the results from bowtie2 
mapping.

```
cat logs/align_stats.txt 
1423240957 reads; of these:
  1423240957 (100.00%) were paired; of these:
    159723489 (11.22%) aligned concordantly 0 times
    58492468 (4.11%) aligned concordantly exactly 1 time
    1205025000 (84.67%) aligned concordantly >1 times
    ----
    159723489 pairs aligned concordantly 0 times; of these:
      441371 (0.28%) aligned discordantly 1 time
    ----
    159282118 pairs aligned 0 times concordantly or discordantly; of these:
      318564236 mates make up the pairs; of these:
        84476186 (26.52%) aligned 0 times
        11101644 (3.48%) aligned exactly 1 time
        222986406 (70.00%) aligned >1 times
97.03% overall alignment rate
```
The manual states that we would expect a high proportion of reads to map
to the assembly, in this case it is very high @ 97%. The manual also states
proper pairs should map 1 or more times ~70-80%, in this case it is 84.7%. 
There is high levels of duplication as indicated by the difference between
the unique mapping versus multiple mapping statistics, however, the manual
states that this is normally not an area of concern. But difference is
large indicating a lot of redundancy, so we should keep this in mind 
for subsequent steps (downstream analysis will take this redundancy into
consideration.     

Ultimately we can use this data to visualise the read mapping using
IGV.  

## 4. Use transdecoder to obtain the open reading frames   
- use transdecoder based outputs for a protein busco with the longest orf.  
- Use python to parse the peptide file to extract the longest peptide per trinity loci

## 5. Use busco to assess the longest transcoder transcript per trinity gene
Gene loci based on the fasta header clustering from Trinity.  

### The results from arthropoda/arthropoda_odb12 primary report  

```
    ---------------------------------------------------
    |Results from dataset arthropoda_odb12.2           |
    ---------------------------------------------------
    |C:96.2%[S:82.7%,D:13.5%],F:0.9%,M:2.9%,n:1332     |
    |1281    Complete BUSCOs (C)                       |
    |1101    Complete and single-copy BUSCOs (S)       |
    |180    Complete and duplicated BUSCOs (D)         |
    |12    Fragmented BUSCOs (F)                       |
    |39    Missing BUSCOs (M)                          |
    |1332    Total BUSCO groups searched               |
    ---------------------------------------------------
```
- 96% complete buscos (83% single copy, 14% duplicated)  
- 0.9 fragmented  
- 3% missing  

Some duplication but once again not concerning at this stage due to this
being a transcriptome assembly.  


## 6. Salmon   
See scripts directory. There are three lanes of data per sample, so these
were combined using the salmon script. I had issues with `T1-16..L001` in
that it caused a seg-fault issue with salmon. Only the L001 run of this sample
caused issues, with L002 and L003 being processed correctly. I ran a number
of quality checks on the R1 and R2 file for L001 but nothing was identified. I
used `seqkit head` to iterate through the file increasing the number of reads 
processed until I was able to trigger the seg-fault between reads 
15,487,300 and 15,487,400. So I removed these 100 reads and re-ran the 
script with no issues. For some technical details of what was done to fix
the L001 sample see `adtrim/notes-t1-16-l001.txt`.   

## 7. Generate a expression count table using tximport  
This is based on the gene to transcript file generated by trinity
`assembly/trinity.Trinity.fasta.gene_trans_map`. This means counts are 
consolidated to the gene level. The final count table ready for edgeR is
``.  

Would import something like this:  
```
counts <- read.delim(
    "gene_counts.tsv",
    row.names = 1,
    check.names = FALSE
)

dge <- DGEList(counts)
``` 

## 8. basic qc  
Just some quick and dirty QC, I noticed that sample `T1_20` has a much
larger normalisation factor. I did a quick MDA plot and it is an outlier,
but to an extreme outlier, so I will just flag this for now as something 
we should keep an eye on.   
```
            group lib.size norm.factors
T1-15_quant     1 59297647    0.7034822
T1-16_quant     1 57635518    1.2055975
T1-1_quant      1 52750096    0.6000330
T1-20_quant     1 35790338    2.7481003 **EXTREME check**
....
```

## 9. Annotation of coding regions (optional at this stage) 
Could leave this to after we have a list of DEGs to simplify the analysis
- TransDecoder
- DIAMOND
- eggNOG-mapper
