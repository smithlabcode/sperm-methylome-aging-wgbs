library(lmerTest) # Mixed model package
library(RLRsim) # For testing mixed models by simulation

X <- read.table(input_filename, header=T)
ages_table <- read.table(ages_filename, header=T)

stopifnot("subjects must be identical between input files" =
              X$subject == ages_table$subject)

stopifnot("column headings must be subject mean weighted fractional" =
              c('subject', 'mean', 'weighted', 'fractional') == colnames(X))

X$age <- ages_table$age

use_reml <- TRUE # use restricted max likelihood
n_simulations <- 10000000 # do 1M simulations for exactRLRT tests

### First test
### H0: mean methylation is independent of age

X$mean <- scale(X$mean)
mean_model <- lmer(mean ~ age + (1|subject), data = X, REML=use_reml)
print(summary(mean_model))
print(exactRLRT(mean_model, nsim=n_simulations))

### Second test
### H0: weighted mean methylation is independent of age

X$weighted <- scale(X$weighted)
weighted_model <- lmer(weighted ~ (1|subject) + age, data = X, REML=use_reml)
print(summary(weighted_model))
print(exactRLRT(weighted_model, nsim=n_simulations))

### Third test
### H0: fraction methylated is independent of age

X$fractional <- scale(X$fractional)
fractional_model <- lmer(fractional ~ (1|subject) + age, data = X, REML=use_reml)
print(summary(fractional_model))
print(exactRLRT(fractional_model, nsim=n_simulations))
