

#################################################################
# merge grm with grm.id and phen file


file_grm=read.table(gzfile("merged.grm.gz"),header=F)
colnames(file_grm)=c("index1","index2","nsnp","grm")
file_grm_id=read.table("merged.grm.id",header=F)
colnames(file_grm_id)=c("FID","IID")
file_grm_id$idx=1:nrow(file_grm_id)
file_pheno=read.table("out1.info.pop1.gen10.txt",header=T)
head(file_pheno)

# merge grm with grm.id
d1=merge(file_grm,file_grm_id,by.x="index1",by.y="idx")
d2=merge(d1,file_grm_id,by.x="index2",by.y="idx")
head(d2)
dim(file_grm)
dim(d1)
dim(d2)


# merge grm with phen
temp_phen=file_pheno[,c("ID","ID_Father","ph1_P")]
d2_phen1=merge(d2,temp_phen,by.x="IID.x",by.y="ID")
head(d2_phen1)
dim(d2_phen1)

d2_phen2=merge(d2_phen1,temp_phen,by.x="IID.y",by.y="ID")
head(d2_phen2)
dim(d2_phen2)



#################################################################
# HE regression

P1P2=pheno %*%t (pheno)
model1=lm(P1P2 ~ grm_offdiag$grm)
HE_va=coef(model1)[2]
HE_va
HE_h2=HE_va/var(pheno)
HE_h2


## OR
# GRM is n*n matrix
ras_init_GCTA <- function(phen,GRM1)
{
    phen_mean_extrcat <- phen - mean(phen)
    Phi  <- phen_mean_extrcat %*% t(phen_mean_extrcat)
    phi <- Phi[upper.tri(Phi, diag = FALSE)]
    
    grm1 <- GRM1[upper.tri(GRM1, diag = FALSE)]
    fit_a2 <- lm(phi~grm1)
    est_init_a  <- 0
    if(coef(fit_a2)[2]>0)
    {
        est_init_a=sqrt(coef(fit_a2)[2])
    }
    
    
    #for e
    y <- diag(Phi) - est_init_a^2 * diag(GRM1)
    est_init_e  <- 0
    if(mean(y)>0)
    {
        est_init_e <- sqrt(mean(y))
    }
    return(c(est_init_a,est_init_e))
}




#################################################################
# simulate genotypes

nind <- 500
nsnp <- 200
p    <- runif(nsnp,min=.05,max=.95)
geno <- matrix(nrow=nind,ncol=nsnp)
for (i in 1:length(p))
{
    geno[,i] <- rbinom(nind,2,p[i])
}



#################################################################
# simulate phenotypes
# standardized genotypes
# compute GRM

alpha <- matrix(rnorm(ncol(geno)),ncol=1)

p_hat <- apply(geno,2,mean)/2
twopq_hat <- 2*p_hat*(1-p_hat)
Z <- (geno-2*matrix(rep(p_hat,nind),nrow=nind,byrow=T))/sqrt(matrix(rep(twopq_hat,nind),nrow=nind,byrow=T))

A <- Z %*% alpha
E <- matrix(rnorm(nind,mean=0,sd=sqrt((1/h2-1)*var(A))),ncol=1)

P <- A + E


ZZp <- Z %*% t(Z)/nsnp

PPp <- P %*% t(P)


#################################################################
# OR
# simulate phenotypes
# standardized genotypes
# compute GRM

s2_g <- .6
s2_e <- .4

alpha <- matrix(rnorm(nsnp,sd=sqrt(s2_g/nsnp)),ncol=1)

p_hat <- apply(geno,2,mean)/2
twopq_hat <- 2*p_hat*(1-p_hat)
Z <- (geno-2*matrix(rep(p_hat,nind),nrow=nind,byrow=T))/sqrt(matrix(rep(twopq_hat,nind),nrow=nind,byrow=T))

A <- Z %*% alpha
E <- matrix(rnorm(nind,mean=0,sd=sqrt(s2_e)),ncol=1)

P <- A + E
var(A)
var(E)



#################################################################
#
ZZp[upper.tri(ZZp,diag=T)]
#################################################################



#################################################################
plot(x, y, col=rgb(red, 0.5, 0.25, 0.8), cex=2, pch=16, xlab="x-axis label", ylab="y-axis label", main="main title")
#################################################################




#################################################################
# CI
ras_CI <- function(x)
{
    n <- sum(!is.na(x))
    #qt(1-.05/2,df=nn-1)
    x_mean <- mean(x,na.rm=T)
    x_sd <- sd(x,na.rm=T)
    ci_l <- x_mean - 1.96 * x_sd / sqrt(n)
    ci_u <- x_mean + 1.96 * x_sd / sqrt(n)
    return(c(ci_l,ci_u))
}




#################################################################
# Genomic Inflation Factor and λgc for GWAS

## Convert your output to chi-squared values
# For z-scores, just square them
chisq <- data$z^2

# For chi-squared values, keep as is
chisq <- data$chisq

# For p-values, calculate chi-squared statistic
chisq <- qchisq(1-data$pval,1)


## Calculate lambda gc (λgc)
median(chisq)/qchisq(0.5,1)


# If analysis results your data follows the normal chi-squared distribution, the expected λgc value is 1. If the λgc value is greater than 1, then this may be evidence for some systematic bias that needs to be corrected in your analysis.





res <- optim(param0, loglike, lower=c(0,0), method="L-BFGS-B", control=list(REPORT=1,trace=6), hessian = T)




###########################################
d <- matrix(runif(30),nrow=10)
d[,1] <- c(rep(1,5),rep(2,5))
d[,3] <- (0:9)%%3+1
by(d[,2],d[,3],mean)
by(d[,2],list(d[,1],d[,3]),mean)

