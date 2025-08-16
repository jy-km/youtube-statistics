finaldf$Views <- factor(finaldf$Views) 

table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + DurationGroup
, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + LikesLog + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + DurationGroup
               | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + LTVGroup + DurationGroup
               | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)

table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup
               | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)



library(rvest)

# Save table1 output as HTML
html_file <- "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table1-export.html"
print(
  table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup
                 | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)
)

# Read the HTML and extract table
df_tbl <- read_html(html_file) %>%
  html_table(fill = TRUE) %>%
  .[[1]]  # Take first table

# Save to CSV
write.csv(df_tbl, "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table1_export.csv", row.names = FALSE)




# Save table2 output as HTML
html_file <- "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table2-export.html"
print(
  table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup
                 | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)
)

# Read the HTML and extract table
df_tbl <- read_html(html_file) %>%
  html_table(fill = TRUE) %>%
  .[[1]]  # Take first table

# Save to CSV
write.csv(df_tbl, "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table2_export.csv", row.names = FALSE)




# Save table1 output as HTML
html_file <- "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table3-export.html"
print(
  table1::table1(~ViewsLog + LikesLog + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup + DurationGroup
                 | Category, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)
)

# Read the HTML and extract table
df_tbl <- read_html(html_file) %>%
  html_table(fill = TRUE) %>%
  .[[1]]  # Take first table

# Save to CSV
write.csv(df_tbl, "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table3_export.csv", row.names = FALSE)




# Save table1 output as HTML
html_file <- "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table3-export.html"
print(
  table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + LTVGroup + DurationGroup
                 | DiffGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)
)

# Read the HTML and extract table
df_tbl <- read_html(html_file) %>%
  html_table(fill = TRUE) %>%
  .[[1]]  # Take first table

# Save to CSV
write.csv(df_tbl, "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table3_export.csv", row.names = FALSE)



# Save table1 output as HTML
html_file <- "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table4-export.html"
print(
  table1::table1(~ViewsLog + LikesLog + Category + Duration + Duration_min + LTV + CTV + Diff + CommentsGroup + DiffGroup + LTVGroup
                 | DurationGroup, data = finaldf, na.rm = TRUE, digits = 2, format.number = TRUE)
)

# Read the HTML and extract table
df_tbl <- read_html(html_file) %>%
  html_table(fill = TRUE) %>%
  .[[1]]  # Take first table

# Save to CSV
write.csv(df_tbl, "C:/Users/jaeyo/Downloads/youtube-statistics/CSV/table4_export.csv", row.names = FALSE)
