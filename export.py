from datetime import datetime
import csv
def export(video_data,category,categoryID):
    if video_data: #checking if there is video data to export 
        filename = f"C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_{category[categoryID]}{datetime.now().date()}.csv"
        with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
            writer = csv.writer(csvfile)
            
            headers = ['Title', 'Date', 'Views', 'Likes', 'Comments','Duration','Video ID']
            writer.writerow(headers)
            
            writer.writerows(video_data)
        
        print(f"\nData exported to CSV: {filename}")
        print(f"Total videos exported: {len(video_data)}")
    else:
        print("No video data to export.")