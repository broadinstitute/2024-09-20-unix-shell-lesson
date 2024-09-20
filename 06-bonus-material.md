---
title: 'Practical examples'
teaching: 10
exercises: 2
---

:::::::::::::::::::::::::::::::::::::: questions 

- How can we work with files specific to the biological sciences in Unix?

::::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::: objectives


- Explain how to use common Unix tools (eg. grep, sed etc) to extract information from a specialized biological file format (example: [GFF](https://useast.ensembl.org/info/website/upload/gff.html) )
- Demonstrate  how to use a specialized Unix tool (eg. h5ls) to inspect biological data in a specialized file format (example: [AnnData](https://anndata.readthedocs.io/en/latest/) with single cell RNAseq data)

::::::::::::::::::::::::::::::::::::::::::::::::

Apologies - this section is still being refined. The general examples commands are shown but the expected outputs still need to be added.

## Introduction

Unix/Linux provides many small tools and utilities that can easily interact with each other using their built-in Input and Output streams, allowing you to  perform complex data manipulations on the command line without writing a formal program or script.

This bonus section provides some examples of how to use Unix for biology-specific tasks.

### Data wrangling using grep, pipes and file redirection

Background: The [CHESS gene catalog](https://ccb.jhu.edu/chess/index.shtml?t=release) curates the set of all human genes and their transcripts through analysis of GTEx RNA sequencing data and manual assessment of RefSeq and GENCODE annotations and overlap. This catalog reports a different count of protein-coding genes in the human genome compared to RefSeq and GENCODE. To identify the overlap of genes across all three annotations sets, we need the total list of protein-coding gene names by extracting them from the annotation files. 


#### Task: generate file with unique list of protein-coding gene names from CHESS annotation file (GFF)

Download cb_unix_shell.tgz to your home directory and unpack it.

```
$ cd
$ wget https://github.com/jlchang/cb-unix-shell-lesson-template/raw/refs/heads/main/learners/files/chess3.1.3.GRCh38.assembly.gff.gz
$ gunzip chess3.1.3.GRCh38.assembly.gff.gz
```

First head the file to see the signature of a protein-coding gene in the file

```
$ head chess3.1.3.CHM13.assembly.gff
```
```
##gff-version 3
#!gff-spec-version 1.21
chr1	CHESS	gene	11874	14409	.	+	.	ID=CHS.1;gene_name=DDX11L1;gene_type=transcribed_pseudogene
chr1	RefSeq	transcript	11874	14409	.	+	.	ID=CHS.1.1;Parent=CHS.1;gene_name=DDX11L1;gene_type=transcribed_pseudogene;db_xref=RefSeq:NR_046018.2,GENCODE:ENST00000456328.2;assembly_id=NA;cds_adjustment_status=0;exon_adjustment_status=0;original_source=BestRefSeq
chr1	RefSeq	exon	11874	12227	.	+	.	Parent=CHS.1.1;gene_name=DDX11L1
chr1	RefSeq	exon	12613	12721	.	+	.	Parent=CHS.1.1;gene_name=DDX11L1
chr1	RefSeq	exon	13221	14409	.	+	.	Parent=CHS.1.1;gene_name=DDX11L1
chr1	CHESS	gene	14362	29370	.	-	.	ID=CHS.2;gene_name=WASH7P;gene_type=transcribed_pseudogene
chr1	RefSeq	transcript	14362	29370	.	-	.	ID=CHS.2.1;Parent=CHS.2;gene_name=WASH7P;gene_type=transcribed_pseudogene;db_xref=RefSeq:NR_024540.1;assembly_id=NA;cds_adjustment_status=0;exon_adjustment_status=0;original_source=BestRefSeq
chr1	RefSeq	exon	14362	14829	.	-	.	Parent=CHS.2.1;gene_name=WASH7P`
```
It seems we can locate protein coding gene names in the file with the following search: 
```
;gene_name=DNASE1;gene_type=protein_coding
```
… where the gene “DNASE1” could be replaced with any gene name. 

To identify such a string with any gene name inserted, we recognize that a gene name may contain uppercase letters, lowercase letters, numbers, or hyphens. We therefore turn to https://regex101.com/ to see if we can devise an appropriate regular expression to identify the string above containing any gene name

After identifying an appropriate regex, we grep the file for these lines, instruct to only report the exact matching sequence (-o), and save the results to a text file 

```
 grep -o ';gene_name=[a-zA-Z0-9-]*;gene_type=protein_coding' chess3.1.3.CHM13.assembly.gff | uniq > chess3.1.3_genes.txt
```
Isolate individual gene names from the matching lines
```
grep -o "[A-Z][a-zA-Z0-9-]*" chess3.1.3_genes_temp.txt | sort >chess3.1.3_genes.txt
```
Alternatively, this final clean up step can be done with sed 
```
grep -o ';gene_name=[a-zA-Z0-9-]*;gene_type=protein_coding' chess3.1.3.CHM13.assembly.gff | uniq > newfile.txt
sed 's/;gene_name=//' newfile.txt > newnewfile.text
sed 's/;gene_type=protein_coding//' newnewfile.text > justthegenes.txt
```


### Introducing **h5ls**, a Unix tool to peek into AnnData objects

Let's get an example h5ad file and put it in our home directory

```
$ cd
$ wget https://github.com/jlchang/cb-unix-shell-lesson-template/raw/refs/heads/main/learners/files/example.h5ad
```

If you have an AnnData file locally AND you have the hdf5 library installed locally (which you do if you have the AnnData or ScanPy library installed), you can use the hdf5 command line tool h5ls to quickly peek inside an AnnData file. HDF5 files have two types of objects, Datasets and Groups.
Example:

```
> h5ls example.h5ad
```
```
X                        Dataset {700, 765}
layers                   Group
obs                      Group
obsm                     Group
obsp                     Group
raw                      Group
uns                      Group
var                      Group
varm                     Group
varp                     Group
```

Go deeper by appending a Group name to the file:

```
> h5ls example.h5ad/obs
```
```
G2M_score                Dataset {700}
S_score                  Dataset {700}
bulk_labels              Group
index                    Dataset {700}
louvain                  Group
n_counts                 Dataset {700}
n_genes                  Dataset {700}
percent_mito             Dataset {700}
phase                    Group
```

Too focused? Get the entire directory tree for the file with **h5ls -r**
```
> h5ls -r example.h5ad
```

Too much information? Do a more focused recursive **h5ls** by specifying a deeper path in the object (in this example, the deeper path is '/obs'):
```
> h5ls -r example.h5ad/obs
/G2M_score               Dataset {700}
/S_score                 Dataset {700}
/bulk_labels             Group
/bulk_labels/categories  Dataset {10}
/bulk_labels/codes       Dataset {700}
/index                   Dataset {700}
/louvain                 Group
/louvain/categories      Dataset {11}
/louvain/codes           Dataset {700}
/n_counts                Dataset {700}
/n_genes                 Dataset {700}
/percent_mito            Dataset {700}
/phase                   Group
/phase/categories        Dataset {3}
/phase/codes             Dataset {700}
```
Notice that for AnnData objects, there are some Group objects that have nested datasets named categories and codes these are often Pandas' categorical data. You can get the unique list of categorical labels with **h5dump -d**:
```
> h5dump -d "obs/phase/categories" example.h5ad
```
```
HDF5 "example.h5ad" {
DATASET "obs/phase/categories" {
   DATATYPE  H5T_STRING {
      STRSIZE H5T_VARIABLE;
      STRPAD H5T_STR_NULLTERM;
      CSET H5T_CSET_UTF8;
      CTYPE H5T_C_S1;
   }
   DATASPACE  SIMPLE { ( 3 ) / ( 3 ) }
   DATA {
   (0): "G1", "G2M", "S"
   }
   ATTRIBUTE "encoding-type" {
      DATATYPE  H5T_STRING {
         STRSIZE H5T_VARIABLE;
         STRPAD H5T_STR_NULLTERM;
         CSET H5T_CSET_UTF8;
         CTYPE H5T_C_S1;
      }
      DATASPACE  SCALAR
      DATA {
      (0): "string-array"
      }
   }
   ATTRIBUTE "encoding-version" {
      DATATYPE  H5T_STRING {
         STRSIZE H5T_VARIABLE;
         STRPAD H5T_STR_NULLTERM;
         CSET H5T_CSET_UTF8;
         CTYPE H5T_C_S1;
      }
      DATASPACE  SCALAR
      DATA {
      (0): "0.2.0"
      }
   }
}
}
```
::::::::::::::::::::::::::::::::::::: challenge 

## Challenge


:::::::::::::::::::::::: solution 

## Output
 
```output
[1] "This new lesson looks good"
```

:::::::::::::::::::::::::::::::::


::::::::::::::::::::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::::::::: keypoints 

- Use common Unix tools to work with specialized file formats for biological data
- Look for less common tools that may be more efficient or more quickly accessible to increase your productivity.

::::::::::::::::::::::::::::::::::::::::::::::::

