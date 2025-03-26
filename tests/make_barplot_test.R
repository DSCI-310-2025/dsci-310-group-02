library(testthat)
library(ggplot2)
library(rlang)


source("make-barplot.R") 

# Create a mock dataset for testing
test_data <- data.frame(
  category = rep(c("A", "B", "C"), each = 10),
  outcome = rep(c("X", "Y"), 15)
)


# Expected output: One barplot with the correct categories and proportions.
expected_plot <- ggplot(test_data, aes(x = category, fill = outcome)) +
  geom_bar(position = "fill") + 
  labs(x = "Category", y = "Outcome Proportion") +
  theme_minimal() +
  scale_y_continuous(labels = scales::percent) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# tests for valid inputs
test_that("Valid input - make_barplot() works as expected", {
  figure <- make_barplot(test_data, "category", "Category", "outcome", "Proportion")
  
  # Check if the output is a ggplot object
  expect_s3_class(figure, "gg")
})

# tests for edges cases
test_that("Edge case - Dataset with only one data point", {
  test_data_single <- data.frame(category = "A", outcome = "X")
  
  figure_single <- make_barplot(test_data_single, "category", "Category", "outcome", "Proportion")
  
  # Check if the plot has one bar (should be a valid plot)
  expect_s3_class(figure_single, "gg")
})

test_that("Edge case - Dataset with all zero values", {
  test_data_zero <- data.frame(category = c("A", "B", "C"), outcome = c("X", "Y", "Z"))
  
  figure_zero <- make_barplot(test_data_zero, "category", "Category", "outcome", "Proportion")
  
  # Check if the plot is valid
  expect_s3_class(figure_zero, "gg")
})

test_that("Edge case - Dataset with duplicate x-axis values", {
  test_data_duplicates <- data.frame(category = c("A", "A", "B", "B", "C", "C"), outcome = c("X"," X", "Y", "Y", "X", "X"))
  
  figure_duplicates <- make_barplot(test_data_duplicates, "category", "Category", "outcome", "Proportion")
  
  # Check if the plot is valid
  expect_s3_class(figure_duplicates, "gg")
})


# tests for data structure
test_that("Invalid data - throws an error when numeric values are in the y-axis column", {
  test_data_invalid <- data.frame(category = c("A", "B", "C"), outcome = c(5, 10, 15))
  
  expect_error(make_barplot(test_data_invalid, "category", "Category", "outcome", "Proportion"))
})

test_that("Missing argument - throws an error when dataset is missing", {
  expect_error(make_barplot(NULL, "category", "Category", "value", "Proportion"))
})
test_that("Missing argument - throws an error when x is missing", {
  expect_error(make_barplot(test_data, NULL, "Category", "value", "Proportion"))
})

test_that("Handles unexpected errors gracefully", {
  expect_error(make_barplot(test_data, "category", "Category", "nonexistent_column", "Proportion"))
})


# Tests the barplot generates properly
test_that("make_barplot returns a ggplot object", {
  plot <- make_barplot(test_data, "category", "Category", "outcome", "Outcome Proportion")
  expect_s3_class(plot, "ggplot")
})

test_that("make_barplot correctly sets axis labels", {
  plot <- make_barplot(test_data, "category", "Category", "outcome", "Outcome Proportion")
  expect_equal(plot$labels$x, "Category")
  expect_equal(plot$labels$y, "Outcome Proportion")
})

test_that("make_barplot correctly applies fill aesthetic", {
  plot <- make_barplot(test_data, "category", "Category", "outcome", "Outcome Proportion")
  expect_true("fill" %in% names(plot$mapping))
  expect_equal(rlang::as_name(plot$mapping$fill), "outcome")
})

