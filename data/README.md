# Directories
 - `methylation_global` contains the average, weighted average and fractional
   methylation values genome-wide per donor. Files in this directory
   show these values in the CHM13 reference genome, with and without
   centromeric satellites, as well as in hg38.

 - `methylation_bins` contain matrices of weighted averge methylation
   when splitting the genome in 10kbp and 100kbp bins. It also
   contains BED files showing the donor-corrected correlation between
   each bin's methylation level and the donor age

 - `centromere` contains both annotation and methylation data
   regarding centromeric regions and subfamilies. This directory shows
   the intervals defined as centromeric, the weighted average
   methylation level in these regions per donor, and the correlation
   between methylation levels in centromeres and centromeric repeat
   subfamilies with age

 - `pmd` contains both the methylation level and the donor-corrected
   correlation for regions identified as PMDs in the 7 datasets
   described in the manuscript.

 - `hmr` contains the coverage, count and size of HMRs proximal and
   distal to promoters for each donor.

# Data files

- `sample_donor_age.txt` is a 3 column data frame with the sample
  id, the donor id, and the age for each sample.

- `data_quality.txt` shows the summary statistics for mapping and
  quality control metrics for whole genome bisulfite sequencing data
  for each dataset. These include: percentage of reads mapped
  ambiguously and uniquely, bisulfite conversion rate, coverage and
  depth of CpGs, and upper bound on CpG->TpG mutations.
