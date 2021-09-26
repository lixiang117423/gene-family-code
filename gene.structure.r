rm(list = ls())

library(ggplot2)
library(gggenes)
library(ggsci)

my.gene <- data.table::fread("../results/step.21.gene_exon_info.gff", header = FALSE) %>%
  dplyr::select(c(1, 3:5)) %>%
  dplyr::rename(Genes = V1, Position = V3, start = V4, end = V5) %>% 
  dplyr::filter(Position == 'CDS')

my.gene %>%  
  dplyr::filter(Genes %in% unique(my.gene$Genes)[1:50]) %>% 
  ggplot(
  aes(xmin = start, xmax = end, y = Genes, fill = Position)
) +
  geom_gene_arrow() +
  facet_wrap(~Genes, scales = "free", ncol = 1) +
  scale_fill_aaas() +
  theme_genes() -> p

ggplot2::ggsave(p, file = "../results/step.21.gene.structure.tiff", 
                width = 10, height = 20, dpi = 300)
