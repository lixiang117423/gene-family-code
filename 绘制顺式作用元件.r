rm(list = ls())

source("plotCisElement.r")

p <- plotCisElements(
  data = "../results/cis.element/plantCARE_output_PlantCARE_11359.tab",
  length = 1500, Cis = ""
)

p + guides(fill = guide_legend(ncol = 4))


export::graph2tif(
  file = "../results/cis.element/顺式作用元件.tif",
  width = 12, height = 8, dpi = 500
)
