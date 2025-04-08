# Author: Nolan

library(readr)
library(testthat)

test_output1 <- read_csv("make_table_test_data1.csv")
test_output2 <- read_csv("make_table_test_data2.csv")
test_output3 <- read_csv("make_table_test_data3.csv")

test_that("a csv file exists when no data is input, the csv has no data in it",
          {
            expect_equal(1, ncol(test_output1))
          })

test_that("a csv file exists when 1 data column is input,
           the csv has the correct data in it",
          {
            expect_equal(2, ncol(test_output2))
            expect_equal(1, test_output2$col1)
            expect_equal(2, test_output2$Freq)
          })
test_that("a csv file exists when 2 data columns are input,
           the csv file has the correct data in it",
          {
            expect_equal(3, ncol(test_output3))
            expect_equal(c(1, 2, 1, 2), test_output3$col1)
            expect_equal(c(2, 2, 3, 3), test_output3$col2)
            expect_equal(c(1, 0, 0, 1), test_output3$Freq)
          })

test_that("the function throws an error when the folder doesn't currently exist",
          {
            expect_error(make_table(list(1, 2), "does-not-exist",
                                    "error_test_table"))
          })