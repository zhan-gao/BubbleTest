date.stamp <- function(stat, cv, delta = 0.8){
  
  # a "stupid" function to conduct the date-stamp strategy
  dif <- stat - cv
  dif.temp <- cumsum(dif > 0)
  bb.ind <- c(0, dif.temp[-1] - dif.temp[-length(dif.temp)])
  period.min <- floor(delta * log(n))
  
  i <- 1
  stamp = NULL
  while(i < length(bb.ind)){
    if(bb.ind[i] == 1){
      j <- i
      while(j < length(bb.ind)){
        if(bb.ind[j+1] == 1) j <- j + 1
        else break
      }
      if(j - i + 1 >= period.min) stamp <- rbind(stamp, c(i, j))
      i <- j + 1
    }
    else{
      i <- i +1
    }
  }
  return(stamp)
}
