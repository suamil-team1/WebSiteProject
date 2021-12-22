<%@page import="member.ProjectMemberDTO"%>
<%@page import="util.JSFunction"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
</head>
<body>
<%
	String id		= request.getParameter("id");
	String pass = request.getParameter("pass");
	String name		= request.getParameter("name");
	String email1	= request.getParameter("email_1");
	String email2	= request.getParameter("email_2");
	String email = (email1 +"@"+ email2);

	String tellnum1 	= request.getParameter("tel1");
	String tellnum2 	= request.getParameter("tel2");
	String tellnum3 	= request.getParameter("tel3");
	String tellnum = "";
	if ( (tellnum1 != null && !tellnum1.equals(""))
			|| (tellnum2 != null && !tellnum2.equals(""))
			|| (tellnum3 != null && !tellnum3.equals(""))) {
		tellnum 		= (tellnum1 +"-"+ tellnum2 +"-"+ tellnum3);
	}
	String mobile1		= request.getParameter("mobile1");
	String mobile2		= request.getParameter("mobile2");
	String mobile3		= request.getParameter("mobile3");
	String mobile		= (mobile1 +"-" + mobile2 +"-" + mobile3);

	String zipcode		= request.getParameter("zip1");
	String address1		= request.getParameter("addr1");
	String address2		= request.getParameter("addr2");
	String address		= (zipcode +","+ address1 +","+ address2);

	ProjectMemberDAO dao = new ProjectMemberDAO(application);

	String userId = session.getAttribute("UserId").toString();
	ProjectMemberDTO dto = dao.getProMemberInfo(userId, "", "");
	
	dto.setId(id);
	dto.setPass(pass);
	dto.setName(name);
	dto.setEmail(email);
	dto.setTellNum(tellnum);
	dto.setMobile(mobile);
	dto.setAddress(address);
	
	dao.updateMemberInfo(dto);
	
	int result = dao.updateMemberInfo(dto);
	
	
	JSFunction.alertLocation("["+dto.getName()+"] 님의 회원정보가 수정되었습니다.", "../main/main.jsp", out);
%>
	
</body>
</html>