<%@page import="java.util.Date"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.order.OrderDao"%>
<%@page import="silverstar.customer.CustomerGrade"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>
<style>
	
	th, td {
		border: 1px;
		border-left: none;
		border-right: none;
		padding:8px;
		text-align:center;
	}
	tr {
		background-color:white;
		text-align:center;
	}
	.column {
            padding:20px;
            width: 270px;
    }
    .menu ul, .aside ul {
            list-style-type: none;
            margin=0;
            padding=0;
            text-align:center;
    }
    .menu li, .aside li{
            padding: 8px;
            margin-bottom: 8px;
            background-color: cornflowerblue;
            color: white;
            text-align:center;
    } 
</style>
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
<div class="container" style="min-width:1080px; margin-top: 10px;">
<%
		request.setCharacterEncoding("utf-8");
		Customer defaultcust = (Customer) session.getAttribute("loginedCustomer");
		CustomerDao custDao = new CustomerDao();
		Customer cust = custDao.getCustomerByNo(defaultcust.getCustomerNo());
		OrderDao orderDao = new OrderDao();
%>
	<div class="row">
		<div class="col-sm-3">
			<div class="column menu">
				<ul>
					<h2>마이룸</h2>
					<li><a href="myorderlist.jsp">구매내역 관리</a></li>
					<li><a href="../bookstore/cartview.jsp">장바구니</a></li>
					<li><a href="updatemyinfo.jsp">회원정보 수정</a></li>
					<li><a href="reconfirmpwd.jsp">회원 탈퇴</a></li>
				</ul>
			</div>	
		</div>
		<div class="col-sm-9">
			<h4><span class="glyphicon glyphicon-tower"></span> 나의 등급 현황</h4>
			<form id="grade-form" class="well">
				<table style="width: 750px; border-right:none; border-left:none; text-align: center;">
					<tr>
							<th rowspan="2">
								<p>현재등급</p>
								<%
									String grade = cust.getCustomerGrade();
									CustomerGrade custgrade = custDao.getCustomerGrade(grade);
								%>
								<img src="../images/<%=custgrade.getImage() %>" width="90" height="80" />
								<p>포인트 : <%=cust.getCustomerPoint() %>p</p>
							</th>
							<th>
								<img src="../images/grade.JPG" width="600" height="150" />
								
							</th>
						</tr>
				</table>	
			</form>
			<hr>
			<h4><span class="glyphicon glyphicon-list-alt"></span> 구매내역 조회</h4>
			<div>
			<form id="search-form" method="post" action="myordersearch.jsp" onsubmit="searchOrders(event);">
			<table class = "table" style="width: 750px;">
				<tbody>
						<tr>
							<th style="width: 100px; height: 40px; text-align: center;">기간조회</th>
							<td id="date-search">
								<button onclick="oneWeek(event);">1주일</button>
								<button onclick="oneMonth(event);">1개월</button>
								<button onclick="threeMonth(event);">3개월</button>
								<input type="date" name="from" id="from-date-field" style="width: 140px; height: 25px;" value=""/> <span class="glyphicon glyphicon-calendar"></span>
								 ~ 
								<input type="date" name="end" id="end-date-field" style="width: 140px; height: 25px;" value="" /> <span class="glyphicon glyphicon-calendar"></span>
							</td>
							<td rowspan="2" class="text-center" style="width:80px;">
								<input name="mypno" type="hidden" value="1" id="mypno-field"/>
								<input type="submit" class="btn btn btn-default"  id="search-field" style="width: 75px; height: 60px;" value="조회" />
							</td>
						</tr>
						<tr>
							<th style="width: 100px; height: 40px; text-align: center;">상품조회</th>
							<td><input style="width: 470px; height: 25px;" class="text" name="bookname" id="bookname-field" placeholder="상품명을 입력하세요"/></td>
						</tr>
				</tbody>
			</table>
			</form>
			<table class = "table" style="width: 750px;" id="orderList-table">
					<thead>
						<tr>
							<th style="text-align: center;">주문번호</th>
							<th style="text-align: center;">주문일</th>
							<th style="text-align: center;"></th>
							<th style="text-align: center; width: 40%;">상품명</th>
							<th style="text-align: center;">수량</th>
							<th style="text-align: center;">주문금액</th>
							<th style="text-align: center;">주문상태</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
			<div class="row" id="pagination" style="text-align: center;" >
		            <ul class="pagination" id="navi-field">
		            </ul>
  			 </div>
		</div>
		<div class="col-sm-1">
		
		</div>
	</div>
	<%@ include file="../navigation/footer.jsp" %>
