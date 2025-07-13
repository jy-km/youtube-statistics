#Views vs LTV (overall)
#Pearson
cor(
  combined$log_Views[combined$Views > 0 & combined$LTV > 0],
  combined$log_LTV[combined$Views > 0 & combined$LTV > 0],
  method = "pearson"
)

#graph
combined %>%
  filter(Views > 0, LTV > 0) %>%
  mutate(
    log_Views = log10(Views),
    log_LTV = log10(LTV)
  ) %>%
  ggplot(aes(x = log_Views, y = log_LTV)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "Pearson Correlation: Views vs LTV",
       x = "Log10(Views)",
       y = "Log10(LTV)") +
  theme_minimal()

#Views vs LTV , by category
#Views vs LTV, by video age category 
#Comments vs LTV (overall) 
t.test(combined$Comments, combined$LTV, var.equal = FALSE)

#Comments vs LTV , by category
t.test(
  combined$Comments[combined$Category=="Entertainment"],
  combined$LTV[combined$Category=="Entertainment"]
)
#Comments vs LTV , by video age category
t.test(
  combined$Comments[combined$Category=="Entertainment"],
  combined$LTV[combined$Category=="Entertainment"],
  var.equal = FALSE
)
#Views vs Comments (overall)
t.test(combined$Views, combined$Comments, var.equal = FALSE)

#Views vs Comments, by category 
t.test(
  combined$Views[combined$Category=="Entertainment"],
  combined$Comments[combined$Category=="Entertainment"],
  var.equal = FALSE
)