# Burrows-Wheeler Aligner
# BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome. It consists of three algorithms: BWA-backtrack, BWA-SW and BWA-MEM. The first algorithm is designed for Illumina sequence reads up to 100bp, while the rest two for longer sequences ranged from 70bp to 1Mbp. BWA-MEM and BWA-SW share similar features such as long-read support and split alignment, but BWA-MEM, which is the latest, is generally recommended for high-quality queries as it is faster and more accurate. BWA-MEM also has better performance than BWA-back

http://bio-bwa.sourceforge.net/bwa.shtml

bwa index ref.fa
bwa mem ref.fa reads.fq > aln-se.sam
bwa mem ref.fa read1.fq read2.fq > aln-pe.sam
bwa aln ref.fa short_read.fq > aln_sa.sai
bwa samse ref.fa aln_sa.sai short_read.fq > aln-se.sam
bwa sampe ref.fa aln_sa1.sai aln_sa2.sai read1.fq read2.fq > aln-pe.sam
bwa bwasw ref.fa long_read.fq > aln.sam






# From a sorted BAM alignment, raw SNP and indel calls are acquired by:
samtools pileup -vcf ref.fa aln.bam > raw.pileup


# The resultant output should be further filtered by:
samtools.pl varFilter raw.pileup | awk '$6>=20' > fina

# convert pileup to vcf
sam2vcf.pl [OPTIONS] < in.pileup > out.vcf
Options:
   -r, -refseq <file.fa>            The reference sequence, required when indels are present.







#
