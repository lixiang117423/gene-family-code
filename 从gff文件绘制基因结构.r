rm(list = ls())

library(aplot)

source("plotGeneStructure.R")

# 绘制基因结构图
p <- plotGeneStructure(
  gff = "../results/gene.structure/gene.exon.info.gff",
  tree = "../results/seq.and.tree/new.tree.nwk"
)

p + labs(y = "")

# 绘制进化树
tree <- ape::read.tree("../results/seq.and.tree/new.tree.nwk")

as_tibble(tree) %>%
  dplyr::select(4) %>%
  dplyr::mutate(Chromosome = stringr::str_sub(label, 4, 5)) %>%
  na.omit() -> gene.chromo

gene.chromo.info <- split(gene.chromo$label, gene.chromo$Chromosome)


p2 <- ggtree(tree) %<+% gene.chromo +
  geom_tippoint(aes(color = Chromosome), size = 3) +
  geom_tiplab() +
  scale_color_igv()
p2

if (F) {
  p3 <- groupOTU(p2, gene.chromo.info, "Chromosome") +
    aes(color = Chromosome) +
    scale_color_igv() +
    theme(legend.position = "right")

  p3
}

# 连接进化树和基因结构
p2 %>% insert_right(p, width = 0.8)

export::graph2tif(file = '../results/gene.structure/基因结构与进化树.tif',
                  width = 12, height = 8, dpi = 500)

export::graph2pdf(file = '../results/gene.structure/基因结构与进化树.pdf',
                  width = 12, height = 8)







