<%@page import="member.ProjectMemberDTO"%>
<%@page import="util.CookieManager"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>



<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Login</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    
<%
ProjectMemberDAO dao = new ProjectMemberDAO(application);
dao.close(); 
//쿠키값 읽어오기
String loginId = CookieManager.readCookie(request, "loginId");

//앞에서 읽어온 쿠키값이 있다면 checked 속성값을 변수에 설정한다.
String cookieCheck="";
if(!loginId.equals("")){
	cookieCheck = "checked";
}

if(request.getAttribute("LoginErrMsg")!=null){
	JSFunction.alertBack("아이디 혹은 비밀번호가 일치하지 않습니다.", out);
}
%>
<script>
function validateForm(form) {
	if(!form.id.value){ 
		alert("아이디 입력하세요.");
		form.id.focus();
		return false;
	}
	if(form.pass.value ==""){
		alert("패스워드를 입력하세요.");
		form.pass.focus();
		return false;
	}
}
</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-login-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Welcome Back!</h1>
                                    </div>
                                    <form class="user" action="../adminpage/login.do" method="post" name="adminLoginFrm" onsubmit="return validateForm(this);">
                                        <%
                                        String id = (String)session.getAttribute("UserId");
                                        if (id != "admin"){
                                        %>
                                        
                                        <div class="form-group">
                                            <input type="text" name="id" value="<%= loginId%>" class="form-control form-control-user"
                                                id="exampleInputId" aria-describedby="emailHelp"
                                                placeholder="Enter Admin Id">
                                        </div>
                                        <div class="form-group">
                                            <input type="password" name="pass" class="form-control form-control-user"
                                                id="exampleInputPassword" placeholder="Password">
                                        </div>
                                        <div class="form-group">
                                            <div class="custom-control custom-checkbox small">
                                                <input type="checkbox" name="save_check" class="custom-control-input" id="customCheck" value="Y" <%= cookieCheck %>>
                                                <label class="custom-control-label" for="customCheck">Remember
                                                    Me</label>
                                            </div>
                                        </div>
                                        <!-- <a href="index.jps" class="btn btn-primary btn-user btn-block"> -->
                                        <input type="submit" class="btn btn-primary btn-user btn-block" value="Login">
			                            <!-- Login -->
                                        <!-- </button> -->
                                        <hr>
                                        <a href="index.jps" class="btn btn-google btn-user btn-block">
                                            <i class="fab fa-google fa-fw"></i> Login with Google
                                        </a>
                                        <a href="index.jps" class="btn btn-facebook btn-user btn-block">
                                            <i class="fab fa-facebook-f fa-fw"></i> Login with Facebook
                                        </a>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="forgot-password.jps">Forgot Password?</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="register.jps">Create an Account!</a>
                                    </div>
                                    <%
									} 
                                        else{
                                    %>
                                    <span style="font-size: 18px; font-weight: bold;"><%= session.getAttribute("UserName") %></span> 님, 반갑습니다.<br>
									<br><br>
									<button type="button"  class="btn btn-primary btn-user btn-block" onclick="location.href='logout.jsp';">로그아웃</button>
                                </div>
                                	<%
                                    	}
                                	%>
                            </div>
                        </div>
                    </div>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>