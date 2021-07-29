suppressPackageStartupMessages(library(tidyverse))
library(ggplot2)
head(msleep)

Q1 <- 
  carni <- filter(msleep, vore == "carni" & conservation == "lc")
  summ <- summarise(carni, var = var(sleep_total))
  total <- as.data.frame(summ)
  options(digits = 4)
  print(total)

Q2s <- filter(msleep, order == "Rodentia")
  no_na <- na.omit(msleep)
  sleep_df <- mutate(no_na, sleep = sleep_total/sleep_rem )
  most_sleep <- arrange(sleep_df, desc(sleep))
  first <- head(most_sleep, 1)
  first_2 <- select(first, name)
  print(first_2)
  
Q3 <- primates <- filter(msleep, order == "Primates")
  ratio_df = transmute(primates, ratio = bodywt/brainwt)
  over <- filter(ratio_df, ratio > 100)
  counts <- count(over)
  print(counts)

Q4 <- cons <- group_by(msleep, conservation)
  no_na <- select_if(cons, ~ !any(is.na(.)))
  no_na_df <- na.omit(no_na)
  new_vars <- mutate(no_na_df, mean_sleep = mean(sleep_total), var_sleep = var(sleep_total))
  small <- select(new_vars, conservation, mean_sleep, var_sleep)
  dist_df <- distinct(small, mean_sleep, var_sleep, .keep_all=TRUE)
  arr <- arrange(dist_df, conservation)
  df <- as.data.frame(arr)
  options(digits = 3)
  print(df)
  
Q5 <- herb <- filter(msleep, conservation == "domesticated" & vore == "herbi" & sleep_total > 12)
  df_2 <- select(herb, name)
  print(df_2)


