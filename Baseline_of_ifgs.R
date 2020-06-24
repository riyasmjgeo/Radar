# To get the list and details of interferograms in a folder in csv format

# list folders
directory = getwd()
op_file = paste0(directory, "/op_ifgs.csv")
files <- list.files(directory)
count <- length (files)

# Output CSV specifications
tab = matrix(byrow = TRUE, ncol=3, nrow = count)
colnames(tab) = c("Master","Slave", "Baseline")

# Looping through each folder
for (i in 1:length(files))
{
  fname = files[i]
  proc_path = paste0(directory,"/",fname,"/topsProc.xml")
  proc = readLines(proc_path)
  
  ############# IW-1 ############
  #Perp_baseline_first burst
  iw1_first_line = proc [65] 
  var1 = strsplit(iw1_first_line, ">")
  var1 = var1[[1]]
  var1 = var1[2]
  var1 = strsplit(var1, "<")
  var1 = var1[[1]]
  iw1_first = as.numeric(var1[1])
  
  #Perp_baseline_last burst
  iw1_last_line = proc [67] 
  var2 = strsplit(iw1_last_line, ">")
  var2 = var2[[1]]
  var2 = var2[2]
  var2 = strsplit(var2, "<")
  var2 = var2[[1]]
  iw1_last = as.numeric(var2[1])
  
  
  ############# IW-2 ##########
  #Perp_baseline_first burst
  iw2_first_line = proc [76] 
  var3 = strsplit(iw2_first_line, ">")
  var3 = var3[[1]]
  var3 = var3[2]
  var3 = strsplit(var3, "<")
  var3 = var3[[1]]
  iw2_first = as.numeric(var3[1])
  
  #Perp_baseline_last burst
  iw2_last_line = proc [78] 
  var4 = strsplit(iw2_last_line, ">")
  var4 = var4[[1]]
  var4 = var4[2]
  var4 = strsplit(var4, "<")
  var4 = var4[[1]]
  iw2_last = as.numeric(var4[1])
  
  ############# IW-3 ##########
  #Perp_baseline_first burst
  iw3_first_line = proc [87] 
  var5 = strsplit(iw3_first_line, ">")
  var5 = var5[[1]]
  var5 = var5[2]
  var5 = strsplit(var5, "<")
  var5 = var5[[1]]
  iw3_first = as.numeric(var5[1])
  
  #Perp_baseline_last burst
  iw3_last_line = proc [89] 
  var6 = strsplit(iw3_last_line, ">")
  var6 = var6[[1]]
  var6 = var6[2]
  var6 = strsplit(var6, "<")
  var6 = var6[[1]]
  iw3_last = as.numeric(var6[1])
  
  # Perpendicular baseline
  baseline = (iw1_first + iw1_last + iw2_first + iw2_last + iw3_first + iw3_last)/6
  
  # master and slave names. Folder names should be like 20090127_20091230
  master = substring (fname, 0,8)
  slave = substring (fname, 10,18)
  
  #preparing and exporting the table
  tab [i,] = c (master,slave,baseline)
}
write.table(tab,file = op_file)