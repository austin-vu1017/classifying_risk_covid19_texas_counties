# Classifying Risk of COVID-19 in Texas Counties

For a concise report along with images, please access https://docs.google.com/document/d/10OurJtyCdOMMtABE0LrzEMi3YbQ-lzv7PGZ9fJnE5dY/edit?usp=sharing to view the full report.

## Introduction
This data was chosen because we want to understand the difficult situation we are currently facing in regards to COVID-19. We want to create a useful and accurate model to identify the correlation between the population(of all counties in Texas) and the number of confirmed cases for COVID-19. We’ll use the dataset to classify which counties are at “high risk” and “low risk”. A county is considered “high risk” if it has a greater number of confirmed cases than its average. A county is considered “low risk” if there’a lesser number of confirmed cases than its average. The tests can give an estimate of which counties are more inclined to have confirmed cases and determine whether their population is a factor when classifying them. This project can contribute to decisions that Texas counties will make to ensure their citizen’s safety.  

Goal:
We plan to use both K-Nearest Neighbor(KNN) and Support Vector Machine(SVM) for our overall final goal.

Which is the better model to use to determine which counties are at high/low risk of COVID-19 and its predictions of future risks?
Hypothesis: The greater the population, the higher at risk Texas counties have for COVID-19.

Responses: Counties’ high/low risk of COVID-19 
Predictors: County Name, Population, Cumulative Total tests, Confirmed, Current

## Methodology
K-Nearest Neighbors: Will be used to classify and create an accurate prediction of which validation method is best to determine high/low risk of COVID-19. 
The advantage to KNN is that it is simple and intuitive, it performs with high accuracy, there are no prior assumptions, and it can be utilized for both classification and regression. 
The downside for KNN is that it requires high computationality and lots of storing training data. It also uses an excess amount of memory and is sensitive to scaling of data and other irrelevant features. 			
Support Vector Machine: Will create a hyperplane that separates the data, we want to find the optimal hyperplane.
SVM is a stable model that is good at finding the best linear separator. It can handle non-linear data efficiently with the kernel trick. Can be used to solve classification and regression problems.
Disadvantages for SVM include long training time for large data sets and finding a “good” kernel function is rather difficult. Like KNN, it also requires extensive memory,  and a need to scale variables before applying SVM.
Can prevent overfitting by taking a portion of the training dataset and use cross-validation and grid search to find optimal parameters.

Walkthrough of Model and Formulas
For response variable risk01, we included the following predictors: 
1. County Name
2. Population
3. Cumulative Total tests
4. Confirmed
5. Current.

## Data Analysis
K-Nearest Neighbor
When performing KNN to achieve results from our initial question, we want to appropriately designate a county to be at high or low risk based on its confirmed cases. To do so, we will need to remove the first column which holds the county’s name and transform it into row names. Additionally, we will append an additional column, which will also be the response variable, dubbed “risk01”. At the date of April 16, 2020, the median for confirmed cases is 40.5. If the county’s confirmed cases are greater than 40.5, it is labeled “1” for high risk. Else, the county is labeled “0” for low risk. 

We will use predictors population, cumulative total tests, confirmed, current, and fatalities against risk01. These are all the predictors within the dataset minus risk01 that are well-correlated. Therefore, it will be fruitful in creating results that we desire. 
Considering the predictors population and cumulative total tests, it is necessary to scale our observations. Both those predictors will have a much greater number compared to the other predictors. To prevent miscalculation and show differences, we will use KNN with validation set and Leave-One-Out cross validation. While also performing KNN with both approaches’ scaled versions. A for loop will perform a 100 iterations for all approaches. Additionally, the model is trained on the 80% training observations and 20% testing observations for validation set approach and the entire dataset is trained for LOOCV approach.
Validation set - optimal K = 21, prediction error rate = 0.1960784
Scaled validation set - optimal K = 2, prediction error rate = .05882353
Leave-One-Out cross validation - optimal K = 12, prediction error rate = 0.1338583
Scaled Leave-One-Out cross validation - optimal K = 1, prediction error rate = 0.0511811

## Support Vector Machines
When using SVM we would like to implement a hyperplane to separate low risk and high risk counties. Just like KNN, we will append a new column (a response variable) based on the median of all the datasets, 1 is for high risk and 0 for low risk.

We will be using population against the confirmed cases to create the plot. We will mark high and low risk counties with different colors in order to separate them and be able to create the hyperplane.



After plotting the svmfit we get a plot with false positive and false negatives, giving error to our method. We also need to scale our svmfit to get better results.


This will be our summary for svmfit:
Call:
svm(formula = y ~ ., data = dat, kernel = "linear", cost = 10, scale = TRUE)


Parameters:
   SVM-Type:  C-classification 
 SVM-Kernel:  linear 
       cost:  10 

Number of Support Vectors:  249

 ( 124 125 )


Number of Classes:  2 

Levels: 
 -1 1


Lastly we need to implement the tune function to predict our best cost.





## Best Model
Between both models, KNN yields the most optimal test error rate. Specifically, when the dataset is performed with a scaled data and where the model is approached by Leave-One-Out cross validation. The model will be trained onto the entire dataset. 

The graph represents the progression as we change the value of K. Notice that K = 1 is at the lowest and all the other K values slowly increased. 
 
> summary(knnScaleLOOCV.test.err)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
0.05118 0.09843 0.12205 0.12807 0.16240 0.18898 

The knnScaleLOOCV.test.err is a list that contains the entire testing error rate for K = 1 to K = 100. When using this model and approach, the greatest error rate we can expect is .18898 at the worst performance or K value.

Interpretation of Data Analysis Results (Austin Vu)
K-Nearest Neighbor:
Initially, we hypothesized that any scaled version of the data, specifically Leave-One-Out cross validation approach. Since it’s much more stable despite a possibility of a bias-variance trade off and increased computation performance. For this model, we believed we achieved the most useful prediction error. At the worst approach and K value, 

> summary(knn.test.err)
   	   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
 	0.1961  0.1961  0.2157  0.2235  0.2157  0.3725 

the validation set approach’s greatest prediction error is .3725 or 37.25% prediction inaccuracy. This model is able to accurately predict 62.75% at its worst and 99.95% at its best with the best approach and optimal K value. Therefore, we achieved a respectable predictive performance for KNN.

Support Vector Machine:
In my opinion I thought that SVM was going to be the better option to predict and get the appropriate results for our project. Sadly after running the tune function we got really high error values around 0.5 and 0.6. We believed this happened because we get a lot of false positives and false negatives in our results when generating the plot for SVM.

To our surprise, SVM performs inadequately. With a predictive error rate greater than > .5 or >50%, SVM isn’t the optimal data model to train the dataset. The possibilities of the data model being worse could be due to lack of predictors to use at once.

## Conclusion
Some difficulties we encounter are the layout of the dataset and how we can apply KNN and SVM to reach our goal. 

Overall, KNN(Scaled LOOCV) was better than SVM at being the most accurate when it came to classifying Texas counties at high and low risk of COVID-19. 
We could improve on our analysis by performing K-Cross Validation method, One-versus-One classification, etc. We also want to include additional pairing of predictors for SVM to run against risk01. Especially with the addition of performing SVM with the linear, polynomial, and radial kernels.

## References 
https://hhs.texas.gov/ 			Texas Health and Human Services
https://elearning.uh.edu/		Professor Wang’s Lectures and Labs
