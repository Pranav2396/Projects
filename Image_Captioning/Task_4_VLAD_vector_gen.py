from keras.applications.inception_v3 import InceptionV3
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
from keras.applications.inception_v3 import preprocess_input
import tensorflow as tf
from sklearn.utils import shuffle
from keras.models import Model
import glob
import numpy as np
from sklearn.cluster import KMeans
import pickle
import math

cluster_input=[]

model = InceptionV3()
model.layers.pop()
model.layers.pop()
model.layers.pop()
model = Model(inputs=model.inputs, outputs=model.layers[-1].output)
clusters=64

####################################################################Gorilla#########################
arr_count=0

image_vectors=[]
input_to_rnn=[]

with open('./test.txt') as f:
    content = [x.strip('\n') for x in f.readlines()]

str1='./8/test/'

# data_input=[]
# data_output=[]

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
        features = features.reshape((features.shape[0] * features.shape[1] * features.shape[2]), features.shape[3])

        image_vectors.append(features)

        for j in range(0, 64):
            cluster_input.append(features[j])

        if(i%100==0):
            print(i)
    except:
        pass

#kmeans = KMeans(n_clusters=clusters,n_init=3,max_iter=100,random_state=0).fit(cluster_input)
print('K means over')

pkl_filename = "pickle_model_64.pkl"
# with open(pkl_filename, 'wb') as file:
#     pickle.dump(kmeans, file)

with open(pkl_filename, 'rb') as file:
   kmeans = pickle.load(file)

centers=kmeans.cluster_centers_

#print(centers[0])
#print(len(centers),len(centers[0]))

beta=0.3

for i in range(0,len(image_vectors)):
    vec=image_vectors[i]

    cc=np.zeros(shape=(clusters,192),dtype=int)

    for k in range(0,clusters):
        for j in range(0,64):
          #pred=kmeans.predict([vec[j]])
          subt=np.subtract(vec[j],centers[k])
          normm=np.dot(subt,np.transpose(subt))
          num=math.exp(-1*beta*normm)

          sum=0

          for l in range(0,clusters):
              temp=np.subtract(vec[j],centers[l])
              sum=sum+math.exp(-1*beta*np.dot(temp,np.transpose(temp)))

          akj=float(num)/(sum)
          cc[k]=np.add(cc[k],akj*(subt))

    cc=cc.reshape((clusters*192))
    input_to_rnn.append(cc)

print('Saving.....')
np.savez('data_input_goog_test_4_64.npz', name1=input_to_rnn)

#print(len(input_to_rnn),len(input_to_rnn[0]))
#print(input_to_rnn[0])
#print(input_to_rnn[9])