# Data files

- `cpg_methylation_CHM13.txt` shows the methylation levels for each sample,
  which is indicated by the sample id. Each row also has the donor id
  and the age for the sample. The methylation levels in this file are
  for the symmetric CpG sites, which should not matter for the
  weighted mean methylation, but might have a slight impact on the
  estimate of the mean and fractional methylation.

 - `cpg_methylation_CHM13_ambig.txt`  is the same as
   `cpg_methylation_CHM13.txt` but including reads that map
    ambiguously to the reference genome.

 - `cpg_methylation_hg38.txt` shows the methylation level for each
   sample with reads mapped to the GRCh38.p13 reference genome.

 - `cpg_methylation_nocensat_CHM13.txt` shows methylation levels
   excluding centromeric satellites. The regions excluded are shown in
   file `centromeric_satellites_CHM13.bed` under the `centromere`
   directory. The regions excluded for each chromosome are the
   smallest continuous interval that cover all intervals shown in this
   file.

