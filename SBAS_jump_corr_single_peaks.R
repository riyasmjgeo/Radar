library(h5)
file <- h5file("c:/Work/SBAS_stacks/ASC/NSBAS-PARAMS.h5", mode = "r")
ts <- readDataSet(file["/rawts"])
ts = ts[, (1:100), (1:100)]

######## Correction of single date errors #########
for (rows in 1:(length(ts[1, ,1])))
{
  print(rows)
  for (cols in 1:length(ts[1,1, ]))
  {
    ts_sub <- ts[, rows, cols]
    dates <- length(ts_sub)
    std_dev <- sd(ts_sub, na.rm = TRUE)
    i <- 0
    for (i in 3:(dates - 1))
    {
      if (is.nan(ts_sub[i]) == FALSE && is.nan(ts_sub[i - 1]) == FALSE && is.nan(ts_sub[i + 1]) == FALSE) {
        gap1 <- abs(ts_sub[i] - ts_sub[i - 1])
        gap2 <- abs(ts_sub[i] - ts_sub[i + 1])
        if (gap1 > (2 * std_dev) && gap2 > (2 * std_dev)) {
          ts [i, rows, cols] <- NaN
        }
        
      }
    }
  }
}
rm(std_dev, i, rows, cols)
######## Correction of single date errors #########

for (rows in 1:(length(ts[1, ,1])))
{
  print (rows)
  for (cols in 1:length(ts[1,1, ]))
  {
    ts_sub = ts[,rows , cols]
    dates = length(ts_sub)
    std_dev = sd(ts_sub, na.rm = TRUE)
    i = 0
    for (i in 3: (dates-1))
    {
      if (is.nan(ts_sub[i]) == FALSE && is.nan(ts_sub[i-1]) == FALSE)
      {
        gap1 = ts_sub[i] - ts_sub[i-1]
        if (abs(gap1) > (2*std_dev)) 
        {
          mean_1 = mean(ts_sub[1:i-1], na.rm = TRUE)
          mean_2 = mean(ts_sub[i:length(ts_sub)], na.rm = TRUE)
          mean_diff = mean_1 - mean_2
          if (mean_diff > (2*std_dev))
          {
            for (image_no in 1: length(ts_sub))
            {
              ts[image_no,rows, cols] = ts[image_no,rows, cols] - (mean_diff) ### Assign sign
            }
            print (paste0("img = ",i, "   row = ", rows, "   Col = ", cols))
          }
        }
      }
    }
  }
}
rm (std_dev, i, rows, cols)
