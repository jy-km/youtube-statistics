library(tidyverse)
library(dplyr)
library(ggplot2)
library(data.table)
library(ggstatsplot)
library(patchwork)
library(GGally)
library(moments)
library(Rmisc)
library(DescTools)
library(ggpubr)
library(gtsummary)
library(table1)
library(purrr)
library(plotly)
library(htmlwidgets)

finaldf <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/nozero_edit.csv")



finaldf$LTV <- as.numeric(finaldf$LTV)
finaldf$Views <- as.numeric(finaldf$Views)

category_LTV <- finaldf %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
  ) %>%
  pivot_longer(cols = c(median_LTV), names_to = "Metric", values_to = "Value") %>%
  ungroup()

category_summary <- finaldf %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
    median_Comments = median(Comments, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(median_LTV, median_Comments), names_to = "Metric", values_to = "Value") %>%
  mutate(Metric = recode(Metric, median_LTV = "LTV", median_Comments = "Comments"))

# LTVGroup grouping
finaldf <- finaldf %>% 
  mutate(
    LTVGroup = case_when(
      LTV > 0     & LTV <= 0.015 ~ "0~0.015 LTV",
      LTV > 0.015 & LTV <= 0.03  ~ "0.015~0.03 LTV",
      LTV > 0.03  & LTV <= 0.06  ~ "0.03~0.06 LTV",
      LTV > 0.06 ~ "0.06~1 LTV"
    )
  )


# LTVGroup factoring
finaldf <- finaldf %>% 
  mutate(
    LTVGroup = factor(
      LTVGroup,
      levels = c("Likes = 0", "0~0.015 LTV", "0.015~0.03 LTV", "0.03~0.06 LTV", "0.06~1 LTV")
    )
  )


# DiffGroup grouping
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = case_when(
      Diff >= 0   & Diff <= 6    ~ "About 1 day (0-6 days)",
      Diff >= 7   & Diff <= 121  ~ "About 1 month (7-121 days)",
      Diff >= 122 & Diff <= 730  ~ "About 1 year (122-730 days)",
      Diff >= 731 & Diff <= 919  ~ "≥2 years (731-919 days)",
    )
  )

# DiffGroup factoring
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = factor(
      DiffGroup,
      levels = c("About 1 day (0-6 days)", "About 1 month (7-121 days)", "About 1 year (122-730 days)", "≥2 years (731-919 days)")
    )
  )


finaldf$ViewsLog <- log10(finaldf$Views)

finaldf$LTV <- (finaldf$LTV / 100) 

finaldf <- finaldf %>%
  filter(Duration != 0)

