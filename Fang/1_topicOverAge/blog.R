library(readr)
library(dplyr)

train <- read_csv("train.csv")
test <- read_csv("test.csv")

train$topic <- factor(train$topic)
test$topic <- factor(test$topic)

# age_sd = (train$age - sd(train$age)) / max(train$age)
# train$age_sd <- age_sd

# lm <- glm(age_sd ~ topic, data = train, family = "binomial")
lm <- lm(age ~ topic, data = train)
summary(lm)

pred_output <- data.frame(test$user.id, predict(lm, newdata = test))
colnames(pred_output) = c("user.id", "age")
output_clean <- pred_output %>% group_by(user.id) %>% summarise(Mean = mean(age))

write.table(output_clean, file = "blog.csv", row.names=F, col.names=c("user.id", "age"), sep=",")
