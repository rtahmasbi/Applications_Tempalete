path_grm="/work/KellerLab/rata8212/DATA_UKBIOBANK/"
path_phen="/work/KellerLab/rata8212/PRJ018_IQ_by_SES_BMI/20170707_RealData_BMI_TDI_GCTA"

gcta64 --grm-gz $path_grm/chrAll.maf0.05 --reml --reml-no-constrain --pheno $path_phen/residuals.txt --out res.GCTA --thread-num 20 --reml-est-fix

gcta64 --HEreg  --mgrm-gz $fname.txt  --pheno $out.info.pop1.genAll.phen --out $fname.HE --thread-num 20 --reml-priors 0.5 0 0 0 0 0.5 | tee $fname.HE.log


gcta64 --bfile sim.iter$iter --make-grm-d-gz --out sim.iter$iter --thread-num 10


gcta64 --grm test --grm-cutoff 0.05 --make-grm --out test



options:
--thread-num 40

--make-grm-gz
--make-grm-d-gz
--make-grm-bin

--grm-gz
--grm-bin
--mgrm-gz [file]

--reml-priors  # initial values
--reml
--reml-no-constrain
--reml-no-lrt

--HEreg

--grm-cutoff 0.05
--qcovar
--covar


--extract snps   file with one column of just SNP names
--exclude snps
--keep inds
--remove inds

#for vcf filter
--biallelic-only strict
--snps-only just-acgt







############################################################################################
############################################################################################

cat > run_gcta.sh
#!/bin/bash
#SBATCH --mem=300gb
#SBATCH --ntasks-per-node=40
#SBATCH --nodes=1
#SBATCH --qos normal
#SBATCH --partition=smem
#SBATCH --time=30:0:00

ml load intel
ml load mkl
ml load R



date

phen=/work/KellerLab/rata8212/DATA_UKBIOBANK/Data_BMI/BMI.txt
grm=/work/KellerLab/rata8212/DATA_UKBIOBANK/Data_BMI/chrAll.maf0.05
covar=/work/KellerLab/rata8212/DATA_UKBIOBANK/Data_BMI/covars.txt
gcta64 --grm-bin $grm --pheno $phen --out chrAll.maf0.05 --qcovar $covar --reml --reml-no-constrain --thread-num 40 --reml-est-fix  --out res.all

date



##############################
sbatch --mem=800gb --time=20:0:00 run_gcta.sh
##############################
