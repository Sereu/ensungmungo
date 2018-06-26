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
  <title>Silver Star Admin</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
		.container, .container-fluid {
			min-width: 1080px;
		}
		
	</style>
</head>
<%
	if(session.getAttribute("loginedAdmin") == null) {
		response.sendRedirect("adminloginview.jsp");
		return;
	}
%>
<body>
<%
	BookDao bookDao = new BookDao();
	
	final int rows = 10;
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	String col = request.getParameter("col");
	String sort = request.getParameter("sort");
	String status = "";
	if(request.getParameter("status") != null)
		status = request.getParameter("status");
	String searchtag = "";
	if(request.getParameter("searchtag") != null)
		searchtag = request.getParameter("searchtag");
	String search = "";
	if(request.getParameter("search") != null)
		search = request.getParameter("search");
	
	Map<String, Object> statusMap = new HashMap<>();
	if (!"".equals(status)){
		statusMap.put("status", status);
	}
	statusMap.put("search",search);
	statusMap.put("searchtag",searchtag);
	
	int records = bookDao.getBooksStatusCount(statusMap);
	int pages = (int)Math.ceil((double)records/rows);
	
	int beginIndex = (currentPage - 1)*rows+1;
	int endIndex = currentPage*rows;
	
	Map<String, Object> map = new HashMap<>();
	if (!"".equals(status)){
		map.put("status",status);
	}
	map.put("beginIndex", beginIndex);
	map.put("endIndex",endIndex);
	map.put("col", col);
	map.put("sort", sort);
	map.put("search",search);
	map.put("searchtag",searchtag);
	

	
	List<Book> books = bookDao.getArrayBooks(map);
%>

<%@ include file="header.jsp" %>
<div class="container">
	<h1>도서 리스트</h1>
	<div class="btn-group text-right" role="group" aria-label="...">
		<a class="btn btn-default" onclick = "status();">전체</a>
		<a class="btn btn-default" onclick = "status('N');">판매 중 상품</a>
		<a class="btn btn-default" onclick = "status('Y');">절판된 상품</a>
	</div>
	<div class="text-right" >
		<form class="form-inline" id="frm" action="booklist.jsp">
			<div class="form-group">
				<select name="searchtag" class="form-control">
					<option value="book_title"> 제목</option>
					<option value="book_publisher"> 출판사</option>
					<option value="book_author"> 작가</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" name="search" class="form-control"/>
			</div>
			<button onclick="searchAction();" class="btn btn-default btn-sm">검색</button>
			<input type="hidden" name="pno" value="<%=currentPage %>"/>	
			<input type="hidden" name="col" value="<%=col != null ? col :"book_title" %>"/>
			<input type="hidden" name="sort" value="<%=sort != null ? sort :"asc" %>" />
			<input type="hidden" name="status" value="<%=status != null ? status :"" %>" />	
		</form>
	</div>
	<table class="table table-striped" >
		<colgroup>
			<col width="8%">
			<col width="22%">
			<col width="15%">
			<col width="10%">
			<col width="6%">
			<col width="5%">
			<col width="6%">
			<col width="11%">
			<col width="5%">
			<col width="12%">
		</colgroup>
		<thead>
			<tr>
				<th>도서 번호</th>
				<th>제목
					<a onclick="sort('book_title', 'asc');"><span class="glyphicon glyphicon-triangle-top" ></span></a>
					<a onclick="sort('book_title', 'desc');"><span class="glyphicon glyphicon-triangle-bottom" ></span></a>
				</th>
				<th>카테고리
					<a onclick="sort('main_cartegory', 'asc');"><span class="glyphicon glyphicon-triangle-top" ></span></a>
					<a onclick="sort('main_cartegory', 'desc');"><span class="glyphicon glyphicon-triangle-bottom" ></span></a>
				</th>
				<th>출판사
					<a onclick="sort('book_publisher', 'asc');"><span class="glyphicon glyphicon-triangle-top" ></span></a>
					<a onclick="sort('book_publisher', 'desc');"><span class="glyphicon glyphicon-triangle-bottom" ></span></a>
				</th>
				<th>가격</th>
				<th>재고</th>
				<th>저자</th>
				<th>출간일</th>
				<th>절판상태</th>
				<th></th>
			</tr>
		</thead>
		<tbody>
		<!-- 반복 시작 -->
		<%
		for (Book book : books) {
		%>
			<tr>
				<td><%=book.getNo() %></td>
				<td><a href="../bookstore/bookdetail.jsp?bookno=<%=book.getNo() %>"><%=book.getTitle() %></a></td>
				<td><%=book.getMainCartegory() %>><%=book.getSubCartegory() %></td>
				<td><%=book.getPublisher() %></td>
				<td><%=book.getCommaFixedPrice() %></td>
				<td><%=book.getStock() %></td>
				<td><%=book.getAuthor() %></td>
				<td><%=book.getPublishDate() %></td>
				<td><%=book.getOutStatus() %></td>
				<td>
					<a id="review-btn-<%=book.getNo() %>" onclick = "openReviewWindow();" class = "btn btn-success btn-xs">리뷰</a>
					<a href = "updatebookform.jsp?bookno=<%=book.getNo() %>" class = "btn btn-info btn-xs">수정</a>
					<a href = "updatebookoutstatus.jsp?pno=<%=currentPage %>&bookno=<%=book.getNo() %>" class = "btn btn-danger btn-xs">삭제</a>
				</td>
			</tr>
		<%
		}
		%>
		<!-- 반복 종료 -->
		</tbody>
	</table>
	
	
	<div class="text-right">
	<a href="addbookform.jsp" class="btn btn-primary">책 등록</a>
	</div>
	<div class="text-center">
	  <ul class="pagination">

	  <%
	  
		for(int i=1; i<=pages; i++){
		%>
			<li class="<%=currentPage==i ? "active":"" %>" ><a onclick="page(<%=i %>);" href="booklist.jsp?pno=<%=i %>&col=<%=col %>&sort=<%=sort %>&status=<%=status %>&searchtag=<%=searchtag%>&search=<%=search%>"><%=i %></a></li>

		<%
	    }
		%>	
	  </ul>
	</div>

</div>
</body>
<script>
	function openReviewWindow() {
		event.preventDefault();
		var booknoid = event.target.id;
		var bookno = booknoid.replace("review-btn-","")
		
		window.open("adminreview.jsp?bookno="+bookno);
	}
	
	
	function sort(columnName, sortDirection) {
		document.querySelector("input[name='pno']").value = 1;
		document.querySelector("input[name='col']").value = columnName;
		document.querySelector("input[name='sort']").value = sortDirection;
		
		document.querySelector("#frm").submit();
	}
	
	function status(outStatus) {
		document.querySelector("input[name='pno']").value = 1;
		if(outStatus) {
			document.querySelector("input[name='status']").value = outStatus;
		}else {
			document.querySelector("input[name='status']").remove();
		}
		document.querySelector("#frm").submit();
	}
	
	function page(pageNo) {
		document.querySelector("input[name='pno']").value = pageNo;
		document.querySelector("#frm").submit();
	}
	function page2(pageNo) {
		document.querySelector("input[name='pno']").value = pageNo;
		document.querySelector("input[name='status']").remove();
		document.querySelector("#frm").submit();
	}
	
	function searchAction() {
		document.querySelector("input[name='pno']").value = 1;
		document.querySelector("input[name='searchtag']").value;
		document.querySelector("input[name='search']").value;
		
		document.querySelector("#frm").submit();
	}
	
</script>
</html>