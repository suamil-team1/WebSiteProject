<%@page import="util.JSFunction"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="member.ProjectMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String find = request.getParameter("find");

	String id = request.getParameter("user_id");
	String name = request.getParameter("user_name");
	String email = request.getParameter("user_email");
	
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	ProjectMemberDTO projectMemberDTO = null;
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	
	
	
	
	if(id == null) {
	//if(find.equals("id_btn")) { //아이디 찾기	
		projectMemberDTO = dao.getProMemberInfo("", name, email);
		if(projectMemberDTO.getId()==null){
			JSFunction.alertBack("귀하의 정보가 없습니다.", out);
			return;
		}
		dao.close();
		JSFunction.alertLocation("귀하의 아이디는 "+ projectMemberDTO.getId() +" 입니다", "login.jsp", out);
		
	}
	else {
	//else if(find.equals("pw_btn")) { //비번 찾기	
		projectMemberDTO = dao.getProMemberInfo(id, name, email);
		if(projectMemberDTO.getPass()==null){
			JSFunction.alertBack("귀하의 정보가 없습니다.", out);
			return;
		}
		dao.close();
		JSFunction.alertLocation("귀하의 비밀번호는 "+ projectMemberDTO.getPass() +" 입니다", "login.jsp", out);
}
%>