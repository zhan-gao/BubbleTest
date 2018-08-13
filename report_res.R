library(lubridate)
library(tidyverse)

# Conduct summary statistics computation and report results
# Convert weekly results to quarterly frequency

load("compute_cv_res.RData")
load("compute_stat_res.RData")

# Convert the result list to a matrix
bsadf.stat.seq.mat <- NULL
for(i in 1:8){
  bsadf.stat.seq.mat <- cbind(bsadf.stat.seq.mat, bsadf.stat.seq[[i]])
}
colnames(bsadf.stat.seq.mat) <- names(bsadf.stat.seq)

stat.minus.cv.90 <- bsadf.stat.seq.mat - as.numeric(quantile.bsadfs[1, ])
colnames(stat.minus.cv.90) <- paste0(colnames(bsadf.stat.seq.mat), 
                                     "_stat_minus_cv_90")
stat.minus.cv.95 <- bsadf.stat.seq.mat - as.numeric(quantile.bsadfs[2, ])
colnames(stat.minus.cv.95) <- paste0(colnames(bsadf.stat.seq.mat), 
                                     "_stat_minus_cv_95")
stat.minus.cv.99 <- bsadf.stat.seq.mat - as.numeric(quantile.bsadfs[3, ])
colnames(stat.minus.cv.99) <- paste0(colnames(bsadf.stat.seq.mat), 
                                     "_stat_minus_cv_99")

# Construct tibble data frame
Date <-  D$Dates[-(1:(swindow0 - 1))]
cv <- t(quantile.bsadfs)
colnames(cv) <- paste0("cri.value.", colnames(cv))
stat.df <- as_tibble(cbind.data.frame(Date, cv, bsadf.stat.seq.mat,
                                      stat.minus.cv.90, stat.minus.cv.95, 
                                      stat.minus.cv.99))
stat.df <- mutate(stat.df,
                 year = year(as_date(Date)),
                 quarter = quarter(as_date(Date)))

write.csv(stat.df, file = "res_sum_weekly.csv")

# Compute quarterly mean

quarterly.res <- NULL
for(yr in 2000:2018){
  for(qt in 1:4){
    
    if(yr == 2000 && qt == 1){
      next
    }
    else if(yr == 2018 && qt == 4){
      next
    }else{
      
    }
    print(c(yr, qt))
    stat.df.this.qt <- select( filter(stat.df, year == yr, quarter == qt), 
                               year, quarter, colnames(stat.minus.cv.90),
                               colnames(stat.minus.cv.95), colnames(stat.minus.cv.99))
    quarterly.res <- rbind(quarterly.res, colMeans(stat.df.this.qt))
     
  }
}
write.csv(quarterly.res, file = "res_sum_quarterly_avg.csv")

