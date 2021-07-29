suppressPackageStartupMessages(library(tidyverse))
library(openintro)
library(lm.beta)
fastfood <- openintro::fastfood

Q1 <- 
  filff <- filter(fastfood, restaurant == "Sonic" | restaurant == "Subway" | restaurant == "Taco Bell")
  no_na <- na.omit(filff)
  selff <- select(no_na, calories, total_fat, sugar, calcium)
  corff <- cor(selff)
print(corff, digits = 2)


Q2 <- 

  smallfood <- filter(fastfood, restaurant == "Mcdonalds" | restaurant == "Subway")
  varfood <- mutate(smallfood, restbin = ifelse(restaurant == "Subway", 0, 1))
  selfood <- select(varfood, calories, sodium, protein, restbin)
  calories <- selfood$calories
  sodium <- selfood$sodium
  protein <- selfood$protein
  logregfood <- glm(selfood$restbin ~ calories + sodium + protein, binomial, data = selfood)
  sig <- round(logregfood$coefficients, digit = 2)
print(sig)

Q3 <-
  smallfood2 <- filter(fastfood, restaurant == "Mcdonalds" | restaurant == "Subway")
  varfood2 <- mutate(smallfood, restbin = ifelse(restaurant == 'Subway', 0, 1))
  selfood2 <- select(varfood, calories, protein, restbin)
  logregfood2 <- glm(selfood$restbin ~ selfood$calories  + selfood$protein, binomial, data = selfood2)
print(logregfood2, digits = 4)

Q3 <- AIC(logregfood)
print(Q3, digits = 5)

regfood <- lm(calories ~ sat_fat + fiber + sugar, data = fastfood)
print(regfood)

standfood <- lm.beta(regfood)
print(standfood)

Q4 <- regfood$coefficients[2]
print(Q4)

fil3 <- filter(fastfood, 50 < item | item < 60)
regress <- lm(total_fat ~ cholesterol + total_carb + vit_a + restaurant, data = fil3)

regress2 <- lm.beta(regress)

Q5 <- regress2$standardized.coefficients[2]

