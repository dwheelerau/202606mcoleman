library(tximport)
library(readr)

samples <- c(
	"T1-15_quant",
	"T1-16_quant",
	"T1-1_quant",
	"T1-20_quant",
	"T1-24_quant",
	"T1-27_quant",
	"T1-29_quant",
	"T1-32_quant",
	"T1-33_quant",
	"T1-3_quant",
	"T1-5_quant",
	"T1-8_quant",
	"T2-15_quant",
	"T2-16_quant",
	"T2-1_quant",
	"T2-20_quant",
	"T2-24_quant",
	"T2-27_quant",
	"T2-29_quant",
	"T2-32_quant",
	"T2-33_quant",
	"T2-3_quant",
	"T2-5_quant",
	"T2-8_quant"
)

files <- file.path("salmon", samples, "quant.sf")
names(files) <-samples

tx2gene <-read.table(
	"assembly/trinity.Trinity.fasta.gene_trans_map",
	header = FALSE,
	stringsAsFactors = FALSE
)
head(tx2gene)

colnames(tx2gene) <-c("gene_id", "transcript_id")

tx2gene <- tx2gene[,c("transcript_id", "gene_id")]
head(tx2gene)

txi <- tximport(
	files,
	type="salmon",
	tx2gene = tx2gene
)

counts <- txi$counts
write.table(
	counts,
	file = "salmon/gene_counts.tsv",
	sep = "\t",
	quote = FALSE,
	col.names = NA
)
head(counts)
