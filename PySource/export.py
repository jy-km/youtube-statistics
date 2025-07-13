from datetime import datetime
import csv

def export(video_data,lenlist):
    if video_data: #checking if there is video data to export 
        #example: youtube_data_FilmAnimation2025-07-01.csv
        filename = f"C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_{datetime.now().date()}.csv"
        with open(filename, 'w', newline='', encoding='utf-8') as csvfile: #writing csv file
            writer = csv.writer(csvfile)
            headers = ['Title', 'Date', 'Views', 'Likes', 'Comments','Category','Duration','VideoID','Extracted','LTV','CTL','Diff']

            writer.writerow(headers)
            for u in range(len(video_data)):
                for i in range(lenlist[u]):
                    writer.writerow(video_data[u][i])
        
        print(f"\nData exported to CSV: {filename}")
        print(f"Total videos exported: {len(video_data)}")
