<%@page import="java.util.HashSet"%>
<%@page import="model.projectboard.calendarDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
request.getParameter("boardName");
//DAO 객체 생성 및 DB연결
projectboardDAO dao = new projectboardDAO(application);
//검색어가 있는 경우 파라미터를 저장하기 위한 Map컬렉션 생성
Map<String,Object> param =new HashMap<String,Object>();
//검색 파라미터를 request 내장객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//검색어가 있는 경우에만
if(searchWord !=null){
	//Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField", searchField);//검색필드명(title,content 등)
	param.put("searchWord", searchWord);//검색어
}
//board테이블에 저장된 게시물의 갯수 카운트
int totalCount = dao.selectCount(param);
//출력할 레코드 추출
List<ProjectBoardDTO> boardLists = dao.selectList(param);
//DB작업 끝났으므로 자원 해제
dao.close();

%>
%>
 <body>
 <div class="container-fluid">
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box" >
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>
				<form action="sub02_write.jsp">
				<input type="hidden" name="boardName" value="<%=boardName%>"/>
				<%@include file="../model1/calendar.jsp" %>
				<button type="submit">일정 등록</button>
				</form>
				</div>
			</div>		
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	<%@ include file="../include/footer.jsp" %>
	</center>
</div>
 </body>
</html>
