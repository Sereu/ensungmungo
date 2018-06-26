<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.order.CustomerOrder"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="silverstar.order.MyOrder"%>
<%@page import="silverstar.order.OrderDao"%>
<%@page import="silverstar.customer.CustomerGrade"%>
<%@page import="silverstar.customer.CustomerDao"%>
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
	<%
		request.setCharacterEncoding("utf-8");
		Customer defaultcust = (Customer) session.getAttribute("loginedCustomer");
		CustomerDao custDao = new CustomerDao();
		Customer cust = custDao.getCustomerByNo(defaultcust.getCustomerNo());
		OrderDao orderDao = new OrderDao();
		
		final int rows = 5;
		int listno = 1;
		if(request.getParameter("listno")!=null)
			listno = Integer.parseInt(request.getParameter("listno"));
		int records = orderDao.getOneMonthOrders(cust.getCustomerNo());
		int pages = (int)Math.ceil((double)records/rows);
		int beginIndex = (listno-1)*rows+1;
		int endIndex = listno*rows;
	%>

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
	<div class="row">
		<div class="col-sm-3" >
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
					<tbody>
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
					</tbody>
				</table>	
			</form>
			<hr>
			<div>
			<h4><span class="glyphicon glyphicon-align-justify"></span> 나의 최근 주문 현황</h4><p>최근 1개월</p>
				<table class = "table" style="width: 750px;">
					<thead>
						<tr>
							<%
								
							%>
							<th class="text-center">주문번호</th>
							<th class="text-center">총 주문금액</th>
							<th class="text-center">총 수량</th>
							<th class="text-center">주문일</th>
							<th class="text-center">주문상태</th>
						</tr>
					</thead>
					<tbody>
					<%	
						HashMap<String, Object> param = new HashMap<>();
						param.put("custNo", cust.getCustomerNo());
						param.put("beginIndex", beginIndex);
						param.put("endIndex", endIndex);
						
						List<MyOrder> oneMonth = orderDao.getOneMonthRange(param);
						if(oneMonth==null){
					%>
						<tr>
							<td colspan="5" style="text-align: center;">최근 1개월간 주문한 내역이 없습니다.</td>
						</tr>
					<%
						} else{
							for(MyOrder order : oneMonth){
					%>
							<tr>
								<td><a href="myorderview.jsp?orderno=<%=order.getOrderNo() %>"><%=order.getOrderNo() %></a></td>
								<td><%=StringUtils.numberWithComma(order.getPrice()) %>원</td>
								<td><%=order.getQty() %></td>
								<td><%=order.getOrderDateFormat() %></td>
									<%
									if(order.getCnt() == 0){
									%>
										<td>주문완료</td>
									<%
									} else {
									%>
										<td>주문취소</td>
									<%
									}
									%>
							</tr>
					<%
							}
						}
					%>
					</tbody>
				</table>
				<div class="row" id="pagination" style="text-align: center;" >
			            <ul class="pagination">
			            <%
			            	for (int index=1; index <=pages; index++){
			            %>
			               <li class="<%=listno==index?"active":""%>"><a href="../customer/mypageview.jsp?listno=<%=index %>"><%=index %></a></li>
			            <% 
			            	}
			            %>
			              
			            </ul>
	  			 </div>
			</div>
			<hr>
			<h4>안내사항</h4>
			<div class="row">
			<form id="infor-form" class="well" style="width: 800px;">
				<div>
					<span class="label label-success">안내</span>  안내사항
					<ul>
						<li> 주문취소/구매내역 확인은 [구매내역] 상세페이지에서 가능합니다.</li>
						<li> 적립금은 현재 고객 등급별 적립률을 참고해 주시기 바랍니다.</li>
						<li> 회원정보 수정 및 비밀번호 변경은 [회원정보 수정] 상세페이지에서 가능합니다.</li>
					</ul>					
				</div>
			</form>
			</div>
		</div>
	</div>

</div>
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>
    