'''
    File name: filter_FcC_loci.py
    Author: Michael Gerschwitz-Eidt
    Date created: 3/01/2019
    Date last modified: 2/15/2021
    Python Version: 2.7
'''

### This script uses BioPython! ###


import random
import sys
import os
from Bio import AlignIO

# Initialize random number generator
random.seed()

# Define functions
def parse_ali(phylip_input):
	try:
		input_handle = open(phylip_input, "r")						# open input file
		alignment = AlignIO.read(input_handle, "phylip-relaxed")				# try to load alignment
		output_handle = open(phylip_input.replace(".fasta.phy", "_random_column.fasta"), "w")	# make output file
		column_number = random.randint(1,alignment.get_alignment_length())			# pick random column
		rand_column = alignment[:, (column_number - 1):column_number]			# fix random column's sequence data in variable
		AlignIO.write(rand_column, output_handle, "fasta")				# write random column to fasta (phylip export is bugged)
		output_handle.close()
		print phylip_input, ": succesfully parsed"
	# In case of error while loading
	except:
		print phylip_input, ": could not be parsed"
	finally:
		input_handle.close()


# Main program
try:								# Try to recognize potential input files
	for filename in os.listdir(sys.argv[1]):
		print "Files in input directory:", filename
except:								# Stop main program if files cannot be found
	print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	print "Syntax: filter_FcC_loci.py [full path to input directory]"
	print "+++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
	sys.exit()

for filename in os.listdir(sys.argv[1]):
	parse_ali(filename)						# Run the actual program on all input files
