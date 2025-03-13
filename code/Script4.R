"This script performs modeling on the cleaned animal shelter data and saves results as figures and tables.

Usage:
  Script4.R --input_path=<input_path> --output_prefix=<output_prefix>

Options:
  --input_path=<input_path>       Path to the cleaned dataset.
  --output_prefix=<output_prefix>  Prefix for saving output figures and tables.
" -> doc
print("Script started")

library(tidyverse)
library(tidymodels)
library(docopt)
library(ggplot2)

opt <- docopt(doc)

animals <- read_csv(opt$input_path)
print("Data loaded")


set.seed(2) 

animals$dob <- as.Date(animals$dob) 
intake_date <- as.Date(animals$intake_date) 
outcome_date <- as.Date(animals$outcome_date)

animals <- animals |> 
  mutate(days_in_shelter = outcome_date - intake_date, age_in_days = outcome_date - dob)

animals <- animals |> 
  mutate(age_in_days = as.numeric(age_in_days), days_in_shelter = as.numeric(days_in_shelter)) |> 
  select('animal_type', 'sex', 'intake_condition', 'intake_type', 'days_in_shelter', 'age_in_days', 'outcome_group')
head(animals)

# Splitting data into train and test data
set.seed(2)
data_split <- initial_split(animals, prop = 0.7, strata = outcome_group)
train_data <- training(data_split)
test_data <- testing(data_split)
head(train_data)

recipe <- recipe(outcome_group ~ ., data = train_data) %>%
  step_novel(all_nominal_predictors()) %>%  # Handle new levels
  step_dummy(all_nominal_predictors()) %>%  # Convert categorical to dummy variables
  step_normalize(days_in_shelter, age_in_days)        # Normalize the numerical predictor

knn_spec <- nearest_neighbor(weight_func = 'rectangular', neighbors = tune()) |> 
  set_engine('kknn') |> 
  set_mode('classification')

shelter_vfold <- vfold_cv(train_data, v = 5, strata = outcome_group)

possible_k <- tibble(neighbors = seq(from = 1, to = 10))

knn_workflow <- workflow() |> 
  add_recipe(recipe) |> 
  add_model(knn_spec) |> 
  tune_grid(resamples = shelter_vfold, grid = possible_k) |> 
  collect_metrics()

accuracies <- knn_workflow |>
  filter(.metric == "accuracy")
head(accuracies)

#graph results to find the k value that gives the best accuracy
print("Generating elbow plot")
accuracy_versus_k<-ggplot(accuracies, aes (x=neighbors, y=mean))+
  geom_point()+
  geom_line()+
  labs(title = "Figure 6: Elbow Plot", x= "Neighbors", y= "Accuracy Estimate")+
  scale_x_continuous(breaks=seq(0,25, by=1))+
  scale_y_continuous(limits=c(0.4, 1.0))
accuracy_versus_k

# Save Figure
fig_path <- paste0(opt$output_prefix, "elbow_plot.png",sep="")
ggsave(fig_path, plot = accuracy_versus_k, width = 6, height = 4)
print(paste("Elbow Plot saved to:", fig_path))

knn_model <-nearest_neighbor(weight_func = 'rectangular', neighbors = 5) |> 
  set_engine('kknn') |> 
  set_mode('classification')

knn_fit <- workflow() |> 
  add_recipe(recipe) |> 
  add_model(knn_model) |> 
  fit(data = train_data)

predictions <- predict(knn_fit, new_data = test_data, type = "prob") |> 
  bind_cols(test_data)

predictions <- predictions %>%
  mutate(outcome_group = factor(outcome_group))


predictions <- predictions %>%
  mutate(.pred_class = ifelse(.pred_Adopted >= `.pred_Not Adopted`, "Adopted", "Not Adopted")) %>%
  mutate(.pred_class = factor(.pred_class, levels = levels(outcome_group)))


confusion_matrix <- conf_mat(predictions, truth = outcome_group, estimate = .pred_class)

accuracy <- accuracy(predictions, truth = outcome_group, estimate = .pred_class)

cm_tibble <- confusion_matrix$table %>% 
  as_tibble() %>%
  rename(Truth = 1, Prediction = 2, Count = 3)

#confusion matrix 
metrics_result <- ggplot(cm_tibble, aes(x = Prediction, y = Truth, fill = Count)) +
  geom_tile() +
  geom_text(aes(label = Count), color = "white", size = 5) +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title = "Figure 7: Confusion Matrix for KNN Model", x = "Predicted", y = "Actual", fill = "Count") +
  theme_minimal()

# Save Figure
fig_path <- paste0(opt$output_prefix, "confusion_matrix.png",sep="")
ggsave(fig_path, plot = metrics_result, width = 6, height = 4)
print(paste("Confusion Matrix saved to:", fig_path))


# Save Table with summary statistics
summary_table <- predictions %>%
  group_by(outcome_group) %>%
  summarise(
    mean_pred = mean(.pred_Adopted, na.rm = TRUE), 
    sd_pred = sd(.pred_Adopted, na.rm = TRUE)
  )

table_path <- paste0(opt$output_prefix, "summary.csv",sep="")
write_csv(summary_table, table_path)
print(paste("Summary table saved to:", table_path))
