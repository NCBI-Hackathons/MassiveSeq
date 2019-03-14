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

#this is godawful slow with 60k genes, who even knows how long it would take if using the transcripts
#cut out non ENSG to speed things up, or just run on 10 cores and hope for the best?
countData <- as.matrix(read.csv("gene_count_matrix.csv", row.names="gene_id"))
countData <-as.matrix(read.csv("gene_count_matrix_noclust.csv",row.names="gene_id"))
countData <- as.matrix(read.csv("transcript_count_matrix.csv", row.names="gene_id"))
#colData <- data.frame(study=)

#stringtie_known_transcript.csv
countData <-as.matrix(read.csv("stringtie_known_gene.csv",row.names="gene_id")) 

#ensg=grep(rownames(countData),pattern="ENSG")
#cdataens = countData[ensg,]


#counts <- read.delim("~/Documents/83_counts.txt", row.names=1)
#222
flag1 <- c(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,1,1,1,2,0,0,0,0,2,2,0,0,1,0,0,1,1,1,1,0,0,0,1,0,0,0,0,1,1,0,0,0,1,1,0,1,1,1,1,1,1,1,1)

flag2 <- c("A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","A","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B","B")
cds <- meta.readData(data = countData, factor = flag1, studies = flag2)

colData <- data.frame(study=flag2,casecont=factor(flag1))
colData$casecont = recode(colData$casecont,`0`="Control",`1`="Friedreichs",`2`="Carrier")

which(colData$casecont=="A")
which(colData$casecont=="B")

library(DESeq2)
library("BiocParallel")
register(SnowParam(6))


#do it with deseq instead for graphics! 
dds <- DESeqDataSetFromMatrix(countData = countData,
                              colData = colData,
                              design= ~ casecont+study)

keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]

dds <- DESeq(dds)
res <- results(dds)

res <- results(dds, name="casecont_1_vs_0")
resultsNames(dds)
resLFCshrink=
resLFC <- lfcShrink(dds, coef=2, type="apeglm")
par(mfrow=c(1,3), mar=c(4,4,2,1))
xlim <- c(1,1e5); ylim <- c(-3,3)
png("ataxia.png")
plotMA(resLFC, xlim=xlim, ylim=ylim, main="apeglm")
dev.off()
plotMA(resLFC, xlim=xlim, ylim=ylim, main="apeglm")


resOrdered <- res[order(res$pvalue),]

d<- plotCounts(dds,gene="ENSG00000165060",intgroup='casecont',returnData=T)

ggplot(d, aes(x=casecont, y=count)) + 
  geom_point(position=position_jitter(w=0.1,h=0)) + 
  scale_y_log10(breaks=c(25,100,400))+theme_bw()
ggsave()

1
gmean=
  rownames(colData)=colnames(countData)
cl <- makeCluster(6, "SOCK")
result <- meta.oneside.noiseq(cds, k = 0.5, norm = "tmm", replicates = "biological", factor = flag1, conditions = c(1,0), studies = flag2, cl = cl)
stopCluster(cl)
F <- Fisher.test(result)
S <- Stouffer.test(result)
saveRDS(result,"metaseq_res_ens.rds")
saveRDS(F,"metaseq_F_ens.rds")
saveRDS(S,"metaseq_S_ens.rds")


BiocManager::install("GSVA", version = "3.8")
BiocManager::install("GSVAdata", version = "3.8")
library(GSVA)
library(GSVAdata)
#library(GSVAbase)

data(commonPickrellHuang)

data(c2BroadSets)


min(c(F$Upper,F$Lower),na.rm=T)
library(stringr)
upc=na.omit(F$Upper)
upcaj=p.adjust(upc)labs(x="Control p-pvalue",y="N")
p1=qplot(upc)+theme_cowplot()+labs(x="Control Upregulated p-value",y="N")
p1=p1+geom_vline(xintercept=.05,color="red")# +annotate("text",label="sig. cutoff",x=.00,y=2000)
save_plot("metaseq_upreg.png",p)
labs(x="MetaSeq Control Downregulated p-values",y="N",title="Histogram of Downregulated genes in Controls vs F. Ataxia")
p2=qplot(lc)+theme_cowplot()+labs(x="Control Downregulated p-value",y="N")
p2=p2+geom_vline(xintercept=.05,color="red")# +annotate("text",label="sig. cutoff",x=.00,y=2000)+xlim(0,1)
save_plot("metaseq_downreg.png",p)

p=plot_grid(p1,p2,labels=c("A","B"))

save_plot("sig_genes_metaseq.png",p,ncol=2)

upc=upc[upc<=.05]
lc=na.omit(F$Lower)
lc=lc[lc<=.05]
"ENSG00000165060" %in% names(upc)
"ENSG00000165060" %in% names(lc)



