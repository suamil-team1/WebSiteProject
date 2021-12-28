<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.shopboard.shopboardDTO"%>
<%@page import="model.shopboard.shopboardDAO"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<!-- 글쓰기 전 로그인 확인 -->
<%-- <%@ include file="../model1/IsLoggedIn.jsp" %> --%>
<%@ include file="../model1/loggingnow.jsp" %>
<%
//게시물의 일련번호를 파라미터를 통해 받는다. 
String pNum = request.getParameter("pNum"); 
String id = request.getParameter("id");

//DB연결
shopboardDAO dao = new shopboardDAO(application);

//일련번호에 해당하는 게시물 조회
//shopboardDTO dto = dao.selectView(pNum);
shopboardDTO dto = dao.selectBasket(id);


List<shopboardDTO> boardLists = dao.selectList(param);

//자원해제
dao.close();                               
%>

 <body>
	<!-- <center> -->
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
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					
<%
if(boardLists.isEmpty()){
%>
	<tr>
		<td colspan="6" align="center">
			장바구니에 담긴 물품이 없습니다^^*
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
					<tbody>
						<tr>
							<td><%= virtualNum %></td>
							<td><img src="../images/market/cake_img1.jpg" /></td>
							<td><%=dto.getPname()%></td>
							<td><%=dto.getPrice()%></td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;<%=dto.getDelivery()%></td>
							<td><input type="text" name="" value="2" class="basket_num" />&nbsp;<a href=""><img src="../images/market/m_btn.gif" /></a></td>
							<td><%=dto.getDelivery()%></td>
							<td><%=dto.getDelVer()%></td>
							<td><span><%=dto.getSump()%><span></td>
						</tr> 
					</tbody>
				</table>
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span> 137,000 + <span>배송비</span> 0 = 합계 : <span class="money">137,000원</span><br /><br /><a href=""><img src="../images/market/basket_btn01.gif" /></a>&nbsp;<a href="basket02.jsp"><img src="../images/market/basket_btn02.gif" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
