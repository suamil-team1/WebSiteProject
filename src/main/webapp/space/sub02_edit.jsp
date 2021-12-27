<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.calendarDTO"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- 글쓰기 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%
String boardName =request.getParameter("boardName");
System.out.println(boardName);

String idx = request.getParameter("idx");	//게시물의 일련 번호
calendarDAO dao = new calendarDAO(application);	//DB연결
calendarDTO dto = dao.selectView(idx);			//게시물 조회

//세션 영역에 저장된 회원 아이디를 얻어와서 문자열의 형태로 변환.
//String sessionId = session.getAttribute("UserId").toString();

//작성자 본인만 수정할 수 있는 if문
/*if(!sessionId.equals(dto.getId())){	
	JSFunction.alertBack("작성자 본인만 수정할 수 있습니다", out);
	return;
}*/
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
$( function() {
    $( "#pdate" ).datepicker();
    $( "#pdate" ).datepicker("option", "dateFormat", "yy-mm-dd");
  } );   
</script>
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

<form name="writeFrm" method="post" action="EditProcessC.jsp"
	onsubmit="return validateForm(this);">
<table class="table table-bordered">
<input type="hidden" name="idx" value="<%= idx %>" />
<input type="hidden" name="boardName" value="<%=boardName%>"/>
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
				style="width:100px;" value="<%= dto.getId()%>"/>
		</td>
	</tr>
	<!-- <tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<input type="text" class="form-control" 
				style="width:400px;" />
		</td>
	</tr> -->
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">날짜</th>
		<td>
			<input type="text" class="form-control" name="pdate" id="pdate"
				style="width:200px;" value="<%= dto.getPdate()%>"/>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td>
			<input type="text" name="title" class="form-control" 
				value="<%= dto.getTitle()%>" />
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td>
			<textarea rows="10" name="content" class="form-control"><%= dto.getContent()%></textarea>
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
	<!-- 각종 버튼 부분 -->
<div class="container mt-3">
	<button type="submit" class="btn btn-danger">전송하기</button>
	<button type="reset" class="btn">Reset</button>
	<button type="button" class="btn btn-warning" 
		onclick="location.href='sub02.jsp?boardName=<%=boardName%>';">리스트보기</button>
</div>
</div>
</form> 
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
