rm(list=ls())
library(tidyverse)
library(LDheatmap)
library(data.table)
library(genetics)

chr07_snps <- fread("snps_fw2.tsv", header=TRUE, sep="\t")
chr07_snps <- as.data.frame(chr07_snps) #it has to be a dataframe
str(chr07_snps)
#reads large input file
hmp <- fread("fw2_hmp.tsv", header=TRUE, sep="\t")

hmp <- as.data.frame(hmp)

physical_pos <- as.matrix(hmp$pos) #has to be a vector

#colnames(chr07_snps) <- as.character(hmp$pos)

class(chr07_snps[,1])

num<-ncol(chr07_snps)

for(i in 1:num){
 chr07_snps[,i]<-as.genotype(chr07_snps[,i], reorder="yes",sep="") #as.genotype functions from genetics package. see the discussion here: https://www.biostars.org/p/105577/
}

str(chr07_snps) 


pdf("LDheatmap.pdf")
 MyHeatmap <- LDheatmap(chr07_snps,genetic.distances =physical_pos, LDmeasure="r",title="Pairwise LD in r^2", add.map=TRUE,SNP.name=c(
 "snp1", "snp2"),color=heat.colors(20) , name="myLDgrob",add.key=TRUE)
dev.off()
