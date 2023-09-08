from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium import webdriver
from bs4 import  BeautifulSoup
import  time
from tkinter import  *
import chromedriver_autoinstaller
#pip install pillow
from ex_crawling import img_util

search_word=""
chromedriver_autoinstaller.install()

def fn_search_tour():
    print('tour search')
    search_word = word_entry.get() #gui 쓰는 부분을 변수에담음
    driver = webdriver.Chrome()
    driver.implicitly_wait(3)
    url = 'https://seil.hanatour.com/package/international'
    driver.get(url) #driver를 이용하여 url을킴
    time.sleep(1)
    input_search = driver.find_element(By.ID, 'input_keyword') #아이디 태그 input_keyword를 담는다
    input_search.send_keys(search_word) #gui 입력부분의 값을 검색창에 넣는다
    time.sleep(1)
    btn = driver.find_element(By.CSS_SELECTOR,'button.btn_search').click() #css셀렉터 태그의 버튼을 클릭한다.
    time.sleep(2)
    driver.find_element(By.XPATH, '//*[@id="contents"]/div[3]/div[1]/div[1]/a').click() #XPATH의 값으로 되어있는애를 클릭한다
    time.sleep(2)
    soup = BeautifulSoup(driver.page_source, 'html.parser') #드라이버 페이지 소스를 html로 파싱한다
    lis = soup.select('.prod_list li') #클래스 prod_list의 li태그를 가져온다
    driver.get_screenshot_as_file('tour.png') #driver의 한 부분의 이미지를 저장
    img_util.fullpage_screenshot(driver, 'tour_all.png') #driver의 풀 화면의 이미지를 저장
    for li in lis:
        info = li.select_one('.txt_info').text



    driver.quit()



app = Tk()
app.title("tour search")
word_entry = Entry(app, width =100)
word_entry.pack()
search_btn =  Button(app, text="search & save", command=fn_search_tour)
search_btn.pack()

app.mainloop()

