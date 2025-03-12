# Group 2 DSCI 310 project: Animal Shelter Adoptability Analysis
## Contributors:
Nolan Vibhakar, Audra Cornick, Angela Yandrofski, Rowan Murphy

## Summary:
The largest problems animal shelters are facing in North America is a lack of space and people to care for the large number of animals they receive everyday. Additionally many animals received by shelters have health conditions that need immediate attention or could potentially spread to other animals, which require more resources to ensure swift treatment of these animals and measures to prevent the spread of sickness within these facilities. It is important that shelters are able to make quick decisions about where they dedicate their limited resources and optimize the adoption process to ensure as many animals are able to find home as possible.
Our project uses animal shelter data from Long Beach Animal Shelter in California to predict whether or not an animal will be adopted based on their age, sex, animal type, intake condition, intake type, and length of stay at shelter. Using predictive analysis in R, we create a k-nearest neighbor model to predict if an animal is going to be adopted based on the features listed above. 
This analysis aims to help enhance adoption rates, so shelters can recognize which animals are unlikely to get adopted and tailor their outreach and marketing strategies to specifically promote the adoption of those animals. Additionally, better understanding which animals are at a higher risk of not being adopted allows shelters to allocate resources more effectively, by providing additional care and resources to help those that are unlikely to be adopted.

## Findings:
With a final accuracy of around 76%, we can fairly confidently state that we were able to successfully predict whether or not an animal would be adopted, at least to an extent. Unfortunately, one of the shortcomings of our chosen analysis model is the lack of feature importances. K nearest neighbours is a non-parametric model, meaning that it does not use coefficients to make its predictions, and as such it is unclear which features in this model contributed the most to this final result. However, what we have produced still serves as a valuable tool for shelter owners as a pre-trained model designed to predict whether or not an animal will be adopted. Overall, we are glad to see that our model functions well as it currently exists, but room for improvement still remains. An accuracy of 76% is good, but not fantastic, and we would be able to gain even more information by utilizing a model that would allow us to determine which specific factors contribute to an animal being adopted or not. These are important questions to consider in the future, and can be easily developed with further analysis of this data.

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

`docker pull ribbitsm/dsci310-group-02:animal_shelter_image_group2`

This will get the container onto your local computer. Then make sure your working directory is still in the root of the repository and run

`docker-compose up`

This will start the container. To Run the analysis open a browser window and go to `http://localhost:8787/`, which will open an Rstudio window. Go to the Rstudio terminal and use the command

`make all`

which will run all the various analysis scripts to clean the data, create EDA figures and tables, and create the model and visualizations. It will also create an `index.html` file in the `docs` folder to allow you to easily view the full report.