</div>
</body>
<script type="text/javascript">
	function getStringDate(d) {
	    var year = d.getFullYear();
	    var month = d.getMonth() + 1;
	    month = (month<10 ? "0" + month : month);
	    var date = d.getDate();
	    date = (date<10 ? "0" + date : date);
	
	    var dateText = year + "-" + month + "-" + date;
	    return dateText;
	}
	var today = new Date();
    var dateText = getStringDate(today);
    
	document.getElementById("from-date-field").value = dateText;
	document.getElementById("end-date-field").value = dateText;
	
	function oneWeek(e) {
		e.preventDefault();
		var fromDate = new Date();
		var endDate = new Date();
		
		fromDate.setDate(endDate.getDate() -7);
	        
        var fromText = getStringDate(fromDate);
        var endText = getStringDate(endDate);
        
        document.getElementById("from-date-field").value = fromText;
        document.getElementById("end-date-field").value = endText;
	}
	function oneMonth(e) {
		e.preventDefault();
		var fromDate = new Date();
        var endDate = new Date();
        
        fromDate.setMonth(endDate.getMonth() -1); 
        
        var fromText = getStringDate(fromDate);
        var endText = getStringDate(endDate);
        
        document.getElementById("from-date-field").value = fromText;
        document.getElementById("end-date-field").value = endText;
	}
	function threeMonth(e){
		e.preventDefault();
		var fromDate = new Date();
        var endDate = new Date();
        
        fromDate.setMonth(endDate.getMonth() -3); 
        
        var fromText = getStringDate(fromDate);
        var endText = getStringDate(endDate);
        
        document.getElementById("from-date-field").value = fromText;
        document.getElementById("end-date-field").value = endText;
	}
	function getStringDate(d) {
		
        var year = d.getFullYear();
        var month = d.getMonth() + 1;
        month = (month<10 ? "0" + month : month);
        var date = d.getDate();
        date = (date<10 ? "0" + date : date);

        var dateText = year + "-" + month + "-" + date;
        return dateText;
    }
	function searchOrders(e, mypno) {
		e.preventDefault();
		var from = document.getElementById("from-date-field").value;
		var end = document.getElementById("end-date-field").value;
		var bookname = document.getElementById("bookname-field").value;
		if(mypno){
			document.getElementById("mypno-field").value = mypno;
		}
		var mypno = document.getElementById("mypno-field").value;
		
		var xhr = new XMLHttpRequest();
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
			var jsonText = xhr.responseText;
			var data = JSON.parse(jsonText);
			
			var navi = "";
			var totalPage = data.totalPages;
				for (var i=1; i<=totalPage; i++){
					navi += "<li><a href='#' onclick='searchOrders(event, "+i+")'>"+i+"</a></li>";
				}
			
			
			var rows ="";
			var myOrders = data.myOrders;
				for (var j=0; j<myOrders.length; j++){
					var orderNo = myOrders[j];
					
					rows +="<tr style='text-align: center;'>";
					rows +="<td><a href='myorderview.jsp?orderno="+orderNo.orderNo+"'>"+orderNo.orderNo+"</a></td>"
					rows +="<td>"+orderNo.orderDate+"</td>"
					rows +="<td><a href='../bookstore/bookdetail.jsp?bookno="+orderNo.bookNo+"'><img src='../images/"+orderNo.image+"'width='70' height='60'></a></td>";
					rows +="<td>"+orderNo.title+"</td>"
					rows +="<td>"+orderNo.qty+"</td>"
					rows +="<td>"+numberWithCommas((orderNo.price-orderNo.price*(orderNo.discount)/100)*orderNo.qty)+"원</td>"
					rows +="<td>"+orderNo.orderStatus+"</td>"
					rows +="</tr>";
				}
			document.querySelector("#orderList-table tbody").innerHTML = rows;
			document.getElementById("navi-field").innerHTML = navi;
				
			}
		}
		xhr.open("POST", "myordersearch.jsp");
		xhr.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
		xhr.send("from=" + from + "&end=" + end +"&bookname=" + bookname +"&mypno="+mypno);
	}
	function numberWithCommas(x) {
	    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	}	
</script>
</html>
    