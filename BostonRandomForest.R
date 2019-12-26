# requare library

library (MASS)
library(randomForest)
library(gbm)
attach(Boston)

# create a training set
set.seed(1101)
train = sample(1:nrow(Boston),nrow(Boston)/2)

# RANDOM FOREST

# use the randomForest(),with m=p to perform both random forests and bagging

rf.model1 = randomForest(medv~.,Boston[train,],mtry = 13,ntree = 500,importance=0)
rf.model1

# see how well does this bagged model perform on the test set

pred1 = predict(rf.model1,Boston[-train,],ntree = 500)
y = Boston[-train,"medv"]
sqrt(mean((y-pred1)^2))


# change the number of trees grown by randomForest(), using the ntree argument

rf.model = randomForest(medv~.,Boston[train,],mtry = 13,ntree = 23,importance=0)
pred = predict(rf.model,Boston[-train,],ntree = 23)
sqrt(mean((y-pred)^2))

# view the importance of each variable.

importance(rf.model1)


# Plots of these importance measures, using the varImpPlot() 

varImpPlot(rf.model1)


# try all possible value of "mtry", record the results, and make a plot

oob.err = double(13)
test.err = double(13)
for (mtry in 1:13){
  fit = randomForest(medv~.,Boston[train,], mtry = mtry, ntrr = 400,importance=0)
  pred = predict(fit,Boston[-train,],ntrr = 400)
  oob.err[mtry] = fit$mse[400]
  test.err[mtry]= with(Boston[-train,],mean((medv-pred)^2))
  cat(mtry," ")
  
}

matplot(1:mtry,cbind(oob.err,test.err),pch = 19,col = c("red","blue"),type = "b",
        ylab = "Mean Squared Error") 
legend("topright",legend = c("OOB","Test"),pch = 19,col= c("red","blue"))



# Create a plot displaying the test error resulting from random forests
#for a more comprehensive range of values for mtry and ntree

rf.model1 = randomForest(medv~.,Boston[-train,],mtry = 13,importance=0)
rf.model2 = randomForest(medv~.,Boston[-train,],mtry = 6,importance = 0)
rf.model3 = randomForest(medv~.,Boston[-train,],mtry = 4,importance = 0)
plot(1:500, rf.model1$mse, col = "green", type = "l", xlab = "Number of Trees", 
     ylab = "Test MSE", ylim = c(12, 26))
lines(1:500, rf.model2$mse, col = "red", type = "l")
lines(1:500, rf.model3$mse, col = "blue", type = "l")
legend("topright", c("m=p", "m=p/2", "m=sqrt(p)"), col = c("green", "red", "blue"), 
       cex = 1, lty = 1)
#The plot shows that test MSE for single tree is quite high (around 28).
#It is reduced by adding more trees to the model and stabilizes around a few hundred trees.
#Test MSE for including all variables at split is slightly higher (around 16)
#as compared to both using half or square-root number of variables (both slightly less than 15).

## The good prformace model

# use the randomForest(),with m=6 to perform randomForests

rf.boston = randomForest(medv~.,Boston[train,],mtry = 6,ntree = 500,importance=0)
rf.boston

# see how well does this model perform on the test set

pred.boston = predict(rf.boston,Boston[-train,],ntree = 500)
sqrt(mean((y-pred.boston)^2))

# the test set MSE associated with the randomForest is 13.738.
#The square root of the MSE is therefore around 3.707, indicating that
#this model leads to test predictions that are within around $3,707 of the 
#true median home value for the suburb.

