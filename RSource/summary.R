#For continuous variables, show these: 
#mean, standard deviation, median, minimum, maximum; 
#for categorical variables, show these: number of observations, % of each category. 

total = 11673

finaldf %>%
  summarise(
  Mean = mean(finaldf$Views, na.rm = TRUE),
  SD = sd(finaldf$Views, na.rm = TRUE),
  Minimum = min(finaldf$Views, na.rm = TRUE),
  Maximum = max(finaldf$Views, na.rm = TRUE),
  Median = median(finaldf$Views, na.rm = TRUE)
)
  
finaldf %>%
  summarise(
  Mean = mean(finaldf$ViewsLog, na.rm = TRUE),
  SD = sd(finaldf$ViewsLog, na.rm = TRUE),
  Minimum = min(finaldf$ViewsLog, na.rm = TRUE),
  Maximum = max(finaldf$ViewsLog, na.rm = TRUE),
  Median = median(finaldf$ViewsLog, na.rm = TRUE)
)
  
finaldf %>%
  filter(Likes > 0) %>%
  summarise(
  Mean = mean(finaldf$Likes, na.rm = TRUE),
  SD = sd(finaldf$Likes, na.rm = TRUE),
  Minimum = min(finaldf$Likes, na.rm = TRUE),
  Maximum = max(finaldf$Likes, na.rm = TRUE),
  Median = median(finaldf$Likes, na.rm = TRUE)
)

finaldf %>%
  summarise(
    Mean = mean(finaldf$LikesLog, na.rm = TRUE),
    SD = sd(finaldf$LikesLog, na.rm = TRUE),
    Minimum = min(finaldf$LikesLog, na.rm = TRUE),
    Maximum = max(finaldf$LikesLog, na.rm = TRUE),
    Median = median(finaldf$LikesLog, na.rm = TRUE)
  )

finaldf %>%
  summarise(
  Mean = mean(finaldf$LTV, na.rm = TRUE),
  SD = sd(finaldf$LTV, na.rm = TRUE),
  Minimum = min(finaldf$LTV, na.rm = TRUE),
  Maximum = max(finaldf$LTV, na.rm = TRUE),
  Median = median(finaldf$LTV, na.rm = TRUE)
)
  
#LTV category
finaldf %>%
  filter(!is.na(LTVGroup)) %>%  
  group_by(LTVGroup) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(percent = round(n / total * 100, 1)) %>%
  print(n=100)

#comments
finaldf %>%
  summarise(
  Mean = mean(finaldf$Comments, na.rm = TRUE),
  SD = sd(finaldf$Comments, na.rm = TRUE),
  Minimum = min(finaldf$Comments, na.rm = TRUE),
  Maximum = max(finaldf$Comments, na.rm = TRUE),
  Median = median(finaldf$Comments, na.rm = TRUE)
)

#comments category
finaldf %>%
  filter(!is.na(CommentsGroup)) %>%  
  group_by(CommentsGroup) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(percent = round(n / total * 100, 1)) %>%
  print(n=100)

#comments-to-view ratio
finaldf %>%
  summarise(
  Mean = mean(finaldf$CTV, na.rm = TRUE),
  SD = sd(finaldf$CTV, na.rm = TRUE),
  Minimum = min(finaldf$CTV, na.rm = TRUE),
  Maximum = max(finaldf$CTV, na.rm = TRUE),
  Median = median(finaldf$CTV, na.rm = TRUE)
)

#comments-to-view ratio category

#video category
finaldf %>%
  filter(!is.na(Category)) %>%  
  group_by(Category) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(percent = round(n /  total * 100, 1)) %>%
  print(n=100)

#video age
finaldf %>%
  summarise(
  Mean = mean(finaldf$Diff, na.rm = TRUE),
  SD = sd(finaldf$Diff, na.rm = TRUE),
  Minimum = min(finaldf$Diff, na.rm = TRUE),
  Maximum = max(finaldf$Diff, na.rm = TRUE),
  Median = median(finaldf$Diff, na.rm = TRUE)
)
#video age category
finaldf %>%
  filter(!is.na(DiffGroup)) %>%  
  group_by(DiffGroup) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(percent = round(n /  total * 100, 1)) %>%
  print(n=100)

#video length
finaldf %>%
  summarise(
  Mean = mean(finaldf$Duration, na.rm = TRUE),
  SD = sd(finaldf$Duration, na.rm = TRUE),
  Minimum = min(finaldf$Duration, na.rm = TRUE),
  Maximum = max(finaldf$Duration, na.rm = TRUE),
  Median = median(finaldf$Duration, na.rm = TRUE)
)
#video length category
finaldf %>%
  filter(!is.na(DurationGroup)) %>%  
  group_by(DurationGroup) %>%
  summarise(n = n(), .groups = 'drop') %>%
  mutate(percent = round(n /  total * 100, 1)) %>%
  print(n=100)

  finaldf %>%
    filter(!is.na(CTV), CTV != 0) %>%
    summarise(row_count = n())



log[views] vs LTV category
log[views] vs #comments category
log[views] vs comments-to-views category
Also, plot the bivariate relationships using bar charts.  In each chart, there is a bar for each category and the height of the bar is average log[view].   See the example codes for barcharts in 7.3.2 in the ebook above link, but you can use other examples that you like. 
Examine bivariate relationships using ANOVA and pairwise tests.  Same as above, but this time, separately for each video category.  No plots needed yet.  Just ANOVA and pairwise t-tests.  I.e.,
1) For video category 1 (e.g., gamining), do ANOVA and pairwise t-tests of 
log[views] vs LTV category
log[views] vs #comments category
log[views] vs comments-to-views category
2) For video category 2 (e.g., entertainment), do ANOVA and pairwise t-tests of 
log[views] vs LTV category
log[views] vs #comments category
log[views] vs comments-to-views category
3) For video category 3 (e.g., politics), do ANOVA and pairwise t-tests of 
log[views] vs LTV category
log[views] vs #comments category
log[views] vs comments-to-views category
