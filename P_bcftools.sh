bcftools query -l input.vcf # extract individual IDs




######
--hapsample
convert from VCF to hap/sample format used by IMPUTE2 and SHAPEIT.


#########
bcftools query -f'%CHROM\t%POS\t%REF,%ALT\t%INFO/TAG\n' file.vcf
