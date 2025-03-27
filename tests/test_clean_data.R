library(testthat)

set.seed(2) 

#test the clean data 
source(here::here("R", "clean_data.R"))

test_df <- tibble(
    animal_type = c("dog", "cat", "reptile", NA),
    animal_name = c("spot", "charlene", "emily", "roger"),
    primary_color = c("black", "brown", "white", NA),
    secondary_color = c("gray", "red", "yellow", "blue"),
    sex = c("Female", "Male", "Neutered", "Spayed"),
    dob = as.Date(c("2013-02-18", "2021-03-15", "2024-10-10","2023-08-16")),
    intake_condition = c("ill mild", "normal", "injured severe", "ill moderate"),
    intake_type = c("stray", "wildlife", "owner surrender", "confiscate"),
    intake_date = as.Date(c("2023-06-01", "2023-09-01", "2024-08-04", "2021-03-07")),
    outcome_date = as.Date(c( "2023-07-01", "2023-10-01", "2024-05-27", "2022-05-19")),
    outcome_type = c("adoption", "foster", "euthanasia", "rescue"), 
  )

cleaned_df <- clean_animal_shelter_data(test_df)

test_that("clean_animal_shelter_data correctly removes NA values", {
  expect_false(any(is.na(cleaned_df)))
})

test_that("clean_animal_shelter_data correctly recategorizes outcome types", {
  expect_equal(cleaned_df$outcome_group[1], "Adopted")
  expect_equal(cleaned_df$outcome_group[2], "Adopted")
  expect_equal(cleaned_df$outcome_group[3], "Not Adopted")
})

test_that("clean_animal_shelter_data makes sure dates are a numeric value", {
  expect_is(cleaned_df$age_at_intake, "numeric")
})

test_that("clean_animal_shelter_data returns correct columns", {
  expected_columns <- c("animal_type", "primary_color", "sex", "dob", "intake_condition", 
                        "intake_type", "intake_date", "outcome_date", "outcome_type", 
                        "outcome_group", "age_at_intake")
  expect_equal(colnames(cleaned_df), expected_columns)
})
