from selenium import webdriver
from selenium.webdriver.common.by import By
import time
from selenium.webdriver.common.keys import Keys
from bs4 import BeautifulSoup

driver = webdriver.Edge('./msedgedriver.exe')
driver.implicitly_wait(3)
url = 'https://upbit.com/exchange?code=CRIX.UPBIT.KRW-BTC'
driver.get(url)
time.sleep(1)
soup = BeautifulSoup(driver.page_source, 'html.parser')
print(soup.prettify())