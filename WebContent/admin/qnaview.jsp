<%@page import="silverstar.qna.QnaAsk"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.qna.QnA"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.qna.QnADao"%>
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
</head>
<body>
<%
	if(session.getAttribute("loginedAdmin") == null) {
		response.sendRedirect("adminloginview.jsp");
		return;
	}
%>
<%
	QnADao qnaDao = new QnADao();
	
	final int rows = 5;
	int records = qnaDao.getAllCounts();
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	
	List<QnA> qnAs = qnaDao.getQnAsByRange(param);
%>
	<%@ include file="header.jsp" %>
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
	<div class="row">

	<h1>회원문의 리스트</h1>
		<form method="post" action="qnabycustid.jsp" onsubmit="searchQnAById(event)" id="searchQnA">
		<input type="hidden" value="1" name="pno" id="pno-field">
		<p>ID로 회원조회 :</p><input type="text" name="customerId" id="customerId"><input type="submit" value="검색">
		</form>
		<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>제목</th>
				<th>날짜</th>
				<th colspan="2">비고</th>
			</tr>
		</thead>
		<tbody id="qna-box"></tbody>
		</table>
		<div class="text-center">
			<ul class="pagination" id="navi">
				
			</ul>
		</div>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>제목</th>
				<th>날짜</th>
				<th colspan="2">비고</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(QnA qna : qnAs) {
				CustomerDao customerDao = new CustomerDao();
				Customer customer = customerDao.getCustomerByNo(qna.getCustomerNo());
				QnaAsk qnaAsk = qnaDao.getQnaAskByNo(qna.getQnaNo());
		%>
			<tr>
				<td><%=qna.getQnaNo() %></td>
				<td><%=customer.getCustomerId() %></td>
				<td><a href="qnadetail.jsp?pno=<%=currentPage%>&qnaNo=<%=qna.getQnaNo()%>"><%=qna.getQnaTitle() %></a></td>
				<td><%=qna.getStringQnaDate() %></td>
		<% 
				if(qnaAsk == null) {
		%>			
					<td colspan="2"><a href="qnaanswer.jsp?pno=<%=currentPage%>&qnaNo=<%=qna.getQnaNo()%>" class="btn btn-primary">답변</a></td>
		<%
				} else {
		%>
					<td><button class="btn btn-primary" disabled="disabled" style="size: 2">답변완료</button></td>
					<td><a href="qnaanswerupdate.jsp?pno=<%=currentPage%>&qnaNo=<%=qna.getQnaNo()%>" class="btn btn-warning" style="size: 2">수정</a></td>
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
				<li class="<%=currentPage==index ? "active":""%>"><a href="qnaview.jsp?pno=<%=index%>"><%=index %></a></li>
		<%	
			}
		%>
		</ul>
	</div>
	
	</div>
</div>
<%@ include file="../../navigation/footer.jsp" %>
<script type="text/javascript">
	function searchQnAById(event, pno) {
		event.preventDefault();
		
		if(pno) {
			document.getElementById("pno-field").value = pno;
		}
		
		var xhr = new XMLHttpRequest();
		var custId = document.getElementById("customerId").value;
		var pno = document.getElementById("pno-field").value;
		
		xhr.onreadystatechange = function() {
			if (xhr.readyState == 4 && xhr.status == 200) {
				var jsonData = xhr.responseText;
				var data = JSON.parse(jsonData);
				var qnas = data.qnas;
				var pages = data.pages;
				
				for(var i=0; i<qnas.length; i++) {
				var row = "";
					var qna = qnas[i];
					
					row += "<tr>";
					row += "<td>"+qna.qnaNo+"</td>";
					row += "<td>"+custId+"</td>";
					row += "<td><a href='qnadetail.jsp?pno="+<%=currentPage%>+"&qnaNo="+qna.qnaNo+"'>"+qna.qnaTitle+"</a></td>";
					row += "<td>"+qna.qnaDate+"</td>";
					
					if(qna.qnaContents == "N") {
						row += "<td colspan='2'><a href='qnaanswer.jsp?pno="+<%=currentPage%>+"&qnaNo="+qna.qnaNo+"' class='btn btn-primary'>답변</a></td>";
					} else {
						row += "<td><button class='btn btn-primary' disabled='disabled' style='size: 2'>답변완료</button></td>";
						row += "<td><a href='qnaanswerupdate.jsp?pno='"+<%=currentPage%>+"&qnaNo="+qna.qnaNo+" class='btn btn-warning' style='size: 2'>수정</a></td>";
					}
					row += "</tr>";
				
				}
				
				var rows= "";
				for(var j=1; j<=pages; j++) {
					rows += "<li><a href='#' onclick='searchQnAById(event, "+j+")'>"+j+"</a></li>"
				}
				document.getElementById("qna-box").innerHTML = row;
				document.getElementById("navi").innerHTML = rows;
			}
		
		}
		xhr.open("GET", "qnabycustid.jsp?custId="+custId+"&pno="+pno);
		xhr.send();
	}
</script>
</body>
</html>