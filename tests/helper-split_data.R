source("R/split_data.R")

test_frame <- data.frame(index = c(1:100))
bool_frame <- data.frame(index = c(1:100),truth=sample(rep(c("TRUE","FALSE"),each=5),10,replace=FALSE))
strata_prop1 <- split_data(bool_frame, 0.8, "truth", 42)[[1]]['truth']
strata_prop2 <- split_data(bool_frame, 0.8, "truth", 42)[[2]]['truth']
strata_prop3 <- split_data(bool_frame, 0.5, "truth", 42)[[1]]['truth']
strata_prop4 <- split_data(bool_frame, 0.5, "truth", 42)[[2]]['truth']