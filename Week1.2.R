#this is an example R script to explore creating a script installing packages, loading packages, and exploring data types

#hand out the RStudio setup document

#install a few packages - this installs the packages on your system but does not load them
#you can also use the install button in the packages tab in the bottom right pane
#packages are specific to a version of R. You can use packages from different versions, but sometimes there are issues
#  install.packages('dplyr')
#  install.packages('tidyr')
#  install.packages('ggplot2')
#  install.packages('DT')

#load a few packages
#note that when you load a package it sometimes reports that the package that was loaded has masked a function from a different package.
  library(dplyr) #a package for working with data

#Attaching package: ‘dplyr’

#The following objects are masked from ‘package:stats’:

#    filter, lag
#in this case, there are functions 'filter' and 'lag' that also occur in package 'stats' that is loaded automatically when R starts. These have been masked by package 'dplyr'. 
#If you call filter() it will do the steps specified by package dplyr automatically. The steps for filter() from the stats package can still be used, but you need to use stats::filter() instead of just filter().
  
#The following objects are masked from ‘package:base’:

#    intersect, setdiff, setequal, union   

#load the rest of the packages we will need for this exercise
  
  library(tidyr) #a package for transforming data
  library(ggplot2) #a package for graphing
  
  #note that this does not mask any other functions

  #assign a couple of the native datasets to variables
  data(iris) #flower data
  data(midwest) #demographic data for the midwest

#subset one of the columns
  poppovknown <- midwest$poppovertyknown

  
#data types
  #determine the data type of iris, mw, and mw1
  class(iris) #a data.frame
  class(midwest) #a dplyr data.frame
  class(poppovknown) #an integer vector
  
#look at the structure of each, you can also see this by clicking on the blue arrow next to the object in the environment
  str(iris) 
  str(midwest)
  str(poppovknown)
  

#data types
#  vector = collection of values of the same type. Example: "a","b","c" or 1,2,300 or 1.1, 1.4, 5.4 (a very common data type)
#  matrix = collection of values of the same type with 2 dimensions (I never use these)
#  array = collection of values of the same type with more than 2 dimensions (I have never used one of these)  
#  data.frame = a collection of vectors where each column is the same type and the same length (this is by far the most common type you will use)
#  list = a collection of vectors where each slot is the same type but does not have to be the same length as other slots (these are really cool and super powerful and behind a lot of R functionality, but I don't use these explicitly)

#data modes    
#  int = integer: whole number
#  chr = character: a text string
#  num = numeric: a decimal number
#  factor = a complicated data type that involves R taking character values and creating a lookup table linking the character value with an integer and then storing the integer in the dataframe (this happens behind the scenes and can be used for both good and evil) 
  
#If performing a task that requires ordering, character values will be alphabetized, numeric and integers will be ordered sequentially, factors will be alphabetized unless you specify a different order   
  
#we will mainly be working with vectors and data.frames

#other interesting functions
ls() #shows what is in the environment (you can see this in the Environment tab too)
head(iris) #shows the first 6 lines of data
View(iris) #see the entire dataset
getwd() #shows the current working directory
dir() #shows the contents of the directory
dim(iris) #shows the number of rows and columns of data
setwd("new working directory path") #allows you to change the working directory
rm(poppovknown) #removes mw1 from the environment  

#naming conventions 
#I use all lower case names for objects in my script (e.g. data, test, real.data, bushy_tail, etc).  You don't have to follow this, but it can be helpful to have a standard practice. Object names can not start with a number or contain spaces (e.g. 1.pic, real data)
#I use CamelCase for column names (e.g. Temperature, PlotID, CommonName, etc). Again, no numbers or spaces.
#So, in the mw dataframe, I would have named it PercAdultPoverty instead of percadultpoverty.

#creating your own data
#briefly, if you want to create a vector of values, you use c("value1","value2","value3", etc) or c(1,2,3,4), more below

#assignment vs comparison
#NA is used for missing data. If a cell is blank, it is actually "" or " " and not NA (NULL occasionally makes an appearance too, but is much less common and probably means something different).
#R uses <- to assign value to an object. You can also use =, but I find the arrow to be more explicit
  x <- c(1,0,NA) #assigns the values 1, 0, and NA to x
  x = c(1,0,NA) #also assigns the value 1 to x

  x
#R uses ==, <, >, <=, >=, !=, is.na() and ! for comparisons and a special %in% for exact comparisons
  x == 1 #this is telling you if each value in the vector == 1, it cant tell for the NA, so it returns NA. NOTE: R will return the NA for comparisons using ==
  x %in% 1 #this is doing exact matching. R knows that 1 isn't an exact match of NA, so it doesn't return the NA using %in%
  
#creating your own data
#lets create a vector and a small dataframe
  x <- c(1,2,3,4,5)
  y <- data.frame(ID = c(1,2,3,4,5), Animal = c("Cat","Dog","Pig","Hare","Guinea Pig"), Weight_lb = c(7.4, 45.3, 300, 2.5, 1.8))

#Week 1 Assignment: load one of the native datasets and explore 
#1) create an object from ????? (a native dataset in R)
#2) determine the class of data
#3) determine the structure of the data
#4) review the first 6 lines of data
#5) review all of the data
#6) how many columns and rows of data
#7) create an object named "zippy" that contains a vector from 6 to 10
#8) create a dataframe of anything
  
#why doesn't this work? Can you interpret the error?
  
  animals <- data.frame(ID = c(1,2,3,4), Animal = c("Cat","Dog","Pig","Hare","Guinea Pig"), Weight_lb = c(7.4, 45.3, 300, 2.5, 1.8))
  
#BONUS: how would you create y so that it does not turn "Animal" into a factor?
  
  
  