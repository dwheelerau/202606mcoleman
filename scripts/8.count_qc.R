library("edgeR")

# dims and sample names
counts <- read.delim(
	"salmon/gene_counts.tsv",
	row.names=1,
	check.names= FALSE
)

print("counts")
dim(counts)
head(counts)
colnames(counts)

print("lib size")
colSums(counts)
keep
 FALSE   TRUE
333473  15530
#            group lib.size norm.factors
#T1-15_quant     1 59297647    0.7034822
#T1-16_quant     1 57635518    1.2055975
#T1-1_quant      1 52750096    0.6000330
#T1-20_quant     1 35790338    2.7481003 **EXTREME check**
#T1-24_quant     1 55796014    1.5110989
#T1-27_quant     1 57815737    1.3507627
#T1-29_quant     1 67339564    0.6519619
#T1-32_quant     1 54329963    1.4145224
#T1-33_quant     1 52484158    1.3169298
#T1-3_quant      1 59110616    0.8298168
#T1-5_quant      1 50777492    0.8138572
#T1-8_quant      1 56983784    0.6460500
#T2-15_quant     1 52426274    0.9049413
#T2-16_quant     1 52531339    0.9003304
#T2-1_quant      1 66697328    0.9178591
#T2-20_quant     1 51056685    1.1215996
#T2-24_quant     1 66000404    1.1646111
#T2-27_quant     1 62717999    0.9745803
#T2-29_quant     1 65575172    1.3636095
#T2-32_quant     1 66427743    0.9424524
#T2-33_quant     1 54761918    1.0521376
#T2-3_quant      1 51771368    0.6189967
#T2-5_quant      1 53616389    0.7065199
#T2-8_quant      1 37689988    1.1743680

libsizes <-colSums(counts)
pdf("salmon/libsizes_qc.pdf")
barplot(
	libsizes,
	las = 2,
	main = "Library sizes",
	ylab = "Estimated counts"
)
dev.off()

pdf("salmon/count_dist_qc.pdf")
boxplot(
	log2(counts + 1),
	las = 2,
	main = "Log2 Counts Distribution"
)
dev.off()

# MDS remove lowexpressed genes first
dge <- DGEList(counts)
keep <-filterByExpr(dge)
table(keep)
dge<-dge[keep,,keep.lib.sizes=FALSE]
dge <- calcNormFactors(dge)
# should be close to 1
dge$samples

# plot
pdf("salmon/MDS_qc.pdf")
plotMDS(dge, labels = colnames(dge))
dev.off()

# better plot
# group <-factor(c("Control","Control","Treatment","Treatment",...))
#plotMDS(dge,labels=colnames(dge), col=as.numeric(group))
