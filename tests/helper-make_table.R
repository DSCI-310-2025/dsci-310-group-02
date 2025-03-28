#Author: Nolan

library(dplyr)
source(here::here("R", "make_table.R"))

col <- list("a", "a")
test_data1 <- tibble(class_labels = character(0), values = double(0))
test_data2 <- data.frame(col1 = unlist(list(1, 1)))
test_data3 <- data.frame(col1 = unlist(list(1, 2)), col2 = unlist(list(2, 3)))

make_table(test_data1, ".", "make_table_test_data1.csv")
make_table(test_data2, ".", "make_table_test_data2.csv")
make_table(test_data3, ".", "make_table_test_data3.csv")
