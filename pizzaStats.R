suppressPackageStartupMessages(library(tidyverse))
pizza <- read_csv('pizza.csv')
library(lm.beta)



Q1 <-
  smallpiz <- select(pizza, temperature, bill, pizzas, got_wine)
  corpiz <- cor(smallpiz)
print(corpiz, digits = 2)

Q2 <- 
  filpiz <- filter(pizza, operator == "Laura" & branch == "East")
  smallpiz2 <- select(filpiz, time, temperature, bill, pizzas)
  corpiz2 <- cor(smallpiz2)
print(corpiz2, digits = 2)


temperature <- pizza$temperature
pizzas <- pizza$pizzas
got_wine <- pizza$got_wine
bill <- pizza$bill

Q3 <- 
  filpizza <- filter(pizza, temperature, bill, pizzas)
  var1 <- mutate(filpizza, winebin = ifelse(got_wine == 1, 0, 1))
  selpizza <- select(var1, winebin, temperature, bill, pizzas)
  logreg1 <- glm(selpizza$winebin ~ temperature + bill + pizzas, binomial, data = selpizza)
  summ <- summary(logreg1)
print(summ, digits = 4)

Q4 <- 
  regpiz2 <- lm(formula = pizza$bill ~ temperature + pizzas + got_wine)
  standpiz <- lm.beta(regpiz2)
print(standpiz)
 
AIC(regpiz)
AIC(standpiz)

Q5 <- 
  AIC(regpiz)
print(Q5)

