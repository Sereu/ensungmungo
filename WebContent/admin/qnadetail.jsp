<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.qna.QnA"%>
<%@page import="silverstar.qna.QnADao"%>
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
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>
<body>
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
	<%
		String pno = request.getParameter("pno");
	
		int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
		QnADao qnADao = new QnADao();
		QnA qnA = qnADao.getQnAByNo(qnaNo);
		
		CustomerDao customerDao = new CustomerDao();
		Customer customer = customerDao.getCustomerByNo(qnA.getCustomerNo());
	%>
<div class="container">
	<h1>1:1 상담</h1>
	<hr style="border: solid 1px black;" />
	<form method="post" class="form" action="qnaanswer.jsp?pno=<%=pno%>&qnaNo=<%=qnaNo%>">
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" value="<%=qnA.getQnaTitle()%>" name="qna-title" readonly="readonly"></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><%=customer.getCustomerId() %></td>
					<th>날짜</th>
					<td><%=qnA.getStringQnaDate() %></td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th rowspan="10" style="text-align: center">
						내용
					</th>
					<td rowspan="10">
						<textarea rows="9" cols="100" readonly="readonly" name="qna-contents" ><%=qnA.getQnaContents() %></textarea>
					</td>
				</tr>
			</tbody>
		</table>
			<div class="col-sm-offset-10">
				<a href="qnaview.jsp?pno=<%=pno %>" class="btn btn-dfault">목록</a>
			</div>
	</form>

</div>
<%@ include file="../../navigation/footer.jsp" %>
</body>
</html>