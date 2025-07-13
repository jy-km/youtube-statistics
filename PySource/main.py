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
    rq = randomquery(category, ID,"2025-6-10T00:00:00Z","2025-07-15",40) 
    totallist.append(rq) #date: YYYY-MM-DD format
    lenlist.append(len(rq))
    #2025-07-15 last day to extract data
export(totallist,lenlist) 
print(lenlist)

#122 days in 4 months
"""
40 samples each 
First Date: July 15, 2024

Second Date: November 14, 2024 (122 days after July 15, 2024)

Third Date: March 16, 2025 (122 days after November 14, 2024)

Fourth Date: July 16, 2025 (122 days after March 16, 2025)

END DATE HOWEVER ENDS IN JULY 15 2025
"""
