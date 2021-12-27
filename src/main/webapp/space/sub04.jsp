<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName); 

//DAO객체 생성
projectboardDAO dao = new projectboardDAO();
//목록 가져오기
Map<String,Object> param =new HashMap<String,Object>();
//출력할 레코드 추출
List<ProjectBoardDTO> boardLists = dao.selectList(param, boardName);

dao.close();
%>
 <body>
 <div class="container-fluid">
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub04_title.gif" alt="사진게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판<p>
				</div>
				<div class="row">
				<form id="galFrm">
				<div class="row text-center mt-3">
				
	<%
	for(ProjectBoardDTO b:boardLists){
	%>
		<div class="card col-md-4">
				<a href="sub04_view.jsp?idx=<%= b.getIdx()%>&boardName=<%=boardName%>">
		        <img class="card-img-top" src="../Uploads/<%=b.getSfile() %>" style="width: 200px; height: 270px;">
		        </a>
	        <div class="card-body">
	        <h4 class="card-title" style="text-align: end;">
		        <a href="sub04_view.jsp?idx=<%= b.getIdx()%>&boardName=<%=boardName%>">
		        <%=b.getTitle() %>
		        </a>
	        </h4>         
	    	</div>
    	</div>
	<%} %>
    	</div>
				<div class="container mt-3">	
				<button type ="button" class="btn btn-outline-dark"  
					onclick="location.href='sub04_write.jsp?boardName=<%=boardName%>';">사진등록</button>
				</div>
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
