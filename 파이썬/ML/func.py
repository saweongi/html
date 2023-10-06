# python 익명함수 -> 정의와 동시에 사용

result = (lambda x: x+1)(3)  #: 앞에 입력  ,:뒤는 식 ,3은 입력값
print(result)

#객체에 담아 사용
func01 = lambda x, y : x * y + 1
print(func01(4,2))

#제곱시키기
arr = [1, 2, 3, 4, 5]
res = list(map(lambda x: x**2, arr)) #map은 각데이터 함수를 대응시켜 그 값을 반환하는 역할 -->arr이 리스트라서 각각 대응시키기위해 map을 사용
print('res : ', res)
