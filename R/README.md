# R scripts

- `model_comparisons_hmr.R` Contains the function
  `model_comparisons_hmr`, which fits mixed models and tests
  hypotheses concerning summary stats on HMRs. The required input is
  onefile: `input_filename`. This file must have columns for sample,
  donor, age, coverage, count and size of the HMRs. An optional
  parameter determines the number of samples to take when doing the
  exact RLRT tests for the mixed model.

- `model_comparisons_levels.R` Contains the function
  `model_comparisons_levels`. This runs similar to the above, except
  the input file must have columns for sample, donor, age, mean,
  weighted and fractional.

- `plot_mixed_model.R` Contains the function `plot_mixed_model`. This
  function must be given (1) an input file with donor id, age and
  value for a covariate, (2) the name of the covariate to plot, and
  (3) an output file for a pdf format plot. The output file is not
  required, and if not specified the plot will be generated in the R
  window.
