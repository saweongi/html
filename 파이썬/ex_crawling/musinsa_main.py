from musinsa import fn_get_musinsa

all_arr = []
for i in range(1, 11):
    try:
        print(i, ':page 수집')
        all_arr += fn_get_musinsa(i)
    except Exception as e:
        print(str(e))
print(all_arr)
import csv
with open('musinsa.csv', 'w', encoding='utf-8') as f: #파일을 만들고 오픈한다.
    write =csv.writer(f, delimiter='|', quotechar='"') #delimiter |로 구분하게 했다.
    write.writerows(all_arr) # 배열에 갯수만큼 다넣겠다

