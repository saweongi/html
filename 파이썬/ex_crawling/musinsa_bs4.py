from bs4 import BeautifulSoup
import requests
import csv

#정적이랑 동적이랑 데이터 크롤링 하는 방법이 다르다 이건 정적


url = f'https://www.musinsa.com/mz/community?p=1'
res = requests.get(url) #url에 요청을 한다
print(res.content) #응답한 객체의 정보를 출력함(지금은 그냥 텍스트라서 문자열로 나온다) --> 그냥 사용하기 어러워서 밑에 코드를 사용한다.
soup = BeautifulSoup(res.content, 'html.parser') #텍스트문서를 html문서로 파싱하게해준다.
print("="*100)
#print(soup.prettify()) #구조화되게 출력(우리가 알아보기 쉽게 출력해준다)
uls = soup.find('ul', class_='ul-col') #파인드로 ul태크인 클래스명 ul-col를 객체 형태로 가져온다.
lis = uls.find_all('li') #uls객체중에 li라는 것을 리스트로 다 가져온다
arr = []
for i, li in enumerate(lis):   #순서정보가 필요한 for문을 쓸경우 enumerate를사용 인덱스랑 값 같이나옴
    if i > 1:      #0은 게시판 이런글짜라서 내용이아니라서 1이상부터 가져옴
        print(li)
        cate = li.find('span', class_='colName').text #span 태그중에 클래스명이 colName인 애의 텍스트를 가져온다
        date = li.find('span', class_='colDate').text
        hit = li.find('span', class_='colHit').text
        href = li.find('span', class_='colSbj-cate').find_all('a')[1]['href'] #span태크중에 colSbj-cate클래스명인애 안에 a태크의 첫번째원소의 href를 가져온다
        title = li.find('span', class_='colSbj-cate').find_all('a')[1].text #span태크중에 colSbj-cate클래스명인애 안에 a태크의 첫번째원소의 텍스트를 가져온다
        print(cate, date, hit,href,title)
        arr.append([cate, date, hit,href,title])
with open('musinsa.csv', 'w', encoding='utf-8') as f: #파일을 만들고 오픈한다.
    write =csv.writer(f, delimiter='|', quotechar='"') #delimiter |로 구분하게 했다.
    for d in arr:
        write.writerow(d) # arr 넣은 데이터를 파일에 적어라!

