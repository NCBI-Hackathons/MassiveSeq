# MassiveSeq_Ataxia

This is a repostory for "massive" RNA-seq to analyze roughly 100 Friedreich's ataxia RNA-seq datasets. 

# pipeline overview

Here is an overview of the proposed pipeline ![pipeline](https://github.com/NCBI-Hackathons/MassiveSeq/raw/master/MassiveSeq%20Flow%20Diagram%20v3.pdf). The key "guts" of our pipeline is a snakemake program to make the key sequence of mapping-quantification easily parralization within and across compute machines availaible to researchers.

# Methods

We began by conducting a literature search of all publically deposited Friedreich's Ataxia RNA-seq datasets on SRA. This led to 152 initial samples. We then decided to limit our scope to only human datatests and excluded one small-RNA datasets, as the methods for analyzing smallRNA tend to be fairly different from a "typical" RNA-seq study.

As mentioned in the introduction, we planned the main pipeline in snakemake to automate dispatching of jobs depending on the available cores and memory of a machine (cite). Here, the core steps involved Hisat2 for alignment, followed by Stringtie for transcript annotation and de novo annotation. Finally, reads were quantified using featureCounts from the subRead package (cite). This quantification pipeline follows a common, recently published protocol on Stringtie and Hisat2 (Pertea et al 2016 Nature Protocols).

Once the gene counts were fully quantified for each sample, we analyzed the overall dataset comprised of all 4 studies using the R package metaSeq.  

# Methods v2 (from paper)

We began by conducting a brief literature survey of the Friedreich’s ataxia RNA-seq datasets.  Then, we followed the following steps to download the RNA-seq datasets:
Steps to get data: 

1.    Search on Google SRA NCBI
2.    Search ataxia in SRA NCBI
3.    Click on RNA (367) on left hand side of page
4.    Click on Homo sapiens (157) on right hand side of page (click on 157)
5.    Click on Send to
6.    Click on Run Selector
7.    Click on Go
8.    Click on Instrument on the left hand side
9.    On bottom left hand side, click on illumina hiseq 2000, illumina hiseq 2500, and nextseq 500
10.    Should see 99 runs found (cases and controls)
11.    Click on green plus sign on 99 runs found
12.    Download data by clicking on RunInfo Table
13.    Open excel file and use default for tab de-limited data to bring in data
14.    This was main dataset we used to merge with other datasets
15.    Go to GEO to get information on studies to merge with main data file:     
            https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104288
16.    Get count data at this link: 
            https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE104288
17.       Restructure GEO file so that the gene numbers are rows and IDs are columns
18.    Then, we merged the datasets using a common variable

We elected to focus on human data and as a result, excluded one dataset that was smallRNA, leaving 4 studies in total and 83 samples (41 samples were controls, 39 were cases; the remaining 3 were parental carriers) in our final dataset.  Next,     we conducted differential analyses using GEO and count datasets in R to compare differences in gene expression between cases and controls.    



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

Separately, once the results come out you can analyze the counts data with "metaseq_ataxia.R" , you'll need the counts.txt file. If you are doing it on a novel dataset, you'll need to generate the study and case/control flags from, for example the SRA sample sheet we began with.

# Results

We have identified some promising truncated transcripts in the current main Friedreich's Ataxia gene, FXN. extra vis from the metaseq to come?
