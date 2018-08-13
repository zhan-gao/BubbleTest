setwd("C:/Users/Zhan/Dropbox/Global Financial Risk Gauge_180610/BubbleTest")

library(tidyverse)
library(reshape2)
library(ggplot2)
library(gtable)
library(grid)
library(lubridate)

load("compute_cv_res.RData")
load("compute_stat_res.RData")
source("date_stamp.R")
source("multiplot.R")

series.name = c("SPX", "MXEF", "LUACTRUU", "LF98TRU",	
                "LEGATRUU", "LG30TRUU", "EMUSTRUU",	"BCOM")
dat <- as_date( D$Dates[-(1:(swindow0 - 1))] )
pt = dat[seq(from = 1, to = d, by = (d / 4 - 1) )]

# --------------------------------------------------------------
# Full plot with test statistics and raw data
# S&P 500

# Prepare data
X <-  data.frame(dat, D$`SPX Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`SPX Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
      geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
      geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
      geom_line(aes(y = raw / 250, colour = "The S&P 500 index (right axis)")) +
      scale_y_continuous(limits = c(-2, 12), 
                         sec.axis = sec_axis(~.*250, name = NULL)) + 
      scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
      labs(y = NULL, x = "Date") + 
      ggtitle("SPX Index")

p <- p + theme(
          panel.background =  element_blank(),
          panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
          panel.grid.major = element_line(linetype = 2, color = "grey90"),
          legend.title=element_blank(),
          legend.position = c(0.2, 0.9),
          legend.background = element_rect(fill = "transparent", colour = "transparent"),
          legend.key = element_rect(fill = "transparent", colour = "transparent"),
          plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
        )

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -2, ymax = 12, alpha=.35, fill="yellow")
}

# ----------------------------------------------------------------

# MXEF

# Prepare data
X <-  data.frame(dat, D$`MXEF Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`MXEF Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
  geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
  geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
  geom_line(aes(y = raw / 80, colour = "The MXEF index (right axis)")) +
  scale_y_continuous(limits = c(-2, 16.5), 
                     sec.axis = sec_axis(~.*80, name = NULL)) + 
  scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
  labs(y = NULL, x = "Date") +
  ggtitle("MXEF Index")

p <- p + theme(
  panel.background =  element_blank(),
  panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
  panel.grid.major = element_line(linetype = 2, color = "grey90"),
  legend.title=element_blank(),
  legend.position = c(0.2, 0.9),
  legend.background = element_rect(fill = "transparent", colour = "transparent"),
  legend.key = element_rect(fill = "transparent", colour = "transparent"),
  plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
)

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -2, ymax = 16.5, alpha=.35, fill="yellow")
}


# -----------------------------------------------------------------

# LUACTRUU Index

# Prepare data
X <-  data.frame(dat, D$`LUACTRUU Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`LUACTRUU Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
  geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
  geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
  geom_line(aes(y = raw / 250, colour = "The LUACTRUU Index (right axis)")) +
  scale_y_continuous(limits = c(-3, 12), 
                     sec.axis = sec_axis(~.*250, name = NULL)) + 
  scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
  labs(y = NULL, x = "Date") +
  ggtitle("LUACTRUU Index")

p <- p + theme(
  panel.background =  element_blank(),
  panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
  panel.grid.major = element_line(linetype = 2, color = "grey90"),
  legend.title=element_blank(),
  legend.position = c(0.2, 0.9),
  legend.background = element_rect(fill = "transparent", colour = "transparent"),
  legend.key = element_rect(fill = "transparent", colour = "transparent"),
  plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
)

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -3, ymax = 12, alpha=.35, fill="yellow")
}


# -----------------------------------------------------------------

# LF98TRUU Index

# Prepare data
X <-  data.frame(dat, D$`LF98TRUU Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`LF98TRUU Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
  geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
  geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
  geom_line(aes(y = raw / 125, colour = "The LF98TRUU Index (right axis)")) +
  scale_y_continuous(limits = c(-4, 16), 
                     sec.axis = sec_axis(~.*125, name = NULL)) + 
  scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
  labs(y = NULL, x = "Date") +
  ggtitle("LF98TRUU Index")

p <- p + theme(
  panel.background =  element_blank(),
  panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
  panel.grid.major = element_line(linetype = 2, color = "grey90"),
  legend.title=element_blank(),
  legend.position = c(0.2, 0.9),
  legend.background = element_rect(fill = "transparent", colour = "transparent"),
  legend.key = element_rect(fill = "transparent", colour = "transparent"),
  plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
)

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -4, ymax = 16, alpha=.35, fill="yellow")
}


# ----------------------------------------------------------------
# EMUSTRUU Index

