rm(list = ls())

library(tidyverse)
library(ggtree)

my.tree = ggtree::read.tree('../results/step.3.seq.and.tree/first.domain.confirmed.nwk')

df.fasta = ape::read.dna('../results/step.3.seq.and.tree/first.domain.confirmed.MEGA.fas',
                         format = 'fasta')

p = ggtree(my.tree, branch.length='none',layout = 'circular') +
  #geom_label(aes(x=branch, label=node)) +
  geom_tiplab() +
  geom_hilight(node=124, fill="#921100", alpha=.8)  +
  geom_hilight(node=139, fill="#008000", alpha=.8)  +
  #geom_hilight(node=122, fill="#804000", alpha=.8)  +
  #geom_hilight(node=113, fill="#ffa74f", alpha=.8)  +
  geom_hilight(node= 84, fill="#ff5900", alpha=.8)  +
  theme()
p


ggtree::msaplot(p, df.fasta, offset = 3, width = 2)


export::graph2ppt(p, file = '../results/step.3.seq.and.tree/tree.pptx')


tree <- read.tree("data/tree.nwk")
p <- ggtree(tree) + geom_tiplab(size=3)
msaplot(p, "data/sequence.fasta", offset=3, width=2)
p <- ggtree(tree, layout='circular') + 
  geom_tiplab(offset=4, align=TRUE) + xlim(NA, 12)
msaplot(p, "data/sequence.fasta", window=c(120, 200))