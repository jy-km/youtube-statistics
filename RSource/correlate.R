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
cor(
  combined$log_Views[combined$Views > 0 & combined$LTV > 0 & combined$Category == "Gaming"],
  combined$log_LTV[combined$Views > 0 & combined$LTV > 0 & combined$Category == "Gaming"],
  method = "pearson"
)



#Comments vs LTV (overall) 
t.test(combined$Comments, combined$LTV, var.equal = FALSE)

#Comments vs LTV , by category
t.test(
  combined$Comments[combined$Category=="Entertainment"],
  combined$LTV[combined$Category=="Entertainment"]
)

#Views vs Comments (overall)
t.test(combined$Views, combined$Comments, var.equal = FALSE)

#Views vs Comments, by category 
t.test(
  combined$Views[combined$Category=="Entertainment"],
  combined$Comments[combined$Category=="Entertainment"],
  var.equal = FALSE
)

#Also, plot the bivariate relationships using bar charts.  In each chart, there is a bar for each category and the height of the bar is average log[view].   See the example codes for barcharts in 7.3.2 in the ebook above link, but you can use other examples that you like. 

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

finaldft <- finaldf[complete.cases(finaldf[, c("ViewsLog", "LTVGroup")]), ]

pairwise.t.test(
  finaldf$ViewsLog[complete.cases(finaldft$ViewsLog, finaldft$LTVGroup)],
  finaldf$LTVgroup[complete.cases(finaldft$ViewsLog, finaldft$LTVGroup)],
  p.adj = "bonferroni"
)

object <- Rmisc::summarySE(finaldf, measurevar = "ViewsLog", groupvars = c("LTVGroup"), na.rm = TRUE)
ggplot2::ggplot(object, aes(x = factor(LTVGroup), y = ViewsLog)) +
  geom_bar(stat = "Identity", fill = "gray", width = 0.8) +
  geom_errorbar(aes(ymin = ViewsLog - se, ymax = ViewsLog + se), width = .2, color = "black") +
  xlab("Overall label for x-axis groups") + ylab("Y-axis label") + scale_x_discrete(breaks =
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
