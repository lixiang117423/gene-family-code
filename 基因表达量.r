rm(list = ls())

gene.id = fread('../results/first.domain.search/uniqueID.txt', header = FALSE) %>% 
  dplyr::mutate(id = stringr::str_sub(V1, 1, 12))

gene.expr = fread('../data/fpkm.txt') %>% 
  dplyr::filter(V1 %in% gene.id$Vid)


gene.expr %>% 
  dplyr::select(-1) %>% 
  pheatmap:::scale_rows() %>% 
  dplyr::filter(SRR4067802 != 'NaN') -> lx 

ComplexHeatmap::pheatmap(as.matrix(lx))
