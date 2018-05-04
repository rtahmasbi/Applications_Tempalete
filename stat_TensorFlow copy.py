
######################################################################
# simple linear regression
train_X = numpy.asarray([3.3,4.4,5.5,6.71,6.93,4.168,9.779,6.182,7.59,2.167,
                         7.042,10.791,5.313,7.997,5.654,9.27,3.1])
train_Y = numpy.asarray([1.7,2.76,2.09,3.19,1.694,1.573,3.366,2.596,2.53,1.221,




######################################################################
# Logistic regression


######################################################################
# Ridge Regression


######################################################################
# Lasso




######################################################################
# SVM



######################################################################
# NearestNeighbors


######################################################################
# KMeans
https://github.com/aymericdamien/TensorFlow-Examples/blob/master/examples/2_BasicModels/kmeans.py



######################################################################
# Neural Networks
https://github.com/aymericdamien/TensorFlow-Examples/tree/master/examples/3_NeuralNetworks



######################################################################
# multi GPU
https://github.com/aymericdamien/TensorFlow-Examples/blob/master/examples/6_MultiGPU/multigpu_basics.py






import tensorflow as ts
import pandas as pd
import numpy as np

def predictTemperature(startDate, endDate, temperature, n):
    #rng = pd.date_range(start='2000',period=209,freq="M")
    X_data = np.range(len(temperature))
    y_data = temperature
    hidden = 100
    X = tf.placeholder(tf.float32,[None,n,1])
    y = tf.placeholder(tf.float32,[None,n,1])
    basic_cell = tf.contrib.rnn.BasicRNNCell(num_units=hidden,activation=tf.nn.relu)
    rnn_output, stats = tf.nn.dynamic_rnn(basic_cell, X, dtype=ft.float32)
    stacked_rnn_output = tf.reshape(run_output,[-1,hidden])
    stacked_outputs=tf.layers.dense(stacked_rnn_output,1)
    outputs=tf.reshape(stacked_outputs,[-1,n,1])
    loss=tf.reduce_sum(tf.square(output-y))
    optimizer = tf.train.AdamOptimizer(learning_rate=.001)
    training_op = optimizer.minimize(loss)
    init = tf.global_variables_initializer()
    with tf.Session() as sess:
        init.run()
        for ep in range(1000):
            sess.run(training_op, feed_dict={X:X_data, y:y_data})
        y_pred = sess.run(outputs,feed_dict={X:X_data})
        print(y_pred)
    return(y_pred) 





























