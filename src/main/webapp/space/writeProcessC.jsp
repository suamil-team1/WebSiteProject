<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="model.projectboard.calendarDTO"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리 전 로그인 확인 -->
<%@ include file="../model1/IsLoggedIn.jsp" %>
<%
String boardName = request.getParameter("boardName");
//폼값 받기
String title = request.getParameter("title");
String content = request.getParameter("content");
String pdate = request.getParameter("pdate");

/* String[] arrDate = date.split("/"); 
String sdate = arrDate[2] +"-"+ arrDate[0] +"-"+ arrDate[1];
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
try {
	Date pdate = format.parse(sdate);
} catch (Exception e) {
	e.printStackTrace();
} */


//사용자가 입력한 폼값을 저장하기 위해 DTO객체 생성
calendarDTO dto = new calendarDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setPdate(pdate);
dto.setBoardName(boardName);

//session에 있는 아이디를 가져와 dto에 저장
dto.setId(session.getAttribute("UserId").toString());

//DAO객체생성, DB연결
calendarDAO dao = new calendarDAO(application);

//insert 글쓰기 처리 메서드
int iResult = dao.insertWrite(dto);
dao.close();

if(iResult == 1){ //글쓰기 성공 > 목록으로 가기
	
	response.sendRedirect("sub02.jsp?boardName=cal");

}
else{ //실패 뒤로가기
	JSFunction.alertBack("글쓰기에 실패했습니다", out);
}
%>
