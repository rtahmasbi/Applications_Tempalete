
#############################################################################################
#############################################################################################
# SharedHaplotype

gen=10

for chr in $(seq 1 22); do
fname=out1.pop1.gen$gen.chr$chr
GE_True_IBD --in $fname.int --out $fname.share --min_bp 10000
done


#############################################################################################
#############################################################################################
# plot GRM_SNP vs GRM_SH

R

share=NULL
for (chr in 1:22)
{
file.share <- read.table(gzfile(paste0("out1.pop1.gen10.chr",chr,".share.gz")),header=T)
share=rbind(share,file.share)
}
head(share)
tail(share)


chr_len=rep(0,22)
for (chr in 1:22)
{
file.bim <- read.table(paste0("out1.pop1.gen10.chr",chr,".bim"),header=F)
chr_len[chr]=max(file.bim$V4)-min(file.bim$V4)+1
}
head(chr_len)
tail(chr_len)



share2=share[,c("ind1","ind2","bp_distance")]

share2_sum <- aggregate(as.numeric(share2$bp_distance), by=list(share2$ind1,share2$ind2), FUN=sum, na.rm=TRUE)
colnames(share2_sum)=c("ind1","ind2","sum_sh")
head(share2_sum)

share2_sum$sh=share2_sum$sum_sh/sum(chr_len)/2



file.grm <- read.table(gzfile("out1.pop1.gen10.all.update.grm.gz"),header=F)
colnames(file.grm) <- c("i","j","n","grm")
head(file.grm)

file.grm.id <- read.table("out1.pop1.gen10.all.update.grm.id",header=F)
file.grm.id$idx <- 1:nrow(file.grm.id)
colnames(file.grm.id) <- c("FID","IID","idx")
head(file.grm.id)

grm_snp <- merge(file.grm,file.grm.id,by.x="i",by.y="idx")
grm_snp <- merge(grm_snp,file.grm.id,by.x="j",by.y="idx")
head(grm_snp)

dim(grm_snp)
dim(share2_sum)


GRM_SH_SNP=merge(share2_sum,grm_snp,by.x=c("ind1","ind2"),by.y=c("FID.x","FID.y"))
head(GRM_SH_SNP)
dim(GRM_SH_SNP)


NN=50000
idx=sample(nrow(GRM_SH_SNP),NN)
plot(GRM_SH_SNP$grm[idx],GRM_SH_SNP$sh[idx],pch=16,cex=.5,main=paste0("GRM_SNP vs GRM_SH for N=",NN," randomly selected pair of inds"),xlab="GRM_SNP",ylab="GRM_SH")
