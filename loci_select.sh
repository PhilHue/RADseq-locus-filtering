#!/bin/bash

#####################################################################################
###     Markus S. Dillenberger                        27.11.2020                  ###
#####################################################################################
###     SYNTAX                                                                    ###
### loci_select.sh [name of loci-file] [locus information-file] [suffix]          ###
#####################################################################################

locifile=$1
#name of .loci output-file from iPyrad.

list=$2
#loci_for_analysis.txt Tab-delimited list: 1. locus number <tab> 2. length of locus 
#<tab> 3. number of samples in Locus

suffix=$3
#suffix for files

#####################################################################################
#This copies the sequences in individual phylip-files.

IFS=$'\n' read -d '' -r -a lines < $list
#array

for i in "${lines[@]}"; do
	locus=$(echo "$i" | cut -f1)
#gives the locus number.
	seqNum=$(echo "$i" | cut -f3)
#gives the number os samples in the locus.
	length=$(echo "$i" | cut -f2)
#gives the length of the locus.
	lineNum=$(grep -n "|$locus|" "$locifile" | cut -f1 -d:)
#gives the line number where the name of the locus can be found.
	count=$(echo "$lineNum - $seqNum"|bc)
#gives the first line of the locus.
	count2=$(echo "$lineNum - 1"|bc)
#gives the last line of the locus.
	echo ""$seqNum" "$length"" > Locus_"$locus"."$suffix".phy
#writes sample number and locus length in file.
	sed -n "$count","$count2"p $locifile >> Locus_"$locus"."$suffix".phy
#writes the sequences in the file.
done
#####################################################################################






