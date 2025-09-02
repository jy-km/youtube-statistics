#Views vs LTV (overall)
#Pearson
cor(
  finaldf$log_Views[finaldf$Views > 0 & finaldf$LTV > 0],
  finaldf$log_LTV[finaldf$Views > 0 & finaldf$LTV > 0],
  method = "pearson"
)

#graph
finaldf %>%
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
cor(
  finaldf$log_Views[finaldf$Views > 0 & finaldf$LTV > 0 & finaldf$Category == "Gaming"],
  finaldf$log_LTV[finaldf$Views > 0 & finaldf$LTV > 0 & finaldf$Category == "Gaming"],
  method = "pearson"
)



#Comments vs LTV (overall) 
t.test(finaldf$Comments, finaldf$LTV, var.equal = FALSE)

#Comments vs LTV , by category
t.test(
  finaldf$Comments[finaldf$Category=="Entertainment"],
  finaldf$LTV[finaldf$Category=="Entertainment"]
)

#Views vs Comments (overall)
t.test(finaldf$Views, finaldf$Comments, var.equal = FALSE)

#Views vs Comments, by category 
t.test(
  finaldf$Views[finaldf$Category=="Entertainment"],
  finaldf$Comments[finaldf$Category=="Entertainment"],
  var.equal = FALSE
)





#ViewsLog and LTVGroup

class(finaldf$LTVGroup)  

# 6.3 Checking data for violations of assumptions

## 6.3.1 Group sizes

table(finaldf$LTVGroup)

#other in LTVGroup is filtered out
## 6.3.2 Checking Equal Variances 
by(finaldf$ViewsLog, finaldf$LTVGroup, mean, na.rm = TRUE)
by(finaldf$ViewsLog, finaldf$LTVGroup, sd, na.rm = TRUE)


## Bartlett’s test for equal variances:

bartlett.test(ViewsLog ~ LTVGroup, data = finaldf)


## 6.3.3 Checking Normality

moments::skewness(finaldf$ViewsLog, na.rm = TRUE)
moments::kurtosis(finaldf$ViewsLog, na.rm = TRUE)
ggpubr::ggdensity(finaldf$ViewsLog, fill = "lightgray")
ggpubr::ggqqplot(finaldf$ViewsLog)

# 6.4 The analysis of variance and effect size (eta-squared)

object1 <- aov(ViewsLog ~ LTVGroup, data = finaldf)
summary(object1)
DescTools::EtaSq(object1, type = 2, anova = FALSE)
p_value <- pf(149.6, 4, 8387, lower.tail = FALSE)
print(p_value)

## Conducting follow-up pairwise t-tests (Bonferroni):

# 1. Create a clean dataframe with no missing values in the columns of interest.
finaldft <- finaldf[complete.cases(finaldf[, c("ViewsLog", "LTVGroup")]), ]

# 2. Call the function using the x and g arguments from that clean dataframe.
pairwise.t.test(
  x = finaldft$ViewsLog,
  g = finaldft$LTVGroup,
  p.adj = "bonferroni"
)

