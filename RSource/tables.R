source("C:/Users/jaeyo/Downloads/youtube-statistics/RSource/startup.R")
library(htmltools)

finaldf$Views <- factor(finaldf$Views) 

table1::table1(~ViewsLog + Likes + Category + Duration + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + DurationGroup
, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Duration + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + DurationGroup + CTVGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + Duration + LTV + CTV + Diff + CommentsGroup + LTVGroup + DurationGroup + CTVGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + Likes + Category + Duration + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + CTVGroup
               | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)


t1 <- table1::table1(~ViewsLog + Likes + Category + Duration + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + CTVGroup
                     | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

save_html(t1, file = "C:/Users/jaeyo/Downloads/youtube-statistics/Tables/DurationGroup.html")


