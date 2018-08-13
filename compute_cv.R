# Construct the critical value sequence

# install.packages("MultipleBubbles")

library(MASS)
library(foreach)
library(stats)

library(doParallel)
library(MultipleBubbles)

core = 10
registerDoParallel(core)

m <- 2000 # number of replications
n <- 1019
r0 <- 0.01 + 1.8 / sqrt(n)
swindow0 <- floor(n*r0)
d <- n - swindow0 + 1

bsadf.stat <-  foreach(p = 1:core, .combine = 'rbind') %dopar% {
  MultipleBubbles::bsadf(m/core, n)$values
}

qe <- c(0.9, 0.95, 0.99)
quantile.bsadfs <- matrix(NA, nrow = length(qe), ncol = ncol(bsadf.stat))

for(i in 1:ncol(bsadf.stat)){
  quantile.bsadfs[, i] <- quantile(bsadf.stat[,i], qe, na.rm = T)
}

rownames(quantile.bsadfs) <- as.character(qe)

save.image(file = "compute_cv_res.RData")

