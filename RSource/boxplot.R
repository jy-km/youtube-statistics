ViewsLog (continuous) vs Category (categorical)

finaldf %>%
  filter(Category %in% c("AutosVehicles", "FilmAnimation")) %>%
  ggplot(aes(x = Category, y = ViewsLog)) +   # usually Category on x, ViewsLog on y
  geom_boxplot() +
  labs(title = "Box Plot of ViewsLog by Category",
       x = "Category", y = "ViewsLog")

finaldf %>%
  ggplot(aes(x = Category, y = ViewsLog)) +   # usually Category on x, ViewsLog on y
  geom_boxplot() +
  labs(title = "Box Plot of ViewsLog by Category",
       x = "Category", y = "ViewsLog")

LTV (continuous) vs DiffGroup (categorical)

finaldf %>%
  filter(LTV < 0.05) %>%
  ggplot(aes(x = DiffGroup, y = LTV)) +
  geom_boxplot() +
  labs(title = "Box Plot of LTV by DiffGroup: LTV < 0.05",
       x = "DiffGroup", y = "LTV")


LTVGroup vs views

finaldf %>%
  ggplot(aes(x = LTVGroup, y = ViewsLog)) +
  geom_boxplot() +
  labs(title = "Box Plot of ViewsLog by LTVGroup",
       x = "LTVGroup", y = "ViewsLog")