## plot_mixed_model.R: plots mixed models for a very specific kind of
## data. This script is written to run from command line instead of
## within the R interpreter.
##
## Copyright (C) 2022 Andrew D Smith and Guilherme de Sena Brandine
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

plot_mixed_model <- function(input_filename,
                             the_covariate,
                             output_filename = NULL) {

  library(lmerTest) # Mixed model package
  library(RColorBrewer)

  ## get the input from the two input files
  X <- read.table(input_filename, header=T)
  stopifnot("Specified covariate not in input file" =
              is.element(the_covariate, names(X)))

  n_observations <- nrow(X)
  donor_names <- unique(X$donor)
  n_donors <- length(donor_names)

  ## Define the colors
  col_vector <- brewer.pal(10, name='Paired')

  ## standardize covariate prevents numerical problems
  covar_mean <- mean(X[, the_covariate])
  covar_sd <- sd(X[, the_covariate])
  X[, the_covariate] <- scale(X[, the_covariate])

  ## create the formula and fit the mixed model
  the_formula <- as.formula(paste(the_covariate, "~ age + (1|donor)"))
  use_reml <- TRUE # use restricted max likelihood
  mixed_model <- lmer(the_formula, data=X, REML=use_reml)

  ## unscale the data so it can be plotted in original units
  X[, the_covariate] <- X[, the_covariate]*covar_sd + covar_mean

  ## open the output file
  if (!is.null(output_filename)) {
    pdf(output_filename)
  }

  ### Use +/- 3 stdandard deviations for y range
  x_limits <- c(0, 80) ## Magic
  y_limits <- c(covar_mean - 2.5*covar_sd, covar_mean + 2.5*covar_sd) ## ++magic
  ### Make an empty plot with the right axes
  plot(c(), xlim=x_limits, ylim=y_limits, xlab="age", ylab=the_covariate)

  ### keep an estimate of the intercept for each donor
  subj_intercepts <-
    data.frame(row.names=donor_names, intr=rep(0, n_donors))

  ### plot the line for each donor
  for (i in 1:n_donors) {

    ## j gives the indices for this donor among all observations
    j <- which(rownames(coef(mixed_model)$donor) == donor_names[i])
    ## in coef for the mixed model, [1] is intercept and [2] is slope
    subj_intercept <- coef(mixed_model)$donor[[1]][j]*covar_sd + covar_mean
    subj_slope <- coef(mixed_model)$donor[[2]][j]*covar_sd

    ## add the estimated line for this donor to the plot
    abline(subj_intercept, subj_slope, col=col_vector[i])

    ## get the intercept for the current donor
    subj_intercepts[donor_names[i], ] <- subj_intercept

    ## Y is observations for current donor; avoids index arithmetic
    Y <- subset(X, donor == donor_names[i])
    ## add the observed points for this donor to the plot
    points(Y$age[1], Y[, the_covariate][1], col=col_vector[i], pch=19)
    points(Y$age[2], Y[, the_covariate][2], col=col_vector[i], pch=19)
  }

  ## estimate value for each observation: for that donor, the
  ## y-coordinate for the each
  estimated_values <- rep(0, n_observations)
  for (i in 1:n_observations) {
    estimated_values[i] <- subj_intercepts[X$donor[i], ] + subj_slope*X$age[i]
  }

  ## draw vertical line segments connecting the observed values and the
  ## line for that donor (the estimate)
  segments(X$age, X[, the_covariate], X$age,
           estimated_values, col=rep(col_vector, each=2))

  if (!is.null(output_filename)) {
    dev.off()
  }
}
