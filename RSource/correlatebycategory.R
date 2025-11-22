
#equal variances
bartlett.test(ViewsLog ~ LTVGroup, data = finaldf)

#failed equal variances test, p-value for kruskal is 2.2E-16
kruskal.test(ViewsLog ~ LTVGroup, data = finaldf)

pairwise.wilcox.test(finaldf$ViewsLog, finaldf$LTVGroup, p.adjust.method = "bonferroni")

aov2 <- aov(ViewsLog ~ LTVGroup * Category, data = finaldf)
summary(aov2)

aov3 <- aov(ViewsLog ~ LTVGroup * DiffGroup, data = finaldf)
summary(aov3)



category_list <- c("AutosVehicles", "Comedy", "Education", "Entertainment", "FilmAnimation", "Gaming", "HowtoStyle", "Music", "NewsPolitics", "NonprofitsActivism", "PeopleBlogs", "PetsAnimals", "ScienceTech", "Sports", "TravelEvents")

for (cat in category_list) {
  
  subdf <- finaldf %>% filter(Category == cat)
  
  aov_result <- aov(ViewsLog ~ LTVGroup, data = subdf)
  
  cat("\nCategory:", cat, "\n")
  print(summary(aov_result))
}

diff_list <- c("About 1 day (0-6 days)", "About 1 month (7-121 days)", "About 1 year (122-730 days)", "≥2 years (731-919 days)")

for (cat in diff_list) {
  
  subdf <- finaldf %>% filter(DiffGroup == cat)
  
  aov_result <- aov(ViewsLog ~ LTVGroup, data = subdf)
  
  cat("\nCategory:", cat, "\n")
  print(summary(aov_result))
}



