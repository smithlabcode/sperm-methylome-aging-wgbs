# Data files

- `subject_age.txt` is a 2 column data frame with the subject name and
  the (ordered) ages of data collection.

- `sample_cpg_meth_CHM13.txt` gives the methylation levels for each
  sample, which is indicated by the subject id (0-9) and the order in
  which the subject appears. This depends on order, but also means
  this file can include the subject id, built into filenames, without
  the ages at the time this file is built. Similar for the other files
  below with info about each sample. The methylation levels in this
  file are for the symmetric CpG sites, which should not matter for
  the weighted mean methylation, but might have a slight impact on the
  estimate of the mean and fractional methylation.

- `sample_cpg_meth_centromere_CHM13.txt` gives the methylation levels
  inside the centromeres for each sample. The levels are as above, for
  symmetric CpG sites. These are only calcualted for the annotated
  "hor", "dhor" and "mon" elements, which roughly span contiguous
  intervals through the centromere on each chromosome.

- `sample_cpg_meth_centromere_CHM13_ambig.txt` is similar to
  `sample_cpg_meth_centromere_CHM13.txt`, but methylation levels were
  calculated by assigning ambiguous reads randomly to one of its optimal
  mapping locations in the genome. These levels are therefore calculated
  under the assumption that, if a read maps to a centromeric region,
  then its other mapping locations are, with high probability, also
  originating from the centromere.

- `sample_hmr_nocensat_CHM13.txt` gives the HMR summary stats for each
  sample, encoded as in the file above. The summary stats are the
  total sum of sizes of the HMRs, their number, and their average size
  (the last of which is redundant). The "nocentromere" means no
  satellite of any type annotated among all the censat. The HMRs in
  healthy somatic cells correspond to transcriptional regulatory
  regions, promoters and enhancers (and maybe insulators). In sperm,
  the same seems to hold if we exclude the centromeres.
