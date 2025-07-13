summary(combined)

summary(combined$Views)


cor(combined$Views,combined$LTV)

cor.test(combined$Views,combined$LTV, method = "pearson")