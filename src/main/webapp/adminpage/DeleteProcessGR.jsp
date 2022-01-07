<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 삭제 처리 전 로그인 확인 -->
<%@ include file="../model1/IsLoggedIn.jsp" %>
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
	
	/*파일명 설정하기
	String fileName=mr.getFilesystemName("attachedFile"); //서버에 저장된 파일
	String ext=fileName.substring(fileName.lastIndexOf(".")); //위치파악
	String now=new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
	
	String newFileName = now+ext; //최종파일명
	
	File oldFile = new File(saveDirectory+File.separator+fileName);
	File newFile = new File(saveDirectory+File.separator+newFileName);
	oldFile.renameTo(newFile);*/
	
	//파일을 제외한 나머지 폼값받아오기
	String boardName=mr.getParameter("boardName"); //보드네임
	String idx = mr.getParameter("idx"); 
	
	//DTO객체 생성 //폼값 입력
	ProjectBoardDTO dto = new ProjectBoardDTO();
	projectboardDAO dao = new projectboardDAO(application);
	
	dto.setBoardName(boardName);
	dto=dao.selectView(idx);
	
	//세션영역에 저장된 아이디를 문자열로 반환
	String sessionId=session.getAttribute("UserId").toString();

	//DAO객체 생성
	int delResult=0;
	
	//현재 삭제하는 사람이 해당 글의 작성자가 맞는지 확인
	//if(sessionId.equals(dto.getId())){//작성자 본인이 맞으면...
		
		//DTO객체에 일련번호를 저장한 후 DAO로 매개변수 전달
		dto.setIdx(idx);
		delResult= dao.deletePost(dto);
		//연결 해제
		dao.close();
		
		if(delResult==1){
			/*if(boardName.equals("not")){
				JSFunction.alertLocation("삭제되었습니다.", "sub01.jsp?boardName=not", out);
			}
			if(boardName.equals("cal")){
				JSFunction.alertLocation("삭제되었습니다.", "sub02.jsp?boardName=cal", out);
			} 
			if(boardName.equals("fre")){
				JSFunction.alertLocation("삭제되었습니다.", "sub03.jsp?boardName=fre", out);
			}*/
			if(boardName.equals("gal")){
				JSFunction.alertLocation("삭제되었습니다.", "gallery_list.jsp?boardName=gal", out);
			}
			if(boardName.equals("ref")){
				JSFunction.alertLocation("삭제되었습니다.", "board_list03.jsp?boardName=ref", out);
			}
		}
/*	
	}
	else{
		JSFunction.alertBack("삭제에 실패하였습니다.", out);
	}*/
}
//else{// 작성자 본인이 아니면 삭제할 수 없음
//		JSFunction.alertBack("본인만 삭제할 수 있습니다.", out);
//		return;
//}
catch(Exception e){
	e.printStackTrace();
	System.out.println("삭제 중 예외 발생");
}
%>

