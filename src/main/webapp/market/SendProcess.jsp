<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="smtp.NaverSMTP"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="util.JSFunction"%>
<%@page import="javax.swing.text.Document"%>
<%@page import="openmarket.applicationFormDTO"%>
<%@page import="openmarket.applicationFormDAO"%>
<%@page import="model.shopboard.shopboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   	
	String client = request.getParameter("client");
	String adrress = request.getParameter("adrress");
	String diff1 = request.getParameter("diff1");
	String diff2 = request.getParameter("diff2");
	String difficulty = diff1 +","+ diff2;
	String dev1 = request.getParameter("dev1");
	String dev2 = request.getParameter("dev2");
	String device = dev1 +","+ dev2;
	String tel1 	= request.getParameter("tel1");
	String tel2 	= request.getParameter("tel2");
	String tel3 	= request.getParameter("tel3");
	String tellnum = "";
	if ((tel1 != null) && (tel2 != null) && (tel3.equals(""))) {
		tellnum 		= (tel1 +"-"+ tel2 +"-"+ tel3);
	}
	String mobile1		= request.getParameter("mobile1");
	String mobile2		= request.getParameter("mobile2");
	String mobile3		= request.getParameter("mobile3");
	String mobile = "";
	if ((mobile1 != null) && (mobile2 != null) && (mobile3.equals(""))) {
		 mobile		= (mobile1 +"-" + mobile2 +"-" + mobile3);
	}
	String email1	= request.getParameter("email1");
	String email2	= request.getParameter("email2");
	String email = (email1 +"@"+ email2);
	String content1 = request.getParameter("content1");
	String content2 = request.getParameter("content2");
	String targetdate = request.getParameter("targetdate"); //jQuery...
	String sort = request.getParameter("sort");
	String etc = request.getParameter("etc");
   	
	applicationFormDAO dao = new applicationFormDAO(application);
	
	String userId = session.getAttribute("UserId").toString();
	String flag = request.getParameter("flag");
	applicationFormDTO dto = dao.sendnSave(flag);
	
	dto.setClient(client);
	dto.setAdrress(adrress);
	dto.setDifficulty(difficulty);
	dto.setDevice(device);
	dto.setTellnum(tellnum);
	dto.setMobile(mobile);
	dto.setEmail(email);
	dto.setContent1(content1);
	dto.setContent2(content2);
	dto.setTargetdate(targetdate);
	dto.setSort(sort);
	dto.setEtc(etc);
	
	Map<String, String> emailInfo = new HashMap<String, String>();
	
	String subject = "";
	String htmlContent = "";
	BufferedReader br;
	String line;	
	if (flag == "1") { 
		br = new BufferedReader(new FileReader(application.getRealPath("/market/sendingMailForm1.html")));
		subject = "블루크리닝 견적 의뢰 내역입니다.";
		while ( (line=br.readLine()) != null ) {
			htmlContent += line + "\n";
		}
		br.close();
		
		htmlContent = htmlContent.replace("adrress", adrress);
	}
	else { 
		br = new BufferedReader(new FileReader(application.getRealPath("/market/sendingMailForm2.html")));
		subject = "체험학습신청 내역입니다.";
		while ( (line=br.readLine()) != null ) {
			htmlContent += line + "\n";

			htmlContent = htmlContent.replace("difficulty", difficulty);
		htmlContent = htmlContent.replace("device", device);
		}
		br.close();
	}
	
	htmlContent = htmlContent.replace("client", client);
	htmlContent = htmlContent.replace("tellnum", tellnum);
	htmlContent = htmlContent.replace("mobile", mobile);
	htmlContent = htmlContent.replace("email", email);
	htmlContent = htmlContent.replace("content1", content1);
	htmlContent = htmlContent.replace("content2", content2);
	htmlContent = htmlContent.replace("targetdate", targetdate);
	htmlContent = htmlContent.replace("sort", sort);
	htmlContent = htmlContent.replace("etc", etc);
	
	
	emailInfo.put("to", email);
 	emailInfo.put("subject", subject);
 	emailInfo.put("format", "text/html;charset=UTF-8");
 	emailInfo.put("content", htmlContent);
	
	
 	try {
 		NaverSMTP smtpServer = new NaverSMTP();
 		smtpServer.emailSending(emailInfo);
 		JSFunction.alertLocation("내역이 메일로 전송되었습니다.", "../main/main.jsp", out);
 		out.print("이메일 전송 성공");
 	}
 	catch (Exception e) {
 		out.print("이메일 전송 실패");
 		e.printStackTrace();
 	}

%>