#LTV vs Views bar chart
gg <- ggplot(finaldf, aes(x = LTVGroup, fill = LTVGroup)) +
  geom_bar(color = "black") +
  labs(title = "Log-transformed Views Across LTV Categories", x = "Likes-To-Views Categories", y = "Log-transformed Views") +
  theme_minimal() +
  theme(plot.title = element_text(size = 17))

print(gg)
saveWidget(ggplotly(gg), file = "C:/Users/jaeyo/Downloads/youtube-statistics/graphs/LTVViews.html")



gg <- finaldf %>%
  filter(Category == "NonprofitsActivism") %>%
  ggplot(aes(x = LTVGroup, fill = LTVGroup)) +
  geom_bar(color = "black") +
  labs(title = "Log-transformed Views Across LTV Categories", x = "Likes-To-Views Categories", y = "Log-transformed Views") +
  theme_minimal() +
  theme(plot.title = element_text(size = 17))
print(gg)

#LTV vs Views by category
finaldf %>%
  filter(Category == "NonprofitsActivism") %>%
  ggplot(aes(x = ViewsLog, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (By Category)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()
