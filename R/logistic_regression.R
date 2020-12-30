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


# Logistic regression sold vs price

glm = glm(Sold~price, data = df, family = binomial)
summary(glm)

# Logistic regression sold vs all
glm2 = glm(Sold~., data = df, family = binomial)
summary(glm2)

probs = predict(glm2, type = "response")

pred = rep("NO",506)

pred[probs > 0.5] = "YES"

# confusion matrix
conf_mtx = table(pred, df$Sold)
conf_mtx