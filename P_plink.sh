
http://zzz.bwh.harvard.edu/plink/reference.shtml#options

--linear
--keep
--pheno
--merge-list
--make-bed
--out
--bfile
--allow-no-sex
--threads [max] (aliases: --thread-num, --num_threads)
--threads 24

--recode 01  # '01' maps A1->0 and A2->1.
--recode A   # for Additive

--extract snps
--exclude snps
--keep inds
--remove inds
--output-missing-genotype 9

--freq

--biallelic-only
--snps-only just-acgt



####
we can use both   --exclude  and  --maf at the same time.





##################### merge
# merge list
rm $out.pop1.gen18.chrlist.txt
for chr in $(seq 1 22); do
echo -e $out.pop1.gen18.chr$chr >> $out.pop1.gen18.chrlist.txt
done

#
plink2 --bfile $out.pop1.gen18.chr1 --merge-list $out.pop1.gen18.chrlist.txt --make-bed --out $out.pop1.gen18.chrAll  --threads 24


##################### Association (GWAS)
plink2 --bfile $bfile --pheno $file_phen --linear --out $file_out --allow-no-sex

##################### Make GRM
plink2 --bfile eur.qc --make-grm-bin --keep eur.unrel05.a.id --out eur.unrel05.a --threads 24


##################### freq
plink2 --vcf /work/KellerLab/UKBiobank/genetics/imputed/vcf/$fname.vcf.gz --freq --out $fname --threads 24














#
