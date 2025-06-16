from googleapiclient.discovery import build

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