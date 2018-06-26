<%@page import="silverstar.qna.QnaAsk"%>
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
  <script type="text/javascript">
  	function updateqna() {
		document.getElementById("sort").value = "update";
	}
  	function deleteqna() {
		document.getElementById("sort").value = "delete";
	}
  </script>
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
<div class="container">
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
	} else if("nullPw".equals(request.getParameter("send"))) {
%>
		<div class="alert alert-danger">
			<strong>비밀번호를 입력해주세요.</strong>
		</div>
<%
	} else if("differentPw".equals(request.getParameter("send"))) {
%>
		<div class="alert alert-danger">
			<strong>비밀번호가 옳지 않습니다.</strong>
		</div>
<%
	}
%>
	<h1>1:1 상담</h1>
	<hr style="border: solid 1px black;" />
	<form class="form" action="updateqna.jsp">
		<table class="table table-bordered">
			<tbody>
			
				<tr>
					<th>제목</th>
					<td><input type="text" name="qna-title" value="<%=qnA.getQnaTitle()%>"></td>
					<th>비밀번호</th>
					<td><input type="password" name="customer-pw" /></td>
				</tr>
				<tr>
					<th>아이디</th>
					<td><input type="text" readonly="readonly" name="customer-id" value="<%=customer.getCustomerId() %>"></td>
					<th>날짜</th>
					<td><%=qnA.getStringQnaDate() %></td>
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
						<textarea rows="9" cols="100" name="qna-contents" ><%=qnA.getQnaContents() %></textarea>
						<div>
							<input type="hidden" name="pno" value="<%=pno%>">
							<input type="hidden" name="qnaNo" value="<%=qnaNo%>">
							<input type="hidden" name="sort" id="sort">
						</div>
					</td>
				</tr>
			</tbody>
		</table>
			<div class="col-sm-offset-9">

				<input type="submit" value="수정" class="btn btn-primary" onclick="updateqna()" >
				<input type="submit" value="삭제" class="btn btn-primary" onclick="deleteqna()">
				<a href="qnadetail.jsp?pno=<%=pno %>&qnaNo=<%=qnaNo %>" class="btn btn-default">취소</a>
			</div>
	</form>
</div>
<%@ include file="../../navigation/footer.jsp" %>
</body>
</html>