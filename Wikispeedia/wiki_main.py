import numpy as np
import urllib.parse
from collections import defaultdict
import sys
import re
import math
import heapq
import csv
import json

f=open("paths/paths_finished.tsv","r")

x=f.readlines()[16:]

paths=[]
rating=[]

string_set=set()
goal_words=set()

word_to_index={}
index_to_word={}

alpha=0.1 ##Dirichlet Parameter

for i in range(0,len(x)):
    y=x[i].split()
    path=y[3].split(';')
    for j in range(0,len(path)):
        path[j]=urllib.parse.unquote(path[j]).lower()

    paths.append(path)
    goal_words.add(path[len(path)-1])

    for j in range(0,len(path)):
        string_set.add(path[j])
    if(y[4]=="NULL"):
        rating.append(-1)
    else:
        rating.append(y[4])

c=0
#
# f=open("paths/splits-vs-preds.txt","r")
# x=f.readlines()[2:]
# pattern = re.compile(r'\s+')
#
# for i in range(0,len(x)):
#     string=x[i].rstrip("\n")
#     string = re.sub(pattern, '_', string)
#     string=string.lower()
#
#     string=string.replace("***", ";")
#     string=string.replace("~~~", ";")
#     string=string.replace(";;", ";")
#     arr=string.split(";")
#     arr1=[]
#     if(arr[0]==''):
#         for j in range(1,len(arr)):
#             arr1.append(arr[j])
#         arr=arr1
#
#     for j in range(0,len(arr)):
#         string_set.add(arr[j])
#
#     paths.append(arr)
#     goal_words.add(arr[len(arr) - 1])
# paths1=[['Hurricane_Vince_(2005)', 'Spain', 'France', '<', '18th_century', '20th_century', 'Computer', 'Charles_Babbage', '<', '<', '<', '<', '15th_century', '20th_century', 'Internet', '<', 'Computer', 'Computer_programming', 'Programming_language', 'Scheme_programming_language', '<', '<', 'Linguistics', 'Noam_Chomsky']]
# string_set=set()
#
# for j in range(0, len(paths1[0])):
#     string_set.add(paths1[0][j])
#

for word in string_set:
    word_to_index[word]=c
    index_to_word[c]=word
    c=c+1


number=np.zeros(shape=(len(string_set),len(string_set)),dtype=int)
number_dash=defaultdict(lambda: defaultdict(dict))
p_star=defaultdict(lambda: defaultdict(dict))
p_zero=defaultdict(lambda: defaultdict(dict))
adj_list = defaultdict(list)
adj_matrix=np.zeros(shape=(len(string_set),len(string_set)),dtype=int)

sets = [set() for _ in range(len(string_set))]
#number_dash=np.zeros(shape=(len(string_set),len(string_set),len(string_set)),dtype=np.int)
#p_star=np.zeros(shape=(len(string_set),len(string_set),len(string_set)),dtype=float)

indegree=np.zeros(shape=(len(string_set)))
outdegree=np.zeros(shape=(len(string_set)))

for i in range(0,len(paths)):
    p=paths[i]
    goal_string=p[len(p)-1]
    goal_index = word_to_index[goal_string]

    for j in range(0,len(p)-1):
        string=p[j]
        #if(string=='Computer' and goal_string=='Noam_Chomsky'):
        #    print(p)
        string_index=word_to_index[string]
        number[goal_index][string_index]=number[goal_index][string_index]+1

    stack=[]
    j=0

    while(j<(len(p)-1)):
        string_index_1 = word_to_index[p[j]]
        string_index_2 = word_to_index[p[j+1]]

        tt=j
        flag=0

        popp=-1

        while(len(stack)>0 and tt<len(p) and p[tt]=='<'):
            if(flag==0):
                popp1=stack.pop()
                flag=1
            elif(p[tt]=='<' and p[tt+1]!='<'):
                popp=stack[len(stack)-1]
                tt=tt+1
                break
            elif(len(stack)>0):
                popp=stack.pop()
                tt=tt+1
                flag=1

        if(popp!=-1):
            #print(index_to_word[popp])
            sets[popp].add(word_to_index[p[tt]])

        if(p[j]!='<'):
          stack.append(string_index_1)

        if(len(sets[string_index_1])==0 or string_index_2 not in sets[string_index_1]):
          adj_list[string_index_1].append(string_index_2)
          adj_matrix[string_index_1][string_index_2]=1
          if((j+1)<len(p) and p[j+1]!='<'):
            sets[string_index_1].add(string_index_2)

        try:
          number_dash[goal_index][string_index_1][string_index_2]=number_dash[goal_index][string_index_1][string_index_2]+1
        except KeyError:
          number_dash[goal_index][string_index_1][string_index_2]=1

        if(flag==1):
         j=tt
        else:
         j=j+1


