package com;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileFilter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/write")
public class DiaryServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");  //한글 안깨지게하는거 
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		System.out.println(title);
		System.out.println(content);
		
		LocalDateTime nowDateTime = LocalDateTime.now();
		DateTimeFormatter formatter = 
				DateTimeFormatter.ofPattern("yyyMMddHHmm"); //분가지
		String nowstr = nowDateTime.format(formatter);
		System.out.println(nowstr);
		
		//최초 요청시 폴더가 없으면 생성
		String dir = "/myfile";
		
		//
		String realPath = getServletContext().getRealPath(dir);
		File file = new File(realPath);
		if(!file.exists()) {  //해당경로가 있냐 없냐
			file.mkdir(); //폴더생성
			
		}
		File textFile = new File(realPath, nowstr + ".txt");
		try(PrintWriter out = new PrintWriter(new BufferedWriter(new FileWriter(textFile))) )
		{ out.println("제목: "+ title );
		  out.println("내용: ");
		  out.println(content);
		  
		}
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter writer = response.getWriter();
		writer.println("<html><body>다이어리가 성공적으로 저장됨.<br>");
		File[] listFiles = file.listFiles();
		writer.println("<h1> 저장된 다이어리 목록:</h1>");
		for(File f: listFiles) {
			if(f.isFile()) {
				String filePath = f.getName();
				writer.println("<a href='myfile?filename="+ filePath+"'>" + f.getName() + "</a><br>");
			}
		}
		writer.println("</body></html>");
	}

}
