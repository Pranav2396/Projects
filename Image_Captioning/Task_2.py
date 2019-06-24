import pretrainedmodels
import torch
import pretrainedmodels.utils as utils
import numpy as np
import tensorflow as tf
import glob
from keras.applications.inception_v3 import InceptionV3
from keras.preprocessing.image import load_img
from keras.preprocessing.image import img_to_array
from keras.applications.inception_v3 import preprocess_input
from sklearn.utils import shuffle
from keras.models import Model
from sklearn.metrics import precision_recall_fscore_support as score
import sklearn as sk
#animal
#window
#plants
#clouds
#water
#buildings

# model_name = 'inceptionv4'
# model = pretrainedmodels.__dict__[model_name](num_classes=1000, pretrained='inceptionv4')
# print(pretrainedmodels.pretrained_settings[model_name])
# model.eval()

strings=[]
strings.append("animal")
strings.append("window")
strings.append("plants")
strings.append("clouds")
strings.append("water")
strings.append("buildings")

# print(strings[0])
#

model = InceptionV3()
model.layers.pop()
model = Model(inputs=model.inputs, outputs=model.layers[-1].output)

path1=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\8\\image\\*.jpg')

input_data=[]
output_data=[]

with open('8/ImageID.csv', 'r') as f:
    input1 = [x.strip('\n') for x in f.readlines()]

with open('8/Y.csv', 'r') as f:
    output1 = [np.fromstring(x.strip('\n'), dtype=np.float32,sep=',') for x in f.readlines()]

print(output1[0])

for i in range(0,len(input1)):
    x=input1[i].split("\\")[0]
    flag=0

    for j in range(0,len(strings)):
        if(x==strings[j]):
            flag=1
            break

    if(flag==1):
        input_data.append(input1[i])
        output_data.append(output1[i])

# print(len(input),len(input[0]))
# print(len(output),len(output[0]))
data_input=np.zeros(shape=(110,2048),dtype=float)
data_output=np.zeros(shape=(110,6),dtype=float)

arr_count=0
count=0
for i in range(0,len(input_data)):
    str1='D:\\PycharmProjects\\Learning\\Assignment_3\\8\\image\\'
    str2=input_data[i]
    str3=str1+str2
    #print(str3)
    path_img = str3

    try:
        image = load_img(path_img, target_size=(299, 299))
        image = img_to_array(image)
        image = image.reshape((1, image.shape[0], image.shape[1], image.shape[2]))
        image = preprocess_input(image)
        features = model.predict(image, verbose=0)

        data_input[arr_count] = features[0]
        data_output[arr_count] = output_data[i]
        arr_count = arr_count + 1
    except:
      count=count+1

#####################Training Neural Network####################
dim=2048
#
data_input,data_output=shuffle(data_input,data_output)


np.savez('data_input_2_GoogleNet.npz', name1=data_input)
np.savez('data_output_2_GoogleNet.npz', name1=data_output)

data_input=np.load('data_input_2_GoogleNet.npz')['name1']
data_output=np.load('data_output_2_GoogleNet.npz')['name1']

train_input=data_input[0:np.int64(0.8*len(data_input))]
train_output=data_output[0:np.int64(0.8*len(data_output))]

test_input=data_input[1+np.int64(0.8*len(data_input)):len(data_input)]
test_output=data_output[1+np.int64(0.8*len(data_output)):len(data_output)]

h1_size=512
h2_size=512

initializer = tf.contrib.layers.xavier_initializer(seed=42)

x = tf.placeholder(tf.float32, [None, dim])
y = tf.placeholder(tf.float32, [None, 6])

W1 = tf.Variable(initializer([dim,h1_size]), name='W1')
b1 = tf.Variable(initializer([h1_size]), name='b1')

W2 = tf.Variable(initializer([h1_size,h2_size]), name='W2')
b2 = tf.Variable(initializer([h2_size]), name='b2')

W3 = tf.Variable(initializer([h2_size,6]), name='W3')
b3 = tf.Variable(initializer([6]), name='b3')

hidden_out = tf.add(tf.matmul(x, W1), b1)
hidden_out = tf.nn.relu(hidden_out)

hidden_out1=tf.add(tf.matmul(hidden_out,W2),b2)
hidden_out1=tf.nn.relu(hidden_out1)

#Output Layer
y_ = tf.nn.sigmoid(tf.add(tf.matmul(hidden_out1, W3), b3))

sse=tf.reduce_mean(tf.squared_difference(y, y_))

# add an optimiser
optimiser = tf.train.AdamOptimizer(learning_rate=0.0001).minimize(sse)

#Setup
init_op = tf.global_variables_initializer()
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

#Training
batch_size=32
epochs=2000

# start the session
with tf.Session() as sess:
   # initialise the variables
   sess.run(init_op)
   total_batch = int(len(train_input) / batch_size)
   for epoch in range(epochs):
        avg_cost = 0
        for i in range(total_batch):
            start=i*batch_size
            end=start+batch_size

            batch_x=train_input[start:end]
            batch_y=train_output[start:end]

            _, c = sess.run([optimiser, sse],feed_dict={x: batch_x, y: batch_y})
            avg_cost += c / total_batch

        _, y_pred = sess.run([accuracy,y_], feed_dict={x: train_input, y: train_output})
        _, y_pred1 = sess.run([accuracy,y_], feed_dict={x: test_input, y: test_output})
        #y_pred = np.argmax(y_pred,1)
        #y_true = np.argmax(train_output, 1)

        for i in range(0,len(y_pred)):
            for j in range(0,6):
                if(y_pred[i][j]>=0.5):
                    y_pred[i][j]=1
                else:
                    y_pred[i][j]=0

        for i in range(0,len(y_pred1)):
            for j in range(0,6):
                if(y_pred1[i][j]>=0.5):
                    y_pred1[i][j]=1
                else:
                    y_pred1[i][j]=0

        tp=0
        fp=0
        fn=0
        tp1=0
        fp1=0
        fn1=0

        for i in range(0,len(y_pred)):
            for j in range(0,6):
                if(y_pred[i][j]==1 and train_output[i][j]==1):
                    tp=tp+1
                elif(y_pred[i][j]==1 and train_output[i][j]==0):
                    fp=fp+1
                elif(y_pred[i][j]==0 and train_output[i][j]==1):
                    fn=fn+1

        for i in range(0,len(y_pred1)):
            for j in range(0,6):
                if(y_pred1[i][j]==1 and test_output[i][j]==1):
                    tp1=tp1+1
                elif(y_pred1[i][j]==1 and test_output[i][j]==0):
                    fp1=fp1+1
                elif(y_pred1[i][j]==0 and test_output[i][j]==1):
                    fn1=fn1+1

        precision=float(tp)/(tp+fp)
        recall=float(tp)/(tp+fn)
        fscore=float(2*recall*precision)/(float(precision+recall))

        precision1 = float(tp1) / (tp1 + fp1)
        recall1 = float(tp1) / (tp1 + fn1)
        fscore1 = float(2 * recall1 * precision1) / (float(precision1 + recall1))

        print('Epochs',epoch+1,'Train Data p,r,f-score',precision,recall,fscore,'Test Data p,r,f-score',precision1,recall1,fscore1)
        #print('Epochs',epoch+1,'Train Accuracy',sess.run(accuracy, feed_dict={x: train_input, y: train_output}),'Test Accuracy',sess.run(accuracy, feed_dict={x: test_input, y: test_output}),'loss',avg_cost)
        if(avg_cost<=0.001):
            break
