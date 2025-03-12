# author: Rowan Murphy
# date: 2025-03-11

"This script takes the cleaned data file from Script3.R and saves EDA charts and tables produced from this file
Usage: Script3.R <path_data> <folder> <name1> <name2> <name3> <name4> <name5> <name6> <name7> <name8>
" -> doc

library(docopt)
library(dplyr)
library(ggplot2)
library(readr)

opt <- docopt(doc)

main <- function(path_data, folder, name1, name2, name3, name4, name5, name6, name7, name8) {

    #read in cleaned data
    animals <- read_csv(path_data)

    #create and save the first table
    table_1 <- table(animals$outcome_group)
    write_csv(as.df(table_1), path=paste(folder,"/",name1))

    #create and save the second table
    table_2 <- table(animals$outcome_type)
    write_csv(as.df(table_2), path=paste(folder,"/",name2))

    #create and save the third table
    table_2 <- table(animals$intake_condition)
    write_csv(as.df(table_3), path=paste(folder,"/",name3))

    #create and save the first graph
    figure_1 <- ggplot(animals, aes(x = animal_type, fill = outcome_type)) +
        geom_bar(position = "fill") +  
        labs(title = "Figure 1: Animal Type vs Outcome Type",
            x = "Animal Type",
            y = "Proportion") +
        theme_minimal() +
        scale_y_continuous(labels = scales::percent)
    
    ggsave(filename=name4, path=folder)

    #create and save the second graph
    figure_2 <- ggplot(animals, aes(x = animal_type, fill = outcome_group)) +
        geom_bar(position = "fill") + 
        labs(title = "Figure 2: Animal Type vs Outcome Group (adopted / not adopted)",
            x = "Animal Type",
            y = "Proportion") +
        theme_minimal() +
        scale_y_continuous(labels = scales::percent)
    
    ggsave(filename=name5, path=folder)

    #create and save the third graph
    figure_3 <- ggplot(animals, aes(x = intake_condition, fill = outcome_type)) +
        geom_bar(position = "fill") + 
        labs(title = "Figure 3: Intake Condition vs Outcome Type",
            x = "Intake Condition",
            y = "Proportion") +
        theme_minimal() +
        scale_y_continuous(labels = scales::percent) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))

        ggsave(filename=name6, path=folder)
    
    #create and save the fourth graph
    figure_4 <- ggplot(animals, aes(x = intake_condition, fill = outcome_group)) +
        geom_bar(position = "fill") +
        labs(title = "Figure 4: Intake Condition vs Outcome Group (adopted / not adopted)",
            x = "Intake Condition",
            y = "Proportion") +
        theme_minimal() +
        scale_y_continuous(labels = scales::percent) +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggsave(filename=name7, path=folder)

    

    #create and save the fifth graph
    figure_5 <- ggplot(animals, aes(x = outcome_group, y = age_at_intake, fill = outcome_group)) +
        geom_boxplot() +
        labs(title = "Figure 5: Age at Intake vs Outcome Group (adopted / not adopted)",
            x = "Outcome Type",
            y = "Age at Intake (Years)") +
        theme_minimal()
    
    ggsave(filename=name8, path=folder)}

    main(opt$path_data, opt$folder, opt$name1, opt$name2, opt$name3, opt$name4, opt$name5, opt$name6, opt$name7, opt$name8)