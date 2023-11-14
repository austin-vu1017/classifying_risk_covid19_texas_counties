#MODIFICATIONS TO DATA SET
Texas_COVID_19_Cases_by_County=data.frame(Texas_COVID_19_Cases_by_County)
rownames(Texas_COVID_19_Cases_by_County) = Texas_COVID_19_Cases_by_County[,1]
fix(Texas_COVID_19_Cases_by_County)
Texas_COVID_19_Cases_by_County=Texas_COVID_19_Cases_by_County[,-1]
fix(Texas_COVID_19_Cases_by_County)
View(Texas_COVID_19_Cases_by_County)
Texas_COVID_19_Cases_by_County$risk01 = ifelse(Texas_COVID_19_Cases_by_County$Confirmed > median(Texas_COVID_19_Cases_by_County$Confirmed), 1, 0)
Texas_COVID_19_Cases_by_County$risk01 = factor(Texas_COVID_19_Cases_by_County$risk01)

## VALIDATION SET
k.set = seq(1, 401, by=10)
knn.test.err = numeric(length(k.set))
set.seed(1)
for (j in 1:length(K.set)){
    knn.pred <- knn(X.train, X.test,
                    Y.train,
                    k=K.set[j])
    knn.test.err[j] <- mean(knn.pred != Y.test)}
for (j in 1:length(k.set)){
    knn.pred <- knn(X.train, X.test,
                    Y.train,
                    k=k.set[j])
    knn.test.err[j] <- mean(knn.pred != Y.test)}
min(knn.test.err)
which.min(knn.test.err)
k.set[which.min(knn.test.err)]
plot(k.set, knn.test.err, type='b', xlab = "K",ylab = "Test Error", main = "Validation Set Test Errors from K=1 to K=401")

### LOOCV
XLOOCV.train = Texas_COVID_19_Cases_by_County[,1:5]
YLOOCV.train = Texas_COVID_19_Cases_by_County[,"risk01"]
kLOOCV.set <- 1:401
knnLOOCV.test.err <- numeric(length(k.set))
 
for (j in 1:length(k.set)){
     print(j)
     set.seed(1)
     knnLOOCV.pred <- knn.cv(train=XLOOCV.train,
                        cl=YLOOCV.train,
                        k=k.set[j])
     knnLOOCV.test.err[j] <- mean(knnLOOCV.pred != YLOOCV.train)
}

## SCALED VALIDATION SET
XScale.train = scale(Texas_COVID_19_Cases_by_County[train,1:5])
XScale.test=scale(Texas_COVID_19_Cases_by_County[-train,1:5], center=attr(XScale.train, "scaled:center"), scale = attr(XScale.train, "scaled:scale"))
kScale.set = 1:401
knnScale.test.err = numeric(length(kScale.set))
for (j in 1:length(kScale.set)){
     set.seed(1)
     knnScale.pred <- knn(XScale.train, XScale.test, Y.train, k=kScale.set[j])
     knnScale.test.err[j] <- mean(knnScale.pred != Y.test)
}
min(knnScale.test.err)
which.min(knnScale.test.err)
kScale.set[which.min(knnScale.test.err)]
plot(kScale.set, knnScale.test.err, 
      type='b',
      xlab="K",
      ylab="Test error",
      main="Scaled Validation Set Approach from K=1 to K=401")
