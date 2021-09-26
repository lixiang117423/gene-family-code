rm(list = ls())

library(tidyverse)

df.step.12 = data.table::fread('../results/step.12.uniqueID.txt', header = FALSE)

df.not.in.smart = data.table::fread('../results/step.13.not.in.SMART.txt', header = FALSE)

df.step.12[!(df.step.12$V1 %in% df.not.in.smart$V1),] %>% 
  write.table(file = '../results/step.13..in.SMART.txt', row.names = FALSE, quote = FALSE)
  
