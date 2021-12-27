<%@page import="util.JSFunction"%>
<%@page import="javax.mail.internet.InternetAddress"%>
<%@page import="javax.mail.internet.MimeMessage"%>
<%@page import="smtp.NaverSMTP"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="member.ProjectMemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String find = request.getParameter("find");
 
	String id = request.getParameter("user_id");
	String name = request.getParameter("user_name");
	String email = request.getParameter("user_email");
	
	String oracleDriver = application.getInitParameter("OracleDriver");
	String oracleURL = application.getInitParameter("OracleURL");
	String oracleId = application.getInitParameter("OracleId");
	String oraclePwd = application.getInitParameter("OraclePwd");
	
	ProjectMemberDTO projectMemberDTO = null;
	ProjectMemberDAO dao = new ProjectMemberDAO(oracleDriver, oracleURL, oracleId, oraclePwd);

	
	if(id == null) {//아이디 찾기	
		projectMemberDTO = dao.getProMemberInfo("", name, email);
		if(projectMemberDTO.getId()==null){
			JSFunction.alertBack("회원 정보가 없습니다.", out);
			//location.reload();
			return;
		}
		dao.close();
		JSFunction.alertLocation("회원님의 아이디는 "+ projectMemberDTO.getId() +" 입니다", "login.jsp", out);
		
		//로그인 input창에 아이디 입력
	}
	else {
		projectMemberDTO = dao.getProMemberInfo(id, name, email);
		if(projectMemberDTO.getPass()==null){
			JSFunction.alertBack("회원 정보가 없습니다.", out);
			return;
		}
		dao.close();
		JSFunction.alertLocation("회원님의 비밀번호를 이메일로 전송했습니다", "login.jsp", out);
		
		//로그인 input창에 아이디 입력
		
		//SMTP 이메일 전송
		String subject = "회원님의 비밀번호를 알려드립니다.";
		
		Map<String, String> emailInfo = new HashMap<String, String>();
		emailInfo.put("to", request.getParameter("user_email"));
	 	emailInfo.put("subject", subject);
	 	emailInfo.put("format", "text/html;charset=UTF-8");
	 	emailInfo.put("content", 
	 			"<b>"+ projectMemberDTO.getId()+ "</b> 회원님의 비밀번호는 '<b>"+ projectMemberDTO.getPass() +"</b>' 입니다.");
	 	try {
	 		NaverSMTP smtpServer = new NaverSMTP();
	 		smtpServer.emailSending(emailInfo);
	 		out.print("이메일 전송 성공");
	 	}
	 	catch (Exception e) {
	 		out.print("이메일 전송 실패");
	 		e.printStackTrace();
	 	}
		
		
}
%>