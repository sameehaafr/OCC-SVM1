#PACKAGES ---------------------------------------------
library(tidyverse)   
library(ggplot2)     
library(e1071)
library(caret)
library(caTools)
library(hrbrthemes)
library(reshape2)
library(rgl)
library(patchwork)


#STEP 1: CREATING DATASET --------------------------------------- 
#1=CUSTOMER WILL BUY (FALSE), 2=CUSTOMER WILL NOT BUY (TRUE)


#for 2 or more variables
sunflower <- (runif(200, min=0, max=7))
sunflower <- format(round(sunflower, 2), nsmall=2)
daisies <- (runif(200, min=0, max=7))
daisies <- format(round(daisies, 2), nsmall=2)

sunflower <- as.numeric(sunflower)
daisies <- as.numeric(daisies)

sum <- (sunflower+daisies)


response <- as.data.frame(ifelse(sum >=6, 1, 2))      
summary(response)
response <- rename(response, "response"="ifelse(sum >= 6, 1, 2)")


sunflower <- as.data.frame(sunflower)
daisies <- as.data.frame(daisies)
df <- cbind(sunflower, daisies, response)


#for 1 variable
sunflower <- (runif(200, min=0, max=7))
sunflower <- format(round(sunflower, 2), nsmall=2)
sunflower <- as.numeric(sunflower)

response <- as.data.frame(ifelse(sunflower >= 3, 1, 2))
summary(response)

response <- rename(response, "response"="ifelse(sunflower >= 3, 1, 2)")

df <- cbind(sunflower, response)


#if you already have data 
df <- read.csv("C:/Users/samee/OneDrive/Documents/R/smallbusiness_occ/df.csv")

#STEP 2: SPLIT INTO TRAINING AND TESTING DATA ----------------------

df2 <- df   #just in case
 
split = sample.split(df2$response, SplitRatio = 0.7)
train = subset(df2, split == TRUE)
test = subset(df2, split == FALSE)


#STEP 3: CREATE SVM MODEL -------------------------------

train_x <- train[-3]      #take out the column with response
train_y <- train[3]       #only the response column
test_x <- test[-3]        #take out the column with response
test_y <- test[3]         #only the response column
train_y$response <- as.factor(train_y$response)
train_x$sunflower <- as.factor(train_x$sunflower)
train_x$daisies <- as.factor(train_x$daisies)
str(train_x)

svm <- svm(data=train, train_x, train_y, type='one-classification', nu=0.10, scale=FALSE)

summary(svm)


#STEP 4: MAKE PREDICTIONS ---------------------------------

p <- predict(svm, test_x)      #predicting test responses using the test independent variables (x)
summary(p)


#STEP 5: MAKE CONFUSION MATRIX ------------------------------
p <- as.data.frame(p)

str(test_y)
str(p)

test_y$response <- as.factor(test_y$response)
p$p <- as.factor(p$p)

levels(p$p) <- list("1"="FALSE", "2"="TRUE")  #levels have to match the test data levels

confusionMatrix(test_y$response, p$p)


#STEP 6: PLOT ------------------------------
X <- seq(1, 200, by=1)
df2 <- cbind(df2, X)


#graphing more than 1 variable
one <- ggplot(df2, aes(x=X, y=sunflower, color=response)) + geom_point(size=5) + theme_ipsum() 
two <- ggplot(df2, aes(x=X, y=daisies, color=response)) + geom_point(size=5) + theme_ipsum() 


one+two

#graphing 1 variable
ggplot(df2, aes(x=X, y=sunflower, color=response)) + geom_point(size=5) + theme_ipsum()











