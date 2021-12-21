<%@page import="util.JSFunction"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="member.ProjectMemberDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String userId = (String)session.getAttribute("UserId");
	
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	ProjectMemberDTO dto = dao.getProMemberInfo(userId, "", "");
	
	
	dao.close();

	//int iResult = dao.insertMember(dto);
	
	/* if(iResult == 1){
		//JSFunction.alertLocation("["+dto.getName()+"] 님의 회원정보가 수정되었습니다.", "../main/main.jsp", out);
		
	}
	else{
		JSFunction.alertBack("회원정보 수정에 실패하였습니다.", out);
	} */
%>
