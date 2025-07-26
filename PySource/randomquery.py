from googleapiclient.discovery import build
import isodate # type: ignore
from datetime import datetime
from category import ratio, log10, grouping, diff
youtube_api_key = 'AIzaSyBQ8vBBDq0Kwf_Ni3hh_HLBkFaqhOifNTk'
youtube = build('youtube', 'v3', developerKey=youtube_api_key)

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
            durationS = int(duration[0:1]) * 3600 + int(duration[2:4]) * 60 + int(duration[5])

            datediff = diff(datetime, extracteddate,date)
            newlog = log10(views,likes)
            newratio = ratio(likes, comments, views)
            newgroup = grouping(comments,datediff)

            video_data.append([
    title, date, views, likes, newlog[0], newlog[0],  comments, category[categoryID], durationS, video_id, publishedbefore,
    newratio[0], newratio[1], datediff, newgroup[0], newgroup[1]
    ])
    
#['Title', 'Date', 'Views', 'Likes', 'ViewsLog', 'LikesLog', 'Comments','Category','Duration','VideoID','Extracted','LTV','CTL','Diff', 'CommentsGroup', 'DiffGroup']

            videos_with_likes += 1 #updating amount of videos with valid likes

    return video_data