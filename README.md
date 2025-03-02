# Group 2 DSCI 310 project: Animal Shelter Adoptability Analysis
## Contributors:
Nolan Vibhakar, Audra Cornick, Angela Yandrofski, Rowan Murphy

## Summary:
The largest problems animal shelters are facing in North America is a lack of space and people to care for the large number of animals they receive everyday. Additionally many animals received by shelters have health conditions that need immediate attention or could potentially spread to other animals, which require more resources to ensure swift treatment of these animals and measures to prevent the spread of sickness within these facilities. It is important that shelters are able to make quick decisions about where they dedicate their limited resources and optimize the adoption process to ensure as many animals are able to find home as possible.
Our project uses animal shelter data from Long Beach Animal Shelter in California to predict whether or not an animal will be adopted based on their age, sex, animal type, intake condition, intake type, and length of stay at shelter. Using predictive analysis in R, we create a k-nearest neighbor model to predict if an animal is going to be adopted based on the features listed above. 
This analysis aims to help enhance adoption rates, so shelters can recognize which animals are unlikely to get adopted and tailor their outreach and marketing strategies to specifically promote the adoption of those animals. Additionally, better understanding which animals are at a higher risk of not being adopted allows shelters to allocate resources more effectively, by providing additional care and resources to help those that are unlikely to be adopted.  

## Dependencies:
- readr
- tidyverse
- ggplot2
- dplyr
- tidymodels
- caret
- gridExtra

## Licenses:
- MIT license
- Creative Commons License

## How to run the analysis:
In your terminal, run the command

`docker pull ribbitsm/animal_shelter_image_group2`

This will get the container onto your local computer. Then run

`docker run --rm -it -p 8888:8888 ribbitsm/animal_shelter_image_group2`

This will start the container. To Run the analysis go to a browser and go to localhost:8888/lab. From here you can open the notebook from the file directory on the side and run the analysis by selecting `run all cells` from the run menu at the top.

