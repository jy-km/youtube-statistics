from randomquery import randomquery

#dictionary of youtube video categories
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
for ID in category:
    randomquery(category, ID)

