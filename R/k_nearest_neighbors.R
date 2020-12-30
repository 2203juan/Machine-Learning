df <- read.csv("~/Documents/Machine Learning/R/House-Price.csv", header = TRUE)

# first look of data
View(summary(df))

boxplot(df$n_hot_rooms)

pairs(~df$Sold+df$rainfall)

barplot(table(df$airport))
barplot(table(df$bus_ter))


# observations
# rainfall and n_hot_rooms have outliers
# n_hos_beds has missing values
# bus_ter is useless


# outliers treatment
uv <- 3*quantile(df$n_hot_rooms, 0.99)
df$n_hot_rooms[df$n_hot_rooms > uv] <- uv
summary(df$n_hot_rooms)

lv <- 0.3*quantile(df$rainfall, 0.01)
df$rainfall[df$rainfall < lv ] <- lv
summary(df$rainfall)

# fill na values with mean
mean_df <- mean(df$n_hos_beds, na.rm = TRUE)
df$n_hos_beds[is.na(df$n_hos_beds)] <- mean_df
summary(df$n_hos_beds)

which(is.na(df$n_hos_beds))

# as we have 4 columns about distance lets take just the average

df$avg_dist = (df$dist1+df$dist2+df$dist3+df$dist4)/4

# now remove dist1,dist2,dist3,dist4
df <- df[,-6:-9]
# delete bus_term (no useful)
df <-df[,-13]


# now lets transform categorical variables into numerical variables
df$airport <- as.numeric(df$airport)
df$waterbody <- as.numeric(df$waterbody)


library(caTools)
set.seed(0)
split <- sample.split(df, SplitRatio = 0.8)
train <- subset(df, split == TRUE)
test <- subset(df, split == FALSE)


# delete target columns
trainX = train[,-14]
testX = test[,-14]

trainY = train$Sold
testY = test$Sold

k = 3

trainX_s = scale(trainX)
testX_s = scale(testX)

library(class)
set.seed(0)
knn = knn(trainX_s, testX_s, trainY, k = k)

# confusion matrix
table(knn, testY)

