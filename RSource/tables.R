source("C:/Users/jaeyo/Downloads/youtube-statistics/RSource/startup.R")
library(htmltools)

finaldf$Views <- factor(finaldf$Views) 


#find best option for digits = x
table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + VideoLengthGroup+ LTV + LTVGroup + DiffGroup + VideoLengthGroup
, data = finaldf, na.rm = TRUE, digits = 5, format.number = TRUE)

table1::table1(~ViewsLog + Likes + VideoLengthMin + LTV + DiffGroup + LTVGroup + VideoLengthGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + LTVGroup + VideoLengthGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + DiffGroup + LTVGroup
               | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)


t1 <- table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + DiffGroup + LTVGroup
                     | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

save_html(t1, file = "C:/Users/jaeyo/Downloads/youtube-statistics/Tables/VideoLengthGroup.html")



t1 <- table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + VideoLengthGroup+ LTV + LikesZero + LTVGroup + DiffGroup + VideoLengthGroup
                     , data = finaldf, na.rm = TRUE, digits = 5, format.number = TRUE)

table1::table1(~ViewsLog + Likes + VideoLengthMin + LTV + LTVGroup + VideoLengthGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + LTVGroup + VideoLengthGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + LTVGroup
               | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

save_html(t1, file = "C:/Users/jaeyo/Downloads/youtube-statistics/Tables/total.html")


names(finaldf)[names(finaldf) == "VideoLengthGroup"] <- "VideoLengthGroup"


likesummary <- summary(finaldf$Likes)
print(t1)
