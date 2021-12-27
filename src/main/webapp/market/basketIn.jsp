<%@page import="model.shopboard.shopboardDAO"%>
<%@page import="model.shopboard.shopboardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
shopboardDTO dto= new shopboardDTO();
shopboardDAO dao= new shopboardDAO(application);
int iResult = dao.insertBasket(dto);
dao.close();

 if(iResult ==1){
	out.println("장바구니에 상품을 넣었습니다.");
}else{
	out.println("장바구니 오류");
} 
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>