<%@page import="model.UserVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="service.UserService" %>    
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userVO" class="model.UserVO" scope="page"></jsp:useBean>
<jsp:setProperty property="userId" name="userVO"/>
<jsp:setProperty property="userPw" name="userVO"/>
<jsp:setProperty property="userNm" name="userVO"/>

<% 
String userId = request.getParameter("userId");
String userPw = request.getParameter("userPw"); 
String userNm = request.getParameter("userNm"); 
System.out.println(userNm);
System.out.println(userVO);


%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinAction</title>
</head>
<body>
	
	
	
</body>
</html>