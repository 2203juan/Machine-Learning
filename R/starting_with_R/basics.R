# Sentencias básicas en R

# sum
1 + 3

# print
print("Hello world from R")

# variables
x <- 2
y <- x + 3

# doble asignamiento
a <- b <- 10

# listas

l1 <- c(1,2,3,4,5)

l2 <- 1:10

w1 <- seq(5,50, by = 5)

# input

w2 <- scan()


# for
for (i in l2) {
  print(i)
}

# while
i <- 0
while(i < 10){
  print("hola")
  i <- i + 1
}

# list all variables in the workspace
ls()

# delete variables from workspace -> rm(variable)

# delete all variables -> rm(list = ls())