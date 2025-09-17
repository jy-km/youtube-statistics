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
finaldf <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/truedf.csv")


finaldf$LTV <- as.numeric(finaldf$LTV)
finaldf$CTV <- as.numeric(finaldf$CTV)
finaldf$Comments <- as.numeric(finaldf$Comments)
finaldf$Views <- as.numeric(finaldf$Views)
  

#error
category_summary <- finaldf %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
    median_Comments = median(Comments, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(median_LTV, median_Comments), names_to = "Metric", values_to = "Value") %>%
  mutate(Metric = recode(Metric, median_LTV = "LTV", median_Comments = "Comments"))

category_LTV <- finaldf %>%
  group_by(Category) %>%
  summarise(
    median_LTV = median(LTV, na.rm = TRUE),
  ) %>%
  pivot_longer(cols = c(median_LTV), names_to = "Metric", values_to = "Value") %>%
  ungroup()

category_Comments <- finaldf %>%
  group_by(Category) %>%
  summarise(
    median_Comments = median(Comments, na.rm = TRUE),
  ) %>%
  pivot_longer(cols = c(median_Comments), names_to = "Metric", values_to = "Value") %>%
  ungroup()



# LTVGroup grouping
finaldf <- finaldf %>% 
  mutate(
    LTVGroup = case_when(
      LTV > 0     & LTV <= 0.015 ~ "0~0.015 LTV",
      LTV > 0.015 & LTV <= 0.03  ~ "0.015~0.03 LTV",
      LTV > 0.03  & LTV <= 0.06  ~ "0.03~0.06 LTV",
      LTV > 0.06 ~ "0.06~ LTV",
      TRUE ~ "Likes = 0"
    )
  )


# LTVGroup factoring
finaldf <- finaldf %>% 
  mutate(
    LTVGroup = factor(
      LTVGroup,
      levels = c("0~0.015 LTV", "0.015~0.03 LTV", "0.03~0.06 LTV", "0.06~ LTV", "Likes = 0")
    )
  )


# DiffGroup grouping
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = case_when(
      Diff >= 0   & Diff <= 6    ~ "<1 week",
      Diff >= 7   & Diff <= 121  ~ "≥1 week, <3 months",
      Diff >= 122 & Diff <= 730  ~ "≥3 months, <2 years",
      Diff >= 731 & Diff <= 919  ~ "≥2 years",
    )
  )

# DiffGroup factoring
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = factor(
      DiffGroup,
      levels = c("<1 week", "≥1 week, <3 months", "≥3 months, <2 years", "≥2 years")
    )
  )

# DurationGroup grouping
finaldf <- finaldf %>% 
  mutate(
    DurationGroup = case_when(
      Duration >= 0    & Duration <= 60    ~ "0–1 min (0 ≤ t ≤ 60 sec)",
      Duration >= 61   & Duration <= 900   ~ "1–15 min (61 ≤ t ≤ 900 sec)",
      Duration >= 901  & Duration <= 3600  ~ "15–60 min (901 ≤ t ≤ 3600 sec)",
      Duration >= 3601                     ~ "60min~ (3601 ≤ t sec)",
    )
  )

# DurationGroup factoring
finaldf <- finaldf %>% 
  mutate(
    DurationGroup = factor(
      DurationGroup,
      levels = c(
        "0–1 min (0 ≤ t ≤ 60 sec)",
        "1–15 min (61 ≤ t ≤ 900 sec)",
        "15–60 min (901 ≤ t ≤ 3600 sec)",
        "60min~ (3601 ≤ t sec)"
        )
    )
  )

finaldf <- finaldf %>%
  mutate(
    CommentsGroup = factor(
      CommentsGroup,
      levels = c(
        "No Comments",
        "1-10 Comments",
        "11-100 Comments",
        "101-1000 Comments",
        "1001+ Comments"
      )
    )
  )

finaldf$ViewsLog <- log10(finaldf$Views)

finaldf$LikesLog <- log10(finaldf$Likes)
 
finaldf <- finaldf %>%
  mutate(Duration_min = Duration / 60)


finaldf$CTV <- (finaldf$CTV * 10) #x1000

finaldf$LTV <- (finaldf$LTV / 100) #percentage -> raw ratio


