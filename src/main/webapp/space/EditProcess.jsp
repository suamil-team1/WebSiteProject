<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
//수정페이지에서 전송한 폼값받기
String idx= request.getParameter("idx");
String title= request.getParameter("title");
String content= request.getParameter("content");
//DTO객체에 입력값 추가하기
ProjectBoardDTO dto = new ProjectBoardDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);

//DB연결
projectboardDAO dao = new projectboardDAO(application);
int affected = dao.updateEdit(dto);
//수정 성공시 1을 반환함
//자원해제
dao.close();

if(affected==1){
	//수정 성공하면 수정된  내용을 확인하기 위해 상세보기 페이지로 이동함
	response.sendRedirect("sub03_view.jsp?idx="+dto.getIdx());
}
else{
	//실패한 경우에는 뒤로 이동
	JSFunction.alertBack("수정하기에 실패하였습니다.", out);
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