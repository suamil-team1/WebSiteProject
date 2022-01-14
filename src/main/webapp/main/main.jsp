<%@page import="java.util.Calendar"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="util.JSFunction"%>
<%@page import="util.CookieManager"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<style type="text/css" media="screen">
@import url("../css/common.css");
@import url("../css/main.css");
@import url("../css/sub.css");
.main_board_list li{overflow:hidden; text-overflow:ellipsis; white-space: nowrap; width:150px; padding-right: 145px;}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
</head> 
<script>
function validateForm(form) {
	if(!form.id.value){
		alert("아이디를 입력하세요");
		form.id.focus();
		return false;
	}  
	if(!form.pass.value){
		alert("비밀번호를 입력하세요");
		form.pass.focus();
		return false;
	}
} 
  
<%
//아이디 저장 
ProjectMemberDAO dao = new ProjectMemberDAO(application);

dao.close();
//쿠키값 읽어오기
String loginId = CookieManager.readCookie(request, "loginId");

String cookieCheck="";
if(!loginId.equals("")){
	cookieCheck = "checked";
}

//각 게시판에 따른 글 가져오기
projectboardDAO boardDao = new projectboardDAO(application);
String boardName = request.getParameter("boardName");
Map<String,Object> param =new HashMap<String,Object>();
List<ProjectBoardDTO> notBoardLists = boardDao.selectList(param, "not");
List<ProjectBoardDTO> freBoardLists = boardDao.selectList(param, "fre");
List<ProjectBoardDTO> galBoardLists = boardDao.selectList(param, "gal");

boardDao.close();
%>
</script>

<!-- 캘린더 -->
<script>
$(function(){
	$('#calendar_view').load('../space/sub02_main_calendar.jsp');
	
	$('#prev_month').click(function(){
		var user_year = parseInt($('#now_year').val());
		var user_month = parseInt($('#now_month').val());
		
		
		if(user_month == 0){
			user_year--;
			user_month = 11;
		}
		else{
			user_month--;
		}
		
		$('#now_year').val(user_year);
		$('#now_month').val(user_month);
		
		$('#calendar_date').html(user_year+"년 "+ (user_month+1)+'월');
		
		$.get('../space/sub02_main_calendar.jsp',
			{
				y : user_year,
				m : user_month
			},
			function(d) {
				$('#calendar_view').html(d);
			}
		);
	});
	
	$('#next_month').click(function(){
		var user_year = parseInt($('#now_year').val());
		var user_month = parseInt($('#now_month').val());
		
		
		if(user_month ==11){
			user_year++;
			user_month = 0;
		}
		else{
			user_month++;
		}
		
		$('#now_year').val(user_year);
		$('#now_month').val(user_month);
		
		$('#calendar_date').html(user_year+"년 "+ (user_month+1)+'월');
		
		$.get('../space/sub02_main_calendar.jsp',
			{
				y : user_year,
				m : user_month
			},
			function(d) {
				$('#calendar_view').html(d);
			}
		);
	});
});

