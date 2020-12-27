# inbuilts datasets in R

data() # look for the dataset list

# let's look for one of them and it's description
? iris

# look for dataset structure
str(iris)
iris

# load dataset
data("iris")

# import data from a csv
file <- "~/Documents/Machine Learning/R/starting_with_R/exportaciones.csv"
test_data <- read.csv(file , header = TRUE)

# view data
View(test_data)
