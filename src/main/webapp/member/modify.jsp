<%@page import="member.ProjectMemberDTO"%>
<%@page import="member.ProjectMemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
	String userId = session.getAttribute("UserId").toString();
	
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);
	ProjectMemberDTO dto = dao.getProMemberInfo(userId, "", "");
	
%>
<script>
function validateForm(form){
	
	if(!form.name.value){
        alert('이름을 입력하세요');
        form.name.focus();
        return false;
    }
	
	if(form.id.value==''){
		alert('아이디를 입력해주세요'); 
		form.id.focus(); 
		return false; 
	}
	
	if( !(form.id.value.length >=4 && form.id.value.length <=12)){ 
	    alert("4자 이상 12자 이내의 값만 입력하세요");
	    form.id.value = '';
	    form.id.focus(); 
	    return false;
	}
	
	//숫자랑 영문 이외에는 모든 값을 입력할 수 없음
	var whatType = form.id.value
	for(var i=0; i<whatType.length; i++){
	    if(!((whatType[i]>='a' && whatType[i]<='z') ||
	            (whatType[i]>='A' && whatType[i]<='Z') ||
	            (whatType[i]>='0' && whatType[i]<='9'))){
	        alert("아이디는 숫자랑 영문자만 입력가능합니다");
	        form.id.value = '';
	        form.id.focus(); 
	        return false;
	    }
	}
	
	if(!form.pass.value || !form.pass2.value){
	    alert('패스워드를 입력하세요');
	    return false;
	}
	
	if(form.pass.value != form.pass2.value){
	    alert('입력한 패스워드가 일치하지 않습니다.');
	    form.pass.value=""; 
	    form.pass2.value="";
	    form.pass.focus();
	    return false;
	}
	

	if(form.mobile1.value =="" && form.mobile2.value=="" && form.mobile3.value==""){
	    alert("핸드폰번호를 입력하세요");
	    form.mobile1.focus();
	    return false;
	}
	
	if(form.email_1.value==""){
	    alert("이메일을 입력하세요");
	    form.email_1.focus();
	    return false;
	}
	
	if(form.last_email_check2.value==""){
	    alert("도메인을 선택하세요");
	    form.last_email_check2.focus();
	    return false;
	}
	
	if(form.zip1.value=="" || form.addr1.value=="" || form.addr2.value==""){
	    alert("주소를 입력하세요");
	    return false;
	}
	
	/* if(form.idDuplication.value != "idCheck"){
		alert("아이디 중복체크를 해주세요.");
		return false;
	} */
}

function focusMove(thisObj, naxtName, inputLen){
    var strLen = thisObj.value.length;
    if(strLen >= inputLen){
        eval('document.join02Frm.'+naxtName).focus();
    }
}


function email_input(form){
    var domain = form.last_email_check2.value;
    if(domain==''){ //'선택해주세요'부분을 선택했을때
    	form.email_1.value='';
    	form.email_2.value='';
    }
    else if(domain =="1"){ //'직접입력'을 선택했을때
    	form.email_2.readOnly = false; 
    	form.email_2.value='';
    	form.email_2.focus();
    }
    else{ //도메인을 선택했을때
    	form.email_2.value = domain; 
    	form.email_2.readOnly = true;
    }
}

function id_check_person(form){
	if(form.id.value==""){
        alert("아이디를 입력후 중복확인을 누르삼");
        form.id.focus();
    }
    else{
    	form.id.readOnly = true; //검증이 끝난후 수정을 할 수 없게하고 팝업창에서는 수정할 수 있도록 readOnly사용 
        window.open("id_check.jsp?id=" + form.id.value, "idover", "width=300, height=200");
    }
}

/* function inputIdChk(){
	document.userInfo.idDuplication.value ="idUncheck";
}

 */

</script>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
function zipFind(){
    new daum.Postcode({
        oncomplete: function(data) {
            var form = document.join02Frm;
            form.zip1.value =  data.zonecode; //12345(우편번호)
            form.addr1.value = data.address; //기본주소
            form.addr2.focus();
        }
    }).open();
}

</script>

 <body>
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
					<!-- <img src="../images/join_tit.gif" alt="회원가입" class="con_title" /> -->
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원정보입력<p>
				</div>
				
				<form name = "join02Frm" action="ModifyProcess.jsp" method="post" onsubmit="return validateForm(this)">
				
				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="<%= dto.getName() %>" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td>
							<input type="text" name="id"  value="<%= dto.getId() %>" class="join_input" onkeydown="inputIdChk()" readOnly />&nbsp;
							<!-- <a style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인" /></a>&nbsp;&nbsp; -->
							<!-- <input type="hidden" name="idDuplication" value="idUncheck" > -->
							<span>* 아이디는 수정할 수 없습니다.</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="pass" value="<%= dto.getPass() %>" class="join_input" />&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="<%= dto.getPass() %>" class="join_input" /></td>
					</tr>
					
					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" />&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" />
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'mobile2', 3);"/>&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'mobile3', 4);"/>&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" onkeyup="focusMove(this, 'email_1', 4);"/></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
							<input type="text" name="email_1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" /> @ 
							<input type="text" name="email_2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" readonly />
							<select name="last_email_check2" onchange="email_input(this.form);" class="pass" id="last_email_check2" >
								<option selected="" value="">선택해주세요</option>
								<option value="1" >직접입력</option>
								<option value="dreamwiz.com" >dreamwiz.com</option>
								<option value="empal.com" >empal.com</option>
								<option value="empas.com" >empas.com</option>
								<option value="freechal.com" >freechal.com</option>
								<option value="hanafos.com" >hanafos.com</option>
								<option value="hanmail.net" >hanmail.net</option>
								<option value="hotmail.com" >hotmail.com</option>
								<option value="intizen.com" >intizen.com</option>
								<option value="korea.com" >korea.com</option>
								<option value="kornet.net" >kornet.net</option>
								<option value="msn.co.kr" >msn.co.kr</option>
								<option value="nate.com" >nate.com</option>
								<option value="naver.com" >naver.com</option>
								<option value="netian.com" >netian.com</option>
								<option value="orgio.co.kr" >orgio.co.kr</option>
								<option value="paran.com" >paran.com</option>
								<option value="sayclub.com" >sayclub.com</option>
								<option value="yahoo.co.kr" >yahoo.co.kr</option>
								<option value="yahoo.com" >yahoo.com</option>
							</select>
							
							<input type="checkbox" name="open_email" value="1">
							<span>이메일 수신동의</span>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
							<input type="text" name="zip1" value=""  class="join_input" style="width:50px;" />
							<a href="javascript:;" title="새 창으로 열림" onclick="zipFind();" onkeypress="">[우편번호검색]</a> 
							    
							<br/>
							
							<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
							<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px"><input type="image" src="../images/btn01.gif" />&nbsp;&nbsp;<a href="../main/main.jsp"><img src="../images/btn02.gif" /></a></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	
	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
