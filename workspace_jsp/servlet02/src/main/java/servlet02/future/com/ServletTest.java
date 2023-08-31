package servlet02.future.com;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
  //test web.xml에 servletText 서블릿을 호출하도록
  //web.xml을 수정해보세요
public class ServletTest extends HttpServlet {
	public void service(HttpServletRequest req, HttpServletResponse res) throws IOException {
		System.out.println("test 입니다.");
		
		req.setCharacterEncoding("utf-8"); // 요청받은 내용
       
        
        // response 응답
        res.setContentType("text/html; charset=utf-8");
        res.setCharacterEncoding("utf-8");

	}
} 