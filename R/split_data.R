library(tidymodels)

split_data <- function(df,prop,strata, seed){
    set.seed(seed)
    data_split <- initial_split(df, prop=prop, strata=strata)
    train <- training(data_split)
    test <- testing(data_split)
    return(list(train, test))
}