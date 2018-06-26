<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<style>
	th {
	background-color: silver;
	}
</style>
<script type="text/javascript">
	function tell() {
		
	}
</script>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>
<%
	if ("nullTitle".equals(request.getParameter("send"))) {
%>
		<div class="alert alert-danger">
			<strong>제목을 입력해주세요.</strong>
		</div>
<%
	} else if("nullContents".equals(request.getParameter("send"))) {
%>
		<div class="alert alert-danger">
			<strong>내용을 입력해주세요.</strong>
		</div>
<%
	}

	Customer customer = (Customer)session.getAttribute("loginedCustomer");
	
	String pno = request.getParameter("pno");
%>
<body>
	<%@ include file="../navigation/header.jsp" %>
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
<div class="container">
	<h1>1:1 상담</h1>
	<hr style="border: solid 1px black;" />
	<form class="form" action="addqna.jsp">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>이름</th>
					<td><input type="text" value="<%=customer.getCustomerName() %>" readonly="readonly" name="customer-name"></td>
					<th>ID</th>
					<td><input type="text" value="<%=customer.getCustomerId() %>" readonly="readonly" name="customer-id"></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="qna-title">
					</td>
				</tr>
				<tr>
					<th rowspan="10" style="text-align: center">
						내용
					</th>
					<td rowspan="10">
						<textarea rows="9" cols="100" name="qna-contents"></textarea>
					</td>
				</tr>
			</tbody>
		</table>
			<div class="col-sm-offset-10">
				<input type="submit" name="등록" class="btn btn-primary">
				<a href="qnaview.jsp?pno=<%=pno %>" class="btn btn-dfault">취소</a>
			</div>
	</form>
</div>
<%@ include file="../../navigation/footer.jsp" %>
</body>
</html>