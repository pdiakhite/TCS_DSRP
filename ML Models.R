install.packages("tidymodels")
library(dplyr)

#Step 1: collect data
head(iris)

## Step 2: Clean and Process Data
##Get rid of NAs
# Only use na.omit when you have specifically selected for this
noNAs <- na.omit(starwars)

noNAs <- filter(starwars, !is.na(mass), !is.na(height))


#replace with means

replaceWithMeans <- mutate(starwars,
                          mass = ifelse(is.na(mass),
                                        mean(mass),
                                        mass))


## Encoding categorical as factors or intergers
#if categorical variable is a character, make it a factor

intSpecies <- mutate(starwars,
                     species = as.integer(as.factor(species)))




#if catergorical is already a factor, make it an integer

irisALLNumeric <- mutate(iris,
                         Species = as.integer(as.factor(Species)))


#step 3: Visualize data
#make a PCA
cor(irisALLNumeric)

install.packages("reshape2")
library(reshape2)
library(ggplot2)

cor(irisALLNumeric)

irisCors <- cor(irisALLNumeric) |>
  cor() |>
  melt() |>
  as.data.frame()

ggplot(irisCors, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "red", high = "blue", mid = "white",
                       midpoint = 0)

#high correlation
ggplot(irisALLNumeric, aes(x = Petal.Length, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

#low correlation
ggplot(irisALLNumeric, aes(x = Sepal.Width, y = Sepal.Length)) +
  geom_point() +
  theme_minimal()

#Step 4: Perform Feature selection
#choose which variable you want to classify or predict
#choose which variable you want to use as features in your model
#for iris, classify on Species (classification) 


#Step 5: Seperate Data into Testing and Training sets
#Choose 70-85% of all dtat to train on
library(tidymodels)
library(rsample)

#put 75% od data into the training set

#create a split
reg_split <- initial_split(irisALLNumeric, prop = .75)

#use the split to form testing and training sets
reg_train <- training(reg_split)
reg_test <- testing(reg_split)


##set a seed for seproducability, gives us the same results every time
set.seed(71723)

#classification dataset splits (use iris instead of irisALLNumeric)

class_split <- initial_split(iris, prop = .75)
class_train <- training(class_split)
class_test <- testing(class_split)


##Step 6 & 7: Choose an= ML mocel and train it
#Liner regresssion

lm_fit <- linear_reg() |>
  set_engine("lm") |>
  set_mode("regression") |>
  fit(Sepal.Length ~ Petal.Length + Petal.Width + Species + Sepal.Width,
      data = reg_train)

##Sepal.Length = 2.3 + Petal.Length*0.7967 

lm_fit$fit

summary(lm_fit$fit)

#logistic regression
# 1. filter dtat to only 2 groups in a categorical variable of intrest
# 2. make the categorical variable a factor
# 3. Make your training and testing splits

#for our purposes, we are just going to filter test and training (dont do this)

binary_test_data <- filter(class_test, Species %in% c("setosa", "versicolor"))
binary_train_data <- filter(class_test, Species %in% c("setosa", "versicolor"))


log_fit <- logistic_reg() |>
  set_engine("glm") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length + ., data = class_train)


##boosted decision trees
install.packages("xgboost")
install.packages("ranger")

boost_reg_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("regression") |>
  fit(Sepal.Length ~., data = reg_train)

boost_fit$fit

boost_reg_fit$fit$evaluation_log

#classification
# Use "classification" as the mode, and use Species as the predictor (independent) variable
# Use class_train as the data

boost_class_fit <- boost_tree() |>
  set_engine("xgboost") |>
  set_mode("classification") |>
  fit(Species ~., data = class_train)


boost_class_fit$fit$evaluation_log



#random forest
#regression

forest_reg_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("regression") |>
  fit(Sepal.Length ~., data = reg_train)

forest_reg_fit$fit



#classification, if classsification the data must be catergorical which is why we called on species

forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(Species ~., data = class_train)

forest_class_fit$fit

#to reduce all those variable, do

forest_class_fit <- rand_forest() |>
  set_engine("ranger") |>
  set_mode("classification") |>
  fit(Species ~ Petal.Width + Petal.Length + Sepal.Length, data = class_train)

## Step 8: Evaluate Model Preformance on Test Set
#Calculate errors for regression
library(yardstick)
#Regression models: lm_fit, boost_reg_fit, forest_reg_fit

predict(lm_fit, reg_test)

reg_results <- reg_test

#tells us how much error is between the trues and the predictions
reg_results$lm_pred <- predict(lm_fit, reg_test)$.pred
reg_results$boost_pred <- predict(boost_reg_fit, reg_test)$.pred
reg_results$forest_pred <- predict(forest_reg_fit, reg_test)$.pred

#truth is speal length false in Lm_pred
mae(reg_results, Sepal.Length, lm_pred)



yardstick::mae(reg_results, Sepal.Length, lm_pred)
yardstick::mae(reg_results, Sepal.Length, boost_pred)
yardstick::mae(reg_results, Sepal.Length, forest_pred)

yardstick::rmse(reg_results, Sepal.Length, lm_pred)
yardstick::rmse(reg_results, Sepal.Length, boost_pred)
yardstick::rmse(reg_results, Sepal.Length, forest_pred)


#calculate accuracy for classification models
install.packages("MLmetrics")
library(MLmetrics)
class_results <- class_test

class_results$lm_pred <- predict(log_fit, class_test)$.pred_class
class_results$boost_pred <- predict(log_fit, class_test)$.pred_class
class_results$forest_pred <- predict(log_fit, class_test)$.pred_class


F1_Score(class_results$Species, class_results$log_pred)
F1_Score(class_results$Species, class_results$boost_pred)
F1_Score(class_results$Species, class_results$forest_pred)














