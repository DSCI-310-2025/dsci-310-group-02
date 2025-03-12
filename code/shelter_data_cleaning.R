# author: Audra Cornick
# date: 2025-03-11

"This script cleans the longbeach.csv animal shelter data and
recodes the outcome_group column into adopted or not adopted for
our analyses.

Usage: shelter_data_cleaning.R <input_file_path> <output_file_path>
" -> doc


library(tidyverse)
library(docopt)

opt <- docopt(doc)

main <- function(input_file_path, output_file_path) {
  
  # read in data
  animals <- read_csv(input_file_path)
  
  animals <- animals %>% 
    select(animal_type, primary_color, sex, dob, intake_condition, intake_type, intake_date, outcome_date, outcome_type) %>% 
    #filter(animal_type != "other") %>%
    na.omit()
  
  animals$outcome_group <- recode(animals$outcome_type,
                                  "adoption" = "Adopted",
                                  "foster" = "Adopted",
                                  "foster to adopt" = "Adopted",
                                  "homefirst" = "Adopted",
                                  "rescue" = "Adopted",
                                  .default = "Not Adopted"  # Everything else is considered "Not Adopted"
  )
  
  animals$age_at_intake <- as.numeric(difftime(Sys.Date(), animals$dob, units = "days")) / 365
  
  # Write cleaned data to output file
   write_csv(animals, output_file_path)
}

main(opt$input_file_path, opt$output_file_path)