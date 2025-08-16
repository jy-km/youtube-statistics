summary(finaldf)

summary(finaldf$Views)


cor(finaldf$Views,finaldf$LTV)

cor.test(finaldf$Views,finaldf$LTV, method = "pearson")

#table with statistical test (ANOVA): Y=log[#views], X=#LTV ratio category 
aov_result <- aov(ViewsLog ~ LTVGroup, data = na.omit(finaldf))
summary(aov_result)

ggplot(finaldf, aes(x=LTVGroup,y=ViewsLog))+
  stat_boxplot(geom="errorbar",width=.5) +
  labs(title="ANOVA results between LTV Group and Log10 Views",x="LTV Group", y="Log10 Views")+
  geom_boxplot(fill = "skyblue")+
  theme_minimal()

#table with statistical test (ANOVA): Y=log[#views], X=#comments category
aov_result <- aov(ViewsLog ~ CommentsGroup, data = na.omit(finaldf))
summary(aov_result)

#for each video category (or by video category),
#ANOVA table and bar chart:  Y=log[#views], X=#LTV ratio category
for (cat in unique(na.omit(finaldf$Category))) {
  subset_data <- finaldf %>%
    filter(Category == cat, !is.na(ViewsLog), !is.na(LTVGroup))
  
  if (nrow(subset_data) > 1 && length(unique(subset_data$LTVGroup)) > 1) {
    model <- aov(ViewsLog ~ LTVGroup, data = na.omit(subset_data))
    print(paste("Category:", cat))
    print(summary(model))
  }
}

#bar chart
finaldf %>%
  filter(!is.na(Category), !is.na(LTVGroup), !is.na(ViewsLog)) %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot(outlier.shape = NA,fill="skyblue") +
  facet_wrap(~ Category, scales = "free_y") +
  theme_minimal() +
  labs(
    title = "Log10(Views) by LTV Group for Each Video Category",
    x = "LTV Group",
    y = "Log10(Views)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#ANOVA table and bar chart:  Y=log[#views], X=#comments category
for (cat in unique(na.omit(finaldf$Category))) {
  subset_data <- finaldf %>%
    filter(Category == cat, !is.na(ViewsLog), !is.na(LTVGroup))
  
  if (nrow(subset_data) > 1 && length(unique(subset_data$LTVGroup)) > 1) {
    model <- aov(ViewsLog ~ CommentsGroup, data = na.omit(subset_data))
    print(paste("Category:", cat))
    print(summary(model))

  }
}
#bar chart
finaldf %>%
  filter(!is.na(Category), !is.na(CommentsGroup), !is.na(ViewsLog)) %>%
  ggplot(aes(x = CommentsGroup, y = ViewsLog)) +
  geom_boxplot(outlier.shape = NA, fill="skyblue") +
  facet_wrap(~ Category, scales = "free_y") +
  theme_minimal() +
  labs(
    title = "Log10(Views) by Comments Group for Each Video Category",
    x = "Comments Group",
    y = "Log10(Views)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#for each age of video category :
#ANOVA table and bar chart:  Y=log[#views], X=#LTV ratio category
for (cat in unique(na.omit(finaldf$DiffGroup))) {
  subset_data <- finaldf %>%
    filter(DiffGroup == cat, !is.na(ViewsLog), !is.na(LTVGroup))
  
  if (nrow(subset_data) > 1 && length(unique(subset_data$LTVGroup)) > 1) {
    model <- aov(ViewsLog ~ LTVGroup, data = na.omit(subset_data))
    print(paste("Category:", cat))
    print(summary(model))
  }
}

finaldf %>%
  filter(!is.na(DiffGroup), !is.na(LTVGroup), !is.na(ViewsLog)) %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot(outlier.shape = NA,fill="skyblue") +
  facet_wrap(~ LTVGroup, scales = "free_y") +
  theme_minimal() +
  labs(
    title = "Log10(Views) by LTV Group for Each Age Category",
    x = "LTV Group",
    y = "Log10(Views)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#ANOVA table and bar chart:  Y=log[#views], X=#comments category
for (cat in unique(na.omit(finaldf$DiffGroup))) {
  subset_data <- finaldf %>%
    filter(DiffGroup == cat, !is.na(ViewsLog), !is.na(CommentsGroup))
  
  if (nrow(subset_data) > 1 && length(unique(subset_data$CommentsGroup)) > 1) {
    model <- aov(ViewsLog ~ CommentsGroup, data = na.omit(subset_data))
    print(paste("Category:", cat))
    print(summary(model))
  }
}

finaldf %>%
  filter(!is.na(DiffGroup), !is.na(CommentsGroup), !is.na(ViewsLog)) %>%
  ggplot(aes(x = CommentsGroup, y = ViewsLog, fill = DiffGroup)) +
  geom_boxplot(outlier.shape = NA,fill="skyblue") +
  facet_wrap(~ DiffGroup, scales = "free_y") +
  theme_minimal() +
  labs(
    title = "Log10(Views) by Comments Group for Each Age Category",
    x = "Comments Group",
    y = "Log10(Views)"
  ) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


df2 <- df2 %>% filter(Likes == "N/A")
model <- lm(ViewsLog ~ Likes + Category + CommentsGroup + Duration, data = df2)
summary(model)



#Using the full sample,

#Get summary statistics of all variables to be included in the analysis. 
#For continuous variables, show these: 
#mean, standard deviation, median, minimum, maximum; 
#for categorical variables, show these: number of observations, % of each category.  
#views
#log views
#likes
#LTV
#LTV category
#comments
#comments category
#comments-to-view ratio
#comments-to-view ratio category
#video category
#video age 
#video age category
#video length
#video length category