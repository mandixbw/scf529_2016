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

#explore
data <- data %>% 
  mutate(wgt = X42001/5)

viewme <- data %>% select(Y1, YY1, wgt, X5729)

repwtnames <- names(repweights)
write.csv(repwtnames, file="repwtnames.csv")

# Calculate Income Percentile.  
library(survey)
library(mitools)
library(srvyr)
  
scf_design <- svrepdesign(repweights = starts_with("WT1B"),
                          weights = wgt,
                          data = data,
                          type = "other",
                          scale = 1,
                          rscales = rep( 1 / 998 , 999 ),
                          mse=TRUE,
                          combined.weights = TRUE)

weights = ~wgt , 
repweights = scf_rw[ , -1 ] , 
data = imputationList( scf_imp ) , 
scale = 1 ,
rscales = rep( 1 / 998 , 999 ) ,
mse = TRUE ,
type = "other" ,
combined.weights = TRUE



