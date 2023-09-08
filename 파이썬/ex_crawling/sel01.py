from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.common.keys import Keys

driver = webdriver.Edge('./msedgedriver.exe')
driver.implicitly_wait(3) #브라우저 켜질대까지 기다리기


url ='https://www.msn.com/ko-kr/new/techandscience'
driver.get(url)
time.sleep(1)
cnt = 5
pagedown = 1
body = driver.find_element(By.TAG_NAME, 'body')
while pagedown < cnt:
    body.send_keys(Keys.PAGE_DOWN) #스크롤 내리기
    time.sleep(1)
    pagedown += 1

