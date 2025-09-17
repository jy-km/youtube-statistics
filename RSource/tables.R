source("C:/Users/jaeyo/Downloads/youtube-statistics/RSource/startup.R")
library(htmltools)

finaldf$Views <- factor(finaldf$Views) 

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + DiffGroup + LTVGroup + VideoLengthGroup
, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + VideoLengthMin + LTV + CommentsGroup + DiffGroup + LTVGroup + VideoLengthGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + LTVGroup + VideoLengthGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + DiffGroup + LTVGroup
               | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)


t1 <- table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + DiffGroup + LTVGroup
                     | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

save_html(t1, file = "C:/Users/jaeyo/Downloads/youtube-statistics/Tables/VideoLengthGroup.html")



t1 <- table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + LTVGroup + VideoLengthGroup
               , data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + VideoLengthMin + LTV + CommentsGroup + LTVGroup + VideoLengthGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + LTVGroup + VideoLengthGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + VideoLengthMin + LTV + CommentsGroup + LTVGroup
               | VideoLengthGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

save_html(t1, file = "C:/Users/jaeyo/Downloads/youtube-statistics/Tables/VideoLengthGroup.html")


names(finaldf)[names(finaldf) == "VideoLengthGroup"] <- "VideoLengthGroup"