# Prepare data
X <-  data.frame(dat, D$`EMUSTRUU Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`EMUSTRUU Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
  geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
  geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
  geom_line(aes(y = raw / 100, colour = "The EMUSTRUU Index (right axis)")) +
  scale_y_continuous(limits = c(-2, 12), 
                     sec.axis = sec_axis(~.*100, name = NULL)) + 
  scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
  labs(y = NULL, x = "Date") +
  ggtitle("EMUSTRUU Index")

p <- p + theme(
  panel.background =  element_blank(),
  panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
  panel.grid.major = element_line(linetype = 2, color = "grey90"),
  legend.title=element_blank(),
  legend.position = c(0.2, 0.9),
  legend.background = element_rect(fill = "transparent", colour = "transparent"),
  legend.key = element_rect(fill = "transparent", colour = "transparent"),
  plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
)

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -2, ymax = 12, alpha=.35, fill="yellow")
}

# -----------------------------------------------------------------
# BCOM Index

# Prepare data
X <-  data.frame(dat, D$`BCOM Index`[-(1:(swindow0-1))], 
                 bsadf.stat.seq$`BCOM Index`, t(quantile.bsadfs))
colnames(X) <- c("date", "raw", "stat", "cv.90", "cv.95", "cv.99")
X <- mutate(X, diff.90 = stat - cv.90, diff.95 = stat - cv.95, diff.99 = stat - cv.99)

# date-stmap bubble periods
stamps <- date.stamp(X$stat, X$cv.90)

p <- ggplot(data = X, aes(x = date)) +
  geom_line(aes(y = stat, colour = "The backward SADF statistic sequence (left axis)")) +
  geom_line(aes(y = cv.90, colour = "The 90% critical value sequence (left axis)")) +
  geom_line(aes(y = raw / 40, colour = "The BCOM Index (right axis)")) +
  scale_y_continuous(limits = c(-2, 6), 
                     sec.axis = sec_axis(~.*40, name = NULL)) + 
  scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
  labs(y = NULL, x = "Date") +
  ggtitle("BCOM Index")

p <- p + theme(
  panel.background =  element_blank(),
  panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
  panel.grid.major = element_line(linetype = 2, color = "grey90"),
  legend.title=element_blank(),
  legend.position = c(0.2, 0.9),
  legend.background = element_rect(fill = "transparent", colour = "transparent"),
  legend.key = element_rect(fill = "transparent", colour = "transparent"),
  plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
)

for(i in 1:nrow(stamps)){
  p <- p + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                    ymin = -2, ymax = 6, alpha=.35, fill="yellow")
}




# -----------------------------------------------------------------
# The plot of p.diff sample

p.diff <- ggplot(data = X, aes(x = date)) +
            geom_line(aes(y = diff.90), colour =  "navyblue") +
            geom_hline(yintercept = 0, linetype = 2) +
            scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
            labs(y = NULL, x = "Date")

p.diff <- p.diff + theme( panel.background =  element_blank(),
                          panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
                          panel.grid.major = element_line(linetype = 2, color = "grey90"),
                          legend.title=element_blank(),
                          plot.title = element_text(size = 10, hjust = 0.5, face = "bold")
                        )

for(i in 1:nrow(stamps)){
  p.diff <- p.diff + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                              ymin = -2, ymax = 2, alpha=.2, fill="yellow")
}


# -----------------------------------------------------------------
# p.diff combined

bsadf.stat.mat <- as.matrix(as.data.frame(bsadf.stat.seq))
colnames(bsadf.stat.mat) <- series.name
cv <- quantile.bsadfs[3, ]
stat.diff <- bsadf.stat.mat - cv

for(i in 1:8){
  
  name <- series.name[i]
  X <- data.frame(date = dat, var = stat.diff[, i])
  up.lim = max(stat.diff[, i]) + 0.1
  bottom.lim = min(stat.diff[, i]) - 0.1
  
  stamps <- date.stamp(bsadf.stat.mat[, i], cv)
  
  p.diff <- ggplot(data = X, aes(x = date)) +
    geom_line(aes(y = var), colour =  "navyblue") +
    geom_hline(yintercept = 0, linetype = 2) +
    scale_x_date(breaks = pt, labels = c("2000", "2004", "2009", "2013", "2018") ) +
    labs(y = name, x = NULL)
  
  p.diff <- p.diff + theme( panel.background =  element_blank(),
                            panel.border = element_rect(linetype = 1, colour = "black", fill = NA),
                            panel.grid.major = element_line(linetype = 2, color = "grey90"),
                            legend.title=element_blank(),
                            plot.title = element_text(size = 10, hjust = 0.5, face = "bold"),
                            axis.title=element_text(size=10, face="bold")
  )
  
  for(i in 1:nrow(stamps)){
    p.diff <- p.diff + annotate("rect", xmin = dat[stamps[i,1]], xmax = dat[stamps[i,2]], 
                                ymin = bottom.lim, ymax = up.lim, alpha=.2, fill="yellow")
  }
  
  assign(paste0("p.", name), p.diff)
  
}


p <- multiplot(p.SPX, 
               p.MXEF, 
               p.LUACTRUU, 
               p.LF98TRU,
               p.EMUSTRUU,
               p.BCOM, cols = 2)

# -----------------------------------------------------------------
# grid_arrange_shared_legend(p, p.diff, nrow = 2, ncol=1)
# multiplot(p, p.diff, cols = 1)
ggsave("stat_minus_cv", plot = p, device = png, width = 3, height = 3, units = "in")


