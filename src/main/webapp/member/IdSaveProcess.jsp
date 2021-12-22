<%@page import="member.ProjectMemberDTO"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="util.JSFunction"%>
<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//전송된 폼값을 받는다.
String user_id = request.getParameter("id");
String user_pw = request.getParameter("pass");

/* ProjectMemberDAO dao = new ProjectMemberDAO();
ProjectMemberDTO memberDTO = dao.getMemberDTO(user_id, user_pw); */
ProjectMemberDTO dto = new ProjectMemberDTO();
/*
checkbox의 경우 둘 이상의 값이라면 getParameterValues()를 통해 받아야 하지만
항목이 한개라면 getParameter()로 받을 수 있다.
*/
String save_check = request.getParameter("save_check");

//아이디, 패스워드가 일치하는 경우 로그인 성공 처리
if("test".equals(user_id) && "1234".equals(user_pw)){
	//로그인 성공시 아이디 저장 체크를 했다면...
	if(save_check != null && save_check.equals("Y")){
		//쿠키를 저장한다. 쿠키값은 로그인아이디, 유효기간은 1일로 설정한다.
		CookieManager.makeCookie(response, "loginId", user_id, 86400);
	}
	else{
		//로그인 성공하고, 아이디 저장 체크를 하지 않았다면 쿠키를 삭제한다.
		CookieManager.deleteCookie(response, "loginId");
	}
	
	JSFunction.alertLocation("로그인에 성공했습니다.", "/main/main.jsp", out);
}
%>