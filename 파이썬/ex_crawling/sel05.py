import xlsxwriter
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.common.by import By
from selenium import webdriver
from bs4 import  BeautifulSoup
import  time
from tkinter import  *
import chromedriver_autoinstaller
#pip install pillow
from ex_crawling import img_util
import csv

driver = webdriver.Chrome()
driver.implicitly_wait(3)
url = 'https://www.starbucks.co.kr/store/store_map.do'
driver.get(url)  # driver를 이용하여 url을킴
time.sleep(3)
driver.find_element(By.XPATH, '//*[@id="container"]/div/form/fieldset/div/section/header[1]/h2/a').click()
time.sleep(3)
driver.find_element(By.XPATH, '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/header[2]/h3/a').click()
time.sleep(3)
driver.find_element(By.XPATH, '//*[@id="container"]/div/form/fieldset/div/section/article[1]/article/article[2]/div[1]/div[2]/ul/li[5]/a').click()
time.sleep(3)
driver.find_element(By.XPATH, '//*[@id="mCSB_2_container"]/ul/li[1]/a').click()
time.sleep(3)
soup = BeautifulSoup(driver.page_source, 'html.parser')

lis = soup.select('.quickSearchResultBoxSidoGugun li')

arr = []
#새 엑셀 파일과 워크시트 생성
workbook = xlsxwriter.Workbook("star.xlsx")   #test라는 엑셀 파일을 만듬
worksheet = workbook.add_worksheet() #워크시트를 생성한다(기본적인거)

for li in lis:
   name = li.get('data-name')
   title = li.select_one('strong').text
   lat = li.get('data-lat')
   long = li.get('data-long')
   info = li.select_one('.result_details').text
   print(title, lat, long, info)
   arr.append([title, lat, long, info])
   for row_num, row_data in enumerate(arr):
      for col_num, col_data in enumerate(row_data):
         worksheet.write(row_num, col_num, col_data)
workbook.close()


