<%@page import="model.shopboard.shopboardDTO"%>
<%@page import="model.shopboard.shopboardDAO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<script>
/* function basketIn(idx) {
	var choiceCount = document.getElementById('Quantity_'+idx).value;
	console.log("상품번호&갯수", idx, choiceCount);
} */
input.name onchange 

ajax 해당 수량을 업데이트하는 쿼리문 

$(document).ready(function() {
	
	//select를 선택하면 발생되는 change이벤트를 통해 서버로 요청
	$('#goodsOptionId01').change(function() {
		$.ajax({
			url : "../basketprocess.do", //요청 URL
			type : "get", //전송방식
			data : { //파라미터 : select에서 선택한 값
				QuantityValue : $('#Quantity').val()
			},
			dataType : "json", //콜백데이터 형식은 JSON
			contentType : "text/html; charset:UTF-8",
			
			success : function(d) {
				//기본가를 얻어온다.
				var totalPrice = parseInt(dto.getPrice());
				//선택한 옵션의 value값을 얻어온다.
				var QuantityCheck = $('#Quantity').val();
				//옵션에 따라 옵션가를 합산한다.
				
				if(QuantityCheck < 0) {
					QuantityCheck = 1;
				}
				else{
					
				}
				
				//합산된 금액을 다시 totalprice에 더한다.
				//계산된 가격을 다시 hidden박스에 적용한다.
				$('#totalPrice').val(totalPrice);
				
				//웹브라우저에 총 금액을 출력한다.
				totalPrice = totalPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','); //콤마추가하기
				$('#totalPrice').html(totalPrice);
				
				//옵션을 선택한 후 최초 상태로 리셋한다.
				$('#goodsOptionId01').val('');
			},
			error : function(e) {
				alert("실패" + e.status)
			}
		});
	});
});
</script>
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
				<form action="market/basketprocess.do">
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
						<th>번호</th>
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
						<td><%= virtualNum %></td>
						<td><a href="market_view.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/img01.jpg" /></a></td>
						<td class="t_left"><a href="market_view.jsp?idx=<%= dto.getIdx()%>"><%=dto.getPname()%></a></td>
						<td class="p_style" id=totalPrice><%=dto.getPrice()%></td>
						<td><input type="number" id="Quantity" name="Quantity" value="1" class="n_box" onchange=""/></td>
						<td><a href="basket02.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br /><a href="basket.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/btn02.gif" style="cursor: pointer"/></a></td>
					</tr>
					<%-- <c:forEach begin="1" end="3" step="1" var="i">
					<tr>
						<td>${i }</td>
						<td><a href="market_view.jsp?idx=${i }"><img src="../images/market/img01.jpg" /></a></td>
						<td class="t_left"><a href="market_view.jsp?idx=${i }"><%=dto.getPname() %>${i }</a></td>
						<td class="p_style"><%=dto.getPrice()%></td>
						<td><input type="number" id="Quantity_${i }" name="Quantity_${i }" value="1" class="n_box" /></td>
						<td><a href="basket02.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br /><a href="basket.jsp?idx=<%= dto.getIdx()%>"><img src="../images/market/btn02.gif" onclick="basketIn(${i })" style="cursor: pointer"/></a></td>
					</tr>
					</c:forEach> --%>
<%
	}
}
%>
				</table>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
