#Summary of variables
#Views
combined %>%
  filter(Views > 0) %>%
  mean(combined$Views, na.rm = TRUE)
  sd(combined$Views, na.rm = TRUE)
  min(combined$Views, na.rm = TRUE)
  max(combined$Views, na.rm = TRUE)
  median(combined$Views, na.rm = TRUE)
  
combined %>%
  filter(Views > 0) %>%
  mutate(log_Views = log10(Views)) %>%
  summarise(
    mean = mean(log_Views, na.rm = TRUE),
    sd   = sd(log_Views, na.rm = TRUE),
    min  = min(log_Views, na.rm = TRUE),
    max  = max(log_Views, na.rm = TRUE),
    median = median(log_Views, na.rm = TRUE)
  )
#LTV
combined %>%
  summarise(
    mean(LTV, na.rm = TRUE),
    sd(LTV, na.rm = TRUE),
    min(LTV, na.rm = TRUE),
    max(LTV, na.rm = TRUE),
    median(LTV, na.rm = TRUE)
  )
combined %>%
  filter(LTV > 0) %>%

#Log_LTV
combined %>%
  filter(LTV > 0) %>%
  mutate(log_LTV = log10(LTV)) %>%
  summarise(
    mean = mean(log_LTV, na.rm = TRUE),
    sd   = sd(log_LTV, na.rm = TRUE),
    min  = min(log_LTV, na.rm = TRUE),
    max  = max(log_LTV, na.rm = TRUE),
    median = median(log_LTV, na.rm = TRUE)
  )

#distribution (n, % of each category) of #likes to views ratio categories
combined %>%
  group_by(Category) %>%
  summarise(
    count = n(),
    mean = mean(LTV, na.rm = TRUE),
    median = median(LTV, na.rm = TRUE),
    sd = sd(LTV, na.rm = TRUE),
    min = min(LTV, na.rm = TRUE),
    max = max(LTV, na.rm = TRUE)
  )

#Comments
combined %>%
  summarise(
    mean = mean(Comments, na.rm = TRUE),
    sd = sd(Comments, na.rm = TRUE),
    min = min(Comments, na.rm = TRUE),
    max = max(Comments, na.rm = TRUE),
    median = median(Comments, na.rm = TRUE)
  )

#distribution (n, % of each category) of #comments categories
combined %>%
  filter(!is.na(Category), !is.na(CommentsGroup)) %>%  
  group_by(Category, CommentsGroup) %>%
  summarise(n = n(), .groups = 'drop') %>%
  group_by(Category) %>%
  mutate(percent = round(n / sum(n) * 100, 1)) %>%
  print(n=100)