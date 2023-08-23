package ch14_jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class JdbcSelect {
	public static void main(String[] args) {
		
		//db와 연결
		Connection connection = null;
		
		//SQL명령
		PreparedStatement ps = null;
		
		//쿼리실행 결과
		ResultSet rs = null;
		
		// 1. 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("드라이버 등록 성공");
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			System.out.println("등록 실패");
			System.out.println(0); // 프로그램 종료
			
		}
		String url = "jdbc:oracle:thin:@127.0.0.1:1521:xe"; //ip
		String db_id ="java";
		String db_pw = "oracle";
		try {
		connection = DriverManager.getConnection(url, db_id, db_pw);
		System.out.println("커넥션 성공");
		StringBuffer query = new StringBuffer();
		query.append(" SELECT user_id");
		query.append("		, user_nm");
		query.append("		, user_mail");
		query.append("		, user_mileage");
		query.append(" FROM tb_user");
		ps = connection.prepareStatement(query.toString()); //문자열이 멸령문으로 담긴다
		rs = ps.executeQuery(); // 쿼리문실행
		while (rs.next()) {
			//System.out.println(rs.getString("user_nm")); 이름 하나 했을때 실행 rs는 휘발성 한번사용하면 사라진다고 생각해라
			String userId = rs.getString("user_id");
			String userNm = rs.getString("user_nm");
			int userMileage = rs.getInt("user_mileage");
			System.out.println("아이디:" +userId + ","+"이름:" +userNm + ",마일리지:" +userMileage);
			
		}
		
	}catch (SQLException e) {
		e.printStackTrace();
		System.out.println("커넥션 오류 계정정보를 확인하세요.");
		
	}finally {  //접속 종료
		
		//connection객체를 꼭 닫아야함
		//안닫으면 계속 쌓여서 오류발생
		if(rs != null) {
			try {
			rs.close();     
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		if(ps != null) {
				try {
					ps.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		
		}
		if(connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
}
}
