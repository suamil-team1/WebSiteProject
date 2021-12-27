<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
	session영역에 저장된 인증관련 속성값이 있는지 확인하여 
	만약 없다면 로그인 페이지로 자동이동한다.
*/
String type = (String)session.getAttribute("UserType");
if(!(type.equals("0"))){
	//자바스크립트를 사용하기 위한 유틸리티 클래스를 이용하여 경고창과 페이지이동을 처리함.
	JSFunction.alertLocation("관리자아이디로 로그인하세요. ", "login.jsp", out);
	
	return;
}
%>
