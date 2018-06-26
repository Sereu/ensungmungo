<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.order.OrderDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.CustomerGrade"%>
<%@page import="silverstar.cart.CartDao"%>
<%@page import="silverstar.cart.Cart"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
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
	<script>
	function recentAddress(el){
		event.preventDefault();
		var address = el.split(',');
		document.getElementById("recipient").value = address[0];
		
		document.getElementById("num1").value = address[1];
		document.getElementById("num2").value = address[2];
		document.getElementById("num3").value = address[3];
		
		document.getElementById("address1").value = address[4];
		document.getElementById("address2").value = address[5];
	}
	
	function customerAddress(name,num,address) {
		event.preventDefault();
		var nums = num.split('-');
		var addresses = address.split('/');
		document.getElementById("recipient").value = name;
		document.getElementById("num1").value = nums[0];
		document.getElementById("num2").value = nums[1];
		document.getElementById("num3").value = nums[2];
		document.getElementById("address1").value = addresses[0];
		document.getElementById("address2").value = addresses[1];
	}
	
	function checkObjects(){
		event.preventDefault();
		var dilivery1 = document.getElementById("dilivery1");
		var dilivery2 = document.getElementById("dilivery2");
		
		var recipient = document.getElementById("recipient");
		
		var num1 = document.getElementById("num1");
		var num2 = document.getElementById("num2");
		var num3 = document.getElementById("num3");
		
		var address1 = document.getElementById("address1");
		var address2 = document.getElementById("address2");
		
		var card1 = document.getElementById("card1");
		var card2 = document.getElementById("card2");
		var card3 = document.getElementById("card3");
		var simplepay1 = document.getElementById("simplepay1");
		var simplepay2 = document.getElementById("simplepay2");
		var simplepay3 = document.getElementById("simplepay3");
		var bank1 = document.getElementById("bank1");
		var bank2 = document.getElementById("bank2");
		var etc = document.getElementById("etc");

		var agree = document.getElementById("agree");
		
		if(dilivery1.checked == false && dilivery2.checked == false){
			alert("배송 정보를 선택하세요");
			dilivery1.focus();
			return;
		}
		if(recipient.value == ''){
			alert("받는 사람 이름을 입력하세요");
			recipient.focus();
			return;
		}
		if(num2.value == '' || num3.value == ''){
			alert("전화 번호를 입력하세요");
			num1.focus();
			return;
		}
		if(address1.value == '' || address2.value == ''){
			alert("주소를 입력하세요");
			address1.focus();
			return;
		}
		if(card1.checked == false && card2.checked == false && card3.checked == false &&
			simplepay1.checked == false && simplepay2.checked == false && simplepay3.checked == false &&
			bank1.checked == false && bank2.checked == false && etc.checked == false){
			alert("결제 방법을 선택하세요");
			card1.focus();
			return;
		}
		if(agree.checked == false){
			alert("모든 내용에 동의하시면 동의를 눌러주세요");
			agree.focus();
			return;
		}
		var orderform = document.getElementById("orderForm");
		orderform.submit();
	}
	
	</script>
	<%

		if(session.getAttribute("loginedCustomer") == null){
			response.sendRedirect("../customer/login.jsp");
			return;
		}	
		Customer cust = (Customer)session.getAttribute("loginedCustomer");
		CustomerDao customerDao = new CustomerDao();
		Customer customer = customerDao.getCustomerByNo(cust.getCustomerNo());
		List<Cart> carts = new ArrayList<>();
		CartDao cartDao = new CartDao();
		BookDao bookDao = new BookDao();
		int bookno = 0;
		
		if(request.getParameterValues("booksno") != null){
			String[] booksno = request.getParameterValues("booksno");
			for(int i=0; i<booksno.length; i++) {
				HashMap<String,Object> book = new HashMap<>();
				book.put("bookno",Integer.parseInt(booksno[i]));
				book.put("customerno",customer.getCustomerNo());
				Cart cart = cartDao.searchBookByCustomerNoAndOutStatusN(book);
				carts.add(cart);
			}
		} else if(request.getParameter("bookno") != null){
			bookno = Integer.parseInt(request.getParameter("bookno"));
			Book book = bookDao.bookSearchDetailByNo(bookno);
			if(book.getStock() == 0) {
				response.sendRedirect("http://localhost/silverstar/bookstore/bookdetail.jsp?bookno="+bookno+"&fail=soldout");
			}
			Cart cart = new Cart();
			cart.setBookNo(bookno);
			cart.setBookQuantity(1);
			cart.setBookImage(book.getImage());
			cart.setBookTitle(book.getTitle());
			cart.setDiscountRate(book.getDiscountRate());
			cart.setFixedPrice(book.getFixedPrice());
			cart.setCustNo(customer.getCustomerNo());
			carts.add(cart);
		} else{
		carts = cartDao.searchCartByCustomerNoAndOutStatusN(customer.getCustomerNo());
			if(carts.size() == 0){
				response.sendRedirect("cartview.jsp");
				return;
			}
		}
		
		int price = 0;
		int totalprice = 0;
		int addpoint = 0;
		int count = 0;
		int leftpoint = 0;
		
		String grade = customer.getCustomerGrade();
		CustomerDao custDao = new CustomerDao();
		CustomerGrade custgrade = custDao.getCustomerGrade(grade);		
		int pointRate = custgrade.getPointRate();
		
		OrderDao orderDao = new OrderDao();
		String recentAddress = orderDao.getRecentAddress(customer.getCustomerNo());
	%>
