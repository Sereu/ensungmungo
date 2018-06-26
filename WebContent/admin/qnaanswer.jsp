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
<script type="text/javascript">
	function checkInputField(event) {
		event.preventDefault();
		
		var titleField = document.getElementById("qna-ask-title");
		var contentsField = document.getElementById("qna-ask-contents");
		
		var title = titleField.value;
		if(title ==""){
			alert("제목을 입력해주세요.");
			titleField.focus();
			return;
		}
		
		var contents = contentsField.value;
		if(contents ==""){
			alert("내용을 입력해주세요.");
			contentsField.focus();
			return;
		}
		
		var answer = document.getElementById("answer");
		answer.submit();
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
<body>
<%
	String pno = request.getParameter("pno");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	
	QnADao qnADao = new QnADao();
	CustomerDao customerDao = new CustomerDao();
	
	QnA qnA = qnADao.getQnAByNo(qnaNo);
	Customer customer = customerDao.getCustomerByNo(qnA.getCustomerNo());
	
%>
<div class="container">
<%@ include file="header.jsp" %>
	<h1>문의 답변</h1>
	<hr style="border: solid 1px black;" />
	<form class="form" method="post" action="qnaask.jsp" id="answer" onsubmit="checkInputField(event)">
		<table class="table table-bordered">
			<tbody>
			
				<tr>
					<th>제목</th>
					<td colspan="3"><input type="text" name="qna-ask-title" id="qna-ask-title"></td>
				</tr>
				<tr>
					<th>회원아이디</th>
					<td><%=customer.getCustomerId() %></td>
					<th>문의번호</th>
					<td>
						<input type="text" name="qnaNo" value="<%=qnA.getQnaNo()%>" readonly="readonly">
						<input type="hidden" name="pno" value="<%=pno%>">
					</td>
				</tr>
			</tbody>
		</table>
		<br>
		<table class="table table-bordered">
			<tbody>
				<tr>
					<th rowspan="10">
						내용
					</th>
					<td rowspan="10">
						<textarea rows="9" cols="100" name="qna-ask-contents" id="qna-ask-contents" ></textarea>
					</td>
				</tr>
			</tbody>
		</table>
			<div class="col-sm-offset-10">
				<input type="submit" value="답변" class="btn btn-primary">
				<a href="qnaview.jsp?pno=<%=pno%>" class="btn btn-warning">취소</a>
			</div>
	</form>
<%@ include file="../navigation/footer.jsp" %>
</div>
</body>

</html>