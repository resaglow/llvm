import keras
import tensorflow as tf
import os, sys
import numpy as np
import pandas as pd  
from random import random

os.environ["CUDA_VISIBLE_DEVICES"]="1"

print("python:{}, keras:{}, tensorflow: {}".format(sys.version, keras.__version__, tf.__version__))

from keras.models import Sequential
from keras.layers.core import Dense, Activation
from keras.layers.recurrent import LSTM

in_out_neurons = 2
hidden_neurons = 30

model = Sequential()
model.add(LSTM(hidden_neurons, return_sequences=False,
               input_shape=(None, in_out_neurons)))
model.add(Dense(in_out_neurons, input_dim=hidden_neurons))
model.add(Activation("linear"))
model.compile(loss="mean_squared_error", optimizer="rmsprop")

def transform_input(data, n_prev):
    """
    Helper function for splitting the data into train/test sets.
    Returns pair of features and the corresponding predicted / ground truth value.
    data should always be a pd.DataFrame()
    """

    docX, docY = [], []
    for i in range(len(data) - n_prev):
        docX.append(data.iloc[i:i + n_prev].as_matrix())
        docY.append(data.iloc[i + n_prev].as_matrix())
    alsX = np.array(docX)
    alsY = np.array(docY)

    return alsX, alsY

def train_test_split(df, test_size=0.1):  
    """
    Split the data into train/test sets.
    """
    ntrn = round(len(df) * (1 - test_size))

    X_train, y_train = transform_input(df.iloc[0:ntrn])
    X_test, y_test = transform_input(df.iloc[ntrn:])

    return (X_train, y_train), (X_test, y_test)

def predict_test_counts(prev_counts):
    """
    Predict lots of future profile counts based on multiple lists of given
    profile counts of a given dimensionality. Also tests them.
    """
    profile_info_dict = {}
    for i in range(len(prev_counts)):
        profile_info_dict[str(i)] = prev_counts[i];
    total_input = pd.DataFrame(profile_info_dict)

    # retrieve data
    (X_train, y_train), (X_test, y_test) = train_test_split(total_input)

    # train the model
    model.fit(X_train, y_train, batch_size=45, epochs=10, validation_split=0.05)

    predicted = model.predict(X_test)  
    rmse = np.sqrt(((predicted - y_test) ** 2).mean(axis=0))

    return predicted

def predict_counts(prev_counts):
    """
    Predict future a single profile count based on multiple lists of given
    profile counts of a given dimensionality. No test set thus no testing happens.
    """
    profile_info_dict = {}
    for i in range(len(prev_counts)):
        profile_info_dict[str(i)] = prev_counts[i];
    total_input = pd.DataFrame(profile_info_dict)

    # retrieve data
    (X_train, y_train) = transform_input(total_input, 4)
    X_test = []
    X_test.append(total_input.iloc[len(prev_counts[0]) - 4:].as_matrix())
    X_test = np.array(X_test)

    # train the model
    model.fit(X_train, y_train, batch_size=45, epochs=10, validation_split=0.05)

    predicted = model.predict(X_test)

    # predicted always contains just a single element, retrieve it
    return predicted[0]
