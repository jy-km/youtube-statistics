#LTV vs Views bar chart
gg <- ggplot(finaldf, aes(x = LTVGroup, fill = LTVGroup, y = ViewsLog)) +
  geom_bar(color = "black") +
  labs(title = "Log-transformed Views Across LTV Categories", x = "Likes-To-Views Categories", y = "Log-transformed Views") +
  theme_minimal() +
  theme(plot.title = element_text(size = 17))

print(gg)
saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVViews.html")



df_summary <- finaldf %>%
  group_by(LTVGroup) %>%
  summarise(
    mean_viewslog = mean(ViewsLog, na.rm = TRUE),
    sd_viewslog = sd(ViewsLog, na.rm = TRUE),
    n = n()
  ) %>%
  mutate(
    se = sd_viewslog / sqrt(n),             # standard error
    ci95 = 1.96 * se,                       # 95% confidence interval
    lower = mean_viewslog - ci95,
    upper = mean_viewslog + ci95
  )

ggplot(df_summary, aes(x = LTVGroup, y = mean_viewslog, fill = LTVGroup)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2) +
  labs(
    title = "Average Log(Views) by LTV Group with 95% Confidence Intervals",
    x = "Likes-to-Views (LTV) Category",
    y = "Mean Log(Views)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 30, hjust = 1)
  )




finaldf %>%
  group_by(LTVGroup) %>%
  summarise(mean_viewslog = mean(ViewsLog, na.rm = TRUE),
            sd_viewslog = sd(ViewsLog, na.rm = TRUE)) %>%
  ggplot(aes(x = LTVGroup, y = mean_viewslog, fill = LTVGroup)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = mean_viewslog - sd_viewslog,
                    ymax = mean_viewslog + sd_viewslog),
                width = 0.2) +
  labs(
    title = "Average Log-transformed Views by LTV Group",
    x = "Likes-to-Views (LTV) Category",
    y = "Average Log-transformed Views"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text()
  )

finaldf %>%
  group_by(LTVGroup) %>%
  summarise(median_viewslog = median(ViewsLog, na.rm = TRUE)) %>%
  ggplot(aes(x = LTVGroup, y = median_viewslog, fill = LTVGroup)) +
  geom_bar(stat = "identity", color = "black") +
  labs(
    title = "Median Log-transformed Views by LTV Group",
    x = "Likes-to-Views (LTV) Category",
    y = "Median Log-transformed Views"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text()
  )

df_summary <- finaldf %>%
  group_by(Category, LTVGroup) %>%
  summarise(
    mean_viewslog = mean(ViewsLog, na.rm = TRUE),
    sd_viewslog = sd(ViewsLog, na.rm = TRUE),
    n = n()
  ) %>%
  mutate(
    se = sd_viewslog / sqrt(n),
    ci95 = 1.96 * se,
    lower = mean_viewslog - ci95,
    upper = mean_viewslog + ci95
  )

ggplot(df_summary, aes(x = LTVGroup, y = mean_viewslog, fill = LTVGroup)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2) +
  facet_wrap(~ Category) +
  labs(
    title = "Average Log(Views) by LTV Group and Video Category (95% CI)",
    x = "Likes-to-Views (LTV) Category",
    y = "Mean Log(Views)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 30, hjust = 1)
  )



df_summary <- finaldf %>%
  group_by(DiffGroup, LTVGroup) %>%
  summarise(
    mean_viewslog = mean(ViewsLog, na.rm = TRUE),
    sd_viewslog = sd(ViewsLog, na.rm = TRUE),
    n = n()
  ) %>%
  mutate(
    se = sd_viewslog / sqrt(n),
    ci95 = 1.96 * se,
    lower = mean_viewslog - ci95,
    upper = mean_viewslog + ci95
  )

ggplot(df_summary, aes(x = DiffGroup, y = mean_viewslog, fill = DiffGroup)) +
  geom_bar(stat = "identity", color = "black") +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.2) +
  facet_wrap(~ LTVGroup) +
  labs(
    title = "Average Log(Views) by LTV Group and Video Age Category (95% CI)",
    x = "Likes-to-Views (LTV) Category",
    y = "Mean Log(Views)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 16, face = "bold"),
    axis.text.x = element_text(angle = 30, hjust = 1)
  )