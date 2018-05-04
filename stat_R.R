
######################################################################
# simple linear regression
m <- 10
n <- 100
X <- matrix(rnorm(m*n),ncol=m)
alpha <- matrix(rnorm(m),ncol=1)
e <- .1 * rnorm(n)
y <- X %*% alpha + e

X <- data.frame(X)
model1 <- lm(y~., data=X)
summary(model1)

x_test <- data.frame(matrix(rnorm(m*3),ncol=m))

predict(model1,x_test)

predict(model1,x_test,interval = "prediction")


######################################################################
# Logistic regression
m <- 10
n <- 100
X <- matrix(rnorm(m*n),ncol=m)
alpha <- matrix(rnorm(m),ncol=1)
e <- .5 * rnorm(n)
y <- X %*% alpha + e
y01 <- rep(0,n)
y01[which(y>mean(y)+sd(y))] <- 1

X <- data.frame(X)
model1 <- glm(y01~., data=X,family=binomial(link='logit'))
summary(model1)


######################################################################
# Ridge Regression
library("MASS")
lm.ridge(y ~ ., longley, lambda = seq(0,0.1,0.001))


######################################################################
# Lasso
library(glmnet)

lambda <- 10^seq(10, -2, length = 100)
ridge.mod <- glmnet(x, y, alpha = 0, lambda = lambda)
predict(ridge.mod, s = 0, exact = T, type = 'coefficients')[1:6,]
ridge.pred <- predict(ridge.mod, s = bestlam, newx = x[test,])



######################################################################
# SVM

library(e1071)

svm.model <- svm(Type ~ ., data = trainset, cost = 100, gamma = 1)
svm.pred <- predict(svm.model, testset[,-10])


######################################################################
# NearestNeighbors
library(class)
knn(train, test, cl, k = 1, l = 0, prob = FALSE, use.all = TRUE)

train <- rbind(iris3[1:25,,1], iris3[1:25,,2], iris3[1:25,,3])
test <- rbind(iris3[26:50,,1], iris3[26:50,,2], iris3[26:50,,3])
cl <- factor(c(rep("s",25), rep("c",25), rep("v",25)))
knn(train, test, cl, k = 3, prob=TRUE)
attributes(.Last.value)


######################################################################
# KMeans
library(stats)
kmeans(x, centers, iter.max = 10, nstart = 1,
       algorithm = c("Hartigan-Wong", "Lloyd", "Forgy",
                     "MacQueen"), trace=FALSE)
## S3 method for class 'kmeans'
fitted(object, method = c("centers", "classes"), ...









#
