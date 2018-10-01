# https://www.kaggle.com/c/sys6018-competition-3

library(readr)
library(dplyr)
library(caret)

train <- read_csv("train_FRE.csv")
test <- read_csv("test_FRE.csv")

# factorise variables
# train$topic <- factor(train$topic)
# test$topic <- factor(test$topic)

# CV
train_index <- createDataPartition(train$age, p=0.6, list=FALSE)
training <- train[train_index, ]
testing <- train[-train_index, ]

# lm <- glm(age_sd ~ topic, data = train, family = "binomial")
lm <- lm(age ~ FRE + FKGL, data = training)
summary(lm)
# FRE + FKGL performs better than FRE or FKGL alone

lm_full <- lm(age ~ FRE + FKGL, data = train)
pred_output <- data.frame(test$user.id, predict(lm_full, newdata = test))
colnames(pred_output) = c("user.id", "age")
output_clean <- pred_output %>% group_by(user.id) %>% summarise(Mean = mean(age))

write.table(output_clean, file = "blog_withFRE.csv", row.names=F, col.names=c("user.id", "age"), sep=",")
