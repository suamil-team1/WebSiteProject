<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 글쓰기 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

String idx = request.getParameter("idx");	//게시물의 일련 번호
projectboardDAO dao = new projectboardDAO(application);	//DB연결
ProjectBoardDTO dto = dao.selectView(idx);			//게시물 조회

//세션 영역에 저장된 회원 아이디를 얻어와서 문자열의 형태로 변환.
String sessionId = session.getAttribute("UserId").toString();

//작성자 본인만 수정할 수 있는 if문
if(!sessionId.equals(dto.getId())){	
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다", out);
	return;
}
dao.close();
%>
<script>
function validateForm(form) {
	if(form.title.value==""){
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if(form.content.value==""){
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
}
</script>
 <body>
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
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
				</div>
				<div>
<form name="writeFrm" method="post" action="editProcess.jsp"
	onsubmit="return validateForm(this);">
<!-- 게시물의 index값 전송 -->
<input type="hidden" name="idx" value="<%= idx %>" />
<input type="hidden" name="boardName" value="<%=boardName %>" />
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		
		<td>
			<input type="text" class="form-control" 
				style="width:100px;" value="<%= session.getAttribute("UserId")%>"/>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" 
				style="width:400px;" value="<%= session.getAttribute("UserMail")%>"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">패스워드</th>
		<td>
			<input type="text" class="form-control" 
				style="width:200px;" value="<%= session.getAttribute("UserPwd")%>"/>
		</td>
	</tr> -->
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" name="title" class="form-control"
				value="<%= dto.getTitle() %>"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content" 
			class="form-control"><%= dto.getContent().replace("\r\n", "<br/>") %></textarea>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td>
			<input type="file" class="form-control" />
		</td>
	</tr> -->
</tbody>
</table>
<div class="row text-center" style="">
<div class="container mt-3">
	<button type="submit" class="btn btn-danger">수정하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='sub03.jsp?boardName=<%=boardName%>';">리스트보기</button>
</div>
</div>
</form>
				</div>
			</div>
		</div>
	
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
