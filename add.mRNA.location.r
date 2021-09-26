rm(list = ls())

library(tidyverse)

df <- data.table::fread("SPI_r1.1.pmol.gene.gff", header = FALSE) %>%
  dplyr::mutate(temp = stringr::str_replace(V9, ":.*", ""))


df.mran <- df %>%
  dplyr::filter(V3 == "CDS") %>% 
  dplyr::group_by(temp) %>% 
  dplyr::mutate(start = min(V4),end = max(V5)) %>% 
  dplyr::mutate(V3 = 'mRNA') %>% 
  dplyr::mutate(V4 = start, V5 = end) %>% 
  dplyr::select(-start, -end) %>% 
  dplyr::select(V1,temp,V4,V5)

df.mran = df.mran[!duplicated(df.mran$temp),]
  
write.table(df.mran,file = 'step.24.allmRNA.gff', 
            sep = '\t',row.names = FALSE, quote = FALSE)
  
  
  
  
  

new.gff = rbind(df, df.cds) %>% 
  dplyr::select(-temp)

write.table(new.gff, file = 'new.gff.with.mrna.gff', 
            sep = '\t',row.names = FALSE, quote = FALSE)


df.cds %>% 
  dplyr::select(temp) %>% 
  dplyr::group_by(temp) %>% 
  dplyr::distinct(temp) %>% 
  write.table(file = 'step.24.allmRNA.txt', row.names = FALSE, quote = FALSE)
