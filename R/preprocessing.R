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

