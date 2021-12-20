<%@page import="util.JSFunction"%>
<%@page import="member.ProjectMemberDTO"%>
<%@page import="member.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%

	String name = request.getParameter("user_name1");
	String email = request.getParameter("user_email1");
	
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL= application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	ProjectMemberDTO projectMemberDTO = null;
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	projectMemberDTO = dao.getProMemberInfo("", name, email);
	
	if(projectMemberDTO.getId() == null){	
		JSFunction.alertBack("일치하는 아이디가 없습니다.", out);
		return;
	} 
	dao.close();
	JSFunction.alertLocation("아이디는 [" + projectMemberDTO.getId() + "] 입니다.", "login.jsp", out);
%>

