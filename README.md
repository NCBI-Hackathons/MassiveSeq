# MassiveSeq_Ataxia

This is a repostory for "massive" RNA-seq to analyze roughly 100 Friedreich's ataxia RNA-seq datasets. 

# pipeline overview

Here is an overview of the proposed pipeline ![pipeline](https://github.com/NCBI-Hackathons/MassiveSeq/raw/master/MassiveSeq%20Flow%20Diagram%20v3.pdf). The key "guts" of our pipeline is a snakemake program to make the key sequence of mapping-quantification easily parralization within and across compute machines availaible to researchers.

# Methods

We began by conducting a literature search of all publically deposited Friedreich's Ataxia RNA-seq datasets on SRA. This led to 152 initial samples. We then decided to limit our scope to only human datatests and excluded one small-RNA datasets, as the methods for analyzing smallRNA tend to be fairly different from a "typical" RNA-seq study.

# Results

We have identified some promising truncated transcripts in the current main Friedreich's Ataxia gene, FXN.
