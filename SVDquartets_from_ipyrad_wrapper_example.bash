#!/bin/bash

# Setup variables
parent_dir="/home/migersch/data/Aichryson/SVD"


# Split ipyrad.loci file into single locus .fasta files and remove all loci without any SNPs
/home/migersch/bin/scripts/pyrad2fasta_edit_MGE.pl -i $parent_dir/merged_BSC_91.loci -w $parent_dir/
 
# Extract parsimonious informative sites
cd $parent_dir/loci
perl /home/migersch/bin/FASconCAT-G-master/FASconCAT-G_v1.04.pl -p -p -o -j -a -s

# Sort and compress files
dir_date=$(date +%Y%m%d_%H%M%S)
mkdir $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date -p && mv $parent_dir/loci/*.fasta $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date
tar -czf pyrad2fasta_edit_MGE_run_$dir_date.tar.gz -C $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date .	# archive with full sequences
mv pyrad2fasta_edit_MGE_run_$dir_date.tar.gz $parent_dir/pyrad2fasta_edit_MGE/
rm -r $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date

mkdir $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date -p && mv $parent_dir/loci/FcC_parsim_inf_sites_*.fasta.phy $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date

mkdir $parent_dir/FASconCAT-G/full_alignments/run_$dir_date -p && mv $parent_dir/loci/FcC_*.fasta.phy $parent_dir/FASconCAT-G/full_alignments/run_$dir_date
mv $parent_dir/loci/FcC_info.xls $parent_dir/FASconCAT-G/ && rm -r $parent_dir/loci/
cd $parent_dir
tar -czf FcC_full_alignments_run_$dir_date.tar.gz -C $parent_dir/FASconCAT-G/full_alignments/run_$dir_date .
mv FcC_full_alignments_run_$dir_date.tar.gz $parent_dir/FASconCAT-G/full_alignments/
rm -r $parent_dir/FASconCAT-G/full_alignments/run_$dir_date

# remove empty alignments and concatenate all loci including all parsimony informative characters
cd $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date
for i in FcC_parsim_inf_sites_*; do length=$(head -1 $i | cut -d " " -f 2); if [ -z "$length" ]; then rm $i; fi; done
perl /home/migersch/bin/FASconCAT-G-master/FASconCAT-G_v1.04.pl -a -n -s
cp $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date/FcC_supermatrix.nex $parent_dir/SVD-A.nex

# Choose one random parsimony informative character per locus
module load bio/Biopython/1.75-foss-2019a
cd $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date
mkdir $parent_dir/filter_FcC_loci/run_$dir_date -p
python /home/migersch/bin/scripts/filter_FcC_loci.py $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date/ &> $parent_dir/filter_FcC_loci/run_$dir_date/filter_FcC_loci_$dir_date.log
mv $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date/*_random_column.fasta $parent_dir/filter_FcC_loci/run_$dir_date
tar -czf FcC_parsim_inf_sites_run_$dir_date.tar.gz -C $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date .
mv FcC_parsim_inf_sites_run_$dir_date.tar.gz $parent_dir/FASconCAT-G/parsim_inf_sites/
rm -r $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date

# Concatenate loci to create SVDquartets input file
cd $parent_dir/filter_FcC_loci/run_$dir_date
perl /home/migersch/bin/FASconCAT-G-master/FASconCAT-G_v1.04.pl -n -a -s
cp $parent_dir/filter_FcC_loci/run_$dir_date/FcC_supermatrix.nex $parent_dir/SVD-C.nex
tar -czf filter_FcC_loci_$dir_date.tar.gz -C $parent_dir/filter_FcC_loci/run_$dir_date .
mv filter_FcC_loci_$dir_date.tar.gz $parent_dir/filter_FcC_loci/
rm -r $parent_dir/filter_FcC_loci/run_$dir_date


# Split ipyrad.alleles file into single locus .fasta files and remove all loci without any SNPs
mkdir -p /home/migersch/data/Aichryson/alleles
cp $parent_dir/merged_BSC_91.alleles /home/migersch/data/Aichryson/alleles/
parent_dir="/home/migersch/data/Aichryson/alleles"
cd $parent_dir

# Split ipyrad.loci file into single locus .fasta files and remove all loci without any SNPs
/home/migersch/bin/scripts/pyrad2fasta_edit_MGE.pl -i $parent_dir/merged_BSC_91.alleles -w $parent_dir/

# Extract parsimonious informative sites
cd $parent_dir/loci
perl /home/migersch/bin/FASconCAT-G-master/FASconCAT-G_v1.04.pl -p -p -o -j -a -s

# Sort and compress files
mkdir $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date -p && mv $parent_dir/loci/*.fasta $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date
tar -czf pyrad2fasta_edit_MGE_run_$dir_date.tar.gz -C $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date .	# archive with full sequences
mv pyrad2fasta_edit_MGE_run_$dir_date.tar.gz $parent_dir/pyrad2fasta_edit_MGE/
rm -r $parent_dir/pyrad2fasta_edit_MGE/run_$dir_date

mkdir $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date -p && mv $parent_dir/loci/FcC_parsim_inf_sites_*.fasta.phy $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date

mkdir $parent_dir/FASconCAT-G/full_alignments/run_$dir_date -p && mv $parent_dir/loci/FcC_*.fasta.phy $parent_dir/FASconCAT-G/full_alignments/run_$dir_date
mv $parent_dir/loci/FcC_info.xls $parent_dir/FASconCAT-G/ && rm -r $parent_dir/loci/
cd $parent_dir
tar -czf FcC_full_alignments_run_$dir_date.tar.gz -C $parent_dir/FASconCAT-G/full_alignments/run_$dir_date .
mv FcC_full_alignments_run_$dir_date.tar.gz $parent_dir/FASconCAT-G/full_alignments/
rm -r $parent_dir/FASconCAT-G/full_alignments/run_$dir_date

# remove empty alignments and concatenate loci to create SVDquartets input file including all parsimony informative characters of the entire allelic variation
cd $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date
for i in FcC_parsim_inf_sites_*; do length=$(head -1 $i | cut -d " " -f 2); if [ -z "$length" ]; then rm $i; fi; done
perl /home/migersch/bin/FASconCAT-G-master/FASconCAT-G_v1.04.pl -a -n -s
cp $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date/FcC_supermatrix.nex $parent_dir/SVD-B.nex

# Sort files and clean up
cp $parent_dir/SVD-B.nex /home/migersch/data/Aichryson/SVD
mv $parent_dir /home/migersch/data/Aichryson/SVD/
parent_dir="/home/migersch/data/Aichryson/SVD/alleles"
cd $parent_dir
tar -czf FcC_parsim_inf_sites_run_$dir_date.tar.gz -C $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date .
mv FcC_parsim_inf_sites_run_$dir_date.tar.gz $parent_dir/FASconCAT-G/parsim_inf_sites/
rm -r $parent_dir/FASconCAT-G/parsim_inf_sites/run_$dir_date