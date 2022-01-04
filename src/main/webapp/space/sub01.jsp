<%@page import="util.BoardPage"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);

//DAO 객체 생성 및 DB연결
projectboardDAO dao = new projectboardDAO(application);
//검색어가 있는 경우 파라미터를 저장하기 위한 Map컬렉션 생성
Map<String,Object> param =new HashMap<String,Object>();
//검색 파라미터를 request 내장객체를 통해 얻어온다.
String searchField = request.getParameter("searchField");
String searchWord = request.getParameter("searchWord");
//검색어가 있는 경우에만
if(searchWord !=null){
	//Map컬렉션에 파라미터 값을 추가한다.
	param.put("searchField", searchField);//검색필드명(title,content 등)
	param.put("searchWord", searchWord);//검색어
}

//board테이블에 저장된 게시물의 갯수 카운트
int totalCount = dao.selectCount(param, boardName);
//System.out.println(totalCount);

/***페이지 처리 start***/
//컨텍스트 초기화 파라미터를 얻어온 후 사칙연산을 위한 정수로 변경한다.
int pageSize=Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
int blockPage=Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
//전체 페이지 수를 계산한다. 소수점을 얻기 위해 double로 형변환 후 나눈다.
int totalPage= (int)Math.ceil((double)totalCount/pageSize);
/*  
목록에 첫 진입시에는 페이지 관련 파라미터가 없으므로 무조건 1page로 지정한다.
만약 pageNum이 있다면 파라미터를 받아와서 정수로 변경한 후 페이지수로 지정한다.
*/
int pageNum=1;
//pageTemp에 잠깐 저장
String pageTemp = request.getParameter("pageNum");
if(pageTemp!=null && !pageTemp.equals("pageNum")){
	pageNum = Integer.parseInt(pageTemp);
}

//게시물의 구간을 계산한다.
int start=(pageNum-1)*pageSize+1;//구간의 시작
int end=pageNum*pageSize;//구간의 끝
param.put("start",start);//Map컬렉션에 저장 후 DAO로 전달함
param.put("end", end);
/***페이지 처리 end***/

//출력할 레코드 추출
List<ProjectBoardDTO> boardLists = dao.selectList(param, boardName);
//DB작업 끝났으므로 자원 해제
dao.close();
%>
<script>

</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub01_title.gif" alt="공지사항" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;공지사항<p>
				</div>
				<div>

<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline" id="notice" method="get">
<div class="col-md-6" >
<div class="input-group mb-3">
	<div class="form-group">
		<select name="searchField" class="form-control" >
			<option value="title">제목</option>
			<!-- <option value="">작성자</option> -->
			<option value="content">내용</option>
		</select>
	</div>
		<input type="text" name="searchWord"  class="form-control" style="width: 200px;"/>
		<div class="input-group-btn">
			<!-- <button type="submit" class="btn btn-default"> -->
				<input type="submit" value="검색하기" class="btn btn-warning"/>
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</div>
</div>
</div>
</form>	
</div>
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
<%
if(boardLists.isEmpty()){
%>
	<tr>
		<td colspan="6" align="center">
			등록된 게시물이 없습니다.
		</td>
	</tr>
<%
}
else{
	//게시물이 있을때
	int virtualNum=0;//게시물의 출력번호(가상번호)
	int countNum=0;

	for(ProjectBoardDTO dto:boardLists) //반복
	{
		//전체 레코드 수를 1씩 차감하면서 번호를 출력
		virtualNum = totalCount-(((pageNum-1)*pageSize)+countNum++);

%>
	<!-- 리스트반복 -->
	<tr>
		<td class="text-center"><%= virtualNum %></td>
		<td class="text-left"><a href="sub01_view.jsp?idx=<%=dto.getIdx()%>&boardName=<%=boardName%>"><%= dto.getTitle() %></a></td>
		<td class="text-center"><%=dto.getId()%></td>
		<td class="text-center"><%=dto.getPostdate()%></td>
		<td class="text-center"><%=dto.getVisitcount()%></td>
		<td class="text-center">첨부</td>
	</tr>
	</tbody>
<%
	}
}
%>
	</table>
</div>
<div class="row text-right" style="padding-right:50px;">
	<!-- 각종 버튼 부분 -->
	<!-- <button type="reset" class="btn">Reset</button> -->
<div class="container mt-3">
<%
if(session.getAttribute("UserType") == null){
}
else if(session.getAttribute("UserType").equals("0"))
{
%>
	<button type="button" class="btn btn-outline-dark" 
		onclick="location.href='sub01_write.jsp?boardName=<%=boardName%>';">글쓰기</button>
<%} %>
			
	<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
</div>
<div class="row text-center">
	<div class="row mt-3">
         <div class="col">
             <ul class="pagination justify-content-center">
                 <%=BoardPage.pagingStr(totalCount,pageSize,
 				blockPage, pageNum, request.getRequestURI()) %>
             </ul>
         </div>
     </div>
</div>

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>