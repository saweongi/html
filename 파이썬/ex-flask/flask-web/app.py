import requests
import json
from flask import Flask, render_template, request

app = Flask(__name__)

@app.route("/") #요청하는 경로
def index():
    return "hello, world"
@app.route("/hello")
def hello():
    return render_template("hello.html", content = "Jack", age=20) #화면전환(그대신 파일에 templates안에 이 파일이 있어야함)
    #정적으로 데이터를 사용하려면 content에 텍스트를 넣으면 그 페이지에 사용가능(nm머 이런식으로 던짐(변수명은 상관없음))

@app.route("/coin", methods=['GET', 'POST'])
def coin():
    if request.method == 'POST':
        data = json.loads(request.get_data(),encoding='utf-8')
        print(data)
        res = requests.get("https://api.upbit.com/v1/ticker?markets="+data['market'])
        print(res)
        return res.content
    else:
        res = requests.get("https://api.upbit.com/v1/market/all")
        coin_list = json.loads(res.content)
        print(coin_list)
        return render_template('coin.html',coins=coin_list)
if __name__ == "__main__":
    app.run(debug=True) #서버기동