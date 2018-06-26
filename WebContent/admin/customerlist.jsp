<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%
	if(session.getAttribute("loginedAdmin") == null) {
		response.sendRedirect("adminloginview.jsp");
		return;
	}
%>
<%
	CustomerDao customerDao = new CustomerDao();

	final int rows = 10;
	int records = customerDao.getAllCountsCustomer();
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	
	List<Customer> customers = customerDao.getCustomersByRange(param);
%>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<%@ include file="header.jsp" %>
<div class="container">
	<div class="row">
	
	<h1>아이디로 고객 찾기</h1>
	<input type="text" id="customerId"><button onclick="getCustomer()">검색</button>
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>상태</th>
				<th></th>
			</tr>
		</thead>
		<tbody id="customer-box">
		</tbody>
	</table>
	
	<h1>고객 관리</h1>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>이름</th>
				<th>상태</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<%
			for(Customer customer : customers) {
		%>
				<tr>
					<td><%=customer.getCustomerNo() %></td>
					<td><%=customer.getCustomerId() %></td>
					<td><%=customer.getCustomerName() %></td>
					<%
						if("Y".equals(customer.getCustomerStatus())) {
					%>
							<td>
								<button class="btn btn-primary">정상</button>
							</td>
							<td>
								<a href="deletecustomer.jsp?custNo=<%=customer.getCustomerNo() %>&pno=<%=currentPage %>&try=delete" class="btn btn-primary">탈퇴처리</a>
							</td>
					<%
						} else if("N".equals(customer.getCustomerStatus())) {
					%>		
							<td>
								<button class="btn btn-warning">탈퇴</button>
							</td>
							<td>
								<a href="deletecustomer.jsp?custNo=<%=customer.getCustomerNo() %>&pno=<%=currentPage %>&try=cancel" class="btn btn-warning">되돌리기</a>
							</td>
					<%
						}
					%>
				</tr>
		<%
			}
		%>
		</tbody>
	</table>
	
	<div class="text-center">
		<ul class="pagination">
		<%
			for(int index = 1; index <=pages; index++) {
		%>
				<li class="<%=currentPage==index ? "active":""%>"><a href="customerlist.jsp?pno=<%=index%>"><%=index %></a></li>
		<%	
			}
		%>
		</ul>
	</div>
	
	</div>
</div>
<script type="text/javascript">
	function getCustomer() {
		var xhr = new XMLHttpRequest();
		var custId = document.getElementById("customerId").value;
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var jsonData = xhr.responseText;

				var customer = JSON.parse(jsonData);
				
				var row ="<tr>";
				row += "<td>"+customer.customerNo+"</td>";
				row += "<td>"+customer.customerId+"</td>";
				row += "<td>"+customer.customerName+"</td>";
				if (customer.customerStatus == "Y") {
					row += "<td><button class='btn btn-primary'>정상</button></td>";
					row += "<td><a href=deletecustomer.jsp?custNo="+customer.customerNo+"&try=delete class='btn btn-primary'>탈퇴처리</a></td>";
				} else {
					row += "<td><button class='btn btn-warning'>탈퇴</button></td>"
					row += "<td><a href=deletecustomer.jsp?custNo="+customer.customerNo+"&try=cancel class='btn btn-warning'>되돌리기</a></td>";
				}
				row += "</tr>";
				
				document.getElementById("customer-box").innerHTML = row;
			}
		}
		
		xhr.open("GET", "searchcustomer.jsp?custId=" + custId);
		xhr.send();
	}
</script>
</body>
</html>