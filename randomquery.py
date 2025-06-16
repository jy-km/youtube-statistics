from googleapiclient.discovery import build
import csv
from datetime import datetime
import os

# YouTube API setup
youtube_api_key = 'AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk'
youtube = build('youtube', 'v3', developerKey=youtube_api_key)

idlist = []
video_data = []

search_response = youtube.search().list(
    q="",  
    type="video",
    part="snippet",
    order="date",
    maxResults=10,
    videoCategoryId="26",
    publishedBefore="2025-05-10T00:00:00Z"
).execute()

for item in search_response['items']:
    video_id = item['id']['videoId']
    request = youtube.videos().list(
        part='snippet,statistics',
        id=video_id
    )
    response = request.execute()

    video = response['items'][0]
    stats = video['statistics']
    snippet = video['snippet']

    title = snippet['title']
    date = snippet['publishedAt']
    views = stats.get('viewCount', 'N/A')
    likes = stats.get('likeCount', 'N/A')
    comments = stats.get('commentCount', 'N/A')

    if likes != 'N/A':
        print(f"Title: {title}")
        print(f"Date: {date}")
        print(f"Views: {views}")
        print(f"Likes: {likes}")
        print(f"Comments: {comments}")
        print(f"Video ID: {video_id}")
        print()
        print()
        print()
        print("-----------------------")
        
        # Add data to list for CSV export
        video_data.append([title, date, views, likes, comments, video_id])

# Export to CSV
if video_data:
    # Create filename with timestamp
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    filename = f"C:/Users/jaeyo/Downloads/youtube-statistics/CSV/youtube_data_{timestamp}.csv"
    
    # Write to CSV file
    with open(filename, 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        
        # Write headers
        headers = ['Title', 'Date', 'Views', 'Likes', 'Comments', 'Video ID']
        writer.writerow(headers)
        
        # Write data rows
        writer.writerows(video_data)
    
    print(f"\nData exported to CSV: {filename}")
    print(f"Total videos exported: {len(video_data)}")
else:
    print("No video data to export.")

print(f"Full path: {os.path.abspath(filename)}")

"""
categoryId	Category
1	Film & Animation
10	Music
17	Sports
20	Gaming
22	People & Blogs
23	Comedy
24	Entertainment
25	News & Politics
26	Howto & Style
27	Education
28	Science & Tech
"""
