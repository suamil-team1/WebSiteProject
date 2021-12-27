<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String userId = "test" ;
String userPwd = "1234" ;
String userName = "국희" ;
String userMail = "1234@naver.com" ;

session.setAttribute("UserId", userId );
session.setAttribute("UserPwd", userPwd);
session.setAttribute("UserName", userName);
session.setAttribute("UserMail", userMail);
/*
ProjectBoardDTO dto = new ProjectBoardDTO();

dto.setId(userId);
dto.setPass(userPwd);
dto.setName(userName);
dto.setEmail(userMail);*/
%>