df2=data.frame(up=F$Upper,down=F$Lower,gname=names(F$Upper))

rowmins=apply(df2[,1:2],1,min,na.rm=T)

mingroup=c()
deval=c()
for(i in 1:length(F$Upper)){
  if((!is.na(F$Upper[i]) & !is.na(F$Lower[i])) & F$Upper[i]<F$Lower[i]) {
    mingroup=c(mingroup,"Upper")
    deval=c(deval,-log(F$Upper[i]))    
    }
  else if((!is.na(F$Upper[i]) & !is.na(F$Lower[i])) & F$Upper[i] >F$Lower[i]) {
    mingroup=c(mingroup,"Lower")
    deval=c(deval,log(F$Lower[i]))
    }
  else {mingroup=c(mingroup,NA)
        deval=c(deval,NA)
        }
  
}

#deval more or less ready to run through bitr?
deval2=deval[!is.na(deval)]

good_ids=which(!is.na(deval))

count_de=countData[good_ids,]
count_de2 =count_de[rowSums(count_de)>=10,]
bitnames=bitr(rownames(count_de2),fromType="ENSEMBL",toType="ENTREZID",OrgDb="org.Hs.eg.db")
bit_un=distinct(bitnames,ENSEMBL,.keep_all=T)

bit_over=which(rownames(count_de2)%in% bit_un$ENSEMBL)
count_ent=count_de2[bit_over,]
rownames(count_ent)=bit_un$ENTREZID

#countent_ord=count_ent[order(row.names(count_ent)),]
#bitord=bit_un[order(bit_un$ENSEMBL),]


which(deval2)

desig = which(abs(deval2)>=2.995732)

hm=bitr(names(deval2),fromType="ENSEMBL",toType="ENTREZID",OrgDb="org.Hs.eg.db")
hm
dev_bit=countData[as.integer(rownames(hm)),]

gsva()
bit2()
which(rowmins)
data(c2BroadSets)

library(clusterProfiler)
#use for bitr
#really low hit rate? most remaining genes are lincs?
hm=bitr(rownames(cdataens),fromType="ENSEMBL",toType="ENTREZID",OrgDb="org.Hs.eg.db")





library(GSEABase)
hgmt=getGmt('h.all.v6.2.entrez.gmt')
cgmt = getGmt('c2.all.v6.2.entrez.gmt')


#do the gsva for REAL


#hgmt , count_ent
atax_gsva=gsva(count_ent,hgmt,parallel.sz=5,kcdf="Poisson")
atax_tocat=apply(atax_gsva,2,function(x) ifelse(x>0,"upreg","downreg"))
atax_tocatt=t(atax_tocat)

outdf=cbind(atax_tocatt,tpose_counts)

write.csv(outdf,"atax_expr_fastai.csv")

data.frame(cbind())
write_csv


design <- model.matrix(~factor(flag1))
colnames(design) <- c("ALL","FriedreichvsRest","CarriervsRest")
fit <-lmFit(atax_gsva,design)
fit<-eBayes(fit)
#summary(fit)
allGeneSets <-topTable(fit,coef="FriedreichvsRest",number=Inf)
DEgenesets <-topTable(fit,coef="FriedreichvsRest",number=Inf,
                      p.value=.001,adjust.method='BH')

testgsea=gsva(pickrellCountsArgonneCQNcommon_eset,c2BroadSets,parallel.sz=5,method="ssgsea")
design <-model.matrix(~factor(pickrellCountsArgonneCQNcommon_eset$Gender))

colnames(design) <- c("ALL","MalevsALL")

fit <-lmFit(pickrellCountsArgonneCQNcommon_eset,design)
fit <- eBayes(fit)
allGeneSets <- topTable(fit,coef="MalevsALL",number=Inf)
DEgenesets <-topTable(fit,coef="MalevsALL",number=Inf,
                      p.value=.001,adjust.method='BH')

res <- decideTests(DEgenesets)


testgsea2 <- gsva(leukemia_eset,c2BroadSets,parallel.sz=5)
design <- model.matrix(~factor(leukemia_eset$subtype))
colnames(design)<-c("ALL","MLLvsALL")
fit <- lmFit(testgsea2,design)
fit <- eBayes(fit)
allGeneSets <-topTable(fit,coef="MLLvsALL",number=Inf)
DEgenesets <-topTable(fit,coef="MLLvsALL",number=Inf,
                      p.value=.001,adjust='BH')
adjPvalueCutoff=.001
res <- decideTests(fit, p.value=adjPvalueCutoff)


install.packages('msigdbr')
library(msigdbr)

m_df = msigdbr(species = "Homo sapiens",category="H")

#get the DE genes, then relative DE per sample