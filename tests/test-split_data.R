#' Data Splitter
#' 
#' Creates two dataframes from a single dataframe, where the proportion
#' of rows from the first to the second dataframe is equal to the input proportion value,
#' as well as ensuring a similar proportion in the values of the 
#' specified stratified variable.
#'
#' @param df A dataframe to be split
#' @param prop The desired train to test ratio as a value between 0 and 1
#' @param strata The name of the variable within df to stratify by
#' @param seed value used to control randomness. same seed values will produce same results
#'
#' @return Two dataframes, the first containing the data to be used for training
#' and the other containing data to be used for testing
#'
#' @export
#' @examples
#' data_split(countries_df, 0.8, continent)
data_split <- function(df, prop, strata, seed) {
    #splits dataframe into train and test dataframes
}

library(testthat)
source("R/split_data.R")

test_that("split_data should return two dataframes with sizes in proportion
to each other equal to prop", {
    expect_equal(c(nrow(split_data(test_frame, 0.6, 'index', 1)[[1]]),
    nrow(split_data(test_frame, 0.6, 'index', 1)[[2]])), c(60,40))
    expect_equal(c(nrow(split_data(test_frame, 0.7, 'index', 1)[[1]]),
    nrow(split_data(test_frame, 0.7, 'index', 1)[[2]])), c(68,32))
    expect_equal(c(nrow(split_data(test_frame, 0.8, 'index', 1)[[1]]),
    nrow(split_data(test_frame, 0.8, 'index', 1)[[2]])), c(80,20))
    expect_equal(c(nrow(split_data(test_frame, 0.9, 'index', 1)[[1]]),
    nrow(split_data(test_frame, 0.9, 'index', 1)[[2]])), c(88,12))
})

test_that("Running the function on the same data twice with the same seed
will give the same split", {
    expect_equal(split_data(test_frame, 0.7, "index", 12), split_data(test_frame, 0.7, "index", 12))
    expect_equal(split_data(test_frame, 0.7, "index", 46), split_data(test_frame, 0.7, "index", 46))
    expect_equal(split_data(test_frame, 0.7, "index", 3), split_data(test_frame, 0.7, "index", 3))
    expect_equal(split_data(test_frame, 0.7, "index", 132), split_data(test_frame, 0.7, "index", 132))
})

test_that("Each dataframe returned by the function will have an equal proportion
of positive and negative values of the stratified variable", {
    expect_equal(sum(rowSums(strata_prop1 == TRUE))/nrow(strata_prop1), 0.5)
    expect_equal(sum(rowSums(strata_prop2 == TRUE))/nrow(strata_prop2), 0.5)
    expect_equal(sum(rowSums(strata_prop3 == TRUE))/nrow(strata_prop3), 0.5)
    expect_equal(sum(rowSums(strata_prop4 == TRUE))/nrow(strata_prop4), 0.5)
})