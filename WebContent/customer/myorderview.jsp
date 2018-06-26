<%@page import="silverstar.utils.StringUtils"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.CustomerGrade"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.order.OrderDetail"%>
<%@page import="silverstar.order.OrderDao"%>
<%@page import="silverstar.order.BookOrder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>silverstar</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  .container {
  	min-width: 1080px;
  }
  </style>
</head>
<body>
	<%@ include file="../navigation/header.jsp" %>
	<%@ include file="../navigation/recentbookview.jsp" %>
	<script type="text/javascript">
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
<div class="container" style="margin-top:60px">
	<div class="row">
		<div class="col-sm-7">
    		<span style="font-size:30px">주문 상세 정보</span>
		</div>
	</div>
	<%
	int orderno= Integer.parseInt(request.getParameter("orderno"));
	OrderDao orderDao = new OrderDao();
	List<BookOrder> bookOrders = orderDao.getOrderBook(orderno);
	OrderDetail orderDetail = orderDao.getOrderDetail(orderno);
	BookDao bookDao = new BookDao();
	CustomerDao custDao = new CustomerDao();
	Customer defaultcustomer = (Customer)session.getAttribute("loginedCustomer");
	Customer customer = custDao.getCustomerByNo(defaultcustomer.getCustomerNo());
	String status = "Y";
	%>
	<div class="row">
	<h3><strong>01 주문 상품 목록</strong></h3>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
				<thead>
					<tr class="bg-info">
						<th colspan="2">상품정보</th>
						<th>수량</th>
					</tr>
				</thead>
				<tbody>
				<% for(BookOrder bookOrder : bookOrders){ 
					status = bookOrder.getStatus();
					Book book = bookDao.bookSearchDetailByNo(bookOrder.getBookNo());
				%>
					<tr>
						<td><img src="../images/<%=book.getImage() %>" width="100px" height="120px"/></td>
						<td><%=book.getTitle() %></td>
						<td><%=bookOrder.getOrderQuantity() %></td>
					</tr>
					<% }%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
				<thead>
					<tr class="bg-info">
						<th>상품금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=StringUtils.numberWithComma(orderDetail.getPrice()) %>원</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row">
	<h3><strong>02 추가 정보</strong></h3>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
			<%
			   String[] address = orderDetail.getAddress().split(",");
			%>
				<tbody>
					<tr>
						<td rowspan="5">배송지 정보</td>
					</tr>
					<tr>
						<td>
						<label>받는이 | </label>
						<%=address[0] %>
						</td>
					</tr>
					<tr>
						<td>
						<label>휴대폰 번호 | </label>
						<%=address[1] %>-<%=address[2] %>-<%=address[3] %>
						</td>
					</tr>
					<tr>
						<td>
						<label>우편번호 | </label>
						<%=address[4] %>
						</td>
					</tr>
					<tr>
						<td>
						<label>주소 | </label>
						<%=address[5] %>
						</td>
					</tr>
					<tr>
						<td>지불 정보</td>
						<td><%=orderDetail.getPayment() %></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row">
	<h3><strong>03 포인트 정산</strong></h3>
	</div>
	<form action="deleteorder.jsp"method="post">
	<div class="row">
		<table class="table">
			<tbody>
				<%
					String grade = customer.getCustomerGrade();
					CustomerGrade custgrade = custDao.getCustomerGrade(grade);		
					int pointRate = custgrade.getPointRate();
					
					int customerpoint = customer.getCustomerPoint(); 
					int price = orderDetail.getPrice();
					int usedpoint = orderDetail.getPoint();
					int cancelpoint = orderDetail.getCancelpoint();
				%>
				<tr>
					<td>환불액</td>
					<td><%=StringUtils.numberWithComma(orderDetail.getPrice()) %>원</td>
					<td>현재 포인트</td>
					<td><%=StringUtils.numberWithComma(customerpoint) %>원</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>차감 포인트</td>
					<%
					if(customerpoint < (cancelpoint - usedpoint)) {
						price = price - customerpoint - cancelpoint + usedpoint;
						customerpoint = 0;
					}
					else{
						customerpoint =  customerpoint + usedpoint - cancelpoint;
					}
					%>
					<td><%=StringUtils.numberWithComma(cancelpoint) %>원</td>
				</tr>
				<tr>
					<td></td>
					<td></td>
					<td>돌려주는 포인트</td>
					<td><%=StringUtils.numberWithComma(usedpoint) %>원</td>
				</tr>
				<tr>
					<td>최종환불가격</td>
					<td><%=StringUtils.numberWithComma(price) %>원</td>
					<td>최종포인트</td>
					<td><%=StringUtils.numberWithComma(customerpoint) %>원</td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="price" value="<%=price%>">
		<input type="hidden" name="customerpoint" value="<%=customerpoint%>">
		<input type="hidden" name="orderno" value="<%=orderno%>">
	</div>

	<div class="row">
		<div class="col-sm-2 col-sm-offset-4">
			<a href="myorderlist.jsp" class="btn btn-lg btn-block btn-primary">목록으로</a>
		</div>
		<div class="col-sm-2">
			<% if("Y".equals(status)){ %>
			<input type="submit" class="btn btn-lg btn-block btn-info" value="주문취소"/>
			<%} else { %>
			<input type="button" class="btn btn-lg btn-block btn-info" disabled="disabled" value="취소완료"/>
			<%} %>
		</div>
	</div>
	</form>
</div>
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>