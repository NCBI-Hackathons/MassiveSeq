#!/bin/bash

# this assembles all the counts in a master table
# with rows = gene id
# and cols =  sample id

# to run all of them at once use
# for x in $(ls . | grep SRR | grep chr); do sudo bash c_get_counts.sh $x & done

# this will use one cpu per sample

base=$(pwd)
master=$base"/allsamples.txt"
ref=$base"/Homo_sapiens.GRCh38.95.chr.gtf"
genelist=$base"/gene_list.txt"

echo "" > $master

cat $genelist >> $master

x=$1  # first argument is the Sample Folder

i=0
#for x in $(ls . | grep SRR | grep chr); do

	echo "getting sample data for " $x
	cd $x

	../lol "./sample.txt"   # writes a file called sorted.txt
	paste $master sorted.txt > tmp2
	mv tmp2 $master

	cd ..

#done
