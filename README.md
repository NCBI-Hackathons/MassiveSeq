# MassiveSeq_Ataxia

This is a repostory for "massive" RNA-seq to analyze roughly 100 Friedreich's ataxia RNA-seq datasets. 

# pipeline overview

Here is an overview of the proposed pipeline ![pipeline](https://github.com/NCBI-Hackathons/MassiveSeq/raw/master/MassiveSeq%20Flow%20Diagram%20v3.pdf). The key "guts" of our pipeline is a snakemake program to make the key sequence of mapping-quantification easily parralization within and across compute machines availaible to researchers.

# Methods

We began by conducting a literature search of all publically deposited Friedreich's Ataxia RNA-seq datasets on SRA. This led to 152 initial samples. We then decided to limit our scope to only human datatests and excluded one small-RNA datasets, as the methods for analyzing smallRNA tend to be fairly different from a "typical" RNA-seq study.

As mentioned in the introduction, we planned the main pipeline in snakemake to automate dispatching of jobs depending on the available cores and memory of a machine (cite). Here, the core steps involved Hisat2 for alignment, followed by Stringtie for transcript annotation and de novo annotation. Finally, reads were quantified using featureCounts from the subRead package (cite). This quantification pipeline follows a common, recently published protocol on Stringtie and Hisat2 (Pertea et al 2016 Nature Protocols).

Once the gene counts were fully quantified for each sample, we analyzed the overall dataset comprised of all 4 studies using the R package metaSeq.  


# Results

We have identified some promising truncated transcripts in the current main Friedreich's Ataxia gene, FXN. extra vis from the metaseq to come?
