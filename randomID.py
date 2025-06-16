"""
categoryId	Category
1	Film & Animation
10	Music
17	Sports
20	Gaming
22	People & Blogs
23	Comedy
24	Entertainment
25	News & Politics
26	Howto & Style
27	Education
28	Science & Tech
"""



import random #importing module necessary for code generation

def generateid(length, chars): #generates id based on its length and the possible characters
    id = ''.join(random.choice(chars) for _ in range(length))
    return id #returns random combination of ID
