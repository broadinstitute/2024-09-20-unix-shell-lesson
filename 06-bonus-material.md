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

## Introduction

Unix/Linux provides many small tools and utilities that can easily interact with each other using their built-in Input and Output streams, allowing you to  perform complex data manipulations on the command line without writing a formal program or script.

This bonus section provides some examples of how to use Unix for biology-specific tasks.

### Introducing **h5ls**, a Unix tool to peek into AnnData objects

<show what head <AnnData> file looks like>

If you have an AnnData file locally AND you have the hdf5 library installed locally (which you do if you have the AnnData or ScanPy library installed), you can use the hdf5 command line tool h5ls to quickly peek inside an AnnData file.
Example:

```
> h5ls unconventional.h5ad/obs
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

Maybe the top level isn't enough information, go deeper with **h5ls -r**:

```
> h5ls -r unconventional.h5ad             
/                        Group
/X                       Dataset {700, 765}
/layers                  Group
/obs                     Group
/obs/G2M_score           Dataset {700}
/obs/S_score             Dataset {700}
/obs/bulk_labels         Group
/obs/bulk_labels/categories Dataset {10}
/obs/bulk_labels/codes   Dataset {700}
/obs/index               Dataset {700}
/obs/louvain             Group
/obs/louvain/categories  Dataset {11}
/obs/louvain/codes       Dataset {700}
/obs/n_counts            Dataset {700}
/obs/n_genes             Dataset {700}
/obs/percent_mito        Dataset {700}
/obs/phase               Group
/obs/phase/categories    Dataset {3}
/obs/phase/codes         Dataset {700}
/obsm                    Group
/obsm/X_pca              Dataset {700, 50}
/obsm/X_umap             Dataset {700, 2}
/obsp                    Group
/obsp/connectivities     Group
/obsp/connectivities/data Dataset {9992/Inf}
/obsp/connectivities/indices Dataset {9992/Inf}
/obsp/connectivities/indptr Dataset {701/Inf}
/obsp/distances          Group
/obsp/distances/data     Dataset {6300/Inf}
/obsp/distances/indices  Dataset {6300/Inf}
/obsp/distances/indptr   Dataset {701/Inf}
/raw                     Group
/raw/X                   Group
/raw/X/data              Dataset {174400/Inf}
/raw/X/indices           Dataset {174400/Inf}
/raw/X/indptr            Dataset {701/Inf}
/raw/var                 Group
/raw/var/index           Dataset {765}
/raw/varm                Group
/uns                     Group
/uns/bulk_labels_colors  Dataset {10}
/uns/louvain             Group
/uns/louvain/params      Group
/uns/louvain/params/random_state Dataset {1}
/uns/louvain/params/resolution Dataset {1}
/uns/louvain_colors      Dataset {11}
/uns/neighbors           Group
/uns/neighbors/params    Group
/uns/neighbors/params/method Dataset {SCALAR}
/uns/neighbors/params/n_neighbors Dataset {1}
/uns/pca                 Group
/uns/pca/variance        Dataset {50}
/uns/pca/variance_ratio  Dataset {50}
/uns/rank_genes_groups   Group
/uns/rank_genes_groups/names Dataset {100}
/uns/rank_genes_groups/params Group
/uns/rank_genes_groups/params/groupby Dataset {SCALAR}
/uns/rank_genes_groups/params/method Dataset {SCALAR}
/uns/rank_genes_groups/params/reference Dataset {SCALAR}
/uns/rank_genes_groups/params/use_raw Dataset {1}
/uns/rank_genes_groups/scores Dataset {100}
/var                     Group
/var/dispersions         Dataset {765}
/var/dispersions_norm    Dataset {765}
/var/highly_variable     Dataset {765}
/var/index               Dataset {765}
/var/means               Dataset {765}
/var/n_counts            Dataset {765}
/varm                    Group
/varm/PCs                Dataset {765, 50}
/varp                    Group
```

Too much information? Do a more focused recursive **h5ls** by specifying a deeper path in the object (in this example, the deeper path is '/obs'):
```
> h5ls -r unconventional.h5ad/obs
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
Notice that for AnnData objects, there are some Group objects that have nested datasets named categories  and codes these are often Pandas' categorical data. You can get the unique list of categorical labels with **h5dump -d**:
```
> h5dump -d "obs/bulk_labels/categories" unconventional.h5ad
HDF5 "unconventional.h5ad" {
DATASET "obs/bulk_labels/categories" {
   DATATYPE  H5T_STRING {
      STRSIZE H5T_VARIABLE;
      STRPAD H5T_STR_NULLTERM;
      CSET H5T_CSET_UTF8;
      CTYPE H5T_C_S1;
   }
   DATASPACE  SIMPLE { ( 10 ) / ( 10 ) }
   DATA {
   (0): "CD4+/CD25 T Reg", "CD4+/CD45RA+/CD25- Naive T",
   (2): "CD4+/CD45RO+ Memory", "CD8+ Cytotoxic T",
   (4): "CD8+/CD45RA+ Naive Cytotoxic", "CD14+ Monocyte", "CD19+ B", "CD34+",
   (8): "CD56+ NK", "Dendritic"
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


## Challenge 

:::::::::::::::::::::::: solution 

You can add a line with at least three colons and a `solution` tag.

:::::::::::::::::::::::::::::::::
::::::::::::::::::::::::::::::::::::::::::::::::



::::::::::::::::::::::::::::::::::::: keypoints 

- Use common Unix tools to work with specialized file formats for biological data
- Look for less common tools that may be more efficient or more quickly accessible to increase your productivity.

::::::::::::::::::::::::::::::::::::::::::::::::

