# ==========================================================================

# DATA SCIENCE SEMINAR, SPRING 2016, WEEK 03

# ==========================================================================

# opening options

rm(list = ls()) # clear workspace

# ==========================================================================

# file name - seminar03.R

# project name - data science seminar, spring 2016

# purpose - week 03 examples - basic manipulation with numeric data

# created - 12 Feb 2016

# updated - 12 Feb 2016

# author - CHRIS AND CHRISTY

# ==========================================================================

# full description - this file contains the code for replicating the 
# examples described during the week 03 meeting

# updates - none

# ==========================================================================

# superordinates  - none

# subordinates - none

# ==========================================================================
# ==========================================================================

# 1. review of week 2

#making databases out of vectors



# ==========================================================================

# 2. exploring data

# ==========================================================================

str() # print list of all variables
print(head()) # print list of first six observations
print(tail()) # print list of last six observations

#we can and will use our own data, but for now let's use some that R provides
#cars - Speed (mph) of cars and the distances (ft) taken to stop (1920s).

str(cars)
print(head(cars))
print(tail(cars))


# ==========================================================================

# 3. descriptive statistics

# ==========================================================================

mean() #mean value of particular variable
median() #median value
max() #largest value
min() #smallest value
range() #range of values
sd() #standard deviation of particular variable

#to single out a variable to test, we need to tell R which dataset & variable
#mean(dataset$variable)

mean(cars$speed)
median(cars$speed)
max(cars$speed)
min(cars$speed)
range(cars$speed)
sd(cars$speed)

summary() #summary of the properties of each variable in a dataset
#i.e. all of the tests we just did, for each variable in the dataset
summary(cars)

#histograms can also be a good first glance at the data
hist() #makes a histogram of a particular variable in a dataset
hist(cars$speed)
hist(cars$dist)

#with this simple dataset, we can also make a basic plot to look at
#the relationship between the two variables
#plot(dataset$variable1, dataset$variable2)
plot(cars$speed, cars$dist)

# ==========================================================================

# 4. read in data from CSV file

# ==========================================================================

car <- read.csv("car.csv") 
# import sample CSV data into dataframe -- as long as it is in the same 
# directory (folder), all you need is the file name to open in RStudio
str(car) # print list of all variables

# ==========================================================================

# 5. changing variables from numeric to factor and vice versa 

#R assumes anything numeric should be treated as a numeric variable by default
#Say that we want to treat speed as a factor instead of numeric because there are only certain speeds that are actually possible for these cars 

car$Speed <- factor(car$Speed)
is.factor(car$Speed)

#now R will treat this variable as a factor with four possible levels (4,7,8,9)

#Wait, I've changed my mind, speed is obviously continuous! Change it back...

car$Speed <- numeric(car$Speed)


# ==========================================================================

# 6. recoding variables 

#In our simplistic car data, we have a factor that is "Name" -- the name of the car. Say we want to classify the cars by some other feature, for instance, how good they are. We can recode this factor by adding a new column/factor to the dataframe. (Warning: I know nothing about cars....)

car$Quality <- NA 
car$Quality[car$Name == "no"] <- "no"
car$Quality[car$Name == "none"] <- NA
#This tells R to create a new column (that didn't exist previously) entitled "quality". It also tells R to not assign a value to anything that didn't have a value previously.

car$Quality[car$Name == "Model T"] <- "Good"
#Assign any instances of "Model T" to the level "Good" in our new column. 

car$Quality[car$Name == "Model A"] <- "Good"
car$Quality[car$Name == "Renault Vivastella"] <- "Bad"
car$Quality[car$Name == "Halford Special"] <- "Bad"
car$Quality[car$Name == "Fiat 520"] <- "Great"
car$Quality[car$Name == "Alfa Romeo G1"] <- "Great"

#check to make sure this worked
str(car)
summary(car)


# ==========================================================================

# closing options

# {none}

# ==========================================================================

# exit
