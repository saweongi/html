import pandas as pd
from konlpy.tag import Okt
from collections import Counter #단어가 몇개 나왔는지 해주는 라이브러리
#pip install konlpyt 한국어 자연어 처리 관련라이브러리
import pandas as pd
from ex_db.oracle.DBManager import DBManager
from wordcloud import WordCloud
#pip install wordcloude



okt = Okt()
test = "안녕하세요 저는 팽수 입니다. 만나서 방가 방가"
parser_date = okt.pos(test) #모든 명사 동사 머 이런거 다뽑을수있음
print(parser_date)
words = ['팽수', '동길', '팽수', '길수']
cnt_word = Counter(words) #단어의 개수를 세어줌
print(cnt_word)

mydb =DBManager()
param = input("워드클라우드를 보고싶은 종목코드: ")
sql = """SELECT * FROM tb_stock_bbs WHERE item_code =:1 """
df = pd.read_sql(con=mydb.conn, sql=sql, params=[param])
print(df.head())

nouns = []
for idx, row in df.iterrows():
    if row['BBS_CONTENTS']:
        nouns += okt.nouns(row['BBS_CONTENTS']) #nouns는 명사만 추출 할 수 있게 한거
print(nouns)

count= Counter(nouns)
print(count)

wc = WordCloud(background_color= 'white', width =400, height =400, scale =2.0, max_font_size=250, font_path='malgun')
gen = wc.generate_from_frequencies(count)
import matplotlib.pyplot as plt
plt.figure("토론방")
plt.imshow(gen)
plt.show()
