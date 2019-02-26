# MassiveSeq_Ataxia

This is a repostory for "massive" RNA-seq to analyze roughly 100 Friedreich's ataxia RNA-seq datasets. 

# pipeline overview

Here is an overview of the proposed pipeline ![pipeline](https://github.com/NCBI-Hackathons/MassiveSeq/raw/master/MassiveSeq%20Flow%20Diagram%20v3.pdf). The key "guts" of our pipeline is [bcbio](https://bcbio-nextgen.readthedocs.io/en/latest/).

There is also a meta-analysis part, as we are incorportating data from dozens of studies, from multiple tissues. Can we use machine learning (horrible buzzword sighted) to cluster case vs controls across studies, and whether genes in common fall out of that. Can use outlier detection to exclude samples (race will be important confounder).
