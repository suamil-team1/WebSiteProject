<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function idUse(){
    opener.document.join02Frm.id.value = document.checkForm.idinput.value;
	opener.document.join02Frm.idDuplication.value ="idCheck";
    self.close();
}

window.onload = function(){
	var url = location.href;
	var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
	returnValue = parameters[0].split('=')[1];
	document.getElementById('userId').innerHTML = returnValue;
}   

function pValue(){
	document.getElementById("userId").value = opener.document.join02Frm.id.value;
}

function idCheck(){

	var id = document.getElementById("userId").value;

	if (!id) {
		alert("아이디를 입력하지 않았습니다.");
		return false;
	} 
	else if( !(form.id.value.length >=4 && form.id.value.length <=12)){ 
	    alert("4자 이상 12자 이내의 값만 입력하세요");
	    form.id.value = '';
	    form.id.focus(); 
	    return false;
		}
	}
	else if((id < "0" || id > "9") && (id < "A" || id > "Z") && (id < "a" || id > "z")){ 
		alert("한글 및 특수문자는 아이디로 사용하실 수 없습니다.");
		return false;
	}
	else
	{
		var param="id="+id
		/* httpRequest = getXMLHttpRequest();
		httpRequest.onreadystatechange = callback;
		httpRequest.open("POST", "MemberIdCheckAction.do", true);	
		httpRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded'); 
		httpRequest.send(param); */
	}
}

</script>
</head>
<body onload="pValue()">
<div id="wrap">
	<br>
	<b><font size="4" color="gray">아이디 중복체크</font></b>
	<hr size="1" width="460">
	<br>
	<div id="chk">
		<form id="checkForm">
			<input type="text" name="idinput" id="userId">
			<input type="button" value="중복확인" onclick="idCheck()">
		</form>
		<br>
		<input type="button" value="사용하기" onclick="idUse()">
		<input type="button" value="취소" onclick="window.close()"><br>
	</div>
</div>	


    <h3>부모창에서 입력한 아이디 : <span id="user_id"></span></h3>

    <h3>아이디가 중복되었을때 재입력한 아이디</h3>
    <form name="overlapFrm">
        <input type="text" name="retype_id" size="20">
        <input type="button" value="아이디사용하기" onclick="idUse();">
    </form>
    
</body>
</html>