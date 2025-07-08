from randomquery import randomquery
from export import export

#dictionary of youtube video categories
#categoryID : category name
category = {1 : "FilmAnimation",
2 : "AutosVehicles", 
10:	"Music",
15:  "PetsAnimals",
17:	"Sports"    ,
19:  "TravelEvents",
20:	"Gaming", 
22:	"PeopleBlogs",
23:	"Comedy",
24:	"Entertainment",
25:	"NewsPolitics",
26:	"HowtoStyle",
27: "Education",
28:	"ScienceTech",
29: "NonprofitsActivism"
}

#for every item in category dictionary, randomquery runs
totallist = []
lenlist = []
for ID in category:
    rq = randomquery(category, ID,"2021-07-03T00:00:00Z","2025-07-03",3)
    totallist.append(rq) #date: YYYY-MM-DD format
    lenlist.append(len(rq))
    #2025-07-15 last day to extract data
export(totallist,lenlist) 
print(lenlist)


#publishedBefore="2022-05-16T00:00:00Z"
#publishedBefore="2025-05-16T00:00:00Z"
#publishedBefore="2025-04-16T00:00:00Z"
#publishedBefore="2024-05-16T00:00:00Z"
