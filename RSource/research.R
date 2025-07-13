summary(combined)

summary(combined$Views)

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
  summarise(Average_LTV = median(LTV, na.rm = TRUE)) %>%
  ggplot(aes(x = TimeGroup, y = Average_LTV, fill = TimeGroup)) +
  geom_bar(stat = "identity", color = "black") +
  labs(title = "Average LTV Across Timeframes", x = "Time Group", y = "Average LTV") +
  theme_minimal()


