<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String brdName = request.getParameter("boardName");

if(brdName == "not"){
	response.sendRedirect("../space/sub01.jsp?boardName=not");
}
if(brdName == "cal"){
	response.sendRedirect("../space/sub02.jsp");
}
if(brdName == "fre"){
	response.sendRedirect("../space/sub03.jsp");
}
if(brdName == "gal"){
	response.sendRedirect("../space/sub04.jsp");
}
if(brdName == "ref"){
	response.sendRedirect("../space/sub05.jsp");
}

%>