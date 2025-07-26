#Views Filtered & log-transformed
combined %>%
  filter(Views > 0) %>%
  mutate(log_Views = log10(Views)) %>%
  ggplot(aes(x = log_Views)) +
  geom_histogram(binwidth = 0.1, color = "black", fill = "skyblue") +
  labs(title = "Log10(Views) Distribution", x = "Log10(Views)", y = "Count") +
  theme_minimal()

#Comments by group
combined %>%
  ggplot(aes(x = CommentsGroup, fill = CommentsGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per Comments Group", x = "Comments Group", y = "Number of Videos") +
  theme_minimal()

#LTV by group
combined %>%
  ggplot(aes(x = LTVGroup, fill = LTVGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per LTV Group", x = "LTV Group", y = "Number of Videos") +
  theme_minimal()

#Comments Filtered and categorialized
combined %>%
  filter(Comments <= 10000) %>%
  ggplot(aes(x = Comments)) +
  geom_histogram(binwidth = 100, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Comments Distribution", x = "Comments", y = "Count") +
  theme_minimal()

#LTV Filtered & log-transformed
combined %>%
  filter(LTV >= 0 & LTV <= 40) %>%
  ggplot(aes(x = LTV)) +
  geom_histogram(binwidth = 1, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "LTV Distribution", x = "LTV", y = "Count") +
  theme_minimal()

#Category 
combined %>%
  ggplot(aes(x = Category, fill = Category)) +
  geom_bar(color = "black") + 
  labs(title = "Category Distribution", x = "Category", y = "Count") +
  theme_minimal() +
  theme(axis.text.x = element_text(size = 5))
  
#Diff
combined %>%
  ggplot(aes(x = Diff)) +
  geom_histogram(binwidth = 50, color = "black", fill = "blue") + 
  labs(title = "Video Age Distribution", x = "Video Age", y = "Count") +
  theme_minimal()

combined %>%
  ggplot(aes(x = CommentsGroup, fill = CommentsGroup)) +
  geom_bar(color = "black") +
  labs(title = "Number of Videos per Comments Group", x = "Comments Group", y = "Number of Videos") +
  theme_minimal()

#LTV vs views
combined %>%
  filter(Views > 0 & Views <= 1e6, LTV <= 20) %>%
  ggplot(aes(x = Views, y = LTV)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "LTV vs Views (Filtered)", x = "Views", y = "LTV") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

#LTV vs comments plot
combined %>%
  filter(Comments <= 100000, LTV <= 20) %>%
  ggplot(aes(x = LTV, y = Comments)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "Comments vs LTV (Filtered)", x = "LTV", y = "Comments") +
  scale_x_continuous(labels = scales::comma) +
  theme_minimal()

#LTV vs Views scatterplot TOTAL
combined %>%
  filter(Views <= 100000000, LTV <= 100) %>%
  ggplot(aes(x = LTV, y = Views)) +
  geom_point(alpha = 0.6, color = "darkblue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title = "LTV vs Views", x = "Likes-to-Views Ratio (LTV)", y = "Views") +
  theme_minimal()