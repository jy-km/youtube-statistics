#LTV vs comments across categories (hard)
ggplot(category_summary, aes(x = Category, y = Value, fill = Metric)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  scale_fill_manual(values = c("LTV" = "red", "Comments" = "yellow")) +
  labs(title = "LTV and Comments Across Categories", x = "Category", y = "Average Value", fill = "Metric") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#LTV by category
ggplot(category_LTV, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "LTV Across Categories", x = "Category", y = "LTV") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Comments by category
ggplot(category_Comments, aes(x = Category, y = Value)) +
  geom_bar(stat = "identity", position = "dodge", color = "black") +
  labs(title = "Comments Across Categories", x = "Category", y = "Comments") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#LTV vs Views by category
combined %>%
  filter(Category == "NonprofitsActivism") %>%
  filter(Views > 0 & Views <= 10000, LTV <= 20) %>%
  ggplot(aes(x = Views, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (By Category)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()