object <- Rmisc::summarySE(finaldf, measurevar = "ViewsLog", groupvars = c("LTVGroup"), na.rm = TRUE)
ggplot2::ggplot(object, aes(x = factor(LTVGroup), y = ViewsLog)) +
  geom_bar(stat = "Identity", fill = "gray", width = 0.8) +
  geom_errorbar(aes(ymin = ViewsLog - se, ymax = ViewsLog + se), width = .2, color = "black") +
  xlab("LTVGroup") + ylab("ViewsLog") + scale_x_discrete(breaks =
                                                                                      c("1", "2", "3"), labels = c("category 1 label", "category 2 label", "category 3
    label")) 




#ViewsLog and CommentsGroup

class(finaldf$CommentsGroup)  

# 6.3 Checking data for violations of assumptions

## 6.3.1 Group sizes

table(finaldf$CommentsGroup)

#other in CommentsGroup is filtered out
## 6.3.2 Checking Equal Variances 
by(finaldf$ViewsLog, finaldf$CommentsGroup, mean, na.rm = TRUE)
by(finaldf$ViewsLog, finaldf$CommentsGroup, sd, na.rm = TRUE)


## Bartlett’s test for equal variances:

bartlett.test(ViewsLog ~ CommentsGroup, data = finaldf)


## 6.3.3 Checking Normality

moments::skewness(finaldf$ViewsLog, na.rm = TRUE)
moments::kurtosis(finaldf$ViewsLog, na.rm = TRUE)
ggpubr::ggdensity(finaldf$ViewsLog, fill = "lightgray")
ggpubr::ggqqplot(finaldf$ViewsLog)

# 6.4 The analysis of variance and effect size (eta-squared)

object1 <- aov(ViewsLog ~ CommentsGroup, data = finaldf)
summary(object1)
DescTools::EtaSq(object1, type = 2, anova = FALSE)
p_value <- pf(1886, 4, 8387, lower.tail = FALSE)
print(p_value)

## Conducting follow-up pairwise t-tests (Bonferroni):
pairwise.t.test(
  finaldf$ViewsLog[complete.cases(finaldf$ViewsLog, finaldf$CommentsGroup)],
  finaldf$CommentsGroup[complete.cases(finaldf$ViewsLog, finaldf$CommentsGroup)],
  p.adj = "bonferroni"
)

object <- Rmisc::summarySE(finaldf, measurevar = "CommentsGroup", groupvars = c("ViewsLog"), na.rm = TRUE)
ggplot2::ggplot(object, aes(x = factor(CommentsGroup), y = ViewsLog)) +
  geom_bar(stat = "Identity", fill = "gray", width = 0.8) +
  geom_errorbar(aes(ymin = CommentsGroup - se, ymax = ViewsLog + se), width = .2, color = "black") +
  xlab("CommentsGroup") + ylab("ViewsLog") + scale_x_discrete(breaks =
                                                           c("1", "2", "3"), labels = c("category 1 label", "category 2 label", "category 3
    label")) 


#ViewsLog and CTVGroup

class(finaldf$CTVGroup)  

# 6.3 Checking data for violations of assumptions

## 6.3.1 Group sizes

table(finaldf$CTVGroup)

#other in CTVGroup is filtered out
## 6.3.2 Checking Equal Variances 
by(finaldf$ViewsLog, finaldf$CTVGroup, mean, na.rm = TRUE)
by(finaldf$ViewsLog, finaldf$CTVGroup, sd, na.rm = TRUE)


## Bartlett’s test for equal variances:

bartlett.test(ViewsLog ~ CTVGroup, data = finaldf)


## 6.3.3 Checking Normality

moments::skewness(finaldf$ViewsLog, na.rm = TRUE)
moments::kurtosis(finaldf$ViewsLog, na.rm = TRUE)
ggpubr::ggdensity(finaldf$ViewsLog, fill = "lightgray")
ggpubr::ggqqplot(finaldf$ViewsLog)

# 6.4 The analysis of variance and effect size (eta-squared)

object1 <- aov(ViewsLog ~ CTVGroup, data = finaldf)
summary(object1)
DescTools::EtaSq(object1, type = 2, anova = FALSE)
p_value <- pf(149.6, 4, 8387, lower.tail = FALSE)
print(p_value)

## Conducting follow-up pairwise t-tests (Bonferroni):

pairwise.t.test(
  finaldf$ViewsLog[complete.cases(finaldf$ViewsLog, finaldf$CTVGroup)],
  finaldf$CTVGroup[complete.cases(finaldf$ViewsLog, finaldf$CTVGroup)],
  p.adj = "bonferroni"
)




# Function to run ANOVA + pairwise t-tests for a given category and grouping variable
run_anova_pairwise <- function(data, category_name, group_var) {
  # Filter to one video category
  df_cat <- data %>% filter(Category == category_name)
  
  # Remove NA in group_var
  df_cat <- df_cat[complete.cases(df_cat$ViewsLog, df_cat[[group_var]]), ]
  
  cat("\n===== Category:", category_name, "| Group variable:", group_var, "=====\n")
  
  # Dynamically create formula
  formula_obj <- as.formula(paste("ViewsLog ~", group_var))
  
  # Equal variances
  print(bartlett.test(formula_obj, data = df_cat))
  
  # ANOVA
  aov_obj <- aov(formula_obj, data = df_cat)
  print(summary(aov_obj))
  
  # Effect size
  print(DescTools::EtaSq(aov_obj, type = 2, anova = FALSE))
  
  # Pairwise t-tests (Bonferroni)
  print(pairwise.t.test(df_cat$ViewsLog, df_cat[[group_var]], p.adj = "bonferroni"))
}

# List of category names
categories <- c("FilmAnimation", "AutosVehicles", "Music", "PetsAnimals", "Sports",
                "TravelEvents", "Gaming", "PeopleBlogs", "Comedy", "Entertainment",
                "NewsPolitics", "HowtoStyle", "Education", "ScienceTech", "NonprofitsActivism")

# Variables to test against ViewsLog
group_vars <- c("LTVGroup", "CommentsGroup", "CTVGroup")

# Loop over categories and variables
for (cat_name in categories) {
  for (grp in group_vars) {
    run_anova_pairwise(finaldf, cat_name, grp)
  }
}



