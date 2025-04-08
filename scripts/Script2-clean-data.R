# author: Audra Cornick
# date: 2025-03-11

"This script cleans the longbeach.csv animal shelter data and
recodes the outcome_group column into adopted or not adopted for
our analyses.

Usage: Script2.R --input_file_path=<input_file_path> --output_file_path=<output_file_path>
" -> doc


library(readr)
library(dplyr)
library(docopt)

source(here::here("R", "clean_data.R"))

opt <- docopt(doc)

main <- function(input_file_path, output_file_path) {

  # read in data
  animals <- read_csv(input_file_path)

  # clean data using script
  animals <- clean_animal_shelter_data(animals)

  # save clean data to a csv at the given output path
  write_csv(animals, file = output_file_path)
}

main(opt$input_file_path, opt$output_file_path)