summary(combined)

summary(combined$Views)


cor(combined$Views,combined$LTV)

cor.test(combined$Views,combined$LTV, method = "pearson")

#table with statistical test (ANOVA): Y=log[#views], X=#LTV ratio category 
# Step 1: Perform one-way ANOVA
anova_model <- aov(LTV ~ ViewsLog, data = combined)
anova_summary <- summary(anova_model)[[1]]

# Step 2: Extract ANOVA results into a data frame
anova_table <- data.frame(
  Source = c("Group", "Residual"),
  `Sum of Squares` = anova_summary$`Sum Sq`,
  `Degrees of Freedom` = anova_summary$Df,
  `F-Statistic` = c(anova_summary$`F value`[1], NA),  # Residual has no F-value
  `P-Value` = c(anova_summary$`Pr(>F)`[1], NA)       # Residual has no p-value
)

# Step 3: Format the table
anova_table$`Sum of Squares` <- round(anova_table$`Sum of Squares`, 3)
anova_table$`F-Statistic` <- round(anova_table$`F-Statistic`, 3)
anova_table$`P-Value` <- round(anova_table$`P-Value`, 5)

# Step 4: Display the table
print("ANOVA Statistical Table")
print(anova_table)

#bar chart:  Y=log[#views], X=#LTV ratio category
combined %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Log of Views by LTV Group", x = "LTV Group", y = "Log Views") +
  theme_minimal()

#table with statistical test (ANOVA): Y=log[#views], X=#comments category

#bar chart:  Y=log[#views], X=#comments category
combined %>%
  ggplot(aes(x = CommentsGroup, y = ViewsLog)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Log of Views by Comments Group", x = "Comments Group", y = "Log Views") +
  theme_minimal()

#for each video category (or by video category),
#ANOVA table and bar chart:  Y=log[#views], X=#LTV ratio category

#bar chart
combined %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Log of Views by LTV Group", x = "LTV Group", y = "Log Views") +
  theme_minimal()
#ANOVA table and bar chart:  Y=log[#views], X=#comments category

#bar chart
combined %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot(fill = "skyblue") +
  labs(title = "Log of Views by LTV Group", x = "LTV Group", y = "Log Views") +
  theme_minimal()

#for each age of video category :
#ANOVA table and bar chart:  Y=log[#views], X=#LTV ratio category
#ANOVA table and bar chart:  Y=log[#views], X=#comments category