sapply(1:3, function(i) {mean(d[which(d[,3]==i),2])})
# lapply is very similar

tapply(d[,2],list(d[,1],d[,3]),mean)

aggregate



###########################################
# time: convert second to hours:minutes:seconds

format(as.POSIXct('0001-01-01 00:00:00') + x_second, "%I:%M:%S")
# or
paste0(x_second %/%3600,":",(x_second%%3600)%/%60,":",round(x_second%%60,0))







# CI
ras_CI <- function(x)
{
    n <- sum(!is.na(x))
    #qt(1-.05/2,df=nn-1)
    x_mean <- mean(x,na.rm=T)
    x_sd <- sd(x,na.rm=T)
    ci_l <- x_mean - 1.96 * x_sd / sqrt(n)
    ci_u <- x_mean + 1.96 * x_sd / sqrt(n)
    return(c(ci_l,ci_u))
}


library(ggplot2)

ras_CI_plot <- function(data,title="",label=NA)
{
    nc=ncol(data)
    df=data.frame(method=rep(NA,nc), mean=rep(NA,nc),L=rep(NA,nc),U=rep(NA,nc))
    for (i in 1:nc)
    {
        df[i,]=c(i,mean(data[,i],na.rm=T),ras_CI(data[,i]))
    }
    if (is.na(label))
    {
        df$method=colnames(data)
    }
    ggplot(df, aes(x = method, y = mean)) +
    geom_point(size = 2) +
    geom_errorbar(aes(ymax = U, ymin = L),width=0.1, size=.5, color="blue") +
    labs(title = title)+
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
}




#################################################################
#################################################################
# CGTA estimation model

I <- diag(rep(1,nind))
print("-------------- GCTA model")
# input: ZZp, phen
loglike <- function(param)
{
    s_a <- param[1]
    s_e <- param[2]
    
    Sigma <- s_a^2 * ZZp + s_e^2 * I
    
    log_det <- determinant(Sigma)$modulus[1]
    if(is.na(log_det))
    {
        print("--NA")
        assign("not_conerged", T, envir = .GlobalEnv)
        0
    } else {
        if (log_det == -Inf)
        {
            print("--singular")
            diag(Sigma) <- diag(Sigma)+.01
            log_det <- determinant(Sigma)$modulus[1]
        }
        -(-.5 * log_det - .5 * t(phen) %*% solve(Sigma) %*% (phen))
    }
}


param0 <- c(0.5077567961,0.845571)
loglike(param0)

start <- proc.time()
res <- optim(param0, loglike, method="L-BFGS-B", control=list(REPORT=1,trace=6), hessian = T)
print(res)
out_res <- matrix(c(N,res$par,res$value, (proc.time()-start)[3]),nrow=1)
colnames(out_res) <- c("N","a_hat","e_hat","loglike","time")
print(proc.time()-start)
print(out_res)
write.table(out_res, file=paste0("res.txt"), col.name=T,row.names=F,append=F, quote=F)
write.table(res$hessian, file=paste0("res.hessian.txt"), col.name=T,row.names=F,append=F, quote=F)


print("---------------------------------------------------------------------- END")

p_time_end <- proc.time()
print(p_time_end-p_time_start)





#################################################################
#################################################################
# GRM = n*n
# ID = n*1
ras_make_gcta_grm_from_matrix <- function(fname,GRM,ID,m)
{
    nind <- nrow(GRM)
    if (length(ID) != nind)
    {
        stop("length(ID) != nind")
    }
    GRM_file     <- matrix(nrow=nind*(nind+1)/2,ncol=4)
    GRM_file[,1] <- rep(1:nind, 1:nind)
    GRM_file[,2] <- sequence(1:nind)
    GRM_file[,3] <- m
    GRM_file[,4] <- GRM[lower.tri(GRM, diag = FALSE)]
    write.table(GRM_file, file=paste0(fname,".grm"), quote=F, row.names=F, col.names=F)
    write.table(cbind(ID,ID), file=paste0(fname,".id"), quote=F, row.names=F, col.names=F)
}






#################################################################
#################################################################
# shared haplotype int.gz
# check /Users/RasoolTahmasbi/GoogleDrive/PROJECTS/PRJ011_Simulation/GeneEvolve/Check_20171002_h2

share=NULL
for (chr in 1:22)
{
    file.share <- read.table(gzfile(paste0("out1.pop1.gen10.chr",chr,".int.gz")),header=T)
    share=rbind(share,file.share)
}
head(share)
tail(share)


chr_len=rep(0,22)
for (chr in 1:22)
{
    file.bim <- read.table(paste0("out1.pop1.gen20.chr",chr,".bim"),header=F)
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




#################################################################
#################################################################
# read GCTA hsq file


ras_scan_hsq <- function(fname)
{
    hsq <- scan(fname, what="")
    ret <- NULL
    
    ret$VG <- as.numeric(hsq[which(hsq=="V(G)")+1])
    ret$VE <- as.numeric(hsq[which(hsq=="V(e)")+1])
    ret$VP <- as.numeric(hsq[which(hsq=="Vp")+1])
    ret$h2 <- as.numeric(hsq[which(hsq=="V(G)/Vp")+1])
    ret$h2_l <- as.numeric(hsq[which(hsq=="V(G)/Vp_L")+1])
    temp <- hsq[which(hsq=="prevalence")+2]
    ret$K <- as.numeric(substr(temp,1,nchar(temp)-1) )
    temp <- hsq[which(hsq=="(Proportion")+7]
    ret$P <- as.numeric(substr(temp,1,nchar(temp)-1) )
    
    return(as.data.frame(ret))
}

