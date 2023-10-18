import os
from PIL import Image
img_dir = "./dataset/"
keyword = ['범고래', '향유고래', '고래상어']
for dir in keyword:
    main_path = img_dir + dir
    arr = os.listdir(main_path)
    for file in arr:

        with Image.open(main_path + "/" + file) as img:
            width, height = img.size
        if width < 100 or height < 100:
            os.remove(main_path + "/" + file)