</script>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>
		<div class="main_contents">
		
			<form name = "mainLoginFrm" action="../member/login.do" method="post" onsubmit="return validateForm(this)">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><a href="../member/LoginProcess.jsp"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></a></p>
				<div class="login_box">
					<!-- 로그인 전 -->
					<%
					if(request.getAttribute("LoginErrMsg")!=null){
						JSFunction.alertBack("아이디 혹은 비밀번호가 일치하지 않습니다.", out);
					}  
					
					if (session.getAttribute("UserId") == null){
					%>
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" name="id" value="<%= loginId%>" class="login_input" tabindex="1"/></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" tabindex="4"/></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="password" name="pass" value="" class="login_input" tabindex="2"/></td>
						</tr>
						
					</table>
					
					<p>
						<input type="checkbox" name="saveId" value="Y"<%= cookieCheck %> tabindex="3" /><img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					<!-- 로그인 후 -->
					<%
					    } else if(session.getAttribute("UserType").equals("0")){
					%>
					</form> <!-- 이거 안넣으면 관리자모드 안넘어가요오오 -예지- -->
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><%= session.getAttribute("UserName") %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<button onclick="location.href='../adminpage/index.jsp';" style="width:70px;font-size:1px;height:20px; background-color:white; border:solid lightgray 1px;">관리자모드</button>
						<a href="../member/modify.jsp"><img src="../images/login_btn04.gif" /></a>
						<a href="../member/logout.jsp"><img src="../images/login_btn05.gif" /></a>
					</p>
					<%
					    } else {
					%>
					</form>
					<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;"><%= session.getAttribute("UserName") %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
					<p style="text-align:right; padding-right:10px;">
						<a href="../member/modify.jsp"><img src="../images/login_btn04.gif" /></a>
						<a href="../member/logout.jsp"><img src="../images/login_btn05.gif" /></a>
					</p>
					<%
					}
					%>
				</div>
			</div>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="../space/sub01.jsp?boardName=not"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
				<%
					if(notBoardLists.isEmpty()){
					%>
						<tr>
							<td colspan="6" align="center">
								등록된 게시물이 없습니다.
							</td>
						</tr>
					<%
					}
					else{
						//게시물이 있을때
						for(ProjectBoardDTO dto:notBoardLists) //반복
						{
							//전체 레코드 수를 1씩 차감하면서 번호를 출력
					%>
						<tbody>
						<!-- 리스트반복 -->
							<li class="text-left" ><a href="../space/sub01_view.jsp?idx=<%=dto.getIdx()%>&boardName=not" ><%= dto.getTitle()  %></a><span class="text-center"><%=dto.getPostdate()%></span></li>
							<!-- style="display:block; width:150px; overflow:hidden; text-overflow:ellipsis; padding-right: 146px;" -->
						</tbody>
					<%
						}
					}
					%>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="../space/sub03.jsp?boardName=fre"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<%
					if(freBoardLists.isEmpty()){
					%>
						<tr>
							<td colspan="6" align="center">
								등록된 게시물이 없습니다.
							</td>
						</tr>
					<%
					}
					else{
						//게시물이 있을때
						for(ProjectBoardDTO dto:freBoardLists) //반복
						{
							//전체 레코드 수를 1씩 차감하면서 번호를 출력
					%>
						<tbody>
						<!-- 리스트반복 -->
							<li class="text-left"><a href="../space/sub03_view.jsp?idx=<%=dto.getIdx()%>&boardName=fre"><%= dto.getTitle() %></a><span class="text-center"><%=dto.getPostdate()%></span></li>
							
						</tbody>
					<%
						}
					}
					%>
				</ul>
			</div>
		</div>
		
		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<%
					Calendar nowDay = Calendar.getInstance();
					int now_year = nowDay.get(Calendar.YEAR);
					int now_month = nowDay.get(Calendar.MONTH);
					%>
					<input type="hidden" id="now_year" value="<%=now_year %>" />
					<input type="hidden" id="now_month" value="<%=now_month %>" />	
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<td><img src="../images/cal_a01.gif" style="margin-top:3px; cursor:pointer;" id="prev_month"/></td>
							<td style="font-weight:bold;font-size:14px;" id="calendar_date">
								<%=now_year %>년 
								<%=(now_month+1) %>월
							</td>
							<td><img src="../images/cal_a02.gif" style="margin-top:3px; cursor:pointer;" id="next_month"/></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom" id="calendar_view">
				<!-- ajax결과를 여기에 디스플레이 -->
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="../space/sub04.jsp?boardName=gal"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
				<%
				if(galBoardLists.isEmpty()){
				%>
					<li>
						<dl>
							<dd style="width: 150px" >등록된 게시물이 없습니다.</dd>
						</dl>
					</li>
					
					<%
					}
					else{
						//게시물이 있을때
						for(ProjectBoardDTO dto:galBoardLists) //반복
						{
							//전체 레코드 수를 1씩 차감하면서 번호를 출력
					%>
						<!-- 리스트반복 -->
							<li>
								<dl>
									<dt><a href="../space/sub04_view.jsp?idx=<%= dto.getIdx() %>&boardName=gal">
									<img src="../Uploads/<%=dto.getSfile() %>" alt="" width=95 height=63></a></dt>
									<dd style="padding:0 2px; overflow:hidden;text-overflow:ellipsis; white-space:nowrap;">
									<a href=""><%=dto.getTitle() %></a></dd>
								</dl>
							</li>
					<%
						}
					}
					%>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>