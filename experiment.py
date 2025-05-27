from googleapiclient.discovery import build

api_key = 'PASS_KEY_HERE'
youtube = build('youtube', 'v3', developerKey=api_key)

video_id = 'I5bLsSQE5Dk'
channel_name = 'shiro_ai_jp'
def videostats(video_id):
    request = youtube.videos().list(
        part='snippet,statistics',
        id=video_id
    )
    response = request.execute()

    video = response['items'][0]
    stats = video['statistics']
    snippet = video['snippet']

    print(f"Title: {snippet['title']}")
    print(f"Published: {snippet['publishedAt']}")
    print(f"Views: {stats.get('viewCount', 'N/A')}")
    print(f"Likes: {stats.get('likeCount', 'N/A')}")
    print(f"Comments: {stats.get('commentCount', 'N/A')}")
    print(f"Category: {stats.get('category', 'N/A')}")

videostats(video_id)

def channelstats(channel_name):
    search_response = youtube.search().list(
        q=channel_name,
        type='channel',
        part='snippet',
        maxResults=1
    ).execute()

    channel_id = search_response['items'][0]['snippet']['channelId']

    response = youtube.channels().list(
        part='snippet,statistics,contentDetails',
        id=channel_id
    ).execute()

    # Fix: access the first item in the list
    item = response['items'][0]
    stats = item['statistics']
    snippet = item['snippet']

    print(f"Title: {snippet['title']}")
    print(f"Date of creation: {snippet['publishedAt']}")
    print(f"Views: {stats.get('viewCount', 'N/A')}")
    print(f"Subs: {stats.get('subscriberCount', 'N/A')}")
    print(f"Number of vids: {stats.get('videoCount', 'N/A')}")
    print(f"Category: {stats.get('category', 'N/A')}")

# channelstats(channel_name)




search_response = youtube.search().list(
    q="google",  
    type="video",
    part="snippet",
    order="date",
    maxResults=10,
    regionCode="US",
    videoCategoryId="20",
    publishedAfter="2020-05-26T00:00:00Z"
).execute()

for item in search_response['items']:
    print(f"title: {item['snippet']['title']}")
    print(f"date: {item['snippet']['publishedAt']}")
    # print(f"item['id']['videoId'])