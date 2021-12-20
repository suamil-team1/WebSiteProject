<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<form enctype="multipart/form-data">
	<table>
		<colgroup>
			<col width="20%">
			<col width="30%">
			<col width="20%">
			<col width="*">
		</colgroup>
		<tbody>
			<tr>
				<th style="vertical-align:middle;">작성자</th>
				<td>${dto.id}</td>
				<th style="vertical-align:middle;">작성일</th>
				<td>${dto.postdate}</td>
			</tr>
			<tr>
				<th style="vertical-align:middle;">이메일</th>
				<td><!-- 이메일 미구현 --></td>
				<th style="vertical-align:middle;">조회수</th>
				<td>${dto.visitcount}</td>
			</tr>
			<tr>
				<th style="vertical-align:middle;">제목</th>
				<td colspan="3">${dto.title}</td>
			</tr>
			<tr>
				<th style="vertical-align:middle;">내용</th>
				<td colspan="3">${dto.content}</td>
			</tr>
			<tr>
				<th style="vertical-align:middle;">첨부파일</th>
				<td colspan="3">
					<c:if test="${not empty dto.ofile}">
						${dto.ofile}
						<!-- idx가 있는 이유는 다운로드 카운트를 증가시켜야 하기 때문. -->
						<%-- <a href="../mvcboard/download.do?ofile=${dto.ofile}&sfile=${dto.sfile}&idx=${dto.idx}"> --%>
							[다운로드]
						</a>
					</c:if>
				</td>
			</tr>
		</tbody>
	</table>
	
	<div>
		<!-- 각종 버튼 부분 -->
		<button type="button">수정하기</button>
		<button type="button">삭제하기</button>	
		<button type="button" onclick="location.href='../community/List.do';">목록보기</button>
	</div>
</form> 