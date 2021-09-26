rm(list = ls())

library(XML)
library(tidyverse)
library(ggplot2)
library(gggenes)
library(ggsci)
library(ggmotif)

# 从xml文件提取信息
xml.inf <- ggmotif::getMotifFromXML("../results/meme.res/meme.xml") %>%
  dplyr::mutate(motif_id = factor(motif_id, levels = paste0("motif_", 1:10))) %>%
  dplyr::mutate(input.seq.id = stringr::str_sub(input.seq.id, 1, 12))

motif_plot <- motif_location(data = xml.inf) +
  scale_fill_aaas() +
  labs(x = "Position", y = "Gene")

motif_plot

export::graph2tif(
  file = "../results/meme.res/motif位置.tif",
  width = 12, height = 8, dpi = 500
)

# 从txt文件提取信息
txt.inf <- ggmotif::getMotifFromTxt("../results/meme.res/meme.txt")

dir.create("../results/meme.res/motif.seq.log")

for (i in unique(txt.inf$motif.num)) {
  p <- txt.inf %>%
    dplyr::filter(motif.num == i) %>%
    dplyr::select(input.seq.motif) %>%
    ggseqlogo::ggseqlogo() +
    scale_y_continuous(expand = c(0, 0)) +
    theme_classic()

  export::graph2tif(p,
    file = paste0(
      "../results/meme.res/motif.seq.log/motif.",
      i,
      "seq.logo.tif"
    ),
    width = 8, height = 5, dpi = 500
  )
}
