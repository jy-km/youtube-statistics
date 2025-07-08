#library imports
library(tidyverse)
library(dplyr)
library(ggplot2)
library(data.table)


#Changing to INT
combined$LTV <- as.numeric(combined$LTV)
combined$CTL <- as.numeric(combined$CTL)
combined$Comments <- as.numeric(combined$Comments)
combined$Views <- as.numeric(combined$Views)

#sample imports
oneday <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_oneday.csv")
onemonth <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_onemonth.csv")
oneyear <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_oneyear.csv")
threeyears <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_threeyears.csv")
combined <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_6_28.csv")

summary(combined)
ggplot(combined, aes(x = LTV)) +
  geom_histogram(binwidth = 0.01, fill = "black", color = "black") +
  labs(title = "Histogram of Like-to-View Ratio (LTV)", x = "LTV", y = "Count")

summary(combined$Views)

#Views Filtered
combined %>%
  filter(Views <= 1e6) %>%
  ggplot(aes(x = Views)) +
  geom_histogram(binwidth = 10000, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Views Distribution (Under 1M)", x = "Views", y = "Count") +
  theme_minimal()

#LTV vs views
combined %>%
  filter(Views <= 1e6, LTV <= 20) %>%
  ggplot(aes(x = Views, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (Filtered)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

#LTV vs comments
combined %>%
  ggplot(aes(x = Comments, y = LTV)) +
  geom_histogram(binwidth = 1000, color = "black", alpha = 0.7) +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Comments Distribution by LTV", x = "Comments", y = "Count") +
  theme_minimal()
#LTV vs comments filtered
combined %>%
  filter(Views <= 1e6, LTV <= 0.5) %>%
  ggplot(aes(x = Comments, y = LTV)) +
  geom_histogram(binwidth = 1000, color = "black", alpha = 0.7) +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Comments Distribution by LTV", x = "Comments", y = "LTV") +
  theme_minimal()
#LTV vs comments plot
combined %>%
  filter(Comments <= 100000, LTV <= 20) %>%
  ggplot(aes(x = LTV, y = Comments)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "Comments vs LTV (Filtered)", x = "LTV", y = "Comments") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

# Categorize Diff into time ranges
combined <- combined %>% #new bin
  mutate(TimeGroup = case_when(
    Diff >= 34 & Diff <= 40 ~ "34-40 days",
    Diff >= 41 & Diff <= 365 ~ "41-365 days",
    Diff > 365 & Diff <= 1000 ~ "366-1000 days",
    Diff > 1000 & Diff <= 1200 ~ "1000-1200 days",
    TRUE ~ "Other"
  ))

# Bar graph of average LTV across time groups
combined %>%
  group_by(TimeGroup) %>%
  summarise(Average_LTV = mean(LTV, na.rm = TRUE)) %>%
  ggplot(aes(x = TimeGroup, y = Average_LTV, fill = TimeGroup)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Average LTV Across Timeframes", x = "Time Group", y = "Average LTV") +
  theme_minimal()

# Scatter plot of LTV vs Views
combined %>%
  filter(Views <= 100000000, LTV <= 100) %>%
  ggplot(aes(x = LTV, y = Views)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  #geom_smooth(method = "lm", se = FALSE, color = "red") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "LTV vs Views", x = "Likes-to-Views Ratio (LTV)", y = "Views") +
  theme_minimal()

#LTV vs comments across categories (hard)
category_summary <- combined %>%
  group_by(Category) %>%
  summarise(
    mean_LTV = mean(LTV, na.rm = TRUE),
    mean_Comments = mean(Comments, na.rm = TRUE)
  ) %>%
  pivot_longer(cols = c(mean_LTV, mean_Comments), names_to = "Metric", values_to = "Value") %>%
  mutate(Metric = recode(Metric, mean_LTV = "LTV", mean_Comments = "Comments"))

#plot
ggplot(category_summary, aes(x = Category, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_fill_manual(values = c("LTV" = "red", "Comments" = "yellow")) +
  labs(title = "LTV and Comments Across Categories", x = "Category", y = "Average Value", fill = "Metric") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#plot LTV
ggplot(category_summary, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "LTV Across Categories", x = "Category", y = "LTV") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#plot Comments
ggplot(category_summary, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "Comments Across Categories", x = "Category", y = "Comments") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))