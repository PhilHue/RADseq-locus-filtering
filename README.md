# RADseq-locus-filtering

We are pleased to provide small yet helpful tools for locus parsing and filtering to the scientific community and hope they meet your needs.
If you use the scripts for your project, please cite: XYZ



Parsing locus properties and subsequent filtering:

The Perl script 'parse_loci_V3' parses the locus properties and creates a .txt file including the specific locus ID, the locus length, the number of samples, SNPs, PIS and VAR and proportion of missing data of each locus. The input is the ipyrad .loci file. Make sure that the Perl script and the .loci file are in the current working directory. The syntax is: perl parse_loci_V3 [name of .loci file]. You can use the .loci file of the Aichryson assembly 'Aichryson_unfiltered_raw_assembly.loci' for testing. The content of the output .txt file can be copied into an Excel file. The loci can now be sorted respecting varying requirements. 

To create individual, property-specific phylip files, use the "loci_select' bash script. The syntax is: loci_select.sh [name of .loci-file] [locus information-file] [suffix]. This script uses two input files. The first input is the ipyrad .loci file. The second input is the 'locus information-file'. This locus information-file is created by you! It is a simple .txt file containing the first three columns of the parsed locus properties you want to filter [locus ID, locus length, number of samples]. Make sure to not to copy the header of the columns. The file 'loci_information_file_int_301-350.txt' contains the three columns required by the loci_select.sh script of all (cleansed) loci within the length range of 301-450nt. Using a "suffix", this input-term will be added to each individual output locus (e.g. Locus_809.int_301-450.phy). 

The individual phylip files can now be concatenated to a supermatrix using FASconCAT-G (by Kück and Longo, 2014, doi: https://doi.org/10.1186/s12983-014-0081-x) as input for CA-ML inference using RAxML (RAxML-NG by Kozlov et al., 2019, doi: https://doi.org/10.1093/bioinformatics/btz305) or can be used to calculate Maximum Likelihood locus trees as input for CB-SM inference (using ASTRAL III by Zhang et al., 2018, doi: https://doi.org/10.1186/s12859-018-2129-y). 

In case of troubles, please contact: 'huehn@uni-mainz.de' or 'm.dillenberger@fu-berlin.de' or 'riegerb@uni-mainz.de'.


Generating input files for site-based inference using SVDquartets:

The python script 'filter_FcC_loci.py' and the perl script 'pyrad2fasta_edit_MGE.pl' can be used to create input data for SVDquartets from an ipyrad .loci file. They are not meant to be capable to achive that task alone. Instead they were written as small and flexible tools and are adaptable with minor effort to fulfill other tasks as well. 

An example where they were used together with additional software to create three different kind of data sets for SVDQuartets is provided in the bash script 'SVDquartets_from_ipyrad_wrapper_example.bash'. Here we created the data sets 'SVD-A' from haploid assembled ipyrad sequence data and multiple SNP positions per locus, 'SVD-C' from haploid data but with a single, randomly chosen SNP position per locus, and 'SVD-B' from diploid assembled ipyrad sequence data and multiple SNP positions per locus. For a more detailed explanation of these examples, see Huehn et al. 2021...(Hier Ref einfügen).

In case of troubles, please contact: 'mgerschwitzeidt@gmail.com'.


