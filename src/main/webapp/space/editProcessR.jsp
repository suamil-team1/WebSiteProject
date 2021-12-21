<%@page import="fileupload.FileUtil"%>
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

//파일 저장소 위치
String saveDirectory = application.getRealPath("/Uploads");
//업로드 용량
int maxPostsize = 1024*3000;
//인코딩 방식 설정
String encoding = "UTF-8";

try{
	MultipartRequest mr = new MultipartRequest
			(request, saveDirectory, maxPostsize, encoding);
	
	if(mr==null){ //파일 업로드에 실패하는 경우
		JSFunction.alertBack(response, "첨부파일이 제한 용량을 초과합니다.");
	}
	
	//hidden 속성의 값 가져오기
	String idx = mr.getParameter("idx");
	String boardName = mr.getParameter("boardName");
	String prevOfile = mr.getParameter("prevOfile"); //DB에 등록된 원본명의 파일
	String prevSfile = mr.getParameter("prevSfile"); //DB에 등록된 서버명의 파일
	//수정페이지에서 새로 입력한 폼값
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	//파일을 새롭게 등록한다면 이 변수를 쓰겠음..
	String fileName=mr.getFilesystemName("attachedFile"); 
	
	//DTO객체 생성 //폼값 입력
	ProjectBoardDTO dto = new ProjectBoardDTO();
	dto.setIdx(idx);
	dto.setTitle(title);
	dto.setContent(content);
	dto.setBoardName(boardName);
	
	if(fileName != null){//새롭게 파일을 등록한다면..
		String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
		String ext = fileName.substring(fileName.lastIndexOf("."));
		String newFileName = now+ext; //최종파일명
	
		File oldFile = new File(saveDirectory+File.separator+fileName);
		File newFile = new File(saveDirectory+File.separator+newFileName);
		oldFile.renameTo(newFile);
	
		//새로운 파일을 dto에 저장
		dto.setOfile(fileName);
		dto.setSfile(newFileName);
	}
	else{//기존의 파일을 그대로 저장
		dto.setOfile(prevOfile);
		dto.setSfile(prevSfile);
	}
		
	//DAO객체 생성
	projectboardDAO dao = new projectboardDAO();
	
	int affected = dao.updateEdit(dto);  //update처리
	dao.close();
	
	if(affected==1){//성공
		response.sendRedirect("sub05_view.jsp?idx="+ dto.getIdx());	
	}
}
catch(Exception e){
	e.printStackTrace();
	JSFunction.alertBack("파일 업로드에 실패했습니다", out);
}
%>
