"This script downloads data from the internet and saves it locally

Usage:
  01-download_data.R --output_path=<output_path>

Options:
  --output_path=<output_path>  Path to save the downloaded file.
" -> doc

library(tidyverse)
library(janitor)
library(docopt)

opt <- docopt(doc)

animal_shelter <- "https://raw.githubusercontent.com/rfordatascience/tidytuesday/refs/heads/main/data/2025/2025-03-04/longbeach.csv"

# Download and save dataset
download.file(animal_shelter, opt$output_path, mode = "wb")

print(paste("Data downloaded and saved to:", opt$output_path))