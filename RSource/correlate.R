#Views vs LTV (overall)
#Pearson
pearson <- cor(
  finaldf$ViewsLog[finaldf$Views > 0 & finaldf$LTV > 0],
  finaldf$LikesLog[finaldf$Views > 0 & finaldf$LTV > 0],
  method = "pearson"
)

print(pearson)
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

