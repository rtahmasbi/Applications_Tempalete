########################################################
# awk
awk -v FS='\t' -v OFS='\t'


########################################################
# Removing some SNPs from a [.ped] file
awk 'BEGIN{while (getline < "snp_col.txt"){a[6+2*$0-1]; a[6+2*$0]}}; {{for(i=1;i<=NF;i++)if(!(i in a)) printf("%s ",$i)}; printf("\n");}' file.ped > out.ped



########################################################
# Removing some lines from a [.hap] file

chr=9
awk -v chr=$chr -v line_num=affy.chr$chr.rank 'BEGIN{while (getline < line_num) {a[$0]}}; (NR in a) {print $0}' /work/KellerLab/rata8212/DATA_UK10K/UK10K_COHORT.$chr.hap > UK10K_COHORT.chr$chr.affy.hap


########################################################
awk -v FS='\t' -v OFS='\t' '{grm=0; if ($4>0.025) grm=$4; print $1,$2,$3,grm;}' file.grm

awk 'BEGIN { while ( getline < " line_number .txt") aa[$0 ]}; !( NR in aa) { print $0}' a1. txt
awk -v chr =8 'NR >1{ print chr ,$2}' file
awk -v OFS =$ '\t'

zcat $fname.grm.gz | awk -v FS='\t' -v OFS='\t' -v correction=$correction '{if ($1==$2) print; else print $1,$2,$3,$4*correction};' | gzip > $fname.mod.grm.gz
