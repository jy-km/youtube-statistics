library(tidyverse)
library(dplyr)
library(ggplot2)
library(data.table)

combined <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_6_28.csv")

combined$LTV <- as.numeric(combined$LTV)
combined$CTL <- as.numeric(combined$CTL)
combined$Comments <- as.numeric(combined$Comments)
combined$Views <- as.numeric(combined$Views)


category_summary <- combined %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
    median_Comments = median(Comments, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(median_LTV, median_Comments), names_to = "Metric", values_to = "Value") %>%
  mutate(Metric = recode(Metric, median_LTV = "LTV", median_Comments = "Comments"))

category_LTV <- combined %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
  ) %>%
  pivot_longer(cols = c(median_LTV), names_to = "Metric", values_to = "Value") %>%
  ungroup()

category_Comments <- combined %>%
  group_by(Category) %>%
  summarise(
    median_Comments = median(Comments, na.rm = TRUE),
  ) %>%
  pivot_longer(cols = c(median_Comments), names_to = "Metric", values_to = "Value") %>%
  ungroup()
