
#equal variances
bartlett.test(ViewsLog ~ LTVGroup, data = finaldf)

#failed equal variances test, p-value for kruskal is 2.2E-16
kruskal.test(ViewsLog ~ LTVGroup, data = finaldf)

pairwise.wilcox.test(finaldf$ViewsLog, finaldf$LTVGroup, p.adjust.method = "bonferroni")

aov2 <- aov(ViewsLog ~ LTVGroup * Category, data = finaldf)
summary(aov2)

aov3 <- aov(ViewsLog ~ LTVGroup * DiffGroup, data = finaldf)
summary(aov3)