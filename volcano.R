library(tidyverse)

deg <- read.csv("./deg.csv")
ggplot(deg, aes(x=log2FoldChange, y=neglog10PAdj, color=significance)) + geom_point()