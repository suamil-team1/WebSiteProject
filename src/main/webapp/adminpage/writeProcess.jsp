<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리(insert)전 로그인 확인 -->
<%@ include file="../model1/IsLoggedIn.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

//폼값 받기
String title=request.getParameter("title");
String content=request.getParameter("content");

//사용자가 입력한 폼값을 저장하기 위해 DTO객체 생성
ProjectBoardDTO dto= new ProjectBoardDTO();
dto.setTitle(title);
dto.setContent(content);
dto.setBoardName(boardName);

//세션영역에 저장된 회원 인증정보(아이디)를 가져와서 DTO에 저장한다.
dto.setId(session.getAttribute("UserId").toString());

//DAO객체 생성 및 DB연결
projectboardDAO dao= new projectboardDAO(application);
//dto객체를 매개변수로 전달하여 레코드 insert 처리
int iResult = dao.insertWrite(dto);
//자원 해제
dao.close();

if(iResult ==1){
	//글쓰기에 성공했다면 리스트(목록)페이지로 이동한다.
	response.sendRedirect("board_list03.jsp?boardName="+boardName);
}else{
	//실패한 경우에는 글쓰기 페이지로 이동한다. 즉 뒤로 이동한다.
	JSFunction.alertBack("글쓰기에 실패하였습니다.", out);
}

%>
