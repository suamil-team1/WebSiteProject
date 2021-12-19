<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<%
	session.removeAttribute("UserId");
	session.removeAttribute("UserName");
	
	session.invalidate();
	
	response.sendRedirect("LoginMain.jsp");
%>
<body>

</body>
</html>