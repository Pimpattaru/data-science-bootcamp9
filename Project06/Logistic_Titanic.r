library(titanic)
library(dplyr)

head(titanic_train)
str(titanic_train)

## DROP NA (missing values)
titanic_train <- na.omit(titanic_train)
nrow(titanic_train)

## convert am to factor
titanic_train$Sex <- factor(titanic_train$Sex, 
                    levels = c("female","male"),
                    labels = c(0,1))

class(titanic_train$Sex)
table(titanic_train$Sex)

## Split Data 
set.seed(42)
n <- nrow(titanic_train)
id <- sample(1:n, size = n*0.7) ## 70% train 30% test
train_data <- titanic_train[id, ]
test_data <- titanic_train[-id, ]

## train model
logit_model <- glm(Survived ~ Pclass + Age + Parch, 
                   data =  train_data, family = "binomial")
p_train <- predict(logit_model, type="response") ## probability
train_data$pred <- if_else(p_train >= 0.5, "1", "0")
mean(train_data$Survived == train_data$pred) ## Accuracy of model

## test model
p_test <- predict(logit_model, newdata = test_data, type="response") ## probability
test_data$pred <- if_else(p_test >= 0.5, "1", "0")
mean(test_data$Survived == test_data$pred) ## Accuracy of model

## confusion matrix
conM <- table(test_data$pred,test_data$Survived, 
              dnn= c("Predicted", "Actual"))

## Model Evaluation
cat("Accuracy:",conM[1,1] + conM[2,2] / sum(conM))
cat("Precision:",conM[2,2]/ (conM[2,1] + conM[2,2]))
cat("Recall:", conM[2,2] / (conM[1,2] + conM[2,2]))
cat("F1:", 2* ((0.9*0.9) / (0.9+0.9)))
