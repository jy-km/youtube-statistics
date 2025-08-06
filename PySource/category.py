import math
import isodate 
def ratio(likes, comments, views):
    try:
        LTV = int(likes) / int(views)
        CTV = int(comments) / int(views)
    except (ValueError, ZeroDivisionError):
        LTV = "NA"
        CTV = "NA"
    return [LTV, CTV]

def log10(views, likes):
    if views > 0:
        viewslog = math.log10(views)
    else:
        viewslog = "NA"

    if likes > 0:
        likeslog = math.log10(likes)
    else:
        likeslog = "NA"
    return [viewslog,likeslog]

def grouping(comments, datediff):
    if comments == 0:    
        CommentGroup = "No Comments"
    elif comments >= 1 and comments <= 10:
        CommentGroup = "1-10 Comments"
    elif comments >= 11 and comments <= 100:
        CommentGroup = "11-100 Comments"
    elif comments >= 101 and comments <= 1000:
        CommentGroup = "101-1000 Comments"
    elif comments >= 1001:
        CommentGroup = "1001+ Comments"
    else:
        CommentGroup = "Other"            

    if datediff >= 0 and datediff <= 7:
        DiffGroup = "<= 1 week"
    elif datediff >= 8 and datediff <= 31:
        DiffGroup = "<= 1 month"
    elif datediff >= 32 and datediff <= 365:
        DiffGroup = "<= 1 year"
    elif datediff >= 366 and datediff <= 732:
        DiffGroup = "<= 2 years"
    elif datediff >= 733: # This covers all values greater than or equal to 733
        DiffGroup = "> 2 years"    
    return [CommentGroup, DiffGroup]

def diff(datetime, extracteddate,date):
    date_dt = datetime.strptime(extracteddate, "%Y-%m-%d")
    published_dt = datetime.strptime(date,"%Y-%m-%dT%H:%M:%SZ")
    datediff = (date_dt - published_dt).days
    return datediff


"""
Title, date, views, likes, comments, video id, category, ltv, ctv, diff, ltvlog, viewslog, ltvgroup, commentsgroup, diffgroup
"""