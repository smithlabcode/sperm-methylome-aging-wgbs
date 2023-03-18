# Data files

- `centromeric_satellites_CHM13.bed` a 3-column bed format file
  containing the centromeric satellites from the censat annotation
  available from UCSC for CHM13 v2.0, but with the exclusion of the
  "ct" elements. The intervals are collapsed/merged so there are 923
  lines in the file, covering 240521368 bp.

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

 - `cpg_methylation_centromere_acrocentric_CHM13.txt` shows the
   weighted average methylation level using only acrocentric
   chromosomes (13-15, 21 and 22)
 
 - `cpg_methylation_rdna_CHM13.txt` shows the methylation levels in
   regions annotated by the telomere-to-telomere consortium as rDNA
   regions. Methylation for this file is calculated using only
   uniquely mapped reads

 - `cpg_methylation_rdna_CHM13_ambig.txt` is the same as
   `cpg_methylation_rdna_CHM13.txt` but includes reads that map
    ambiguously to CHM13 but uniquely to the rDNA annotation.
