from bs4 import BeautifulSoup
import requests
import csv
import os
import urllib.request as req
import re #정규표현식 사용 하는방법


url = 'https://movie.daum.net/ranking/boxoffice/weekly?date=20230828'
res = requests.get(url)
soup = BeautifulSoup(res.content, 'html.parser')
print(soup.prettify())

# /movie_img/영화명
ol = soup.select_one('.list_movieranking') #.list_movieranking인 클래스명을 가진 애를 가져온다
lis = ol.select('li') #li태그를 가진 애들을 다가져온다
if not os.path.exists('movie_img'):
    os.mkdir('movie_img')
for li in lis:
    print("="*100)
     #print(li)
    title = li.select_one('img').get('alt').replace(":","") #이미지태그안에 alt에 있는 이름을 가져온다.
    src = li.select_one('img').get('src') #이미지태그안에 alt에 있는 링크를 가져온다.
    print(title, src)

    if src:
        if src.startswith('http'): #처음주소?
            local_path = f'movie_img/{title}' + '.png' #파일 이름 저장 어캐 할지
            req.urlretrieve(src, local_path) #파일가져오기

em =soup.select('.num_date')
print(em)
arr = []
#영화명 개봉일자숫자만 관객수 숫자만 상세내용 rl 포스터저장경로
ol = soup.select_one('.list_movieranking') #.list_movieranking인 클래스명을 가진 애를 가져온다
lis = ol.select('li') #li태그를 가진 애들을 다가져온다
for li in lis:
    print("="*100)
     #print(li)
    title = li.select_one('img').get('alt').replace(":","") #이미지태그안에 alt에 있는 이름을 가져온다.
    open_move = li.select('.info_txt')[0].text
    open_move1 = re.sub(r'[^0-9]', '', open_move)
    audience = li.select('.info_txt')[1].text
    audience1 = re.sub(r'[^0-9]', '', audience)
    src = li.select_one('img').get('src') #이미지태그안에 alt에 있는 링크를 가져온다.
    content = li.select_one('.poster_info').select_one('a').get('href')
    ppath = f'C:/dev/pythonProject/ex_crawling/movie_img/{title}'
    print(title,open_move1,audience1 ,content,src,ppath)
    arr.append([title,open_move1,audience1 ,content,src,ppath])
with open('230828_230903.csv', 'w', encoding='utf-8') as f: #파일을 만들고 오픈한다.
    write =csv.writer(f, delimiter='|', quotechar='"') #delimiter |로 구분하게 했다.
    for d in arr:
        write.writerow(d) # arr 넣은 데이터를 파일에 적어라!

