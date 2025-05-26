import requests
from io import BytesIO
from PIL import Image
import sys
print(sys.executable)   

def idcheck(video_id):
    img_url = f"http://img.youtube.com/vi/{video_id}/mqdefault.jpg"
    response = requests.get(img_url)
    
    if response.status_code == 200:
        img = Image.open(BytesIO(response.content))
        return check_thumbnail(img.width)
    else:
        return check_thumbnail(120)

def check_thumbnail(width):
    if width == 120:
        return False
    else:
        return True

