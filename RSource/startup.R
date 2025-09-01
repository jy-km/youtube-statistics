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
finaldf <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/finaldf.csv")


finaldf$LTV <- as.numeric(finaldf$LTV)
finaldf$CTV <- as.numeric(finaldf$CTV)
finaldf$Comments <- as.numeric(finaldf$Comments)
finaldf$Views <- as.numeric(finaldf$Views)
  
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
      LTV > 0.06  & LTV <= 1     ~ "0.06~ LTV",
      TRUE                       ~ "Other"
    )
  )


# LTVGroup factoring
finaldf <- finaldf %>% 
  mutate(
    LTVGroup = factor(
      LTVGroup,
      levels = c("0~0.015 LTV", "0.015~0.03 LTV", "0.03~0.06 LTV", "0.06~ LTV", "Other")
    )
  )


# DiffGroup grouping
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = case_when(
      Diff >= 1   & Diff <= 6    ~ "<1 week",
      Diff >= 7   & Diff <= 121  ~ "≥1 week, <3 months",
      Diff >= 122 & Diff <= 730  ~ "≥3 months, <2 years",
      Diff >= 731 & Diff <= 919  ~ "≥2 years",
      TRUE                       ~ "Other"
    )
  )

# DiffGroup factoring
finaldf <- finaldf %>% 
  mutate(
    DiffGroup = factor(
      DiffGroup,
      levels = c("<1 week", "≥1 week, <3 months", "≥3 months, <2 years", "≥2 years", "Other")
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
      TRUE                                 ~ "Other"
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
        "60min~ (3601 ≤ t sec)",
        "Other"
      )
    )
  )


# CTVGroup grouping WIP
finaldf <- finaldf %>% 
  mutate(
    CTVGroup = case_when(
      CTV >= 1   & Diff <= 6    ~ "<1 week",
      Diff >= 7   & Diff <= 121  ~ "≥1 week, <3 months",
      Diff >= 122 & Diff <= 730  ~ "≥3 months, <2 years",
      Diff >= 731 & Diff <= 919  ~ "≥2 years",
      TRUE                       ~ "Other"
    )
  )

# CTVGroup factoring
finaldf <- finaldf %>% 
  mutate(
    CTVGroup = factor(
      CTVGroup,
      levels = c("<1 week", "≥1 week, <3 months", "≥3 months, <2 years", "≥2 years", "Other")
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



dat <- expand.grid(id=1:10, sex=c("Male", "Female"), treat=c("Treated", "Placebo"))
dat$age <- runif(nrow(dat), 10, 50)
dat$age[3] <- NA  # Add a missing value
dat$wt <- exp(rnorm(nrow(dat), log(70), 0.2))

label(dat$sex) <- "Sex"
label(dat$age) <- "Age"
label(dat$treat) <- "Treatment Group"
label(dat$wt) <- "Weight"

units(dat$age) <- "years"
units(dat$wt) <- "kg"

# basic table 1
tab1_html<- table1(~ sex + age + wt | treat, data=dat)
tab1_df <- as.data.frame(tab1html)


#finish anova and t-tests

#multivariable models after
#upload to drive


#Views Filtered & log-transformed
mutate(log_CTV) = log10(finaldf$CTV)
ggplot(aes(x = finaldf$log_CTV)) +
geom_histogram(binwidth = 0.0001, color = "black", fill = "skyblue") +
labs(title = "CTV Distribution", x = "CTV", y = "Count") +
theme_minimal()

