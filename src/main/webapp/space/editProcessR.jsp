<%@page import="java.util.Date"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ include file="./IsLoggedIn.jsp" %>--%>
<%
//파일 저장소
String saveDirectory = application.getRealPath("/Uploads");
//업로드 용량
int maxPostsize = 1024*3000;
//인코딩 방식 설정
String encoding = "UTF-8";

try{
	MultipartRequest mr = new MultipartRequest
			(request, saveDirectory, maxPostsize, encoding);
	
	//DTO객체 생성 //폼값 입력
	ProjectBoardDTO dto = new ProjectBoardDTO();
	
	dto.setName(mr.getParameter("name"));
	dto.setTitle(mr.getParameter("Title"));
	dto.setContent(mr.getParameter("content"));

	String fileName = mr.getFilesystemName("ofile");
	if(fileName !=null){
		String now=new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = now+ext; //최종파일명
	
		File oldFile = new File(saveDirectory+File.separator+fileName);
		File newFile = new File(saveDirectory+File.separator+newFileName);
		oldFile.renameTo(newFile);
	
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
	}
		
	//DAO객체 생성
	projectboardDAO dao = new projectboardDAO();
	dao.updateEdit(dto);  //insert처리
	dao.close();
	
	response.sendRedirect("sub05_view.jsp");
}
catch(Exception e){
	e.printStackTrace();
	JSFunction.alertBack("파일 업로드에 실패했습니다", out);
}
%>
