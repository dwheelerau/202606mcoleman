# imports
library(edgeR)
library(ggplot2)

# Read count matrix
counts <-read.table(
	"salmon/gene_counts.tsv",
	row.names=1,
	check.names=FALSE
)

# read metadata
meta <- read.csv("edgeR/metadata-rnaseq.csv")

head(meta)
##     SampleID Salinity Temperature Time Replicate
##1 T1-15_quant  Control    Elevated   T1         2
##2 T1-16_quant  Decline    Elevated   T1         2
##3  T1-1_quant  Decline     Control   T1         1
##4 T1-20_quant  Decline     Control   T1         2
##5 T1-24_quant  Control     Control   T1         2
##6 T1-27_quant  Control    Elevated   T1         3

all(colnames(counts) == meta$SampleID)
##[1] TRUE

# factors
meta$Salinity <- factor(
	meta$Salinity,
	levels=c("Control", "Decline")
)
meta$Temperature<- factor(
	meta$Temperature,
	levels=c("Control", "Elevated")
)
meta$Time <- factor(
	meta$Time,
	levels=c("T1", "T2")
)
levels(meta$Salinity)
levels(meta$Temperature)
levels(meta$Time)

##[1] "Control" "Decline"
##[1] "Control"  "Elevated"
##[1] "T1" "T2"

table(
    meta$Salinity,
    meta$Temperature,
    meta$Time
)

# DEGs
dge <- DGEList(counts = counts)
dge

pdf("edgeR/barplot_libsize.pdf")
barplot(
    dge$samples$lib.size / 1e6,
    las = 2,
    ylab = "Millions of reads",
    main = "Library sizes"
)
dev.off()

# Low count filter
group <- interaction(
	meta$Salinity,
	meta$Temperature,
	meta$Time
)
keep <- filterByExpr(dge, group = group)
table(keep)
##keep
## FALSE   TRUE 
##297899  51104 
dge <- dge[keep, , keep.lib.sizes = FALSE]

cat(
    "Genes before filtering:", nrow(counts), "\n",
    "Genes after filtering:", nrow(dge), "\n"
)

# Norm using TMM
dge <-calcNormFactors(dge)
dge$samples

##            group lib.size norm.factors
##T1-15_quant     1 59638658    0.6681396
##T1-16_quant     1 58408944    1.2179819
##T1-1_quant      1 54329808    0.5998176
##T1-20_quant     1 61141706    2.1448093
##T1-24_quant     1 57762946    1.6898168
##T1-27_quant     1 59417573    1.4395851
##T1-29_quant     1 67842599    0.6242038
##T1-32_quant     1 56338808    1.5303106
##T1-33_quant     1 54529353    1.5157662
##T1-3_quant      1 59687846    0.7730935
##T1-5_quant      1 51794700    0.7852928
##T1-8_quant      1 57375721    0.6349318
##T2-15_quant     1 52923525    0.9690360
##T2-16_quant     1 53078149    0.9006512
##T2-1_quant      1 67224214    0.8051977
##T2-20_quant     1 51700778    1.1641536
##T2-24_quant     1 66772716    1.2337665
##T2-27_quant     1 63378764    1.0505155
##T2-29_quant     1 66703144    1.4786953
##T2-32_quant     1 67047364    0.9681232
##T2-33_quant     1 55364211    1.1521492
##T2-3_quant      1 52155341    0.5856200
##T2-5_quant      1 53972123    0.6651054
##T2-8_quant      1 46617618    1.0327826
##
dge$samples$norm.factors

# log CPM values for PCA
logCPM <- cpm(
	dge,
	log=TRUE,
	prior.count = 2
)
pdf("edgeR/boxplot.pdf", height=9)
boxplot(
	logCPM,
	las = 2,
	main = "LogCPM Distribution"
)
dev.off()

library(pheatmap)
cor_matrix <- cor(logCPM)

pdf("edgeR/heatmap.pdf")
# see if replicates cluster
pheatmap(
	cor_matrix,
	annotation_col = data.frame(
		Salinity = meta$Salinity,
		Temperature = meta$Temperature,
		Time = meta$Time,
		row.names = meta$SampleID
	)
)
dev.off()

pca <- prcomp(
	t(logCPM),
	scale.=TRUE
)
pca_df <- data.frame(
    SampleID = meta$SampleID,
    PC1 = pca$x[,1],
    PC2 = pca$x[,2],
    Salinity = meta$Salinity,
    Temperature = meta$Temperature,
    Time = meta$Time
)
head(pca_df)

#ggplot(
#    pca_df,
#    aes(
#        PC1,
#        PC2,
#        colour = Salinity,
#        shape = Temperature
#    )
#) +
#    geom_point(size = 4) +
#    facet_wrap(~Time) +
#    theme_bw() +
#    labs(
#        title = "RNA-seq PCA",
#        colour = "Salinity",
#        shape = "Temperature"
#    
cols <- c(
    "darkgreen",
    "orange"
)
pdf("edgeR/MDS.pdf")

plotMDS(
    dge,
    col = cols[meta$Temperature],
    pch = c(16,17)[meta$Time]
)

legend(
    "topright",
    legend = levels(meta$Temperature),
    col = cols,
    pch = 16
)
dev.off()

##| Coefficient                                | Biological meaning                                                        |
##| ------------------------------------------ | ------------------------------------------------------------------------- |
##| SalinityDecline                            | Salinity effect alone                                                     |
##| TemperatureElevated                        | Temperature effect alone                                                  |
##| TimeT2                                     | Time effect alone                                                         |
##| SalinityDecline:TemperatureElevated        | Does the temperature response change under different salinity conditions? |
##| SalinityDecline:TimeT2                     | Does the time response change under different salinity conditions?        |
##| TemperatureElevated:TimeT2                 | Does the temperature response change over time?                           |
##| SalinityDecline:TemperatureElevated:TimeT2 | Does the salinity-temperature interaction itself change over time?        |

# sanity checks
stopifnot(identical(colnames(counts), meta$SampleID))

with(
    meta,
    table(Salinity, Temperature, Time)
)

design <- model.matrix(
    ~ Salinity * Temperature * Time,
    data = meta
)

colnames(design)
##[1] "(Intercept)"
##[2] "SalinityDecline"
##[3] "TemperatureElevated"
##[4] "TimeT2"
##[5] "SalinityDecline:TemperatureElevated"
##[6] "SalinityDecline:TimeT2"
##[7] "TemperatureElevated:TimeT2"
##[8] "SalinityDecline:TemperatureElevated:TimeT2"
