# Bagging-RandomForests

We will use the Boston Housing data to explore randomForests. these data are in the “MASS” package. It gives housing values and other statistics in each of 506 suburbs of Boston based on a 1970 census. We will build lots of bushy trees, and then average them to reduce the variance.

The only tuning parameter in a randomForest is the argument called mtry, which is the number of the variables that are selected at each split when we make a split for each tree. For example, if mtry is 4 of the 13 variables in the Boston housing data, each time we come to split a node, 4 variables would be selected at random, and then the split would be confined to one of those four variables, and that how randomForeses de-correlated the trees. In order to choose the best mtry first, we fit a series of randomForests, there are 13 variables so, we have mtry range through the values 1 to 13. And then we recorded the errors and we made a plot


![picture(1)](https://user-images.githubusercontent.com/58350018/71455111-3308aa80-2759-11ea-8214-1a928b35f764.png)

The plot shows that mtry around (5) seem to be the best for the test error, For the out-of-bag error is around about (7). Thus, mtry somewhere in the middle will give us a good performance.

Also, the plot shows that the single bushy tree mean squared error on out-of-bag is (23), and we drop down to about just over (12), it’s almost a little bit above half. Thus, we reduced the errors by half.

And likewise, for the test error that means randomFoorests reduced the variance for the trees by averaging.



Also, we create a plot displaying the test error resulting from random forests on Boston housing data set for a more comprehensive range of values for mtry and number of trees.

![picture(2)](https://user-images.githubusercontent.com/58350018/71455353-394b5680-275a-11ea-8681-cd7d958e8108.png)

The plot shows that test MSE for single tree is quite high (around 28). It is reduced by adding more trees to the model and stabilizes around a few hundred trees.
Test MSE for including all variables at split is slightly higher (around 16) as compared to both using half or square-root number of variables (both slightly less than 15).


Finally, the following plot indicate that across all of the trees considered in the random forest, the wealth level of the community (lstat) and the house size (rm) are by far the two most important variables. 

![picture(3)](https://user-images.githubusercontent.com/58350018/71455357-3cdedd80-275a-11ea-9fd0-f1e710d98139.png)
