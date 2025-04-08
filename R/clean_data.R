library(tidyverse)
library(readr)
library(dplyr)
library(docopt)

# cleaning a dataset

clean_animal_shelter_data <- function(df) {
  # Select only relevant columns
    df <- df %>% 
        select(animal_type, primary_color, sex, dob, intake_condition, intake_type, intake_date, outcome_date, outcome_type) %>% 
        na.omit()

    df$outcome_group <- recode(df$outcome_type,
                             "adoption" = "Adopted",
                             "foster" = "Adopted",
                             "foster to adopt" = "Adopted",
                             "homefirst" = "Adopted",
                             "rescue" = "Adopted",
                             "euthanasia" = "Not Adopted",
                             .default = "Not Adopted")
  
# convert dob column to age column
df$age_at_intake <- as.numeric(difftime(Sys.Date(), df$dob, units = "days")) / 365

return(df)
}

main <- function(input_file_path, output_file_path) {
  animals <- read_csv(input_file_path)
  cleaned_animals <- clean_animals_data(animals)
  write_csv(cleaned_animals, output_file_path)
}