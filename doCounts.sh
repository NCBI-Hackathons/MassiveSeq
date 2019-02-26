#!/bin/bash

# this loops over sample data and runs the count analysis
# using featureCounts

base=$(pwd)
master=$base"/allsamples.txt"
ref=$base"/Homo_sapiens.GRCh38.95.chr.gtf"
genelist=$base"/gene_list.txt"

echo "" > $master

cat $genelist >> $master

i=0
for x in $(ls . | grep SRR | grep chr); do

	echo $x
	cd $x
	rm counts.txt

	sudo /vol_c/featureCounts/subread-1.6.3-source/bin/featureCounts -T 16 -O -t transcript -g gene_id -F 'gtf' -a $ref -o counts.txt *bam 


	# remove first 2 header lines
	tail -n +2 "counts.txt" > tmp 
	mv tmp counts.txt 
	tail -n +2 "counts.txt" > tmp
	mv tmp counts.txt 

	cat counts.txt | awk {'print $1,$7'} > sample.txt


	cd ..
done
