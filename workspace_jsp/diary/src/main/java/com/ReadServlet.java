package com;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/myfile")
public class ReadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String filename = request.getParameter("filename");
		String realpath = getServletContext().getRealPath("/myfile");
		File file = new File(realpath, filename);
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		
		writer.println("<html><body>");
		writer.println("<h1>다이어리 내용:</h1>");
		
		if(file.exists() && file.isFile()) {
			try(BufferedReader br = new BufferedReader(new FileReader(file))){
				String line;
				while((line = br.readLine()) !=null){
					writer.println(line + "<br>");
				}
			}
		}else {
			writer.println("해당 파일이 존재하지 않습니다.");
			
		}
		writer.println("<button onclick='history.back()'>뒤로가기</button>");
		writer.println("</body></html>");
		
				
	}

}
