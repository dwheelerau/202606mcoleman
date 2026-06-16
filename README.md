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



