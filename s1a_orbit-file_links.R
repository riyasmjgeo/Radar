# To get download link to all Sentinel-1 SAR data orbit file
directory = getwd()
files <- list.files(directory)
for (i in 1:length(files))
{
  fname = files[i]
  starting = substring (fname, 18, 32)
  
  ending = substring (fname, 34, 48)
  
  
  website = paste0("https://qc.sentinel1.eo.esa.int/api/v1/?product_type=AUX_RESORB&validity_stop__gt=", substring(ending, 1,4),"-",substring(ending, 5,6),"-", substring(ending, 7,11), ":", substring(ending, 12,13), ":", substring(ending, 14,15), "&validity_start__lt=",substring(starting, 1,4),"-",substring(starting, 5,6),"-", substring(starting, 7,11), ":", substring(starting, 12,13), ":", substring(starting, 14,15), "&ordering=-creation_date&page_size=1")
  cat(paste0("\n",website,"\n"))
}