<div class="container" style="margin-top:60px">
	<div class="row">
		<div class="col-sm-7">
    		<span style="font-size:30px">주문/결제</span>
		</div>
	</div>
	<form action="order.jsp" method="post" id="orderForm" onsubmit="checkObjects()">
	<% if(request.getParameterValues("booksno") != null) {
		String[] booksno = request.getParameterValues("booksno");
		for(int i = 0; i < booksno.length; i++) {
	%>
	<input type="hidden" name="booksno" value=<%=booksno[i] %> >
	<%	} 
	   } else if(request.getParameter("bookno") != null) {%>
	<input type="hidden" name="bookno" value="<%=request.getParameter("bookno") %>" />
	<% } %>
	<div class="row">
	<h3><strong>01 주문 상품 목록</strong></h3>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
				<thead>
					<tr class="bg-info">
						<th colspan="2">상품정보</th>
						<th>판매가</th>
						<th>수량</th>
						<th>합계</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					<% for(Cart c : carts) {%>
					<tr>
						<td><img src="../images/<%=c.getBookImage() %>" width="100px" height="120px"/></td>
						<td><%=c.getBookTitle() %></td>
						<td><%=StringUtils.numberWithComma(c.getFixedPrice()) %>원 > <%=StringUtils.numberWithComma(c.getSalePrice()) %>원</td>
						<td><%=c.getBookQuantity() %></td>
						<td><%=StringUtils.numberWithComma(c.getSalePrice()*c.getBookQuantity()) %>원</td>
					</tr>
					<% 
						price += c.getSalePrice()*c.getBookQuantity();
						//addpoint += (c.getSalePrice()*pointRate/100)*c.getBookQuantity();
					   	count += c.getBookQuantity();
					} 
					%>
				</tbody>
			</table>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
				<thead>
					<tr class="bg-info">
						<th>상품금액/n개</th>
						<th>배송비</th>
						<th>결제 예정금액</th>
						<th>적립 예정금액</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><%=StringUtils.numberWithComma(price) %>원/<%=count %>개</td>
						<%int del = ((price < 30000) ? 3000: 0);%>
						<td><%=StringUtils.numberWithComma(del) %>원</td>
						<td><%=StringUtils.numberWithComma(price + del) %>원</td>
						<%addpoint = (price*pointRate)/100; %>
						<td><%=StringUtils.numberWithComma(addpoint)%>원</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div class="row">
	<h3><strong>02 배송지</strong></h3>
	</div>
	<div class="row">
		<div class="col-sm-12">
			<table class="table">
				<tbody>
					<tr>
						<td>주문자 정보</td>
						<td colspan="2"><%=customer.getCustomerName() %>| <%=customer.getCustomerTel() %></td>
					<tr>
						<td>배송방법</td>
						<td>	
							<input type="radio" id="dilivery1" name="dilivery" value="domestic"/><span>&nbsp;일반배송&nbsp;</span> 
							<input type="radio" id="dilivery2" name="dilivery" value="overseas"/><span>&nbsp;해외배송&nbsp;</span>
						</td>
					</tr>
					<tr>
						<td rowspan="5">배송지 정보</td>
						<td>
						<a href="#" class="btn btn-info" onclick="recentAddress('<%=recentAddress%>')">최근 배송지</a>
						<a href="#" class="btn btn-info" onclick="customerAddress('<%=customer.getCustomerName()%>','<%=customer.getCustomerTel() %>','<%=customer.getCustomerAddress()%>')">회원정보 동일</a>
						</td>
					</tr>
					<tr>
						<td>
						<label>받는이 | </label>
						<input type="text" id="recipient" name="recipient"/><span></span>
						</td>
					</tr>
					<tr>
						<td>
						<label>휴대폰 번호 | </label>
						<select name="num1" id="num1">
							<option value="010">010</option>
							<option value="011">011</option>
						</select>
						&nbsp;-&nbsp;<input type="number" id="num2" name="num2"/>&nbsp;-&nbsp;<input type="number" id="num3" name="num3"/>
						</td>
					</tr>
					<tr>
						<td>
						<label>주소 | </label>
						<input type="text" id="address1" name="address1"/>&nbsp;&nbsp;<button class="btn btn-info" onclick="sample4_execDaumPostcode()">우편번호</button>
						</td>
					<tr>
						<td>
						<label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</label>
						<input type="text" id="address2" name="address2" size="66px"/>
						</td>
					</tr>
				</tbody>
			</table>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
    	event.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('address1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('address2').value = fullRoadAddr + data.jibunAddress;
            }
        }).open();
    }
