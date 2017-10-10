library(tidyverse)



if (!(file.exists("scf2016.rda"))) {
  #load haven library to read SAS Files
  library(haven)
  
  #read in SAS data files for the data set and the replicate weights
  data <- read_xpt("scf2016x")
  repweights <- read_xpt("scf2016rw1x")
  
  data <- left_join(data, repweights, by = "YY1") %>% 
    select(-Y1.y) %>% 
    rename(Y1=Y1.x)
  
  #cache out file to .rda
  save(data,
       file = "scf2016.rda") 
} else {
  load("scf2016.rda")
}

# Calculate Income Percentile.  

library(survey)
library(mitools)
library(srvyr)

scf_design <- svrepdesign()



