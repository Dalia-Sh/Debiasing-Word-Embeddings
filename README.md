# DS8008-project

## Instructions:

(1) Download glove.6B.zip from https://nlp.stanford.edu/projects/glove/ and unzip glove.6B.50d.txt into the project folder 

(2) Run the code in the jupyter notebook project.ipynb

## Introduction 

In this project, we aim to perform hard gender debiasing on pre-trained GloVe embeddings. For this project, we have chosen the 50-dimensional version of GloVe, which is based on Wik- ipedia 2014 and Gigaword5 and has 400,000 words. 

The method used consists of neutralizing and equalizing gender word pairs in such a way that any
non-gendered/neutral word is at equal distance to gender word pairs such as she-he.After plotting the extreme she-he occupations, we find that all occupations are at equal distance from the she and he axis. We also find that gender specific words have moved closer to their respective gender axis (corresponding she or he axis). Conclusions. The application of the suggested debiasing algorithm demonstrates promising results in terms of debiasing occupational stereotypes.
![GloVe Pre_debiasing](https://user-images.githubusercontent.com/1936040/56623079-b0937e00-6600-11e9-9b37-d518f43528f1.png)
![GloVe Post_debiasing](https://user-images.githubusercontent.com/1936040/56623083-b9844f80-6600-11e9-85b0-9f1b5aec65da.png)
