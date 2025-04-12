# author: Rowan Murphy
# date: 2025-03-11

"This script takes the cleaned data file from Script3.R and saves EDA charts and
tables produced from this file
Usage: Script3.R --path_data=<path_data> --folder=<folder> 
    --name1=<name1> 
    --name2=<name2> 
    --name3=<name3> 
    --name4=<name4> 
    --name5=<name5> 
    --name6=<name6> 
    --name7=<name7> 
    --name8=<name8>
" -> doc

library(docopt)
library(dplyr)
library(ggplot2)
library(readr)

library(animalshelterdataanalysis)

library(pointblank)


opt <- docopt(doc)

main <- function(path_data, folder,
                 name1, name2, name3, name4, name5, name6, name7, name8) {

    #read in cleaned data
    animals <- read_csv(path_data)

    # before doing analysis, we perform data validation

    # establish acceptable values for categorical variables
    condition_set = c("ill mild", "injured  severe", "normal", "under age/weight", "aged", "injured  mild", "feral",
    "fractious", "behavior  severe", "ill severe", "ill moderatete", "injured  moderate", "i/i report",
    "behavior  moderate", "welfare seizures","behavior  mild", "intakeexam")
    outcome_set = c("euthanasia", "rescue", "adoption", "transfer", "died", "return to owner", "shelter, neuter, return", "return to rescue",
    "transport", "community cat", "homefirst", "missing", "return to wild habitat", "foster to adopt", "duplicate",
    "foster","trap, neuter, release", "disposal")
    intake_set = c("stray", "wildlife", "owner surrender", "safe keep", "confiscate", "welfare seized", "return", 
    "quarantine", "euthenasia required","trap, neuter, return", "adopted animal return", "foster")
    outcome_group_set = c("Adopted", "Not Adopted")

    # Check correct data file format
    "data.frame" %in% class(animals)

    animals |>
    # Check for missingness and empty observations
        col_vals_not_null(vars('intake_condition', 'outcome_type', 'intake_type', 'outcome_group','age_at_intake')) |>
    # Check for correct column names
        col_exists(vars('intake_condition', 'outcome_type', 'intake_type', 'outcome_group', 'age_at_intake')) |>
    # Check for correct data types
        col_is_character(c('intake_condition', 'outcome_type', 'intake_type', 'outcome_group')) |>
        col_is_numeric('age_at_intake') |>
    # Check for outlier/anomalous values
        col_vals_lt(columns = 'age_at_intake', value = 40, actions = action_levels(warn_at = 1)) |>
        col_vals_gt(columns = 'age_at_intake', value = 0, actions = action_levels(warn_at = 1)) |>
    # One invalid observation at row 14632
    # Check for correct category levels
        col_vals_in_set(columns = 'intake_condition', set = condition_set) |>
        col_vals_in_set(columns = 'outcome_type', set = outcome_set) |>
        col_vals_in_set(columns = 'intake_type', set = intake_set) |>
        col_vals_in_set(columns = 'outcome_group', set = outcome_group_set) |>
    # Check for duplicate observations
        rows_distinct(actions = action_levels(warn_at = 100))
    # 2761 duplicate rows found

    # Remove outliers and duplicate rows
    animals = animals[-c(14632), ]

    animals = distinct(animals)

    #create and save a table about the outcome group variable
    make_table(animals$outcome_group, folder, name1)

    #create and save a table about the outcome type variable
    make_table(animals$outcome_type, folder, name2)

    #create and save a table about the intake condition variable
    make_table(animals$intake_condition, folder, name3)

    #create and save the first graph
    figure_1 <- make_barplot(animals, "animal_type", "Animal Type", "outcome_type", "Proportion")
    
    ggsave(filename=name4, path=folder)

    #create and save the second graph
    figure_2 <- make_barplot(animals, "animal_type", "Animal Type", "outcome_group", "Proportion")
    
    ggsave(filename=name5, path=folder)

    #create and save the third graph
    figure_3 <- make_barplot(animals, "intake_condition", "Intake Condition", "outcome_type", "Proportion")

    ggsave(filename=name6, path=folder)
    
    #create and save the fourth graph
    figure_4 <- make_barplot(animals, "intake_condition", "Intake Condition", "outcome_group", "Proportion")
 
    ggsave(filename=name7, path=folder)

    #create and save the fifth graph
    figure_5 <- ggplot(animals, aes(x = outcome_group, y = age_at_intake, fill = outcome_group)) +
        geom_boxplot() +
        labs(x = "Outcome Type",
            y = "Age at Intake (Years)") +
        theme_minimal()
    
    ggsave(filename=name8, path=folder)}

    main(opt$path_data, opt$folder, opt$name1, opt$name2, opt$name3, opt$name4, opt$name5, opt$name6, opt$name7, opt$name8)