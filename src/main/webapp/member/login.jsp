<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<body>
	<!-- 
		request영역에 해당 속성이 있는지 확인하여 속성이 있다면
		에러메세지를 출력한다.
		해당 속성은 로그인 실패처리 시 request영역에 저장하게 된다
	 -->
	<span style="color: red; font-size: 1.2em;">
		<%=  request.getAttribute("LoginErrMsg") == null ?
				"" : request.getAttribute("LoginErrMsg") %>
	</span>
	<%
		//로그인 확인
		if (session.getAttribute("UserId") == null) {
			//만약 session영역에 저장된 속성이 없다면 로그인 이전의 상태이므로
			//로그인 폼을 화면에 출력한다.
	%>
<script>
	function validateForm(form) {
		if (!form.user_id.value) {
			alert("아이디를 입력하세요.");
			form.user_id.focus();
			return false;
		}
		if (!form.user_pw.value) {
			alert("패스워드를 입력하세요.");
			form.user_pw.focus();
			return false;	
		}
	}
</script>
	<!-- <center> -->
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/login_title.gif" alt="인사말" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;로그인<p>
				</div>
				<div class="login_box01">
					<form action="LoginProcess.jsp" method="post" name="LoginFrm"
						onsubmit="return validateForm(this);">
					<img src="../images/login_tit.gif" style="margin-bottom:30px;" />
					<ul>
						<li><img src="../images/login_tit001.gif" alt="아이디" style="margin-right:15px;" /><input type="text" name="user_id" value="" class="login_input01" /></li>
						<li><img src="../images/login_tit002.gif" alt="비밀번호" style="margin-right:15px;" /><input type="password" name="user_pw" value="" class="login_input01" /></li>
					</ul>
					<a href=""><input type="image" src="../images/login_btn.gif" class="login_btn01" /></a>
					</form>
					
					<%
						} else {
					%>
						
						
						
						<%= session.getAttribute("UserName") %> 회원님, 로그인하셨습니다. <br />
						<a href="Logout.jsp">[로그아웃]</a>
						
						
						
						
					<%
						}
					%>

				</div>
				<p style="text-align:center; margin-bottom:50px;"><a href=""><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>&nbsp;<a href=""><img src="../images/login_btn03.gif" alt="회원가입" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	<!-- </center> -->
 </body>
</html>
