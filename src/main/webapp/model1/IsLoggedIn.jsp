<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//로그인 중인지 확인
//세션에 저장된 UserId 확인하기
if(session.getAttribute("UserId")==null)
{
	JSFunction.alertLocation
		("로그인 후 이용해주세요", "../member/login.jsp", out);

	return;
}
%>
