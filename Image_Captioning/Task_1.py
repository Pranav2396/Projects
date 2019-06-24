import pretrainedmodels
import torch
import pretrainedmodels.utils as utils
import numpy as np
import glob
import tensorflow as tf
print(torch.cuda.is_available())
#Gorilla -366
#Binoculars-447
#Mushroom-947
#Watch-826
#faces-1073

from sklearn.utils import shuffle

model_name = 'vgg16' # could be fbresnet152 or inceptionresnetv2
model = pretrainedmodels.__dict__[model_name](num_classes=1000, pretrained='imagenet')
print(pretrainedmodels.pretrained_settings[model_name])
model.eval()
#
# total=0
#
path1=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\090.gorilla\\*.jpg')
path2=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\012.binoculars\\*.jpg')
path3=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\147.mushroom\\*.jpg')
path4=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\240.watch-101\\*.jpg')
path5=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\253.faces-easy-101\\*.jpg')

tot=len(path1)+len(path2)+len(path3)+len(path4)+len(path5)

data_input=np.zeros(shape=(tot,4096))
data_output=np.zeros(shape=(tot,5),dtype=int)

####################################################################Gorilla#########################
path1=glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\090.gorilla\\*.jpg')

arr_count=0

total=0
count1=0

total=total+len(path1)

for i in range(0,len(path1)):
    load_img = utils.LoadImage()

    # transformations depending on the model
    # rescale, center crop, normalize, and others (ex: ToBGR, ToRange255)
    tf_img = utils.TransformImage(model)

    path_img = path1[i]

    input_img = load_img(path_img)
    input_tensor = tf_img(input_img)
    input_tensor = input_tensor.unsqueeze(0)
    input = torch.autograd.Variable(input_tensor,
        requires_grad=False)

    features=model.features(input)
    features=torch.Tensor.detach(features).numpy()
    data_input[arr_count]=features[0]
    data_output[arr_count][0]=1
    arr_count=arr_count+1

    # output_logits = model(input) # 1x1000
    # #print(output_logits.data)
    # arr=output_logits.data
    # arr1=torch.Tensor.detach(arr).numpy()
    # # print(arr1)
    # ind=arr1[0].argsort()[-5:][::-1]
    # for j in range(0,5):
    #     if(ind[j]==366):
    #         count1=count1+1
    #         break

print('Class 1 done')
######################################################################Binoculars################
path1 = glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\012.binoculars\\*.jpg')

count2 = 0

total = total + len(path1)

for i in range(0, len(path1)):
    load_img = utils.LoadImage()

    # transformations depending on the model
    # rescale, center crop, normalize, and others (ex: ToBGR, ToRange255)
    tf_img = utils.TransformImage(model)

    path_img = path1[i]

    input_img = load_img(path_img)
    input_tensor = tf_img(input_img)  # 3x400x225 -> 3x299x299 size may differ
    input_tensor = input_tensor.unsqueeze(0)  # 3x299x299 -> 1x3x299x299
    input = torch.autograd.Variable(input_tensor,
                                    requires_grad=False)

    output_logits = model(input)  # 1x1000

    features = model.features(input)
    features = torch.Tensor.detach(features).numpy()
    data_input[arr_count] = features[0]
    data_output[arr_count][1] = 1
    arr_count = arr_count + 1

    # print(output_logits.data)
    # arr = output_logits.data
    # arr1 = torch.Tensor.detach(arr).numpy()
    # # print(arr1)
    # ind = arr1[0].argsort()[-5:][::-1]
    # #print(ind)
    # for j in range(0, 5):
    #     if (ind[j] == 447):
    #         count2 = count2 + 1
    #         break

print('Class 2 done')
######################################################################Mushroom################
path1 = glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\147.mushroom\\*.jpg')

count3 = 0

total = total + len(path1)

for i in range(0, len(path1)):
    load_img = utils.LoadImage()

    # transformations depending on the model
    # rescale, center crop, normalize, and others (ex: ToBGR, ToRange255)
    tf_img = utils.TransformImage(model)

    path_img = path1[i]

    input_img = load_img(path_img)
    input_tensor = tf_img(input_img)  # 3x400x225 -> 3x299x299 size may differ
    input_tensor = input_tensor.unsqueeze(0)  # 3x299x299 -> 1x3x299x299
    input = torch.autograd.Variable(input_tensor,
                                    requires_grad=False)

    features = model.features(input)
    features = torch.Tensor.detach(features).numpy()
    data_input[arr_count] = features[0]
    data_output[arr_count][2] = 1
    arr_count = arr_count + 1

    # output_logits = model(input)  # 1x1000
    # # print(output_logits.data)
    # arr = output_logits.data
    # arr1 = torch.Tensor.detach(arr).numpy()
    # # print(arr1)
    # ind = arr1[0].argsort()[-5:][::-1]
    # #print(ind)
    # for j in range(0, 5):
    #     if (ind[j] == 947):
    #         count3 = count3 + 1
    #         break

print('Class 3 done')
######################################################################Watch################
path1 = glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\240.watch-101\\*.jpg')

count4 = 0

total = total + len(path1)

