## plot_correlations.R: plots the hierarchical clustering of samples
## using 1 - Pearson correlation as distance metric
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

args <- commandArgs(trailingOnly=TRUE)

if (length(args) != 2) {
    stop("Provide two filenames, the input (10kb data frame) and the output (PDF filename)", call.=FALSE)
}

input_filename <- args[1]
output_filename <- args[2]

X <- read.table(input_filename, header=TRUE, row.names=1)
the_dist <- as.dist(1 - cor(X))

pdf(output_filename, width = 12, height = 5)
plot(hclust(the_dist, method = 'complete'),
     xlab = 'sample', ylab = '1 - Pearson Correlation')
dev.off()
