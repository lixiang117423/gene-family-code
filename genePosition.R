library(ggplot2)
library(ggrepel)


pos = data.table::fread('../results/gene.structure/pos.txt', header = TRUE) %>% 
  dplyr::mutate(pos = pos/1000000,
                length = length/1000000,
                xmin = chr - 0.1,
                xmax = chr + 0.1,
                ymin = 0,
                ymax = length,
                Chromosome = as.character(chr),
                x.lab = chr + 0.5,
                y.lab = pos + 10)

ggplot() +
  ylim(0, max(pos$length)) +
  xlim(0, max(pos$chr)) +
  labs(x = 'Chromosome', y = 'Position (Mb)') + 
  statebins:::geom_rrect(pos,
                         mapping=aes(xmin = xmin,
                                     xmax = xmax,
                                     ymin = ymin,
                                     ymax = ymax,
                                     fill = Chromosome),  
                                colour = "black") +
  geom_segment(data = pos, 
               aes(x = xmin,
                   xend = xmax,
                   y = pos,
                   yend = pos),
               size = 0.5) +
  geom_text(data = pos, aes(x = x.lab, y = pos, label = id), size = 3) +
  scale_x_continuous(breaks = seq(0,max(pos$chr), 1)) +
  scale_fill_igv() +
  theme_prism() +
  theme(legend.position = 'none')


export::graph2ppt(file = '../results/gene.structure/基因在染色体上的位置.pptx',
                  width = 15, height = 6)

export::graph2tif(file = '../results/gene.structure/基因在染色体上的位置.tif',
                  width = 15, height = 6, dpi = 500)












