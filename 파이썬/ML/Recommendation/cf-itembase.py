#아이템 기준으로
import pandas as pd
from sklearn.metrics.pairwise import cosine_similarity #코사인 유사도사용 할려고
df_ratings = pd.read_csv("ratings.csv")
df_movies =pd.read_csv("movies.csv")
print(df_movies.info())
print(df_ratings.info())
df_ratings.drop('timestamp', axis =1, inplace=True) #날짜가 필요없어서 날림
print(df_ratings.head())
user_item_rating = pd.merge(df_ratings, df_movies, on="movieId") # movieId 를 기준으로 합친다
print(user_item_rating.head())
movie_matrix = user_item_rating.pivot_table("rating", index="title", columns="userId")#피벗으로 테이블 만드는데 행은 제목으로 열은 유저 아이디로 하고 값은 rating로준다
print(movie_matrix.head())

# 널값 0으로 바꿔주기
movie_matrix.fillna(0, inplace=True)

# 유사도 비교
item_cf = cosine_similarity(movie_matrix)
print(item_cf)
result_df = pd.DataFrame(data=item_cf, index=movie_matrix.index, columns=movie_matrix.index) #유사도 비교랑똑같은데 행이름이랑 열 이름을 바꿔줌
print(result_df)

def get_item_based(title):

    # asc 오름 False -> desc 라고 생각하면됨
    return result_df[title].sort_values(ascending=False)[:10]

while True:
    text = input("좋아하는 영화 이름을 정확하게 입력하세요:")
    print(get_item_based(text))