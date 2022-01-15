<%@page import="model.projectboard.calendarDTO"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 수정 처리 전 로그인 확인 -->
<%@ include file="../model1/IsLoggedIn.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

//수정페이지에서 전송한 폼값 받기
String idx = request.getParameter("idx");
String title = request.getParameter("title");
String content = request.getParameter("content");
String pdate = request.getParameter("pdate");


//DTO객체에 입력값 추가하기
calendarDTO dto = new calendarDTO();
dto.setIdx(idx);
dto.setTitle(title);
dto.setContent(content);
dto.setBoardName(pdate);

//DB연결
calendarDAO dao = new calendarDAO(application);

int affected = dao.updateEdit(dto); //반환되는 1을 받는 변수

dao.close();

if(affected==1){//성공
	
	if(boardName.equals("cal")){
		response.sendRedirect("calendar_view.jsp?idx="+dto.getIdx()+"&boardName="+boardName);
	}	
}
else{//실패
	JSFunction.alertBack("수정하기에 실패했습니다", out);
}
%>
