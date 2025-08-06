import pandas as pd
import glob

csv_files = glob.glob("C:/Users/jaeyo/Downloads/youtube-statistics/CSV/2025-08-03*.csv")

# Combine
combined_df = pd.concat([pd.read_csv(f) for f in csv_files], ignore_index=True)
combined_df.to_csv("2025-08-03.csv", index=False)