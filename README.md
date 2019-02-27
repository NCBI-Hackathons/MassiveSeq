# MassiveSeq_Ataxia

This is a repostory for "massive" RNA-seq to analyze roughly 100 Friedreich's ataxia RNA-seq datasets. 

# pipeline overview

Here is an overview of the proposed pipeline ![pipeline](https://github.com/NCBI-Hackathons/MassiveSeq/raw/master/MassiveSeq%20Flow%20Diagram%20v3.pdf). The key "guts" of our pipeline is a snakemake program to make the key sequence of mapping-quantification easily parralization within and across compute machines availaible to researchers.

# Methods

We began by conducting a literature search of all publically deposited Friedreich's Ataxia RNA-seq datasets on SRA. This led to 152 initial samples. We then decided to limit our scope to only human datatests and excluded one small-RNA datasets, as the methods for analyzing smallRNA tend to be fairly different from a "typical" RNA-seq study.

As mentioned in the introduction, we planned the main pipeline in snakemake to automate dispatching of jobs depending on the available cores and memory of a machine (cite). Here, the core steps involved Hisat2 for alignment, followed by Stringtie for transcript annotation and de novo annotation. Finally, reads were quantified using featureCounts from the subRead package (cite). This quantification pipeline follows a common, recently published protocol on Stringtie and Hisat2 (Pertea et al 2016 Nature Protocols).

Once the gene counts were fully quantified for each sample, we analyzed the overall dataset comprised of all 4 studies using the R package metaSeq.  


# Running the pipeline

If you are new to Snakemake, you are in for a slight learning curve (it's not tooo bad). It's generally easiest to go with a conda install

```bash
conda create -n snakemake python=3
source activate snakemake
conda install -c bioconda snakemake

#example submission from our ginormous compute  machines on jetstream with 180GB ram and 44 cores
# if you have slurm/etc, you can distribute with a little extra legwork
snakemake -j 42 -s Snakefile_massiveseq --keep-going --latency-wait 900
```

# Results

We have identified some promising truncated transcripts in the current main Friedreich's Ataxia gene, FXN. extra vis from the metaseq to come?
