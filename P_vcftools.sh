vcftools
--vcf
--gzvcf
--freq2
--counts2
--recode

--positions <filename> (tab-separated) chromosome and position
--exclude-positions <filename> (tab-separated) chromosome and position
--snps <filename> The file should contain a list of SNP IDs (e.g. dbSNP rsIDs), with one ID per line. No header line is expected.
--exclude <filename> The file should contain a list of SNP IDs (e.g. dbSNP rsIDs), with one ID per line. No header line is expected.

--recode-INFO-all
--get-INFO AC
--get-INFO MAF
--get-INFO R2
--extract-FORMAT-info DS
--positions
--remove
--IMPUTE
--diff
--diff-discordance-matrix
--kept-sites


### freq2
vcftools --gzvcf MGI_Interim_20160201_FINAL.vcf.gz --freq2 --chr $chr --out target.chr$chr

### sites
vcftools --gzvcf /work/KellerLab/UKBiobank/genetics/imputed/vcf/chr10impv1.vcf.gz --kept-sites --out target.chr$chr



###
vcftools --vcf /rc_scratch/rata8212/UK10K/UK10K_COHORT.$chr.vcf \
--keep /lustre/janus_scratch/rata8212/PRJ_PredRare/data_clean_UK10K/UK10K_rmPC_FID_IID2.txt \
--recode \
--recode-INFO-all \
--out /rc_scratch/rata8212/UK10K/UK10K_COHORT_White.$chr.vcf

###
vcftools --vcf UK10K_COHORT_White.$chr.vcf.recode.vcf \
--remove set.train.txt \
--recode \
--recode-INFO-all \
--out UK10K_Test.$chr


###
vcftools --vcf UK10K_Test.$chr.vcf.recode.vcf \
--positions /work/KellerLab/rata8212/Illumina_CoreExome24/Illumina.chr$chr.txt \
--recode \
--recode-INFO-all \
--out UK10K_Test_IlluminaSNPs.$chr

###
--IMPUTE
--positions chr${i}.UK10K_sites.txt \

###
vcftools --vcf UK10K_Test.$chr.vcf.recode.vcf \
--diff /rc_scratch/rata8212/PRJ_PredRare/out_minimac3/out.minimac3.chr$chr.dose2.vcf \
--diff-discordance-matrix \
--out difmat.$chr \
--positions aa.txt \










#
