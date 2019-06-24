import pretrainedmodels
import torch
import pretrainedmodels.utils as utils
import numpy as np
from keras.preprocessing import sequence
import os
import tensorflow as tf
import glob
import pandas as pd
from sklearn.preprocessing import StandardScaler
from PIL import Image
from sklearn.preprocessing import minmax_scale

from keras.applications.inception_v3 import InceptionV3
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
from keras.applications.inception_v3 import preprocess_input
from keras.models import Model

os.environ['TF_CPP_MIN_LOG_LEVEL'] = '3'

############################################Encoder#################################################
# model_name = 'inceptionv3' # could be fbresnet152 or inceptionresnetv2
# model = pretrainedmodels.__dict__[model_name](num_classes=1000, pretrained='imagenet')
# print(pretrainedmodels.pretrained_settings[model_name])
# model.eval()

model = InceptionV3()
model.layers.pop()
model = Model(inputs=model.inputs, outputs=model.layers[-1].output)

with open('./test.txt') as f:
    content = [x.strip('\n') for x in f.readlines()]

str1='./8/test/'

data_input=[]
data_output=[]
#
for i in range(0,len(content)):
    try:
        str2=content[i].split("|")[0]
        str3=str1+str2

        path_img = str3

        image = load_img(path_img, target_size=(299, 299))
        image = img_to_array(image)
        image = image.reshape((1, image.shape[0], image.shape[1], image.shape[2]))
        image = preprocess_input(image)
        features = model.predict(image, verbose=0)

        data_input.append(features[0])
        capt=content[i].split("|")[2].lstrip()
        data_output.append(capt)

        if(i%100==0):
            print(i)

        if(i%1000==0):
          np.savez('data_input_goog_test_3.npz', name1=data_input)
          #np.savez('data_output_vgg.npz', name1=data_output)
    except:
        pass
#Normalization
# data_input=np.array(data_input)
# print(data_input)
# for i in range (0,4096):
#    data_input[:,i]=minmax_scale(data_input[:,i])

print(data_input[0])
print(data_input[1])
data_input=np.load('data_input_vgg_test.npz')['name1']
print(len(data_input))
data_output=np.load('data_output_vgg.npz')['name1']
