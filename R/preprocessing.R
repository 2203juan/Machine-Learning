df <- read.csv("~/Documents/Machine Learning/R/House_Price.csv", header = TRUE)

View(df)

# look for dataset summary

View(summary(df))

# there are some variables expected to have outliers, letś look them

hist(df$crime_rate, breaks = 5)
pairs(~price+crime_rate+n_hot_rooms+rainfall, data = df)
barplot(table(df$airport))
barplot(table(df$waterbody))
barplot(table(df$bus_ter))

# Observations

# n_hot_rooms and rainfall has outliers
# n_hos_beds has missing values
# bus_term is useless variable (everything is "yes")
# Crime_rate has a functional relationship with price

# we use capping and flooring mehod to treat outliers

# upper cut
uv = 3*quantile(df$n_hot_rooms, 0.99)
df$n_hot_rooms[df$n_hot_rooms > uv] <- uv
summary(df$n_hot_rooms)

# lower cut
lv = 0.3*quantile(df$rainfall, 0.01)
df$rainfall[df$rainfall < lv] <- lv
summary(df$rainfall)

# now lets make the imputation of missing values

n_hos_beds_mean <-mean(df$n_hos_beds, na.rm = TRUE)
df$n_hos_beds[is.na(df$n_hos_beds)] <- n_hos_beds_mean
which(is.na(df$n_hos_beds))

# look for Crime relationship with price

pairs(~price+crime_rate, data = df)
plot(df$price, df$crime_rate, xlab = "PRICE", ylab = "Crime Rate")

# it seems like a logarithmic relationship, let's take log of crime_rate
df$crime_rate = log(df$crime_rate)
plot(df$price, df$crime_rate, xlab = "PRICE", ylab = "Crime Rate")

# as we have 4 columns about distance lets take just the average

df$avg_dist = (df$dist1+df$dist2+df$dist3+df$dist4)/4

# now remove dist1,dist2,dist3,dist4
df <- df[,-7:-10]
# delete bus_term (no useful)
df <-df[,-14]

# now lets transform categorical variables into numerical variables
df$airport <- as.numeric(df$airport)
df$waterbody <- as.numeric(df$waterbody)

# compute correlation matrix
cormat <- round(cor(df),2)
install.packages("reshape2")
library(reshape2)
melted_cormat <- melt(cormat)
library(ggplot2)
ggplot(data = melted_cormat, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()

# delete parks because of hight correlation with air_qual
df <-df[,-14]

# simple linear regression between price and room_num
lr <-lm(price~room_num, data = df)
summary(lr)
plot(df$room_num, df$price)
abline(lr)

# multiple linear regression

multi_lr <- lm(price~., data = df)
summary(multi_lr)

# train-test split
install.packages("caTools")
set.seed(0)
split = sample.split(df, SplitRatio = 0.8)
train <- subset(df, split == TRUE)
test <- subset(df, split == FALSE)