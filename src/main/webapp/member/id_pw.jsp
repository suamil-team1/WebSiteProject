<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<!-- <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.min.js"></script> -->
<script>
	
	function findId(){
	   	var frm = document.idFrm;
	   	if(frm.user_name.value==""){
    		alert("이름을 입력해주세요");
    		frm.user_name.focus();
    		return false;
    	}
		if(frm.user_email.value==""){
    		alert("이메일을 입력해주세요");
    		frm.user_email.focus();
    		return false;
    	}
   		frm.method = "post";
   		frm.action = "FindProcess.jsp"; 
   		frm.submit(); 
    }
	
	function findPw(){
		var frm = document.pwFrm;
		if(frm.user_id.value==""){
    		alert("아이디를 입력해주세요");
    		frm.user_id.focus();
    		return false;
    	}
		if(frm.user_name.value==""){
    		alert("이름을 입력해주세요");
    		frm.user_name.focus();
    		return false;
    	}
		if(frm.user_email.value==""){
    		alert("이메일을 입력해주세요");
    		frm.user_email.focus();
    		return false;
    	}
		
   		frm.method = "post";
   		frm.action = "FindProcess.jsp"; 
   		frm.submit(); 
    }
	
	
	
</script>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
					<form name="idFrm">
						<ul>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:findId();"><img src="../images/member/id_btn01.gif" class="id_btn" /></a>
						<a href="join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" value="id_btn" /></a>
					</form>
					</div>
					<div class="pw_box">
					<form name="pwFrm" method="post" action="SendProcess.jsp" >
						<ul>
							<li><input type="text" name="user_id" value="" class="login_input01" /></li>
							<li><input type="text" name="user_name" value="" class="login_input01" /></li>
							<li><input type="text" name="user_email" value="" class="login_input01" /></li>
						</ul>
						<a href="javascript:findPw();"><img src="../images/member/id_btn01.gif" class="pw_btn" /></a>
					</form>
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
