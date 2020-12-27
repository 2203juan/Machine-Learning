# import data from a csv
file <- "~/Documents/Machine Learning/R/starting_with_R/Customer.csv"
test_data <- read.csv(file , header = TRUE)

# view data
View(test_data)

# count by region

cnt_region <- table(test_data$Region)
View(cnt_region)

# barplot

# descending order
barplot(cnt_region[order(-cnt_region)])

# ascending order
barplot(cnt_region[order(cnt_region)])

# ascending order horizontal
barplot(cnt_region[order(cnt_region)], horiz = TRUE)

# adding colors
barplot(cnt_region[order(cnt_region)], horiz = TRUE, col = c("blue", "yellow", "green", "gray"))

# list colors
colors()

# removing border
barplot(cnt_region[order(cnt_region)], horiz = TRUE, col = c("blue", "yellow", "green", "gray"), border = NaN)

# Frec of Regions
barplot(cnt_region[order(cnt_region)], horiz = TRUE, col = c("blue", "yellow", "green", "gray"), border = NaN, main = "Freq of Regions")

# axis labels
barplot(cnt_region[order(cnt_region)], horiz = TRUE, col = c("blue", "yellow", "green", "gray"), border = NaN, main = "Freq of Regions", xlab = "Number of Customers", ylab = "Region")

# HISTOGRAM
hist(test_data$Age)

# with uniform breaks
hist(test_data$Age, breaks = 5)

n
# with not uniform breaks and freq and color and xlabel
hist(test_data$Age, breaks = c(0,40,60,100), freq = TRUE, col = "green", main = "Histogram of Age")


