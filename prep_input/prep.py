import subprocess

# we are fetching files associated with archives with fastq-dump  (NCBI)
# need to know if they are SINGLE or PAIRED first
with open('SraRunTable_noheader.txt') as f:    
    for line in f:
        if "SINGLE" in line:
            print("sin")
            subprocess.run(["ls", "-l"])
        elif "PAIRED" in line:
            print("pai")


#/var/www/html/prep_input/sratoolkit.2.9.4-ubuntu64/bin/fastq-dump
