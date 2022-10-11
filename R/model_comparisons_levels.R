## model_comparisons_levels.R: compare mixed model fits for
## methylation levels
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

model_comparisons_levels <- function(input_filename, # file with data for samples
                                     ages_filename, # file with ages for samples
                                     # do 1M simulations for exactRLRT tests
                                     n_simulations = 1000000) {

  library(lmerTest) # Mixed model package
  library(RLRsim) # For testing mixed models by simulation

  X <- read.table(input_filename, header=TRUE)
  ages_table <- read.table(ages_filename, header=TRUE)

  stopifnot("subjects must be identical between input files" =
              X$subject == ages_table$subject)

  stopifnot("column headings must be subject mean weighted fractional" =
              c('subject', 'mean', 'weighted', 'fractional') == colnames(X))

  X$age <- ages_table$age

  use_reml <- TRUE # use restricted max likelihood

  ## First test
  ## H0: mean methylation is independent of age

  X$mean <- scale(X$mean)
  mean_model <- lmer(mean ~ age + (1|subject), data = X, REML=use_reml)
  print(summary(mean_model))
  print(exactRLRT(mean_model, nsim=n_simulations))

  ## Second test
  ## H0: weighted mean methylation is independent of age

  X$weighted <- scale(X$weighted)
  weighted_model <- lmer(weighted ~ (1|subject) + age, data = X, REML=use_reml)
  print(summary(weighted_model))
  print(exactRLRT(weighted_model, nsim=n_simulations))

  ## Third test
  ## H0: fraction methylated is independent of age

  X$fractional <- scale(X$fractional)
  fractional_model <- lmer(fractional ~ (1|subject) + age, data = X, REML=use_reml)
  print(summary(fractional_model))
  print(exactRLRT(fractional_model, nsim=n_simulations))
}
