from randomquery import randomquery
from export import export


#15 total
category = {1 : "FilmAnimation",
2 : "AutosVehicles", 
10:	"Music",
15: "PetsAnimals",
17:	"Sports"    ,
19: "TravelEvents",
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

totallist = []
lenlist = []

for ID in category:
#randomquery(category, categoryID,publishedbefore,extracteddate,requestnum)
    rq = randomquery(category, ID,"2023-8-10T00:00:00Z","2025-08-10",50, "oneday") 
    totallist.append(rq) #date: YYYY-MM-DD format
    lenlist.append(len(rq))
export(totallist,lenlist,"twoyears") 
print(lenlist)

