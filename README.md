# sperm-methylome-aging-wgbs
Scripts, pipelines, summary data and figures for this project.

Scripts
=======

R scripts
---------

- `model_comparisons_hmr.R` Script to fit mixed models and test
  hypotheses concerning summary stats on HMRs. The input is assumed to
  include two files: `input_filename` must be defined, as well as
  `ages_filename` before sourcing the script from within an R
  interpreter. The files must have the same number of columns. The
  headings for `ages_filename` need to be `subject` and `age`. The
  `input_filename` must have headings `subject`, `coverage`, `count`
  and `size`. The rows must correspond, and it is expected that each
  subject will have 2 rows in both files, consecutive, although this
  might not matter.

- `model_comparisons_levels.R` Similar to the above, except the
  `input_filename` needs to have columns `subject` and `age`. The
  `input_filename` must have headings `subject`, `mean`, `weighted`
  and `fractional`.

- `plot_mixed_model.R` Pseudo-general script to plot mixed
  models. This must be given (1) a file with the ages for each sample
  (indicated with the subject ID and *ordered*), and (2) a file with
  the same subject IDs, in the same order, and one other covariate,
  and (3) an output file for a pdf. A plot of the mixed model lines
  for each of the samples will be generate.

Data
====

Descriptions of the summary data are in `data/README.md`. These are
small files for processed data.
