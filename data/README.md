# Data files

- `sample_donor_age.txt` is a 3 column data frame with the sample
  id, the donor id, and the age for each sample.

- `cpg_meth_CHM13.txt` gives the methylation levels for each sample,
  which is indicated by the sample id. Each row also has the donor id
  and the age for the sample. The methylation levels in this file are
  for the symmetric CpG sites, which should not matter for the
  weighted mean methylation, but might have a slight impact on the
  estimate of the mean and fractional methylation.

- `cpg_meth_centromere_CHM13.txt` has the same structure as the
  `cpg_meth_CHM13.txt` file. The difference is that methylation levels
  were obtained from the centromeres. The centromere is defined as the
  part of the genome contained in the `censat` annotation, excluding
  those elements labeled as `ct` which "centromeric transition
  regions". The levels are as above, for symmetric CpG sites. The vast
  majority of the data here comes from CpG sites in contiguous
  intervals, one for each chromosome, but we have retained any
  isolated satellite sequences in the annotation. Isolated centromeric
  satellites tend to be very small.

- `cpg_meth_centromere_CHM13_ambig.txt` is similar to
  `cpg_meth_centromere_CHM13.txt`, but methylation levels were
  calculated by assigning ambiguous reads randomly to one of its
  optimal mapping locations in the genome. These levels are therefore
  calculated under the assumption that, if a read maps to a
  centromeric region, then its other mapping locations are, with high
  probability, also within a centromere. The weighted mean methylation
  should be similar to what would be obtained if each read's true
  mapping location were known, or if each read were mapped
  fractionally to each possible mapping location.

- `hmr_nocensat_CHM13.txt` gives the HMR summary stats for each sample
  indicated by the sample id. Each row also has the donor id and the
  age for the corresponding sample. The summary stats are the total
  sum of sizes of the HMRs ("coverage"), their number ("count"), and
  their mean size, which is redundant given the other two. The
  "nocensat" means no CpGs were included from any centromeric
  satellite of any type in the annotation. This excludes even the "ct"
  elements, which do not seem to behave like the other elements within
  the centromere annotations. The HMRs in healthy somatic cells
  correspond to transcriptional regulatory regions, promoters and
  enhancers (and maybe insulators). In sperm, the same seems to hold
  if we exclude the centromeres.

- `centromeric_satellites_CHM13.bed` a 3-column bed format file
  containing the centromeric satellites from the censat annotation
  available from UCSC for CHM13 v2.0, but with the exclusion of the
  "ct" elements. The intervals are collapsed/merged so there are 923
  lines in the file, covering 240521368 bp.

- `sample_10kb_bins.txt` gives the average methylation in 10 kbp
  bins in the human genome across all samples, excluding bins for
  which at least one of the samples does not contain any reads
  (in other words, only using samples with data in all samples).
