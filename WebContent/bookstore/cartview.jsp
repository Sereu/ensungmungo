<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="silverstar.cart.Cart"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
<%@ include file="../navigation/header.jsp" %>
<%@ include file="../navigation/recentbookview.jsp" %>
	<script type="text/javascript">
  	function allSelectUnselect() {
  		
  		var el = document.getElementById("chbox");
  		var checkboxes = document.querySelectorAll("input[name='booksno']");
		if(el.checked == true){
	  		for (var i=0; i<checkboxes.length; i++) {
	  			var checkbox = checkboxes[i];
	  			checkbox.checked = true;
	  		}
		} else {
	  		for (var i=0; i<checkboxes.length; i++) {
	  			var checkbox = checkboxes[i];
	  			checkbox.checked = false;
	  		}
		}
  	}
  	function addAllBooksToCart() {
  		var isChecked = false;
  		var checkboxes = document.querySelectorAll("input[name='booksno']");
  		for (var i=0; i<checkboxes.length; i++) {
  			var checkbox = checkboxes[i];
  			if(checkbox.checked == true){
  				isChecked = true;
  			}
  		}
  		if(!isChecked) {
  			alert("하나이상 체크해주세요.");
  		}
  		else{
  			document.getElementById("book-form").submit();	
  		}
  	}
	function show() {
		var sidebar = document.getElementById("sidebar");
		if(sidebar.style.display == "block"){
			sidebar.style.display ="none";
		}
		else{
			sidebar.style.display ="block";	
		}
	}
	</script>
	
	<%
	
		
		if(session.getAttribute("loginedCustomer") == null ) {
			
			response.sendRedirect("/silverstar/customer/loginview.jsp");
			return;
		}
		
		CustomerDao customerDao = new CustomerDao();
	
		Customer customer = (Customer) session.getAttribute("loginedCustomer");
		
		
		CartDao cartDao = new CartDao();
		List<Cart> cartY = cartDao.searchCartByCustomerNoAndOutStatusY(customer.getCustomerNo());
		List<Cart> cartN = cartDao.searchCartByCustomerNoAndOutStatusN(customer.getCustomerNo());
		
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("MM월 dd일");
		String sd = sdf.format(date);
		
		int allPrice = 0;
		int allShippingPrice = 0;
		int allShippingCount = 0;
		int allShippingAmount = 0;
		int count=0;
		
		
		String status = customer.getCustomerStatus();
		
		StringUtils stringUtils = new StringUtils();
	%>
	
	<!-- 카트 본문  -->
	<div class="container">
		<!-- 헤더2  -->
		<div class="well">
			<h1><%=customer.getCustomerName() %>님의 장바구니 <small>주문하실 상품을 선택해주세요</small></h1>
		</div>
		<div class = "row">
			<!-- 절판된 상품 테이블 -->
			<%if(cartY.size() != 0) { %>
			<h3>절판된 상품 목록</h3>
			<table class="table table-bordered">
				<colgroup>
						<col width="40%">
						<col width="10%">
						<col width="35%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>상품정보</th>
							<th style="text-align: center;">판매가</th>
							<th style="text-align: center;"></th>
							<th style="text-align: center;">선택</th>
						</tr>
					</thead>
					<!-- 반복 시작 -->
					<tbody>
					<%
						for(Cart cart : cartY) {
					%>
							<tr>
								<td>
									<div class="col-xs-3">
										<img src="/silverstar/images/cover/<%=cart.getBookImage() %>" width="80" />
									</div>
									<div class="col-xs-9">
										<a style="text-decoration: none; color: black;" href="bookdetail.jsp?bookno=<%=cart.getBookNo()%>"><%=cart.getBookTitle() %></a>
									</div>
								</td>
								<td>
									<p style="text-align: center;"><small><del><%=stringUtils.numberWithComma(cart.getFixedPrice()) %></del></small></p>
									<p style="text-align: center;"><small><%=stringUtils.numberWithComma(cart.getSalePrice()) %>[<%=stringUtils.numberWithComma(cart.getDiscountRate())%>%↓]</small></p>
								</td>
								<td style="text-align: center;">
								<p>해당 도서는 절판되었습니다.</p>
								</td>
								<td  style="text-align: center;">
								<p><a href="cartdelete.jsp?bookno=<%=cart.getBookNo() %>" class="btn btn-default">삭제하기</a></p>
								</td>
							</tr>
					<%
						}
			}
			
					%>
					</tbody>
					<!-- 반복 끝 -->
			</table>
		</div>
		<!-- 상품목록 -->
		<div class="row">
		<h3>은성문고배송</h3>
		<span>
			<p class="text-right">
				<small>
				배송일정은 설정하신 지역을 기준으로 예상일이 노출되며 주문시 변경될 수 있습니다.
				</small>
			</p>
		</span>
		</div>
		<div class ="row">
		 	<!-- 배송목록 테이블  -->
		 	<form id="book-form" method="POST" action="orderview.jsp">
				<table class="table table-bordered">
					<colgroup>
						<col width="5">
						<col width="35%">
						<col width="10%">
						<col width="10%">
						<col width="10%">
						<col width="15%">
						<col width="15%">
					</colgroup>
					<thead>
						<tr>
							<th>
								<input type="checkbox" name="booklist" onclick="allSelectUnselect()" id="chbox"/>
							</th>
							<th>상품정보</th>
							<th style="text-align: center;">판매가</th>
							<th style="text-align: center;">수량</th>
							<th style="text-align: center;">합계</th>
							<th style="text-align: center;">배송일정</th>
							<th style="text-align: center;">선택</th>
						</tr>
					</thead>
					<tbody>
					<!-- 반복 시작 -->
					<%
					if(cartN.size() != 0) {
						allShippingPrice = 3000;
						for(Cart cart : cartN){
							int price = cart.getSalePrice() * cart.getBookQuantity();
							allPrice += price;
							allShippingCount += 1;
							allShippingAmount += cart.getBookQuantity();
							count+=1;
							allShippingPrice += 200*allShippingCount;
					%>
							<tr>
								<td>
									<input type="checkbox" id="chcek-<%=count%>" name="booksno" value="<%=cart.getBookNo() %>" />
								</td>
								<td>
									<div class="col-xs-3">
										<img src="/silverstar/images/cover/<%=cart.getBookImage() %>" width="80" />
									</div>
									<div class="col-xs-9">
										<a style="text-decoration: none; color: black;" href="bookdetail.jsp?bookno=<%=cart.getBookNo()%>"><%=cart.getBookTitle() %></a>
									</div>
								</td>
								<td>
									<p style="text-align: center;"><small><del><%=stringUtils.numberWithComma(cart.getFixedPrice()) %></del></small></p>
									<p style="text-align: center;"><small><%=stringUtils.numberWithComma(cart.getSalePrice()) %>[<%=stringUtils.numberWithComma(cart.getDiscountRate())%>%↓]</small></p>
								</td>
								<td>
								<input type="hidden" name="bookno" id="bookno-<%=count%>"value="<%=cart.getBookNo()%>" />
								<p style="text-align: center;"><input class="form-control" id="qty-<%=count %>" style="width:50px;"type="number" id="qty-" name="bookamount" value="<%=cart.getBookQuantity()%>"/></p>
								<p style="text-align: center;"><button id="btn-qty-<%=count %>" onclick="amountupdate(event);" class="btn btn-default btn-xs">변경</button><p>
								</td>
								<td>
									<p style="text-align: center;"><strong><%=stringUtils.numberWithComma(price) %>원</strong></p>
								</td>
								<td style="text-align: center;">
									<p><%=sd %></p>
									<p>도착 예정</p>
								</td>
								<td  style="text-align: center;">
								<p><a href="orderview.jsp?bookno=<%=cart.getBookNo()%>" class="btn btn-primary">바로구매</a></p>
								<p><a href="cartdelete.jsp?bookno=<%=cart.getBookNo() %>" class="btn btn-default">삭제하기</a></p>
								</td>
							</tr>
						<%
						}
					} else {
						%>
						<tr>
							<td colspan="7" style="text-align: center;">
							현재 장바구니에 상품이 존재하지 않습니다.
							</td>
						</tr>
						
						<%
					}
						%>
					<!-- 반복 끝 -->
					</tbody>
				</table>
			</form>
		</div>
		<!-- 가격 -->
		<%

		int lastPrice = allPrice + allShippingPrice;
		%>
		<div class="row">
			<table class="table table-bordered">
				<colgroup>
					<col width="4%">
					<col width="32%">
					<col width="32%">
					<col width="32%">
				</colgroup>
				<tr style="background-color: #D1B2FF;">
					<th rowspan="2"><h1>↓</h1></th>
					<th>상품금액/<%=allShippingCount %>종(<%=allShippingAmount %>개)</th>
					<th>배송비</th>
					<th>결제 예정금액</th>
				</tr>
				<tr>
					<td class="text-right"><span><%=stringUtils.numberWithComma(allPrice) %></span>원</td>
					<td class="text-right"><span><%=stringUtils.numberWithComma(allShippingPrice) %></span>원</td>
					<td class="text-right" style="color:red;"><span><%=stringUtils.numberWithComma(lastPrice) %></span>원</td>
				</tr>
				<tr>
					<td colspan="5" style="background-color: #ddd;"></td>
				</tr>
			</table>
		</div>
		<!-- 버튼 -->
		<div class="row" style="text-align: center;">
			<button onclick="goBack();" class="btn btn-default">쇼핑계속하기</button>
			<button class="btn btn-warning" onclick="checkedDeleteToCart()">선택상품 삭제하기</button>
			<button class="btn btn-success" onclick="addAllBooksToCart()">선택상품 주문하기</button>
			<a href="orderview.jsp" class="btn btn-primary">전체상품 주문하기</a>
		</div>
	</div>
	
	<%@ include file="../navigation/footer.jsp" %>
</body>
<script>

	function checkedDeleteToCart() {
		var checkbox = document.querySelectorAll("input[name='booksno']");
		var bookForm = document.getElementById("book-form");
		var isChecked = false;
		for(var i = 0; i<checkbox.length; i++) {
			var el = checkbox[i];
			if(el.checked) {
				var isChecked = true;
				
			}
		}
		if(isChecked == true) {
			bookForm.setAttribute("action","cartlistdelete.jsp");
			bookForm.submit();
		}
 	
		if(!isChecked){
			alert("하나이상 체크해주세요.");
			return;
		}
	}
	function amountupdate(event) {
		event.preventDefault();
		var qtybtnid = event.target.id;
		var qtynum = qtybtnid.replace("btn-qty-","");
		var qtyid = document.getElementById("qty-"+qtynum).value;
		var bookno= document.getElementById("bookno-"+qtynum).value;
		if(qtyid < 0) {
			alert("1권 이상 입력해주세요.");
			return;
		}
		location.href="bookamountupdate.jsp?bookno="+bookno+"&bookamount="+qtyid;
	}
	
	function goBack(){
        history.back();
    }
</script>
</html>