<%@page import="model.shopboard.shopboardDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.shopboard.shopboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
//DAO 객체 생성 및 DB연결
shopboardDAO dao = new shopboardDAO(application);
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
int totalCount = dao.selectCount(param);

//출력할 레코드 추출
List<shopboardDTO> boardLists = dao.selectList(param);
//DB작업 끝났으므로 자원 해제
dao.close();
%>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="5%" />
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th>선택</th>
						<th>상품이미지</th>
						<th>상품명</th>
						<th>가격</th>
						<th>수량</th>
						<th>구매</th>
					</tr>
<%
if(boardLists.isEmpty()){
%>
	<tr>
		<td colspan="6" align="center">
			등록된 게시물이 없습니다^^*
		</td>
	</tr>
<%
}
else{
	//게시물이 있을때
	int virtualNum=0;//게시물의 출력번호(가상번호)
	for(shopboardDTO dto:boardLists) //반복
	{
		//전체 레코드 수를 1씩 차감하면서 번호를 출력
		virtualNum = totalCount--;

%>					
					
					
					<tr>
						<td><input type="checkbox" name="" value="" /></td>
						<td><a href="market_view.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/img01.jpg" /></a></td>
						<td class="t_left"><a href="market_view.jsp?idx=<%= dto.getIdx()%>"><%=dto.getPname()%></a></td>
						<td class="p_style"><%=dto.getPrice()%></td>
						<td><input type="text" name="" value="1" class="n_box" /></td>
						<td><a href="basket02.jsp"><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br /><a href="basket.jsp"><img src="../images/market/btn02.gif" /></a></td>
					</tr>
<%
	}
}
%>
				</table>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
