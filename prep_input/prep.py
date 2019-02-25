import os
import sys


# we are fetching files associated with archives with fastq-dump  (NCBI)
# need to know if they are SINGLE or PAIRED first
i=1
with open('SraRunTable_noheader.txt') as f:    
    for line in f:
        srr = line.find('SRR')
        srrid = line[srr:srr+10]
        print i, srrid
        if "SINGLE" in line:
            os.system('./fastq-dump '+srrid)
        elif "PAIRED" in line:
            os.system('./fastq-dump -I --split-files '+srrid)
        i += 1

#/var/www/html/prep_input/sratoolkit.2.9.4-ubuntu64/bin/fastq-dump
