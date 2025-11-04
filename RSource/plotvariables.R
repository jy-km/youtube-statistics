#Views Filtered & log-transformed
print(gg)
gg <- finaldf %>%
  filter(Views > 0) %>%
  mutate(log_Views = log10(Views)) %>%
  ggplot(aes(x = log_Views)) +
  geom_histogram(binwidth = 0.1, color = "black", fill = "skyblue") +
  labs(title = "Log10(Views) Distribution", x = "Log10(Views)", y = "Count") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LogViewsDistribution.html")

#LTV by group
gg <- ggplot(finaldf, aes(x = LTVGroup, fill = LTVGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per LTV Group", x = "LTV Group", y = "Number of Videos") +
  theme_minimal()
print(gg)
saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/VideosLTVGroup.html")


#LTV Filtered
gg <- finaldf %>%
  filter(LTV >= 0 & LTV <= 1) %>%
  ggplot(aes(x = LTV)) +
  geom_histogram(binwidth = 0.001, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "LTV % Distribution (LTV >= 0 & LTV <= 1)", x = "LTV", y = "Count") +
  theme_minimal()

print(gg)
saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVDistribution.html")

#Category 
gg <- ggplot(finaldf, aes(x = Category, fill = Category)) +
  geom_bar(color = "black") +
  labs(title = "Category Distribution", x = "Category", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 5))

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/CategoryDistribution.html")

#LTV vs Views scatterplot TOTAL
gg <- finaldf %>%
  filter(Views <= 100000000, LTV <= 100) %>%
  ggplot(aes(x = LTV, y = Views)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "LTV vs Views", x = "Likes-to-Views Ratio (LTV), (%)", y = "Views") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVViews.html")


#LTV by category
ggplot(category_LTV, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "LTV Across Categories", x = "Category", y = "LTV") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#LTV vs Views by category
finaldf %>%
  filter(Category == "NonprofitsActivism") %>%
  filter(Views > 0 & Views <= 10000, LTV <= 20) %>%
  ggplot(aes(x = Views, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (By Category)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()
