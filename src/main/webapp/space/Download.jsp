
<%@page import="util.JSFunction"%>
<%@page import="java.io.FileNotFoundException"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//파일이 저장돼있는 물리적 경로
String saveDirectory=application.getRealPath("/Uploads");

//서버파일명 & 원본파일명 가져오기
String saveFilename=request.getParameter("sName");
String originalFilename=request.getParameter("oName");

try{
	//물리적 경로와 파일명을 통해 File객체 생성
	File file=new File(saveDirectory, saveFilename);
	//파일의 내용을 읽어오기 위한 입력스트림 생성
	InputStream inStream=new FileInputStream(file);
	
	//웹브라우저의 종류를 알아오기 위한..
	String client=request.getHeader("User-Agent");
	if(client.indexOf("WOW64")==-1){
		//인터넷 익스플로러가 아닌 경우 한글 파일명 인코딩
		originalFilename=new String(originalFilename.getBytes("UTF-8"),
				"ISO-8859-1");
	}
	else{
		//인터넷 익스플로러 일 때 한글 파일명 인코딩
		originalFilename=new String(originalFilename.getBytes("KSC5601"),
				"ISO-8859-1");
	}
	
	/*
	파일 다운로드를 위한 응답 헤더 설정
	1. 응답헤더 초기화
	2. 웹브라우저가 인식하지 못하는 컨텐츠 타입을 설정하여 다운로드 창을 강제로 띄우게함.
	3. 파일명을 변경하기 위한 응덥헤더를 설정하고 파일사이즈도 설정한다.
	*/
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", 
					"attachment; filename=\""+ originalFilename +"\"");
	response.setHeader("Content-Length", ""+file.length());
	
	//새로운 출력스트림을 생성하기 위해 초기화
	out.clear();
	//새로운 출력스트림을 생성해서 파일을 내보낸다.
	OutputStream outStream=response.getOutputStream();
	
	byte b[]=new byte[(int)file.length()];
	int readBuffer=0;
	while((readBuffer=inStream.read(b))>0){
		outStream.write(b,0,readBuffer);
	}
	
	//입출력 스트림을 닫아준다.(자원해제)
	inStream.close();
	outStream.close();
}
catch(FileNotFoundException e){
	JSFunction.alertBack("파일을 찾을 수 없습니다", out);
}
catch(Exception e){
	JSFunction.alertBack("예외가 발생했습니다", out);
}
%>
