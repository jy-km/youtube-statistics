#library imports
library(tidyverse)
library(dplyr)
library(ggplot2)
library(data.table)


#Changing to INT
combined$LTV <- as.numeric(combined$LTV)
combined$CTL <- as.numeric(combined$CTL)
combined$Comments <- as.numeric(combined$Comments)
combined$Views <- as.numeric(combined$Views)

#sample imports
oneday <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_oneday.csv")
onemonth <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_onemonth.csv")
oneyear <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_oneyear.csv")
threeyears <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_threeyears.csv")
combined <- read.csv("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_6_28.csv")
#LIKES TO VIEWS VS NUMBER OF VIEWS
ltv_views <- function(data, timeframe){
  data$Views <- as.numeric(data$Views)
  data$LTV <- as.numeric(data$LTV)
  
  data$LTV_bins <- cut(data$LTV, breaks = 10, include.lowest = TRUE) 
  binned_data <- data %>%
    group_by(LTV_bins) %>%
    summarise(Total_Views = sum(as.numeric(as.character(Views)), na.rm = TRUE))
  
  return(ggplot(binned_data, aes(x=LTV_bins, y=Total_Views)) + 
           geom_bar(stat = "identity", fill = "black") + 
           scale_y_log10(labels = comma_format()) +
           xlab("Likes-to-Views Ratio") + 
           ylab("Total Views") +
           ggtitle(paste("Comparison between Total Views and LTV Ratio -", timeframe)))
}
plot_1day <- ltv_views(oneday, "1 Day")
plot_1month <- ltv_views(onemonth, "1 Month")
plot_1year <- ltv_views(oneyear, "1 Year") 
plot_3years <- ltv_views(threeyears, "3 Years")

plot_1day
plot_1month
plot_1year
plot_3years

#LTV RATIO VS VIDEO AGE
ltv_age <- function(data, timeframe, days) {
  data$Diff <- as.numeric(as.character(data$Diff))
  data$adjusted_days <- data$Diff - days  # Create the variable you're using in aes()
  
  data_filtered <- data[data$adjusted_days >= 0, ]

  ggplot(data_filtered, aes(x = adjusted_days, y = LTV)) +  # Use filtered data
    geom_point(alpha = 0.6, size = 1.5) +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    labs(
      title = paste("Video Age vs LTV Ratio -", timeframe),
      x = "Days Since Video Publication",
      y = "Likes-to-Views Ratio",
    )
}
plot_1day <- ltv_age(oneday, "1 Day", 0)
plot_1month <- ltv_age(onemonth, "1 Month", 33)
plot_1year <- ltv_age(oneyear, "1 Year", 365) 
plot_3years <- ltv_age(threeyears, "3 Years", 365*3)

plot_1day
plot_1month
plot_1year
plot_3years

# LTV ratio vs. #comments, whole and by category
ltv_comments <- function(data, timeframe, days) {
  data$Diff <- as.numeric(as.character(data$Diff))
  data$adjusted_days <- data$Diff - days  # Create the variable you're using in aes()
  
  data_filtered <- data[data$adjusted_days >= 0, ]
  
  ggplot(data_filtered, aes(x = adjusted_days, y = LTV)) +  # Use filtered data
    geom_point(alpha = 0.6, size = 1.5) +
    geom_smooth(method = "lm", se = TRUE, color = "red") +
    labs(
      title = paste("Video Age vs LTV Ratio -", timeframe),
      x = "Days Since Video Publication",
      y = "Likes-to-Views Ratio",
    )
}
plot_1day <- ltv_comments(oneday, "1 Day", 0)
plot_1month <- ltv_age(onemonth, "1 Month", 33)
plot_1year <- ltv_age(oneyear, "1 Year", 365) 
plot_3years <- ltv_age(threeyears, "3 Years", 365*3)

plot_1day
plot_1month
plot_1year
plot_3years
#LTV ratio vs. #views, whole and by category
