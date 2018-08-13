setwd("C:/Users/Zhan/Dropbox/Global Financial Risk Gauge_180610/BubbleTest")

library(MASS)
library(foreach)
library(stats)

library(MultipleBubbles)
# ==========================================================================

# Process the data and save in RData file

# library(readxl)
# 
# D = read_excel("Weekly_data.xlsx", 
#                sheet = "Sheet2",
#                col_names = TRUE, 
#                na = "#N/A")
# save(D, file = "weekly_data.RData")

# ==========================================================================

# in data fram D
load("weekly_data.RData")
var.name <- colnames(D)[-1]

sadf.gsadf.res <- matrix(0, 2, length(var.name))
colnames(sadf.gsadf.res) <- var.name

bsadf.stat.seq <- badf.stat.seq <- list()

for(ts in var.name){
  
  cat("Computing GSADF and SADF stats for", ts, "\n")
  t0 = Sys.time()
  
  y <-  as.matrix(D[, ts])
  res.stat <- sadf_gsadf(y, adflag = 5, mflag = 1, IC = 2)
  
  sadf.gsadf.res[, ts] = c(res.stat$sadf, res.stat$gsadf)
  bsadf.stat.seq[[ts]] = res.stat$bsadfs
  badf.stat.seq[[ts]] = res.stat$badfs
  
  cat("Time:", Sys.time() - t0, "\n")
  
}

save.image("compute_stat_res.RData")
