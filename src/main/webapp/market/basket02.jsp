<%@page import="model.shopboard.shopboardDTO"%>
<%@page import="model.shopboard.shopboardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<%
//게시물의 일련번호를 파라미터를 통해 받는다. 
String idx = request.getParameter("idx");   
String Quantity = request.getParameter("Quantity");
//DB연결
shopboardDAO dao = new shopboardDAO(application);

//일련번호에 해당하는 게시물 조회
shopboardDTO dto = dao.selectView(idx);
//자원해제
dao.close();                               
%>

<!-- <script>
$(document).ready(function() {
	
	//select를 선택하면 발생되는 change이벤트를 통해 서버로 요청
	$('#goodsOptionId01').change(function() {
		$.ajax({
			url : "../ShoppingOptions.choice", //요청 URL
			type : "get", //전송방식
			data : { //파라미터 : select에서 선택한 값
				goodsOptionName : $('#goodsOptionId01').val()
			},
			dataType : "json", //콜백데이터 형식은 JSON
			contentType : "text/html; charset:UTF-8",
			
			success : function(d) {
				//기본가를 얻어온다.
				var totalPrice = parseInt($('#totalPrice').val());
				//선택한 옵션의 value값을 얻어온다.
				var goodsOption = $('#goodsOptionId01').val();
				//옵션에 따라 옵션가를 합산한다.
				if(goodsOption=='op01') totalPrice += 5000;
				else if (goodsOption=='op02') totalPrice += 7000;
				else if (goodsOption=='op03') totalPrice += 10000;
				
				//합산된 금액을 다시 totalprice에 더한다.
				//계산된 가격을 다시 hidden박스에 적용한다.
				$('#totalPrice').val(totalPrice);
				//웹브라우저에 총 금액을 출력한다.
				$('#priceDisplay').html("총상품금액: " +totalPrice);
				
				//콜백된 데이터를 통해 옵션 테이블을 생성한다.
				var table = ''
					+ '<table class="table table-bordered">'
					+ '<tr>'
					+ '		<td width="30%">옵션명:</td>'
					+ '		<td width="70%">'+d.optionName+'</td>'
					+ '</tr>'
					+ '<tr>'
					+ '		<td colspan="2" class="info">추가비용: '+d.optionPrice+'원</td>'
					+ '</tr>'
					+ '</table>';
				console.log(d);
				
				//웹브라우저에 추가한다.
				$('#goodsList').append(table);
				
				//옵션을 선택한 후 최초 상태로 리셋한다.
				$('#goodsOptionId01').val('');
			},
			error : function(e) {
				alert("실패" + e.status)
			}
		});
	});
});

</script> -->
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
			<input type="hidden" name="idx" value="<%= dto.getIdx() %>" />
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
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
							<th>선택</th>
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
					<tbody>
						<tr>
							<td><input type="checkbox" name="" value="" /></td>
							<td><img src="../images/market/cake_img1.jpg" /></td>
							<td><%= dto.getPname() %></td>
							<td><%= dto.getPrice() %></td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;300원</td>
							<td><input type="number" name="" value="1" class="basket_num" />&nbsp;<a href=""><img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td>
							<td><span>60,000원<span></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> <a href=""><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name=""  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name=""  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:50px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:100px;" /> @ <input type="text" name=""  value="" class="join_input" style="width:100px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 예<input type="radio" /> 아니오<input type="radio" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px; margin-bottom:5px;" /> <a href=""><img src="../images/market/basket_btn03.gif" style="margin-bottom:5px;" /></a><br /><input type="text" name=""  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br /><input type="text" name=""  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:50px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px;" /> - <input type="text" name=""  value="" class="join_input" style="width:50px;" /></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:100px;" /> @ <input type="text" name=""  value="" class="join_input" style="width:100px;" /></td>
						</tr>
						<tr>
							<th>배송메세지</th>
							<td style="text-align:left;"><input type="text" name=""  value="" class="join_input" style="width:500px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money">60,000원</span></td>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;"><input type="radio" /> 카드결제&nbsp;&nbsp;&nbsp;<input type="radio" /> 무통장입금&nbsp;&nbsp;&nbsp;<input type="radio" /> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;"><a href=""><img src="../images/market/basket_btn04.gif" /></a></p>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
