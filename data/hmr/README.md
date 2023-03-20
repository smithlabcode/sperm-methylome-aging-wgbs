# Data files

- `hmr_nocensat_CHM13.txt` shows the HMR summary stats for each sample
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

- `hmr_nocensat_CHM13_promoters.txt` is similar to
  `hmr_nocensat_CHM13.txt`, but only considers HMRs that have a
  non-empty overlap with transcription start sites in the CHM13 v2.0
  RefSeq annotation.

- `hmr_nocensat_CHM13_no_promoters.txt` is also similar to
  `hmr_nocensat_CHM13.txt`, but only uses HMRs that do not overlap
  transcription start sites in the CHM13 v2.0 RefSeq annotation.