for i in range(0, len(path1)):
    load_img = utils.LoadImage()

    # transformations depending on the model
    # rescale, center crop, normalize, and others (ex: ToBGR, ToRange255)
    tf_img = utils.TransformImage(model)

    path_img = path1[i]

    input_img = load_img(path_img)
    input_tensor = tf_img(input_img)  # 3x400x225 -> 3x299x299 size may differ
    input_tensor = input_tensor.unsqueeze(0)  # 3x299x299 -> 1x3x299x299
    input = torch.autograd.Variable(input_tensor,
                                    requires_grad=False)

    features = model.features(input)
    features = torch.Tensor.detach(features).numpy()
    data_input[arr_count] = features[0]
    data_output[arr_count][3] = 1
    arr_count = arr_count + 1

    # output_logits = model(input)  # 1x1000
    # # print(output_logits.data)
    # arr = output_logits.data
    # arr1 = torch.Tensor.detach(arr).numpy()
    # # print(arr1)
    # ind = arr1[0].argsort()[-5:][::-1]
    # #print(ind)
    # for j in range(0, 5):
    #     if (ind[j] == 826):
    #         count4 = count4 + 1
    #         break

print('Class 4 done')

######################################################################Watch################
path1 = glob.glob('D:\\PycharmProjects\\Learning\\Assignment_3\\classification\\253.faces-easy-101\\*.jpg')

count5 = 0

total = total + len(path1)

for i in range(0, len(path1)):
    load_img = utils.LoadImage()

    # transformations depending on the model
    # rescale, center crop, normalize, and others (ex: ToBGR, ToRange255)
    tf_img = utils.TransformImage(model)

    path_img = path1[i]

    input_img = load_img(path_img)
    input_tensor = tf_img(input_img)  # 3x400x225 -> 3x299x299 size may differ
    input_tensor = input_tensor.unsqueeze(0)  # 3x299x299 -> 1x3x299x299
    input = torch.autograd.Variable(input_tensor,
                                    requires_grad=False)

    features = model.features(input)
    features = torch.Tensor.detach(features).numpy()
    data_input[arr_count] = features[0]
    data_output[arr_count][4] = 1
    arr_count = arr_count + 1

    # output_logits = model(input)  # 1x1000
    # # print(output_logits.data)
    # arr = output_logits.data
    # arr1 = torch.Tensor.detach(arr).numpy()
    # # print(arr1)
    # ind = arr1[0].argsort()[-5:][::-1]
    # #print(ind)

print('Class 5 done')

#print('Without Manual training (Top-5 accuracy)',(float(count1+count2+count3+count4)/total)*100)


data_input,data_output=shuffle(data_input,data_output)

np.savez('data_input_1_vgg.npz', name1=data_input)
np.savez('data_output_1_vgg.npz', name1=data_output)

data_input=np.load('data_input_1_vgg.npz')['name1']
data_output=np.load('data_output_1_vgg.npz')['name1']

print(len(data_input),len(data_input[0]))
print(len(data_output),len(data_output[0]))

#####################Training Neural Network####################
dim=4096

train_input=data_input[0:np.int64(0.7*len(data_input))]
train_output=data_output[0:np.int64(0.7*len(data_output))]

test_input=data_input[1+np.int64(0.7*len(data_input)):len(data_input)]
test_output=data_output[1+np.int64(0.7*len(data_output)):len(data_output)]

h1_size=256
h2_size=128

initializer = tf.contrib.layers.xavier_initializer(seed=42)

x = tf.placeholder(tf.float32, [None, dim])
y = tf.placeholder(tf.float32, [None, 5])

W1 = tf.Variable(initializer([dim,h1_size]), name='W1')
b1 = tf.Variable(initializer([h1_size]), name='b1')

W2 = tf.Variable(initializer([h1_size,h2_size]), name='W2')
b2 = tf.Variable(initializer([h2_size]), name='b2')

W3 = tf.Variable(initializer([h2_size,5]), name='W3')
b3 = tf.Variable(initializer([5]), name='b3')

hidden_out = tf.add(tf.matmul(x, W1), b1)
hidden_out = tf.nn.relu(hidden_out)

hidden_out1=tf.add(tf.matmul(hidden_out,W2),b2)
hidden_out1=tf.nn.relu(hidden_out1)

#Output Layer
y_ = tf.nn.softmax(tf.add(tf.matmul(hidden_out1, W3), b3))

y_clipped = tf.clip_by_value(y_, 1e-10, 0.9999999)
cross_entropy = -tf.reduce_mean(tf.reduce_sum(y * tf.log(y_clipped)
                        + (1 - y) * tf.log(1 - y_clipped), axis=1))

# add an optimiser
optimiser = tf.train.AdamOptimizer(learning_rate=0.0001).minimize(cross_entropy)

#Setup
init_op = tf.global_variables_initializer()
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

#Training
batch_size=32
epochs=100

cur_cost=1000
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

            _, c = sess.run([optimiser, cross_entropy],feed_dict={x: batch_x, y: batch_y})
            avg_cost += c / total_batch

        temp=cur_cost
        cur_cost=avg_cost
        avg_cost=cur_cost

        print('Epochs',epoch+1,'Train Accuracy',sess.run(accuracy, feed_dict={x: train_input, y: train_output}),'Test Accuracy',sess.run(accuracy, feed_dict={x: test_input, y: test_output}),'loss',avg_cost)
        if(abs(avg_cost)<=0.0005):
            break
