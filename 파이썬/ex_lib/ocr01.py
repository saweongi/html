# pip install easyOCR
# pip install opencv-python

import easyocr
reader = easyocr.Reader(['ko'])
results = reader.readtext('a.jpg')
for result in results:
    text = result[1]
    print(text)