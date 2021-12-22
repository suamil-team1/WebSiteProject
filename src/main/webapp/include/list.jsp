<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
		<colgroup>
			<col width="80px"/>
			<col width="*"/>
			<col width="120px"/>
			<col width="120px"/>
			<col width="80px"/>
			<col width="50px"/>
		</colgroup>
		
		<thead>
		<tr class="success">
			<th class="text-center">번호</th>
			<th class="text-left">제목</th>
			<th class="text-center">작성자</th>
			<th class="text-center">작성일</th>
			<th class="text-center">조회수</th>
			<th class="text-center">첨부</th>
		</tr>
		</thead>
		
		<tbody>
		<!-- 리스트반복 -->
		<tr>
			<td class="text-center">번호</td>
			<td class="text-left"><a href="sub01_view.jsp">제목</a></td>
			<td class="text-center">작성자</td>
			<td class="text-center">작성일</td>
			<td class="text-center">조회수</td>
			<td class="text-center">첨부</td>
		</tr>
		</tbody>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
		
	<button type="button" class="btn btn-default" 
		onclick="location.href='sub01_write.jsp';">글쓰기</button>
				
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
	<!-- 페이지번호 부분 -->
	<ul class="pagination">
		<li><span class="glyphicon glyphicon-fast-backward"></span></li>
		<li><a href="#">1</a></li>		
		<li class="active"><a href="#">2</a></li>
		<li><a href="#">3</a></li>
		<li><a href="#">4</a></li>		
		<li><a href="#">5</a></li>
		<li><span class="glyphicon glyphicon-fast-forward"></span></li>
	</ul>	
</div>