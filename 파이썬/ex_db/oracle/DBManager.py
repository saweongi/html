import cx_Oracle

class DBManager:

    def __init__(self):
        self.conn = None
        self.get_connection()

    def get_connection(self):
        self.conn = cx_Oracle.connect("java","oracle","localhost:1521/xe")
        return self.conn

    def __del__(self):   #객체가 없어질때 호출됨
        try:
            print("소멸자")
            if self.conn:
                self.conn.close()
        except Exception as err:
            print("__del__",str(err))

    def insert(self,query,param):
        cursor = self.conn.cursor()
        cursor.execute(query, param)
        self.conn.commit()
        cursor.close()

if __name__ == '__main__': #지금 사용 하는 클래스에서만 동작 할 수 있게 해준다.
    maneger = DBManager()
    conn = maneger.get_connection()
    sql = """INSERT INTO TB_USER(user_id, user_pw, user_nm)
             VALUES (:1, :2, :3)
    """
    maneger.insert(sql, ['test','test','test'])
    print(conn.version)