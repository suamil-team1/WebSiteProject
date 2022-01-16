<%@page import="member.ProjectMemberDTO"%>
<%@page import="member.ProjectMemberDAO"%>
<%@page import="util.JSFunction"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
//폼값 받기
String id = request.getParameter("user_id");
String type = request.getParameter("type");

//사용자가 입력한 폼값을 저장하기 위해 DTO객체 생성
ProjectMemberDTO dto = new ProjectMemberDTO();

dto.setId(id);
dto.setType(type);

//DAO객체 생성 및 DB연결
ProjectMemberDAO dao = new ProjectMemberDAO();
//dto객체를 매개변수로 전달하여 레코드 update
int iResult = dao.editType(dto);
//자원해제
dao.close();

if(iResult == 1){
	//회원정보 수정 성공시 메인 페이지로 이동
	JSFunction.alertLocation("회원 등급 수정 완료", "member_list.jsp", out);
} else{
	//실패 시 뒤로 이동
	JSFunction.alertBack("회원 등급 수정 실패", out);
}
%>