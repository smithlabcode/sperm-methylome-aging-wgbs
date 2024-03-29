## model_comparisons_hmr.R: compare mixed model fits for some HMR
## features
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

model_comparisons_hmr <- function(input_filename, # file with data for samples
                                  # do 1M simulations for exactRLRT tests
                                  n_simulations = 1000000) {

  library(lmerTest) # Mixed model package
  library(RLRsim) # For testing mixed models by simulation

  X <- read.table(input_filename, header=T)
  stopifnot("column headings must sample donor age coverage count size" =
              c('sample', 'donor', 'age',
                'coverage', 'count', 'size') == colnames(X))
  use_reml <- TRUE # use restricted max likelihood

  ### First test
  ### H0: HMR coverage is independent of age

  X$coverage <- scale(X$coverage)
  coverage_model <- lmer(coverage ~ age + (1|donor), data = X, REML=use_reml)
  print(summary(coverage_model))
  print(exactRLRT(coverage_model, nsim=n_simulations))

  ### Second test
  ### H0: number of HMRs is independent of age

  X$count <- scale(X$count)
  count_model <- lmer(count ~ (1|donor) + age, data = X, REML=use_reml)
  print(summary(count_model))
  print(exactRLRT(count_model, nsim=n_simulations))

  ### Third test
  ### H0: HMR size is independent of age

  X$size <- scale(X$size)
  size_model <- lmer(size ~ (1|donor) + age, data = X, REML=use_reml)
  print(summary(size_model))
  print(exactRLRT(size_model, nsim=n_simulations))
}
