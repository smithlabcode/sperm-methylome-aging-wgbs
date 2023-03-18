# Data files

This directory contains data pertinet to section 2.3 of the
manuscript. Files depict the average methylation values of 100 kb bins
inside and outside of PMDs (files that start with `regions-`), as well
as donor-corrected age correlation for the same bins (files that start
with `cors-`). The union and intersection of all datasets is also
depicted through files that contains the words `Union` and
`Intersection`.

Files with `regions-` prefix are six-column BED files. The fourth,
fifth and sixth column are, respectively: mean methylation inside bin
(across all 20 donors), the slope value between age and methylation
level, and the slope p-value, indicating significance of
age-association.
