library(ggplot2)
library(rlang)

make_barplot <- function(dataset, x, x_name, class, class_name){
  # Check if dataset is a data frame
  if (is.null(dataset) || !is.data.frame(dataset)) {
    stop("Error: The dataset must be a data frame.")
  }
  
  # Check if x and class columns exist in the dataset
  if (!(x %in% names(dataset))) {
    stop(paste("Error: The column", x, "does not exist in the dataset."))
  }
  
  if (!(class %in% names(dataset))) {
    stop(paste("Error: The column", class, "does not exist in the dataset."))
  }
  
  # Check if x and class are categorical (either character or factor)
  if (!is.character(dataset[[x]]) && !is.factor(dataset[[x]])) {
    stop(paste("Error: The column", x, "must be a character or factor column (categorical variable)."))
  }
  
  if (!is.character(dataset[[class]]) && !is.factor(dataset[[class]])) {
    stop(paste("Error: The column", class, "must be a character or factor column (categorical variable)."))
  }
  
  figure <- ggplot(dataset, aes(x = !!sym(x), fill = !!sym(class))) + 
    geom_bar(position = "fill") + 
    labs(x = x_name,
         y = class_name) + 
    theme_minimal() + 
    scale_y_continuous(labels = scales::percent) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
    return(figure)
}
