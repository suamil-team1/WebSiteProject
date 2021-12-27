<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);
//폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");

//사용자가 입력한 폼값을 저장하기 위해 DTO객체 생성
ProjectBoardDTO dto = new ProjectBoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setBoardName(boardName);

//session에 있는 아이디를 가져와 dto에 저장
dto.setId(session.getAttribute("UserId").toString());

//DAO객체생성, DB연결
projectboardDAO dao = new projectboardDAO(application);

//insert 글쓰기 처리 메서드
int iResult = dao.insertWrite(dto);
dao.close();

if(iResult == 1){ //글쓰기 성공 > 목록으로 가기
	
	/* switch(boardName){
	case "cal" : 
		response.sendRedirect("sub02.jsp?boardName=cal"); return;
	case "fre" :
		response.sendRedirect("sub03.jsp?boardName=fre"); return;
	} */
	response.sendRedirect("sub03.jsp?boardName="+boardName);
}
else{ //실패 뒤로가기
	JSFunction.alertBack("글쓰기에 실패했습니다", out);
}
%>
