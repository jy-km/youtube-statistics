#Standard cont variables
subject_list_1 <- c("Views", "Likes", "Diff", "CTV", "Duration")

#Filtered cont variables
subject_list_2 <- c("LTV", "ViewsLog", "LikesLog", "Likes") 

#cat variables
subject_list_3 <- c("LTVGroup", "CommentsGroup", "DiffGroup", "Category", "DurationGroup")

summary_results <- generate_summary_files(
  data = finaldf,
  contvar = subject_list_1,
  contvar_filt = subject_list_2,
  catvar = subject_list_3,
  output_prefix = "video_analysis" 
)

# You can now view the results directly
print(summary_results$cont)
print(summary_results$cat)


generate_summary_files <- function(data, contvar, contvar_filt, catvar, output_prefix = "summary") {
  
#cont variables
  cont_summary <- purrr::map_dfr(contvar, ~{
    var <- sym(.x)
    data %>%
      summarise(
        Mean = mean(!!var, na.rm = TRUE),
        SD = sd(!!var, na.rm = TRUE),
        Median = median(!!var, na.rm = TRUE),
        Minimum = min(!!var, na.rm = TRUE),
        Maximum = max(!!var, na.rm = TRUE)
      ) %>%
      mutate(Variable = .x, .before = 1)
  })
  
#cont filtered variables
  cont_filtered_summary <- purrr::map_dfr(contvar_filt, ~{
    var <- sym(.x)
    data %>%
      filter((!!var) > 0) %>%
      summarise(
        Mean = mean(!!var, na.rm = TRUE),
        SD = sd(!!var, na.rm = TRUE),
        Median = median(!!var, na.rm = TRUE),
        Minimum = min(!!var, na.rm = TRUE),
        Maximum = max(!!var, na.rm = TRUE)
      ) %>%
      mutate(
        Variable = .x,
        Note = "Filtered for values > 0",
        .before = 1
      )
  })
  
#cat variables
  total_n <- nrow(data)
  cat_summary <- purrr::map_dfr(catvar, ~{
    data %>%
      filter(!is.na(.data[[.x]])) %>%
      count(Category_Level = .data[[.x]], name = "Count") %>%
      mutate(
        Variable = .x,
        Percentage = round(Count / total_n * 100, 1)
      ) %>%
      select(Variable, Category_Level, Count, Percentage)
  })
  
#CSV
  all_cont_summary <- bind_rows(cont_summary, cont_filtered_summary)
  cont_filename <- paste0(output_prefix, "_cont.csv")
  readr::write_csv(all_cont_summary, cont_filename)
  print(paste("Continuous summary saved to:", cont_filename))
  
  
  # --- 5. Write cat results to a separate CSV ---
  cat_filename <- paste0(output_prefix, "_cat.csv")
  readr::write_csv(cat_summary, cat_filename)
  print(paste("Categorical summary saved to:", cat_filename))
  
  # Return the dataframes as a list to use in your R session
  return(list(cont = all_cont_summary, cat = cat_summary))
}