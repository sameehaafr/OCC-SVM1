# occ-svm
One Class Classification with SVM (support vector machine). This shows how I made a random, one class dataset to represent a small business scenario and used OCC with SVM to analyze that data and find patterns/anomalies.


In this project I created a small business scenario where I own a flower shop and i'm currently selling sunflowers and daisies. The values in my randomly created dataset indicate how much the price has lowered on both sunflowers and daisies as well as the response from the customer (they either will or will not buy the flowers depending on how much the price has dropped). You can also recreate this scenario with 1 product, but for this I chose 2 (sunflowers and daisies) and I will demonstrate how you can use OCC with SVM for both situations.

If you want to create your own scenario using this outline, you can replace sunflower and daisies with any desired product.

1. I created a random dataset of 200 rows of dropped prices for each sunflower and daisy product as well as the customers response. I then used a for else loop to create the customer responses. Once all the columns are made, create a dataset combining them.
       
     For 2 variables: If the sum (aka. lowered price) of the sunflower and daisy in one row is greater than $6, return the value "1" (customer will buy the flowers), else return                         the value "2" (customer will not buy the flowers).
     
     For 1 variable: If the lowered price of the sunflower is >= 3, return a "1" (customer will buy sunflower), else return a "2" (customer will not buy sunflower).
     
     Have your own dataset: You don't need to do the for loop to create customer responses (since you already have them).
     
     
2. Split the full dataset into training and testing sets.

3. Create the SVM Model. First split the training set into its independent (sunflower and daisies columns) and dependent (customer responses) variables. Make sure the objects      are Factors with the same levels before using the svm() function.

4. Make the predictions using the independent variables (sunflowers and daisies) from the test dataset.

5. Make a Confusion Matrix. Convert the predictions output into a dataframe and make sure both the dependent variable (customer responses) from the test set and the predictions    are Factors with the same levels before using the confusionMatrix() function.

6. Optional - you can plot the svm model using ggplot just to visualize the separation of customer responses. 

Let me know if there are questions!


