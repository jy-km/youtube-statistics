from googleapiclient.discovery import build

api_key = 'AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk'
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

# videostats(video_id)

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
    q="",  
    type="video",
    part="snippet",
    order="date",
    maxResults=10,
    # regionCode="US",    
    videoCategoryId="26",
    publishedBefore="2025-05-10T00:00:00Z" #change date when conducting experiment
    ).execute()

for item in search_response['items']:
    print(f"title: {item['snippet']['title']}")
    print(f"date: {item['snippet']['publishedAt']}")
    print(f"channel: {item['snippet']['channelTitle']}")
    # print(f"item['id']['videoId'])

"""
1.generate list of keywords (100 or more) for every category that youtube supports
2. use this code to get title and date of the video to look up the URL/ any other way to specify video
3. use specified video to look up statistics (views, likes, etc)
4. exporting into excel spreadsheet

studying more popular videos so it is more useful and relevant, more impact to popular and wannabe youtubers
"""