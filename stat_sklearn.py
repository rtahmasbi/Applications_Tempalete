
from sklearn import linear_model
from sklearn import svm
from sklearn.neighbors import NearestNeighbors


######################################################################
# simple relinear regression
import numpy as np
from sklearn import linear_model

m = 10
n = 100
X = np.random.normal(0,1,(n,m))
X.shape

alpha = np.random.normal(0,1,(m,1))

e = .1 * np.random.normal(0,1,(n,1))

y = np.matmul(X,alpha) + e

# Create linear regression object
regr = linear_model.LinearRegression()

# Train the model using the training sets
regr.fit(X, y)

regr.coef_
alpha
regr.intercept_

np.var(e)
np.var(y)


# Make predictions using the testing set
regr.predict(np.random.normal(0,1,(3,m)))


######################################################################
# Logistic regression
import numpy as np
from sklearn import linear_model

m = 10
n = 100
X = np.random.normal(0,1,(n,m))
X.shape

alpha = np.random.normal(0,1,(m,1))

e = .5 * np.random.normal(0,1,(n,1))

y = np.matmul(X,alpha) + e
y01 = np.zeros((n,1))
y01[y>np.mean(y)+np.std(y)] = 1

logreg = linear_model.LogisticRegression()

res = logreg.fit(X, y01.ravel())

res.coef_
res.intercept_


######################################################################
# Ridge Regression

import numpy as np
from sklearn import linear_model

m = 10
n = 100
X = np.random.normal(0,1,(n,m))
X.shape

alpha = np.random.normal(0,1,(m,1))

e = .1 * np.random.normal(0,1,(n,1))

y = np.matmul(X,alpha) + e


reg = linear_model.Ridge (alpha = .5)
reg.fit(X,y)
reg.coef_
reg.intercept_
reg.alpha_

reg.predict([[1, 1]])


# Generalized Cross-Validation as a Method for Choosing a Good Ridge Parameter
reg = linear_model.RidgeCV(alphas=[0.1, 1.0, 10.0])
reg.fit([[0, 0], [0, 0], [1, 1]], [0, .1, 1])
reg.alpha_



######################################################################
# Lasso
reg = linear_model.Lasso(alpha = 0.1)
reg.fit
reg.predict


reg = linear_model.LassoLars(alpha=.1)
reg.fit(

#Cross-Validation
LassoCV(alphas=[0.1, 1.0, 10.0])


######################################################################
# Bayesian Ridge Regression
reg = linear_model.BayesianRidge()
reg.fit(X, Y)
reg.predict ([[1, 0.]])
reg.coef_



######################################################################
######################################################################
from sklearn import svm
X = [[0, 0], [1, 1]]
y = [0, 1]
clf = svm.SVC()
clf.fit(X, y)
clf.predict([[2., 2.]])
# get support vectors
clf.support_vectors_
# get indices of support vectors
clf.support_


clf = svm.SVC(decision_function_shape='ovo')


lin_clf = svm.LinearSVC()
lin_clf.fit(X, Y)

#Regression
clf = svm.SVR()
clf.fit(X, y)

svm.SVC(kernel='linear')
svm.SVC(kernel='rbf')


def my_kernel(X, Y):
    return np.dot(X, Y.T)

clf = svm.SVC(kernel=my_kernel)


######################################################################
######################################################################
from sklearn.neighbors import NearestNeighbors
X = np.array([[-1, -1], [-2, -1], [-3, -2], [1, 1], [2, 1], [3, 2]])
nbrs = NearestNeighbors(n_neighbors=2, algorithm='ball_tree').fit(X)
distances, indices = nbrs.kneighbors(X)
nbrs.kneighbors_graph(X).toarray()


neighbors.KNeighborsClassifier

neighbors.KNeighborsRegressor

from sklearn.neighbors import KNeighborsRegressor
neigh = KNeighborsRegressor(n_neighbors=2)
neigh.predict([[1.5]])neigh.fit(X, y)
neigh.predict([[1.5]])



from sklearn.neighbors.nearest_centroid import NearestCentroid
clf = NearestCentroid()
clf.fit(X, y)
clf.predict([[-0.8, -1]])



######################################################################
######################################################################
cluster.KMeans
