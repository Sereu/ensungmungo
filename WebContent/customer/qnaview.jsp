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
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>
<body>
<%
	if(session.getAttribute("loginedCustomer") == null) {
		response.sendRedirect("../main/index.jsp");
		return;
	}
	
	QnADao qnaDao = new QnADao();
	final int rows = 10;
	
	Customer loginedCustomer = (Customer) session.getAttribute("loginedCustomer");
	int customerNo = loginedCustomer.getCustomerNo();
	
	int records = qnaDao.getAllCountsQnAByCust(customerNo);
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	param.put("customerNo", customerNo);
	
	List<QnA> qnAs = qnaDao.getQnAsByRangeByCustNo(param);
	
	
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
	<div class="row">

	<h1>문의 리스트</h1>
	
	<table class="table table-hover">
		<thead>
			<tr>
				<th>번호</th>
				<th>아이디</th>
				<th class="col-sm-6 text-center">제목</th>
				<th>날짜</th>
				<th>상태</th>
				<th></th>
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
				<td class="col-sm-6 text-center"><a href="qnadetail.jsp?pno=<%=currentPage%>&qnaNo=<%=qna.getQnaNo()%>"><%=qna.getQnaTitle() %></a></td>
				<td><%=qna.getStringQnaDate() %></td>
		<%
				if(qnaAsk == null) {
		%>
					<td><p class="btn btn-primary">문의대기중</p></td>					
		<%
				} else {
		%>
					<td><p class="btn btn-primary">문의완료</p></td>
					<td><a href="qnaaskview.jsp?pno=<%=currentPage %>&qnaNo=<%=qna.getQnaNo() %>" class="btn btn-waring">내용확인</a>	
		<%		
				}
		%>
			</tr>
		<%
			}
		%>
		</tbody>
	</table>
	<%
		if(session.getAttribute("loginedCustomer") == null) {
			
		} else {
	%>	
			<div class="text-right">
				<a class="btn btn-primary" href="qnaform.jsp?pno=<%=currentPage%>">문의 등록</a>
			</div>
	<%
		}
	%>
	
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
</body>
</html>