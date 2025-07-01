from googleapiclient.discovery import build
import isodate # type: ignore
from export import export # type: ignore
#youtube API setup
youtube_api_key = 'AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk'
youtube = build('youtube', 'v3', developerKey=youtube_api_key)

#main function
def randomquery(category, categoryID):
    print(categoryID, category[categoryID])
    video_data = []
    videos_with_likes = 0
    max_videos_wanted = 45

    search_response = youtube.search().list(
        q="a",
        type="video",
        part="snippet",
        order="date",
        maxResults=50, # YouTube API max is 50 per request
        videoCategoryId=categoryID,
        publishedBefore="2022-05-16T00:00:00Z"
    ).execute()
#        publishedBefore="2025-05-16T00:00:00Z"
#        publishedBefore="2025-04-16T00:00:00Z"
#        publishedBefore="2024-05-16T00:00:00Z"



    for item in search_response['items']:
        # Stop if we've already found enough videos with likes
        if videos_with_likes >= max_videos_wanted:
            break
            
        video_id = item['id']['videoId']
        request = youtube.videos().list(
            part='snippet,statistics, contentDetails',
            id=video_id
        )
        response = request.execute()

        video = response['items'][0]
        stats = video['statistics']
        snippet = video['snippet']
        contentdetails = video['contentDetails']

        title = snippet['title']
        date = snippet['publishedAt']
        views = stats.get('viewCount', 'N/A')
        likes = stats.get('likeCount', 'N/A')
        comments = stats.get('commentCount', 'N/A')
        length = contentdetails.get('duration', 'N/A')

        if likes != 'N/A':
            duration = isodate.parse_duration(length)

            print(f"Title: {title}")
            print(f"Date: {date}")
            print(f"Views: {views}")
            print(f"Likes: {likes}")
            print(f"Comments: {comments}")
            print(f"Video ID: {video_id}")
            print(f"Duration: {duration}")
            print()
            print()
            print("-----------------------")
            
            video_data.append([title, date, views, likes, comments, duration, video_id])
            videos_with_likes += 1
    export(video_data,category,categoryID)