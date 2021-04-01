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


#(SKIP) CREATING DATASET --------------------------------------- 1=CUSTOMER WILL BUY (FALSE), 2=CUSTOMER WILL NOT BUY (TRUE)
sunflower <- (runif(200, min=0, max=7))
sunflower <- format(round(sunflower, 2), nsmall=2)
sunflower <- as.data.frame(sunflower)
daisies <- floor(runif(200, min=0, max=7))

sum <- (daisies+sunflower)

for(val in sum){
  if(val >= 6){
    print('1')
  }
  else {
    print('2')
  }
}

for(val in sunflower){
  if(val > 4){
    print('1')
  }
  else {
    print('2')
  }
}

response <- as.data.frame(ifelse(sunflower >= 3, 1, 2))
response <- rename(response, "response"="sunflower")
one <- cbind(sunflower, response)


#RETRIEVE DATA --------------------------------------
df <- read.csv("C:/Users/samee/OneDrive/Documents/R/smallbusiness_occ/df.csv")

df2 <- df 
class(df2$response)
df2$response <- as.factor(df2$response)
class(df2$response)

#TRAINING AND TESTING DATA ----------------------

one2 <- one

split = sample.split(one2$response, SplitRatio = 0.7)
train = subset(one2, split == TRUE)
test = subset(one2, split == FALSE)


#CREATE MODEL -------------------------------

train_x <- train[-2]
train_y <- train[2]
test_x <- test[-2]
test_y <- test[2]
train_y$response <- as.factor(train_y$response)
train_x$sunflower <- as.factor(train_x$sunflower)
train_x$daisies <- as.factor(train_x$daisies)
str(train_x)

svm <- svm(data=train, train_x, train_y, type='one-classification', nu=0.10, scale=FALSE)

summary(svm)


#MAKE PREDICTIONS ---------------------------------

p <- predict(svm, test_x)      #predicting test responses using the test independent variables (x)
summary(p)


#CONFUSION MATRIX ------------------------------
p2 <- p
p2 <- as.data.frame(p2)
test_y2 <- test_y

str(test_y2)
str(p2)

test_y2$response <- as.factor(test_y2$response)
p2$p2 <- as.factor(p2$p2)

levels(p2$p2) <- list("1"="FALSE", "2"="TRUE")

confusionMatrix(test_y2$response, p2$p2)


#PLOT ------------------------------
X <- seq(1, 200, by=1)
one2 <- cbind(one2, X)

ggplot(df2, aes(x=X, y=sunflower, color=response)) + geom_point(size=5) + theme_ipsum() + scale_color_manual(values = c("#FF6464", "#FBDF6C")) + geom_smooth(method=lm , color="red", se=FALSE) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + theme(axis.line = element_line(colour = "black"))

ggplot(df2, aes(x=X, y=daisies, color=response)) + geom_point(size=5) + theme_ipsum() + scale_color_manual(values = c("#FF6464", "#FBDF6C")) + geom_smooth(method=lm , color="red", se=FALSE) + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + theme(axis.line = element_line(colour = "black"))



ggplot(one2, aes(x=X, y=sunflower, color=response)) + geom_point(size=5) + theme_ipsum()











