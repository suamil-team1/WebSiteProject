<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script>
function idUse(){
    opener.document.join02Frm.id.value = document.overlapFrm.retype_id.value;
    self.close();
}
	window.onload = function(){
	var url = location.href;
	console.log(url);
	var parameters = (url.slice(url.indexOf('?') + 1, url.length)).split('&');
	console.log(parameters[0]); //id=입력된값
	returnValue = parameters[0].split('=')[1];
	document.getElementById('user_id').innerHTML = returnValue;
	}   

</script>
</head>
<body>
    <h2>아이디 중복확인 하기</h2>

    <h3>부모창에서 입력한 아이디 : <span id="user_id"></span></h3>

    <h3>아이디가 중복되었을때 재입력한 아이디</h3>
    <form name="overlapFrm">
        <input type="text" name="retype_id" size="20">
        <input type="button" value="아이디사용하기" onclick="idUse();">
    </form>
</body>
</html>