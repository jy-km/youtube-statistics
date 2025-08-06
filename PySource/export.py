from datetime import datetime
import csv

def export(video_data,lenlist,date):
    if video_data:
        #example: youtube_data_FilmAnimation2025-07-01.csv
        filename = f"C:/Users/jaeyo/Downloads/youtube-statistics/CSV/{datetime.now().date()}/youtube_data_{datetime.now().date()}_{date}.csv"
        with open(filename, 'w', newline='', encoding='utf-8') as csvfile: #writing csv file
            writer = csv.writer(csvfile)
            headers = ['Title', 'Date', 'Views', 'Likes', 'ViewsLog', 'LikesLog', 'Comments','Category','Duration','VideoID','Extracted','LTV','CTV','Diff', 'CommentsGroup', 'DiffGroup']

            writer.writerow(headers)
            for u in range(len(video_data)):
                for i in range(lenlist[u]):
                    writer.writerow(video_data[u][i])
        
        print(f"\nData exported to CSV: {filename}")
        print(f"Total videos exported: {len(video_data)}")


