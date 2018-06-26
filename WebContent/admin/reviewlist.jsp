<%@page import="silverstar.review.ReviewCustomer"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.review.ReviewDao"%>
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
	ReviewDao reviewDao = new ReviewDao();
	
	final int rows = 5;
	int records = reviewDao.getAllReviewCnt();
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	
	List<ReviewCustomer> reviewCustomers = reviewDao.getAllReviewRange(param);
%>
	<%@ include file="header.jsp" %>
<div class="container">
	<div class="row">

	<h1>회원리뷰 리스트</h1>
		<form method="post" action="searchreview.jsp" onsubmit="searchrv(event)" id="searchQnA">
		<input type="hidden" value="1" name="pno" id="pno-field">
		<p>ID로 회원조회 :</p><input type="text" name="customerId" id="customerId"><input type="submit" value="검색">
		</form>
		<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th>내용</th>
				<th>날짜</th>
				<th>평점</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody id="review-box"></tbody>
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
				<th>내용</th>
				<th>날짜</th>
				<th>평점</th>
				<th>비고</th>
			</tr>
		</thead>
		<tbody>
		<%
			for(ReviewCustomer rc : reviewCustomers) {

		%>
			<tr>
				<td><%=rc.getReviewNo() %></td>
				<td><%=rc.getCustId() %></td>
				<td><%=rc.getContents() %></td>
				<td><%=rc.getReviewDateFormat() %></td>
				<td><%=rc.getStar() %></td>
				<td><a class="btn btn-warning" href="delreview.jsp?reviewNo=<%=rc.getReviewNo() %>">삭제</a></td>
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
				<li class="<%=currentPage==index ? "active":""%>"><a href="reviewlist.jsp?pno=<%=index%>"><%=index %></a></li>
		<%
			}
		%>
		</ul>
	</div>
	
	</div>
</div>
<%@ include file="../../navigation/footer.jsp" %>
<script type="text/javascript">
	function searchrv(event, pno) {
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
				var rcs = data.rcs;
				var pages = data.pages;
				
				var row = "";
				for(var i=0; i<rcs.length; i++) {
					var rc = rcs[i];
					
					row += "<tr>";
					row += "<td>"+rc.reviewNo+"</td>";
					row += "<td>"+rc.custId+"</td>";
					row += "<td>"+rc.contents+"</td>";
					row += "<td>"+rc.reviewDate+"</td>";
					row += "<td>"+rc.star+"</td>";
					row += "<td><a class='btn btn-warning' href='delreview.jsp?reviewNo="+rc.reivewNo+"'>삭제</a></td>";
					
				
				var rows= "";
				for(var j=1; j<=pages; j++) {
					rows += "<li><a href='#' onclick='searchrv(event, "+j+")'>"+j+"</a></li>";
				}
				
				}
					document.getElementById("review-box").innerHTML = row;
					document.getElementById("navi").innerHTML = rows;
		
			}
		}
			xhr.open("GET", "searchreview.jsp?custId="+custId+"&pno="+pno);
			xhr.send();
	}
</script>

</body>
</html>