</script>			
		</div>
	</div>
	
	<div class="row">
	<h3><strong>03 할인/적립</strong></h3>
	</div>
	<div class="row">
		<table class="table">
			<tbody>
				<tr>
					<td>사용 마일리지</td>
					<% int usepoint = customer.getCustomerPoint(); 
					   if( usepoint > price) {
						   leftpoint = usepoint - price;
						   usepoint = price;
					   }
					%>
					<td><%=StringUtils.numberWithComma(usepoint) %>원(<%=StringUtils.numberWithComma(leftpoint) %>원 남음)</td>
				</tr>
				<tr>
					<td>적립 마일리지</td>
					<td><%=StringUtils.numberWithComma(addpoint)%>원</td>
				</tr>
			</tbody>
		</table>
	</div>
	
	<div class="row">
	<h3><strong>04 결제정보</strong></h3>
	</div>
	<div class="row">
		<div class="col-sm-9">
			<table class="table">
				<tbody>
					<tr>
						<td>신용카드</td>
						<td>
							<input type="radio" name="pay" value="credit1" id="card1"/><span>&nbsp;신용카드&nbsp;</span> 
							<input type="radio" name="pay" value="credit2" id="card2"/><span>&nbsp;제휴전용카드&nbsp;</span> 
							<input type="radio" name="pay" value="credit3" id="card3"/><span>&nbsp;해외발급신용카드&nbsp;</span> 
						</td>
					</tr>
					<tr>
						<td>간편결제</td>
						<td>
							<input type="radio" name="pay" value="kakaopay" id="simplepay1"/><span>&nbsp;카카오페이&nbsp;</span> 
							<input type="radio" name="pay" value="paynow" id="simplepay2"/><span>&nbsp;페이나우&nbsp;</span> 
							<input type="radio" name="pay" value="naverpay" id="simplepay3"/><span>&nbsp;네이버페이&nbsp;</span> 
						</td>
					</tr>
					<tr>
						<td>현금결제</td>
						<td>
							<input type="radio" name="pay" value="bank" id="bank1"/><span>&nbsp;실시간 계좌이체&nbsp;</span> 
							<input type="radio" name="pay" value="online" id="bank2"/><span>&nbsp;온라인 송금&nbsp;</span> 
						</td>
					</tr>
					<tr>
						<td>기타결제</td>
						<td>
							<input type="radio" name="pay" value="phone" id="etc"/><span>&nbsp;휴대폰결제&nbsp;</span> 
						</td>
					</tr>
				</tbody>
			</table>				
		</div>
		<div class="col-sm-3">
			<ul class="list-group">
				<li class="list-group-item list-group-item-info">상품금액<span style="float:right"><%=StringUtils.numberWithComma(price) %>원</span></li>
				<li class="list-group-item list-group-item-info">배송비<span style="float:right"><%=StringUtils.numberWithComma(del) %>원</span></li>
				<li class="list-group-item list-group-item-info">차감마일리지<span style="float:right"><%=StringUtils.numberWithComma(usepoint) %>원</span></li>
				<%totalprice = price + del - usepoint; %>
				<li class="list-group-item list-group-item-info">최종 결제금액<span style="float:right; color:red"><%=StringUtils.numberWithComma(totalprice) %><strong>원</strong></span></li>
				<li class="list-group-item list-group-item-info list-group-item-right"><input type="radio" id="agree"/>&nbsp;내역에 동의하십니까?</li>
			</ul>
			
		<input type="hidden" name="addpoint" value="<%=addpoint %>"/>
		<input type="hidden" name="usepoint" value="<%=usepoint %>"/>
		<input type="hidden" name="leftpoint" value="<%=leftpoint %>"/>
		<input type="hidden" name="totalprice" value="<%=totalprice %>"/>
		</div>
	</div>

	<div class="row">
		<div class="col-sm-2 col-sm-offset-4">
			<input type="submit" class="btn btn-lg btn-block btn-primary" value="결제하기"/>
		</div>
		<div class="col-sm-2">
			<a href="cartview.jsp" class="btn btn-lg btn-block btn-info">장바구니 가기</a>
		</div>
	</div>
	</form>
</div>
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>