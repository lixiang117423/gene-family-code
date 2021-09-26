plotGeneStructure <- function(gff, tree = "None") {
  df.gff <- fread(gff, header = FALSE) %>%
    dplyr::mutate(gene.id = "")

  for (i in 1:nrow(df.gff)) {
    str <- stringr::str_split(df.gff$V9[i], ";")[[1]]
    for (j in str) {
      res <- stringr::str_sub(j, 1, 6)

      if (res == "Parent") {
        trans.id <- stringr::str_split(j, "=")[[1]][2]
        df.gff$gene.id[i] <- stringr::str_split(trans.id, "\\.")[[1]][1]
      }
    }
  }

  df.gff <- df.gff %>%
    dplyr::group_by(gene.id) %>%
    dplyr::mutate(
      min = min(min(V4), min(V5)),
      max = max(max(V4), max(V5))
    ) %>%
    dplyr::mutate(
      start = ifelse(V7 == "+", V4 - min, abs(V4 - max)),
      end = ifelse(V7 == "+", V5 - min, abs(V5 - max))
    ) %>%
    dplyr::mutate(length = max - min)

  # 构建顺序
  if (tree == "None") {
    df.num <- data.table(gene.id = unique(df.gff$gene.id))
    df.num$y <- 1:nrow(df.num)
  } else {
    my.tree <- ape::read.tree(file = tree) %>%
      ggtree::ggtree()

    df.num <- my.tree[["data"]] %>%
      dplyr::filter(isTip == "TRUE") %>%
      dplyr::select("label", "y") %>%
      dplyr::rename(gene.id = label)
  }

  df.gff <- merge(df.gff, df.num, by = "gene.id")

  df.gff <- df.gff %>%
    dplyr::mutate(y.min = y - 0.4, y.max = y + 0.4) %>%
    dplyr::arrange(y) %>%
    dplyr::mutate(gene.id = factor(gene.id, levels = unique(gene.id)))

  # 绘图
  df.gff %>%
    dplyr::filter(V3 != "mRNA") %>%
    ggplot() -> p

  if (tree == "None") {
    p <- p +
      geom_segment(aes(
        x = start,
        xend = length,
        y = gene.id,
        yend = gene.id
      ),
      size = 0.8
      )
  } else {
    p <- p +
      geom_segment(aes(
        x = start,
        xend = length,
        y = y,
        yend = y
      ),
      size = 0.8
      )
  }

  p <- p +
    geom_rect(aes(
      xmin = start, xmax = end,
      ymin = y.min, ymax = y.max,
      fill = V3
    )) +
    scale_x_continuous(expand = c(0, 0), breaks = seq(0, max(df.gff$length), 1000)) +
    labs(x = "", y = ifelse(tree == "None", "Gene", "")) +
    theme_classic() +
    theme(legend.title = element_blank()) -> p

  if (tree != "None") {
    p <- p +
      theme(
        axis.ticks.y = element_blank(),
        axis.text.y = element_blank(),
        axis.title.y = element_blank(),
        axis.line.y = element_blank(),
        axis.text.x = element_text(angle = 90, hjust = 0, vjust = 0.5)
      )
  } else {
    p <- p
  }

  return(p)
}