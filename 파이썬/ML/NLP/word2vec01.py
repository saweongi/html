import requests
import re
import os
from gensim.models.word2vec import Word2Vec
res = requests.get('http://www.gutenberg.org/files/2591/2591-0.txt')
grimm = res.text[2801:530661]
grimm = re.sub(r'[^a-zA-Z\.]',' ', grimm) #텍스트만 뽑기위해서
sentence = grimm.split('. ')
data = [s.split() for s in sentence]
print(data)
embedding_model = Word2Vec(data, sg=1, # 0:CBOW, 1:skip -gram
                           vector_size=100,  #단어의 임베딩 차원(한개의 단어에 100개의 성분이있다 라고 생각하면될듯)
                           window =3,  #앞뒤 단어를 얼만큼
                           min_count=3,  # 출현 최소빈도
                           workers=4)  # 동시처리 작업수
embedding_model.save("book.model")
print(embedding_model)

while True:
    text1, text2 = input("비교 단어를 입력(end=q):").split()
    if text1 == 'q':
        break
    else:
        print("가까운 단어:", embedding_model.wv.most_similar(positive=[text1, text2]))
        print("먼 단어", embedding_model.wv.most_similar(negative=[text1,text2]))