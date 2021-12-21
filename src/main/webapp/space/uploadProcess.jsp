<%@page import="util.JSFunction"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글쓰기 처리 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
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
	
	//파일명 설정하기
	String fileName=mr.getFilesystemName("attachedFile"); //서버에 저장된 파일
	String ext=fileName.substring(fileName.lastIndexOf(".")); //위치파악
	String now=new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	
	String newFileName = now+ext; //최종파일명
	
	File oldFile = new File(saveDirectory+File.separator+fileName);
	File newFile = new File(saveDirectory+File.separator+newFileName);
	oldFile.renameTo(newFile);
	
	//파일을 제외한 나머지 폼값받아오기
	String title=mr.getParameter("title");
	String content=mr.getParameter("content");
	String boardName=mr.getParameter("boardName"); //보드네임
	
	//DTO객체 생성 //폼값 입력
	ProjectBoardDTO dto = new ProjectBoardDTO();
	
	dto.setTitle(title);
	dto.setContent(content);
	dto.setOfile(fileName);
	dto.setSfile(newFileName);
	dto.setBoardName(boardName);
	
	//id저장
	dto.setId(session.getAttribute("UserId").toString());
		
	//DAO객체 생성
	projectboardDAO dao = new projectboardDAO();
	int iResult = dao.insertFile(dto);  //insert처리
	dao.close();
	
	//문제가 없다면 파일리스트로 이동한다.
	//response.sendRedirect("sub05.jsp");
	if(iResult == 1){ //글쓰기 성공 > 목록으로 가기
		
		switch(boardName){
		case "gal" : 
			response.sendRedirect("sub04.jsp?boardName=gal"); return;
		case "ref" :
			response.sendRedirect("sub05_view.jsp?boardName=ref"); return;
		}
	}
}
catch(Exception e){
	e.printStackTrace();
	//예외가 발생하면 request영역에 메세지를 저장한 후 메인으로 포워드한다.
	JSFunction.alertBack("파일 업로드에 실패했습니다", out);
}
%>    