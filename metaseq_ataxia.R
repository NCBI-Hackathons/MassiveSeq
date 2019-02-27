
library(metaSeq)
#would normally do in markdown, but something is breaking
counts=read.table('counts.txt',header=T,skip=1)
rownames(counts)=counts$Geneid

#only minor modifications from what Swamy provided, Thanks!

counts=counts[,7:ncol(counts)]
#coldata=read_tsv('SraFilternomirna.txt')
#22
#clean up the raw featurecounts to format it to just the count matrix

library(metaSeq)
library("snow")

#counts <- read.delim("~/Documents/83_counts.txt", row.names=1)
#222
flag1 <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,2,0,0,0,0,2,2,0,0,1,0,0,1,1,1,1,0,0,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,1)

flag2 <- c("A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B")
cds <- meta.readData(data = counts, factor = flag1, studies = flag2)
cl <- makeCluster(4, "SOCK")
result <- meta.oneside.noiseq(cds, k = 0.5, norm = "tmm", replicates = "biological", factor = flag1, conditions = c(1, 0), studies = flag2, cl = cl)
stopCluster(cl)
F <- Fisher.test(result)
S <- Stouffer.test(result)
