#Views Filtered
combined %>%
  filter(Views > 0 & Views <= 1000) %>%
  ggplot(aes(x = Views)) +
  geom_histogram(binwidth = 10, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Views Distribution", x = "Views", y = "Count") +
  theme_minimal()

#Comments Filtered
combined %>%
  filter(Comments > 0 & Comments <= 10000) %>%
  ggplot(aes(x = Comments)) +
  geom_histogram(binwidth = 100, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "Comments Distribution", x = "Comments", y = "Count") +
  theme_minimal()

#LTV Filtered
combined %>%
  filter(LTV > 0 & LTV <= 100) %>%
  ggplot(aes(x = LTV)) +
  geom_histogram(binwidth = 1, color = "black", fill = "skyblue") +
  scale_x_continuous(labels = scales::comma) +
  labs(title = "LTV Distribution", x = "LTV", y = "Count") +
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