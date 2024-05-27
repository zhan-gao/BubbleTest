date.stamp <- function(stat, cv, delta = 0.8){
  
    # Calculate the difference and identify periods where stat is greater than cv
    dif <- stat > cv
    
    # Identify changes in the status of dif to find beginnings and ends of periods
    changes <- which(diff(c(FALSE, dif, FALSE)) != 0)
    starts <- changes[seq(1, length(changes), by = 2)]
    ends <- changes[seq(2, length(changes), by = 2)] - 1
    
    # Calculate the minimum period length based on the total number of observations
    period.min <- floor(delta * log(length(stat)))
    
    # Filter periods by minimum length
    valid <- (ends - starts + 1) >= period.min
    stamp <- cbind(starts[valid], ends[valid])
    
    return(stamp)
}
