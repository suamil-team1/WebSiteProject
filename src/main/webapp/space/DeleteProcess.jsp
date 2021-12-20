<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
//폼값 받기
String idx= request.getParameter("idx");

//DTO객체와 DB연결 및 기존 게시물 가져오기
ProjectBoardDTO dto = new ProjectBoardDTO();
projectboardDAO dao = new projectboardDAO(application);
dto=dao.selectView(idx);

//세션영역에 저장된 아이디를 문자열로 반환
String sessionId=session.getAttribute("UserId").toString();

int delResult=0;

//현재 삭제하는 사람이 해당 글의 작성자가 맞는지 확인
if(sessionId.equals(dto.getId())){//작성자 본인이 맞으면...
	
	//DTO객체에 일련번호를 저장한 후 DAO로 매개변수 전달
	dto.setIdx(idx);
	delResult= dao.deletePost(dto);
	//연결 해제
	dao.close();
	
	if(delResult==1){
		//게시물 삭제에 성공하면 리스트로 이동한다.
		JSFunction.alertLocation("삭제되었습니다.", "sub03.jsp", out);
	}
	else{
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}
}
	else{// 작성자 본인이 아니면 삭제할 수 없음
		JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
		return;
	}

%>
