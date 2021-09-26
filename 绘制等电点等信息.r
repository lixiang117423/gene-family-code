rm(list = ls())

df <- data.table::fread("绘图用.txt", header = TRUE) %>% 
  dplyr::arrange(length) %>% 
  dplyr::mutate(id = factor(id, levels = unique(id)))

ggplot(df) +
  geom_bar(aes(x = length, y = id),
    stat = "identity", width = 0.8, fill = "#ff5900"
  ) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 800, 100)) +
  labs(x = "Protein sequence length", y = "Gene") +
  theme_bw() -> p1

p1

ggplot(df) +
  geom_bar(aes(x = `MW(Da)`, y = id),
    stat = "identity", width = 0.8, fill = "#0d0dbb"
  ) +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 80000, 10000)) +
  theme_bw() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) -> p2

p2

ggplot(df) +
  geom_bar(aes(x = pI, y = id),
    stat = "identity", width = 0.8, fill = "#c5199e"
  ) +
  geom_vline(xintercept = 11, color = 'white') +
  scale_x_continuous(expand = c(0, 0), breaks = seq(0, 12, 2)) +
  labs(x = "PI") +
  theme_bw() +
  theme(
    axis.title.y = element_blank(),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank()
  ) -> p3

p3


p1 %>%
  aplot::insert_right(p2) %>%
  aplot::insert_right(p3)


export::graph2tif(file = '蛋白长度等信息.tif',
                  width = 12, height = 8, dpi = 500)















