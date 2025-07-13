from googleapiclient.discovery import build
import isodate # type: ignore
from datetime import datetime
#youtube API setup with key and youtube variable
youtube_api_key = 'AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk'
youtube = build('youtube', 'v3', developerKey=youtube_api_key)

#query search function
def randomquery(category, categoryID,publishedbefore,extracteddate,requestnum):#publishedbefore
    print(categoryID, category[categoryID])
    video_data = [] #list with information to export
    videos_with_likes = 0 #current number of videos with a valid amount of likes
    max_videos_wanted = 50 #our target number
    
    search_response = youtube.search().list(
        q="a", #random character "a" added to keep the videos in english (or any other language that uses latin alphabet)
        type="video", #initializing search type
        part="snippet",
        order="date", #sorting by date
        maxResults=requestnum, #youtube API max is 50 per request
        videoCategoryId=categoryID,
        # publishedBefore=publishedbefore,
        publishedBefore=publishedbefore
    ).execute()


    for item in search_response['items']:
        # stop if enough videos with likes
        if videos_with_likes >= max_videos_wanted:
            break
            
        video_id = item['id']['videoId']
        request = youtube.videos().list( #youtube search using previously found videoID
            part='snippet,statistics, contentDetails',
            id=video_id
        )
        response = request.execute()

        video = response['items'][0] #making variables with collected data
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
            try:
                duration = isodate.parse_duration(length) #changing video length from ISO8601 to normal date type
            except (isodate.isoerror.ISO8601Error):
                break
            #parsing date
            date_dt = datetime.strptime(extracteddate, "%Y-%m-%d")
            published_dt = datetime.strptime(date,"%Y-%m-%dT%H:%M:%SZ")
            datediff = (date_dt - published_dt).days
            """
            print(f"Title: {title}") #printing data out for double check
            print(f"Date: {date}")
            print(f"Views: {views}")
            print(f"Likes: {likes}")
            print(f"Comments: {comments}")
            print(f"Video ID: {video_id}")
            print(f"Duration: {duration}")
            print(f"Diff: {datediff}")
            print()
            print("-----------------------")
            """
            
            #appending to export list
            try:
                LTV = int(likes) / int(views)
                CTL = int(comments) / int(likes)
            except (ValueError, ZeroDivisionError):
                LTV = "N/A"
                CTL = "N/A"
                                
            video_data.append([
    title, date, views, likes, comments, category[categoryID], duration, video_id, publishedbefore,
    LTV, CTL, (datediff)
    ])
            
            videos_with_likes += 1 #updating amount of videos with valid likes
    print(f"Total videos exported: {len(video_data)}")
    return video_data
    