for j in range(0,len(string_set)):
    outdegree[j]=len(sets[j])

#print(adj_matrix[word_to_index['England']][word_to_index['Charles_Darwin']])

for i in range(0,len(paths)):
    p=paths[i]
    goal_string=p[len(p)-1]
    goal_index = word_to_index[goal_string]

    for j in range(0,len(p)-1):
        string_index_1 = word_to_index[p[j]]
        string_index_2 = word_to_index[p[j + 1]]
        out=outdegree[string_index_1]

        try:
            numerator=float(number_dash[goal_index][string_index_1][string_index_2])+alpha
            denominator=float(number[goal_index][string_index_1]) + (alpha*out)
            p_star[goal_index][string_index_1][string_index_2]=float(numerator)/denominator
            if(out!=0):
              p_zero[goal_index][string_index_1][string_index_2]=float(1.0)/out
        except:
            pass


gg=word_to_index['rainbow']
one=word_to_index['14th_century']
two=word_to_index['time']

#print(p_star[gg][one][two])

#####################################################################################
pagerank={}

for line in open("pagerank.txt"):
    listWords = line.split("\t")
    w=urllib.parse.unquote(listWords[0]).lower()
    pagerank[w]=float(listWords[1])

distance=np.zeros(shape=(len(string_set),len(string_set)))
path_no=np.zeros(shape=(len(string_set),len(string_set)))
minn = np.zeros(shape=(len(string_set), len(string_set)))

for i in range(0,len(paths)):
    p=paths[i]

    goal_string = p[len(p) - 1]
    goal_index = word_to_index[goal_string]

    for j in range(0,len(p)-1):
        string_index_j=word_to_index[p[j]]

        sum=0
        for k in range(j,len(p)-1):
            string_index_1 = word_to_index[p[k]]
            string_index_2 = word_to_index[p[k + 1]]

            ###Calcuating dp(j,g)
            try:
              sum=sum+math.log(p_star[goal_index][string_index_1][string_index_2])
            except:
              pass

        temp=(-1*float(sum))/(pagerank[goal_string.lower()])
        #minn[goal_index][string_index_j]=temp
        distance[goal_index][string_index_j]=distance[goal_index][string_index_j]+temp

    # for j in range(0,len(p)-1):
    #     string_index_j=word_to_index[p[j]]
    #     distance[goal_index][string_index_j] = distance[goal_index][string_index_j] + minn[goal_index][string_index_j]

for i in range(0,len(paths)):
    p=paths[i]
    goal_string = p[len(p) - 1]
    goal_index = word_to_index[goal_string]
    seen=set()
    for j in range(0,len(p)-1):
        if(word_to_index[p[j]] not in seen):
            path_no[goal_index][word_to_index[p[j]]]=path_no[goal_index][word_to_index[p[j]]]+1
            seen.add(word_to_index[p[j]])

#print(distance[word_to_index['Noam_Chomsky']][word_to_index['Hurricane_Vince_(2005)']])
#print(path_no[word_to_index['Noam_Chomsky']][word_to_index['Computer']])

for i in range(0,len(string_set)):
    for j in range(0,len(string_set)):
        if(path_no[i][j]!=0):
          distance[i][j]=distance[i][j]/path_no[i][j]


#print(distance[word_to_index['Minneapolis']][word_to_index['Minnesota']])
vall={}

#word='england'
for i in  range(1,len(string_set)):
    if(index_to_word[i]!=word):
        if(distance[word_to_index[word]][i]==0):
            distance[word_to_index[word]][i]=math.inf
        vall[index_to_word[i]]=distance[word_to_index[word]][i]

#print(sorted(vall, key=vall.get))

sum_info=np.zeros(shape=(len(string_set),1))
sum_info1=np.zeros(shape=(len(string_set),1))

information_gain={}
# for i in range(0,len(string_set)):
#     string=index_to_word[i]
#     sum=0
#     if(i%10==0):
#         print(i)
#     for j in goal_words:
#         for k in sets[i]:
#             try:
#                 prob=p_star[word_to_index[j]][i][k]
#                 prob1=p_zero[word_to_index[j]][i][k]
#                 sum_info[k][0]=sum_info[k][0]+(-1*prob*math.log2(prob)) #j=goal_node , sets[k]=a', i=a
#                 sum_info1[k][0]=sum_info1[k][0]+(-1*prob1*math.log2(prob1))
#             except KeyError:
#                 pass
#
#
# for i in range(0,len(string_set)):
#     string=index_to_word[i]
#     information_gain[string]=sum_info[i][0]-sum_info1[i][0]
#
# np.savez('information_gain.npz', name1=information_gain)
information_gain=np.load('information_gain.npz')['name1'].item()

