# SLU Data Science Seminar
## Spring 2016, Seminar 03

### Seminar Overview

##### Exploring a data set
R Studio contains several data sets. The next several commands will allow us to explore the data set "cars". "cars" contains the speed (mph) of cars from the 1920s and the distances (ft) taken to stop.

*str(cars) will give you a list of all variables in the data set.
*print(head(cars)) will give you a list of the first six observations in the data set.
*print(tail(cars)) will generate a list of the last six observations.
*you can modify the print command to specify how many lines of data you want it to show: print(head(cars, n=3)) will give you n lines of data. This works for the tail also.
The print (head or tail) commands are useful if you have a large data set.
*print(cars) will generate all of the data. This is useful if you are looking at a small data set, such as the "cars" sample.

![screenshot1]
(https://github.com/slu-data-science-seminar/spring-2016-seminar-03/blob/master/images/image1.png)

##### Running descriptive statistics on a data set
###### Use the following commands to further explore a data set. For each command, in parenthesis you need to specify which data set and which variable you want to examine:  
mean(dataset$variable) will give you the mean value of a particular variable
median(dataset$variable)  - median value of a particular variable
max(dataset$variable)  - largest value
min(dataset$variable)  - smallest value
range(dataset$variable)  - range of values
sd(dataset$variable)  - standard deviation 

**OR** to get all of those measures EXCEPT the standard deviation, use the command summary(dataset).

We used all of these commands to look at the "speed" variable in "cars" data set:
![screenshot2]
(https://github.com/slu-data-science-seminar/spring-2016-seminar-03/blob/master/images/image2.png)

###### You can make a histogram to further explore the data. Use command hist(dataset$variable) to generate a histogram of a particular variable in a dataset.
We made a histogram to look at the variable "speed" in the "cars" data set:
![screen shot3]
https://github.com/slu-data-science-seminar/spring-2016-seminar-03/blob/master/images/Screen%20Shot%203.png

###### You can also make a scatter plot to examine the relationship between two variables. Use the command plot(dataset$variable1, dataset$variable2) to plot the data. The first variable will be plotted on the X-axis, the second on the Y-axis.
We plotted the variables "speed" and "distance" in the "cars" data set:
[screenshot5]
https://github.com/slu-data-science-seminar/spring-2016-seminar-03/blob/master/images/Screen%20Shot%205.png

##### How to read-in data (use your own data file) 
*csv is the suggested file format for importing your own data into R Studio.

First, tell R Studio where to locate your file. Set your working directory in the More/settings button in the file directory window   
**screen shot 6** 

Use the command read.csv("file name"). We did this with the file "car.csv".
Give your data set a name in R studio, so that it will appear in your global environment (upper right section of the screen). 
ex: car<-read.csv("car.csv")
Then you can run the other commands to look at the data and descriptive stats, as we did above with the "cars" sample data set.
**screen shot 7**

	
##### A few notes on variables and factors in R
*R assumes that anything numeric should be treated as a numeric variable by default.
*You can change the variable type; tell R that your variable is a factor of a certain type, rather than a numeric factor. For example, say that we want to treat speed as a factor instead of numeric because there are only certain speeds that are actually possible for these cars.

ex: car$speed<-as.factor(car$speed)
Now R will treat this variable as a factor with four possible levels (4,7,8,9)
**screen shot 8**

*Words are  assumed to be strings, and are made into factors. 

A reminder from Seminar 02: **Use StringsAsFactors = FALSE** This statement is used to keep string (character) data as strings. If you don't include this statement, they'll be converted to numbers.

##### A shortcut
To repeat a command in R Studio, hit the up arrow ⌃. You can use this shortcut to correct the syntax in an error, also.

