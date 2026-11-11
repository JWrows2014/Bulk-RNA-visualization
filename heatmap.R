library(pheatmap)

# Rows are genes; columns are samples.
expression <- read.csv("normalized_expression.csv", row.names = 1,
                       check.names = FALSE)
expression_matrix <- as.matrix(expression)

# Constant genes cannot be scaled to row z-scores.
variable_genes <- apply(expression_matrix, 1, sd) > 0
expression_matrix <- expression_matrix[variable_genes, , drop = FALSE]

sample_annotation <- data.frame(
  Group = sub("_[0-9]+$", "", colnames(expression_matrix)),
  row.names = colnames(expression_matrix)
)

# Compute per-gene z-scores directly from normalized expression, without logging.
pheatmap(
  expression_matrix,
  scale = "row",
  cluster_rows = TRUE,
  cluster_cols = TRUE,
  clustering_distance_rows = "euclidean",
  clustering_distance_cols = "euclidean",
  clustering_method = "complete",
  annotation_col = sample_annotation,
  main = "Gene expression clustering (row z-scores of normalized expression)",
  filename = "heatmap.png",
  width = 10,
  height = 7
)
