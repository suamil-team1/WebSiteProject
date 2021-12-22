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
	<jsp:useBean id="dto" class="member.ProjectMemberDTO" />
	<jsp:setProperty property="*" name="dto"/>
	
	<%
		String userId = session.getAttribute("UserId").toString();
		dto.setId(userId);
		
		ProjectMemberDAO dao = new ProjectMemberDAO(application);
		dao.updateMemberInfo(dto);
	%>
<script>
	JSFunction.alertLocation("["+dto.getName()+"] 님의 회원정보가 수정되었습니다.", "../main/main.jsp", out);
</script>
	
	
</body>
</html>