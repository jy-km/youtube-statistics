from googleapiclient.discovery import build
import isodate # type: ignore
from datetime import datetime
from category import ratio, log10, grouping, diff
api_list = ['AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk', 'AIzaSyDaHBCoomTdIcabsnKRJONYCgJVomWFlI8','AIzaSyA6TJPtt58PpgzVT93DqVLIuDmi58BghGU']
youtube_api_key = api_list[1]
youtube = build('youtube', 'v3', developerKey=youtube_api_key)

def randomquery(category, categoryID,publishedbefore,extracteddate,requestnum, timeperiod):#publishedbefore
    print(categoryID, category[categoryID])
    video_data = [] #list with information to export
    videos_with_likes = 0 #current number of videos with a valid amount of likes
    max_videos_wanted = requestnum #our target number
    
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

        if likes != 'N/A' and comments != 'N/A':
            views = int(views); likes = int(likes); comments = int(comments)
            try:
                duration = isodate.parse_duration(length) #changing video length from ISO8601 to normal date type
            except (isodate.isoerror.ISO8601Error):
                break
            durationS = int(duration.total_seconds()) 
            datediff = diff(datetime, extracteddate,date)
            newlog = log10(views,likes)
            newratio = ratio(likes, comments, views)
            newgroup = grouping(comments,datediff)

            video_data.append([
    title, date, views, likes, newlog[0], newlog[1],  comments, category[categoryID], durationS, video_id, publishedbefore,
    newratio[0], newratio[1], datediff, newgroup[0], newgroup[1]
    ])
    
#['Title', 'Date', 'Views', 'Likes', 'ViewsLog', 'LikesLog', 'Comments','Category','Duration','VideoID','Extracted','LTV','CTL','Diff', 'CommentsGroup', 'DiffGroup']

            videos_with_likes += 1 #updating amount of videos with valid likes

    return video_data

#variables: views, lvt, comments, category, date extracted, date uploaded, video length
