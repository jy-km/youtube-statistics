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
    Comments == 0 ~ "No Comments",
    Comments >= 1 & Comments <= 50 ~ "1-50 Comments",
    Comments >= 21 ~ "51+ Comments",
    TRUE ~ "Other"
  ))

combined <- combined %>% 
  mutate(LTVGroup = case_when(
    LTV > 0 & LTV <= 1 ~ "0-1 LTV",
    LTV > 1& LTV <= 2 ~ "2 LTV",
    LTV > 2 & LTV <= 4 ~ "3~4 LTV",
    LTV > 4 & LTV <= 6 ~ "5~6 LTV",
    LTV > 6 ~ "6+ LTV",
    TRUE ~ "Other"
  ))

combined <- combined %>% 
  mutate(DiffGroup = case_when(
    Diff >= 0   & Diff <= 7     ~ "<= 1 week",
    Diff >= 8   & Diff <= 31    ~ "<= 1 month",
    Diff >= 32  & Diff <= 365   ~ "<= 1 year",
    Diff >= 366 & Diff <= 732   ~ "<= 2 years",
    Diff > 732                  ~ "> 2 years",
    TRUE                        ~ "Other"
  ))

combined$CommentsGroup <- factor(combined$CommentsGroup,
                                 levels = c("No Comments", "1-50 Comments", "51+ Comments","Other"))

combined$ViewsLog <- log10(combined$Views)

combined$LTVLog <- log10(combined$LTV)
  