#print(information_gain)
#print(information_gain['England'])
# p_test=paths[0]
# print(p_test)
# p_test_info=[]
# for i in range(0,len(p_test)):
#     p_test_info.append(information_gain[p_test[i]])
# print(p_test_info)

#for i in range(0,4096):
#    print(sum_info[i][0])
#print(information_gain)
#print(information_gain)
#print(distance[word_to_index['Noam_Chomsky']][word_to_index['Linguistics']])
#print(distance[word_to_index['Noam_Chomsky']][word_to_index['United_States']])
#print(distance[word_to_index['Noam_Chomsky']][word_to_index['United_Kingdom']])
#print(urllib.parse.unquote('%C3%81ed%C3%A1n_mac_Gabr%C3%A1in'))

#print(information_gain)

final_sets = [set() for _ in range(len(string_set))]

for i in range (0,len(paths)):
    counter=0
    p=paths[i]
    goal_string=p[len(p)-1]
    info=information_gain[goal_string]

    for j in range(len(p)-2,0,-1):
        if(information_gain[p[j]]<info and counter<10):
            break
        else:
            info=information_gain[p[j]]
            final_sets[word_to_index[goal_string]].add(word_to_index[p[j]])
        counter=counter+1

final_sets_wiki=[ [] for _ in range(len(string_set))]

for goal_word in goal_words:
    goal_string=goal_word
    li=[]

    #print(goal_string)
    for ind in final_sets[word_to_index[goal_string]]:
        heapq.heappush(li,(distance[word_to_index[goal_string]][ind],index_to_word[ind]))

    for i in range(0,5):
        if(len(li)==0):
            break
        tup=heapq.heappop(li)
        lii=list(tup)
        final_sets_wiki[word_to_index[goal_string]].append(lii[1])

from collections import defaultdict
d = defaultdict(list)

for i in range(0,len(string_set)):
    for j in range(0,len(final_sets_wiki[i])):
      d[index_to_word[i]].append(final_sets_wiki[i][j])

np.save('data_file.npy', d)
print('Words related to Rainbow ->')
for word in final_sets_wiki[word_to_index['rainbow']]:
     print(word,end=' ')
print()

#################################Training Neural Network#################

paths_neural=[]
paths_output=[]

pattern = re.compile(r'\s+')

f=open("paths/splits-vs-preds.txt","r")

x=f.readlines()[2:]
data=[]
split_data=[]

for i in range(0,len(x)):
    flag=1
    string=x[i].rstrip("\n")
    string = re.sub(pattern, '_', string)
    string=string.lower()

    string1=string
    string1=string1.replace("~~~", ";")
    string1=string1.split("***")[1]
    string1=string1.split(";")
    split_string=string1[0]

    if(string1[0]==''):
        split_string=string1[1]

    split_string_index=word_to_index[split_string]

    arr1=np.zeros(shape=(len(string_set)))
    arr1[split_string_index]=1

    string=string.replace("***", ";")
    string=string.replace("~~~", ";")
    string=string.replace(";;", ";")
    arr=string.split(";")

    split_index=-1

    for j in range(0,len(arr)):
        if(arr[j]==split_string):
            split_index=j
            break

    for j in range(0,len(arr)):
        if(arr[j] not in string_set):
            flag=0
            break

    if(flag==1):
      paths_neural.append(arr)
      paths_output.append(arr1)
      split_data.append(split_index)

print('No of split paths',len(paths_neural))
#print(paths_output[0][word_to_index['medicine']])
#print(paths_output[0][word_to_index['16_Cygni_Bb']])

train_input=[]
train_output=[]
train_split=[]

test_input=[]
test_output=[]
test_split=[]

for i in range(0,int(0.8*len(paths_neural))):
    p=paths_neural[i]
    #print(p)
    A=[]
    for j in range(0,len(p)):
          A.append(information_gain[p[j]])
    for j in range(0,len(p)):
        goal_distance=len(p)-j-1
        tempo = np.zeros(shape=(2))
        min=math.inf
        min_index=-1

        for k in range(j+1,len(p)):
          if(A[k]<min):
              min=A[k]
              min_index=k


        index = word_to_index[p[j]]

        #tempo[0]=index
        tempo[0]=goal_distance

        if(min_index==-1):
            tempo[1]=-1
        else:
            tempo[1]=min_index-j

        if(paths_output[i][index]==1):
            train_output.append(1)
        else:
            train_output.append(0)

        train_input.append(tempo)

