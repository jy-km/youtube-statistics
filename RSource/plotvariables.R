#Views Filtered & log-transformed
gg <- finaldf %>%
  filter(Views > 0) %>%
  mutate(log_Views = log10(Views)) %>%
  ggplot(aes(x = log_Views)) +
  geom_histogram(binwidth = 0.1, color = "black", fill = "skyblue") +
  labs(title = "Log10(Views) Distribution", x = "Log10(Views)", y = "Count") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LogViewsDistribution.html")

#Comments by group
gg <- ggplot(finaldf, aes(x = CommentsGroup, fill = CommentsGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per Comments Group", x = "Comments Group", y = "Number of Videos") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/VideosCommentsGroup.html")


#LTV by group
gg <- ggplot(finaldf, aes(x = LTVGroup, fill = LTVGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per LTV Group", x = "LTV Group", y = "Number of Videos") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/VideosLTVGroup.html")


#Comments Filtered and categorialized
gg <- finaldf %>%
  filter(Comments <= 10000) %>%
  ggplot(aes(x = Comments)) +
  geom_histogram(binwidth = 100, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Comments Distribution", x = "Comments", y = "Count") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/CommentsDistribution.html")


#LTV Filtered
gg <- finaldf %>%
  filter(LTV >= 0 & LTV <= 1) %>%
  ggplot(aes(x = LTV)) +
  geom_histogram(binwidth = 0.05, color = "black", fill = "skyblue") +
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

gg <- finaldf %>%
  filter(CTV <= 0.0001) %>%
  ggplot(aes(x = CTV)) +
  geom_histogram(binwidth = 0.00001, color = "black", fill = "blue") + 
  labs(title = "CTV Distribution (filtered, binwidth = 0.00001)", x = "CTV", y = "Count") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/CTVDistribution.html")


#LTV vs views
gg <- finaldf %>%
  filter(Views > 0 & Views <= 1e6, LTV <= 20) %>%
  ggplot(aes(x = Views, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (Filtered)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVViews.html")

#LTV vs comments plot
gg <- finaldf %>%
  filter(Comments <= 100000, LTV <= 20) %>%
  ggplot(aes(x = LTV, y = Comments)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "Comments vs LTV (Filtered)", x = "LTV", y = "Comments") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/CommentsLTV.html")

#LTV vs Views scatterplot TOTAL
gg <- finaldf %>%
  filter(Views <= 100000000, LTV <= 100) %>%
  ggplot(aes(x = LTV, y = Views)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "LTV vs Views", x = "Likes-to-Views Ratio (LTV), (%)", y = "Views") +
  theme_minimal()

saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVViews.html")


source("C:/Users/jaeyo/Downloads/youtube-statistics/RSource/startup.R")
