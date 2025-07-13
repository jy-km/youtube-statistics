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

combined <- combined %>% 
  mutate(CommentsGroup = case_when(
    Comments >= 0 & Comments <= 1 ~ "0-1 Comments",
    Comments >= 2 & Comments <= 30 ~ "2-30 Comments",
    Comments >= 31 & Comments <= 250 ~ "31-250 Comments",
    Comments >= 251 ~ "251+ Comments",
    TRUE ~ "Other"
  ))

combined$CommentsGroup <- factor(combined$CommentsGroup,
                                 levels = c("0-1 Comments", "2-30 Comments", "31-250 Comments", "251+ Comments","Other"))

combined$ViewsLog <- log10(combined$Views)

combined$LTVLog <- log10(combined$LTV)

combined <- combined %>%
  filter(Views >= 0, LTV >= 0) %>%
  mutate(
    log_Views = log10(Views),
    log_LTV = log10(LTV)
  )
  