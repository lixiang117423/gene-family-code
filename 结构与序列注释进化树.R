rm(list = ls())

library(ggplot2)
library(ggtree)
library(treeio)

my.tree <- ggtree::read.tree("../results/step.3.seq.and.tree/first.domain.confirmed.nwk")
p.1 <- ggtree(my.tree, branch.length = "none") +
  geom_tiplab(size = 3) +
  geom_hilight(node=124, fill="#921100", alpha=.6)  +
  geom_hilight(node=139, fill="#008000", alpha=.6)  +
  geom_hilight(node= 84, fill="#ff5900", alpha=.6)
p.1

mm = p.1[["data"]] %>% 
  dplyr::filter(isTip == 'TRUE')



ll = data.frame(gene = na.omit(lx$label), m = 1:82, size = 100)


p2 = ggplot(ll) +
  geom_point(aes(x = m, y = gene, size = size))
p2

p.1 %>% aplot::insert_right(p2)





msaplot(p.1, "../results/step.3.seq.and.tree/first.domain.confirmed.MEGA.fas", 
        offset = 3, width = 2) +
  labs(fill = 'Domain\nsequences')

export::graph2pdf(file = '../results/step.3.seq.and.tree/序列比对注释进化树.结构阈.pdf',
                  width = 12, height = 10)
export::graph2tif(file = '../results/step.3.seq.and.tree/序列比对注释进化树.结构阈.tif',
                  width = 12, height = 10, dpi = 500)





p.2 <- ggtree(my.tree, layout = "circular") +
  geom_tiplab(offset = 4, align = TRUE) + 
  xlim(NA, 12)
p.2
msaplot(p.2, "../results/step.3.seq.and.tree/first.domain.confirmed.MEGA.fas", width = 2.5)

export::graph2ppt(file = '../results/step.3.seq.and.tree/序列比对注释进化树.结构阈.圈状.pptx',
                  width = 12, height = 12)

export::graph2pdf(file = '../results/step.3.seq.and.tree/序列比对注释进化树.结构阈.圈状.pdf',
                  width = 8, height = 8)
