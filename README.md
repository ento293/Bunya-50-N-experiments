# Bunya-50-N-experiments
Our goal is to understand which Orthobunyavirus L and N proteins are compatible in a minigenome system.
We cloned 50 helper plasmids that express N proteins. Then, using a minigenome assay, we tested these 50 different N proteins with three different L proteins: La Crosse virus (LACV), Bunyamwera virus (BUNV), and Kairi virus (KRIV). N proteins have an overlapping ORF for a non-structural NSs protein; we repeated all the experiments with a different set of 50 NSs-less N protein plasmids.
Data, analysis, and plots are shown here. 

## Directory structure

```
Bunya-50-N-experiments/
├── README.md
├── shared
│   └── make_tidy_function.R
│   └── plot_functions.R
│   └── metadata.xlsx
├── 2025_01_14_LACV_50N_with_NSs_exp1/
│   ├── data/
│   │   └── 2025_01_13_LACV_50N_exp1_plate_layout.docx
│   │   └── 2025_01_16_LACV_50N_exp1_plate1.xlsx
│   │   └── 2025_01_16_LACV_50N_exp1_plate2.xlsx
│   │   └── 2025_01_16_LACV_50N_exp1_plate3.xlsx
│   │   └── 2025_01_16_LACV_50N_exp1_tidy.xlsx
│   ├── 2025_01_14_LACV_50N_with_NSs_exp1_analysis.R
│   └── plots/
│       ├── 2025_01_16_LACV_50N_exp1_double_norm.pdf
│       └── 2025_01_16_LACV_50N_exp1_single_norm.pdf
├── 2025_01_21_LACV_50N_with_NSs_exp2/
│   ├── etc

```
## Data Description
Raw luminescence data for each plate is stored in each experiments ```/data``` subdirectory as ```.xlsx``` files. Compiled data is found in the same directory as ```experiment_name_tidy.xcel```. Metadata used to generate the plots is found in the ```shared``` subdirectory.

