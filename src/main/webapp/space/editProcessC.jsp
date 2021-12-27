<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="./IsLoggedIn.jsp" %>--%>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

//수정페이지에서 전송한 폼값 받기
String idx = request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");
String pdate = request.getParameter("pdate");


//DTO객체에 입력값 추가하기
ProjectBoardDTO dto = new ProjectBoardDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);
dto.setBoardName(pdate);

//DB연결
projectboardDAO dao = new projectboardDAO(application);

int affected = dao.updateEdit(dto); //반환되는 1을 받는 변수

dao.close();

if(affected==1){//성공
	
	if(boardName.equals("cal")){
		response.sendRedirect("sub02_view.jsp?idx="+dto.getIdx()+"&boardName="+boardName);
	}	
}
else{//실패
	JSFunction.alertBack("수정하기에 실패했습니다", out);
}
%>
