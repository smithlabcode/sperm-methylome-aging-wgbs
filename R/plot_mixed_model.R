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

#!/usr/bin/env Rscript

library(lmerTest) # Mixed model package
library(RColorBrewer)

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 3) {
    stop("Provide three filenames, two input, one output", call.=FALSE)
}

input_filename <- args[1]
ages_filename <- args[2]
output_filename <- args[3]

## get the input from the two input files
X <- read.table(input_filename, header=T)
the_covariate <- colnames(X)[length(colnames(X))] # what's at the end
ages_table <- read.table(ages_filename, header=T)
X$age <- ages_table$age

stopifnot("Mismatching subjects between input files" =
              all(ages_table$subject==X$subject))

n_observations <- nrow(X)
subject_names <- unique(X$subject)
n_subjects <- length(subject_names)

## Define the colors
qual_col_pal <- brewer.pal.info[brewer.pal.info$category == 'qual',]
col_vector <- unlist(mapply(brewer.pal, qual_col_pal$maxcolors,
                            rownames(qual_col_pal)))

## standardize covariate prevents numerical problems
covar_mean <- mean(X[, the_covariate])
covar_sd <- sd(X[, the_covariate])
X[, the_covariate] <- scale(X[, the_covariate])

## create the formula and fit the mixed model
the_formula <- as.formula(paste(the_covariate, "~ age + (1|subject)"))
use_reml <- TRUE # use restricted max likelihood
mixed_model <- lmer(the_formula, data=X, REML=use_reml)

## unscale the data so it can be plotted in original units
X[, the_covariate] <- X[, the_covariate]*covar_sd + covar_mean

## open the output file
pdf(output_filename)

### Use +/- 3 stdandard deviations for y range
y_limits <- c(covar_mean - 3*covar_sd, covar_mean + 3*covar_sd)
### Make an empty plot with the right axes (0 to 80 yrs)
plot(c(), xlim=c(0, 80), ylim=y_limits, xlab="age", ylab=the_covariate)

### keep an estimate of the intercept for each subject
subj_intercepts <-
    data.frame(row.names=subject_names, intr=rep(0, n_subjects))

### plot the line for each subject
for (i in 1:n_subjects) {

    ## j gives the indices for this subject among all observations
    j <- which(rownames(coef(mixed_model)$subject) == subject_names[i])
    ## in coef for the mixed model, [1] is intercept and [2] is slope
    subj_intercept <- coef(mixed_model)$subject[[1]][j]*covar_sd + covar_mean
    subj_slope <- coef(mixed_model)$subject[[2]][i]*covar_sd
    ## add the estimated line for this subject to the plot
    abline(subj_intercept, subj_slope, col=col_vector[i])

    ## get the intercept for the current subject
    subj_intercepts[subject_names[i], ] <- subj_intercept

    ## Y is observations for current subject; avoids index arithmetic
    Y <- subset(X, subject == subject_names[i])
    ## add the observed points for this subject to the plot
    points(Y$age[1], Y[, the_covariate][1], col=col_vector[i], pch=19)
    points(Y$age[2], Y[, the_covariate][2], col=col_vector[i], pch=19)
}

## estimate value for each observation: for that subject, the
## y-coordinate for the each
estimated_values <- rep(0, n_observations)
for (i in 1:n_observations) {
    estimated_values[i] <- subj_intercepts[X$subject[i], ] + subj_slope*X$age[i]
}

## get the colors for each observation, repeating each subject twice
the_colors <- rep(col_vector, each=2)

## draw vertical line segments connecting the observed values and the
## line for that subject (the estimate)
segments(X$age, X[, the_covariate], X$age, estimated_values, col=the_colors)

dev.off()
