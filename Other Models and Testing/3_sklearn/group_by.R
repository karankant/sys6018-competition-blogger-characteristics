# sys6018-competition-titanic
# https://www.kaggle.com/c/titanic/overview
# Fang You (fy6vj)

library(readr)
library(dplyr)

py_output <- read_csv("test_sklearn_output.csv")
output_clean <- py_output %>% group_by(user.id) %>% summarise(Mean = mean(age))
write.table(output_clean, file = "blog_sklearn.csv", row.names=F, col.names=c("user.id", "age"), sep=",")