for i in range(int(0.8*len(paths_neural))+1,len(paths_neural)):
    p=paths_neural[i]
    #print(p)
    A=[]
    for j in range(0,len(p)):
          A.append(information_gain[p[j]])
    for j in range(0,len(p)):
        goal_distance=len(p)-j-1
        tempo = np.zeros(shape=(2))
        min=math.inf
        min_index=-1

        for k in range(j+1,len(p)):
          if(A[k]<min):
              min=A[k]
              min_index=k


        index = word_to_index[p[j]]

        #tempo[0]=index
        tempo[0]=goal_distance

        if(min_index==-1):
            tempo[1]=-1
        else:
            tempo[1]=min_index-j

        if(paths_output[i][index]==1):
            test_output.append(1)
        else:
            test_output.append(0)

        test_input.append(tempo)

train_split=split_data[0:np.int64(0.8*len(split_data))]
test_split=split_data[1+np.int64(0.8*len(split_data)):len(split_data)]

#print(train_input[0])
#print(train_input[5])

#########################################Building a neural network###################################
print('Training Neural network.......')

import tensorflow as tf

inp_size=2

train_input=np.reshape(train_input,(len(train_input),inp_size))
train_output=np.reshape(train_output,(len(train_output),1))

# train_input=train_data[0:np.int64(0.8*len(train_data))]
# train_output=train_output[0:np.int64(0.8*len(train_output))]
#
# test_input=train_data[1+np.int64(0.8*len(train_data)):len(train_data)]
# test_output=train_output[1+np.int64(0.8*len(train_output)):len(train_output)]

h1_size=2

initializer = tf.contrib.layers.xavier_initializer(seed=15)

###############################Auto-encoder 1########################
x = tf.placeholder(tf.float32, [None, inp_size])
y = tf.placeholder(tf.float32, [None, 1])

# now declare the weights connecting the input to the hidden layer1
W1 = tf.Variable(initializer([inp_size,h1_size]), name='W1')
b1 = tf.Variable(initializer([h1_size]), name='b1')

W2 = tf.Variable(initializer([h1_size,1]), name='W2')
b2 = tf.Variable(initializer([1]), name='b2')

# calculate the output of the hidden layer
hidden_out = tf.add(tf.matmul(x, W1), b1)
hidden_out = tf.nn.tanh(hidden_out)

#Output Layer
y_ = tf.add(tf.matmul(hidden_out, W2), b2)
y_=tf.nn.sigmoid(y_)

sse=tf.reduce_mean(tf.squared_difference(y, y_))

# add an optimiser
optimiser = tf.train.AdamOptimizer(learning_rate=0.0001).minimize(sse)

#Setup
init_op = tf.global_variables_initializer()
correct_prediction = tf.equal(tf.argmax(y, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, tf.float32))

#Training
batch_size=16
epochs=100

# start the session
with tf.Session() as sess1:
   # initialise the variables
   sess1.run(init_op)
   tf_saver = tf.train.Saver(tf.all_variables())
   total_batch = int(len(train_input) / batch_size)
   for epoch in range(epochs):
        avg_cost = 0
        for i in range(total_batch):
            start=i*batch_size
            end=start+batch_size

            batch_x=train_input[start:end]
            batch_y=train_output[start:end]

            _, c = sess1.run([optimiser, sse],feed_dict={x: batch_x, y: batch_y})
            avg_cost += c / total_batch

        print('Epochs',epoch+1,'Loss',avg_cost)

   tf_saver.save(sess1,"model.ckpt")

with tf.Session() as sess2:
    tf.train.Saver().restore(sess2,"model.ckpt")
    W11=sess2.run(W1)
    b11=sess2.run(b1)
    W22 = sess2.run(W2)
    b22 = sess2.run(b2)

W1=W11
b1=b11
W2=W22
b2=b22

predicted_output=[]
c=0
count=0
sum=0

for i in range(int(0.8*len(paths_neural))+1,len(paths_neural)):
    p=paths_neural[i]
    arr2=[]

    for j in range(0,len(p)):
        inp=test_input[c]
        h1 = np.add(np.matmul(inp, W1), b1)
        pred_output = np.add(np.matmul(h1, W2), b2)
        arr2.append(pred_output)
        c=c+1

    oo=arr2.index(max(arr2))
    predicted_output.append(oo)

for i in range(0,len(predicted_output)):
    sum=sum+(abs(test_split[i]-predicted_output[i]))
    if(abs(test_split[i]-predicted_output[i])<=1):
         print(test_split[i],predicted_output[i])
    count=count+1

print(float(sum)/count)