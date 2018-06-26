<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.bookstore.SearchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>도서리스트</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
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
  	function allSelectUnselect() {
  		
  		var el = document.getElementById("chbox");
  		var checkboxes = document.querySelectorAll("input[name='bookno']");

  		var text = el.innerHTML;
  		
  		if (text == "전체선택") {
	  		for (var i=0; i<checkboxes.length; i++) {
	  			var checkbox = checkboxes[i];
	  			checkbox.checked = true;
	  		}
	  	
	  		el.innerHTML = "전체해제";
  			
  		} else {
  			for (var i=0; i<checkboxes.length; i++) {
	  			var checkbox = checkboxes[i];
	  			checkbox.checked = false;
	  		}
	  	
	  		el.innerHTML = "전체선택";
  		}
  	}
  	function addAllBooksToCart() {
  		var checkboxescart = document.querySelectorAll("input[name='bookno']");
  		
  		var isChecked = false;
  		for (var i=0; i<checkboxescart.length; i++) {
  			if (checkboxescart[i].checked) {
  				isChecked = true;
  			}
  		}
  		
  		if (isChecked) {
  			document.getElementById("book-form").submit();
  				
  		} else {
  			alert("장바구니에 담을 상품을 하나 이상 선택하세요");
  			return;
  		}
  	}
	</script>
	<%
	String opt = request.getParameter("opt");
	String keyword = request.getParameter("keyword");
	
	SearchDao searchDao = new SearchDao();
	List<Book> searchbooks = null;
	
	BookDao bookDao = new BookDao();
	int rows = 20;
	if(request.getParameter("rows") != null)
		rows = Integer.parseInt(request.getParameter("rows"));
	int currentPage = 1;
	if(request.getParameter("pno") != null)
		currentPage = Integer.parseInt(request.getParameter("pno"));
	
	int records = 0;
	if (keyword == null) {
		records = bookDao.getAllBooksCount();
	} else if("T".equals(opt)){
		records = searchDao.countBookByTitle(keyword);
	} else if("P".equals(opt)) {
		records = searchDao.countBookByPublisher(keyword);
	} else if("A".equals(opt)) {
		records = searchDao.countBookByAuthor(keyword);
	}
	
	int pages = (int)Math.ceil((double)records/rows);
	int beginIndex = (currentPage-1)*rows +1;
	int endIndex = currentPage*rows;
		
	Map<String, Object> searchObjects = new HashMap<>();
	
	searchObjects.put("keyword",keyword);
	searchObjects.put("beginIndex",beginIndex);
	searchObjects.put("endIndex",endIndex);
	
	if("T".equals(opt)){
		searchbooks = searchDao.getBookByTitle(searchObjects);
	} else if("P".equals(opt)) {
		searchbooks = searchDao.getBookByPublisher(searchObjects);
	} else if("A".equals(opt)) {
		searchbooks = searchDao.getBookByAuthor(searchObjects);
	}

	%>
<div class="container" style="margin-top: 70px;">
	<%
		String fail = request.getParameter("fail");
		if(fail != null && "overlap".equals(fail)){
	%>
			<div class="alert alert-danger">
				<strong>[이미 장바구니에 있는 도서입니다.]</strong>
			</div>
	<%
		} else if(fail != null && "soldout".equals(fail)) {
	%>			
			<div class="alert alert-danger">
				<strong>[재고가 없습니다.]</strong>
			</div>
	<%
		} 
	%>
	<nav class="navbar">
		<div class="container">
			<ul class="nav nav-pills nav-justified "  >
				<li><a href="booklist.jsp?maincategory=10">전체도서</a></li>
				<li><a href="booklist.jsp?maincategory=9">베스트셀러</a></li>
			</ul>
		</div>
	</nav>
	<hr />
	
	<div class="row">
		<div class="col-sm-9">
			<span class="tit_info"></span>
		</div>
			
				<div  class="btn-group col-sm-3">
					<label class="dropdown">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1"  data-toggle="dropdown" aria-expanded="true">
						    20개씩 보기
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="search.jsp?opt=<%=opt %>&keyword=<%=keyword%>&rows=20">20개씩 보기</a></li>
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="search.jsp?opt=<%=opt %>&keyword=<%=keyword%>&rows=50">50개씩 보기</a></li>
						  </ul>
						  
					</label>

					<label class="dropdown">
						  <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu2"  data-toggle="dropdown" aria-expanded="true">
						    펼쳐보기
						  	<span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="search.jsp?opt=<%=opt %>&keyword=<%=keyword%>">펼쳐보기</a></li>
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="simplesearch.jsp?opt=<%=opt %>&keyword=<%=keyword%>">간략보기</a></li>
						  </ul>
					</label>
				</div>
		
	</div>		
			<hr class ="border:none; border:1px double">
	
	<div class="row">
		<nav>
			<div class="list_button text-right">
				<button class="btn btn-primary" onclick="allSelectUnselect()" id="chbox">전체선택</button >
				<button class="btn btn-primary" onclick="addAllBooksToCart()">장바구니 담기</button>
			</div>
			<ul class="pagination">
			<%
			for(int i=1; i<=pages; i++){
			%>
				<li class="<%=currentPage == i ? "active":"" %>" >
					<a href="search.jsp?pno=<%=i %>&opt=<%=opt %>&keyword=<%=keyword%>&rows=<%=rows%>"><%=i %></a>
				</li>
			<%		
			}
			%>
			</ul>
		</nav>
	</div>

		<form id="book-form" action="addsearchcart.jsp">
			<input type="hidden" name="pno" value="<%=currentPage%>"/>
			<input type="hidden" name="opt" value="<%=opt%>"/>
			<input type="hidden" name="keyword" value="<%=keyword%>"/>
			<input type="hidden" name="status" value="n"/>
		<%
			for (Book book : searchbooks) {
				if ("N".equals(book.getOutStatus())) {
		%>
				<input type="checkbox" name="bookno" value="<%=book.getNo() %>">
		<%
				}
		%>	
				<div class="row">
					<div class="col-sm-2">
						<a href="bookdetail.jsp?bookno=<%=book.getNo() %>">
						<img src="../images/cover/<%=book.getImage() %>" width="150" height="150" />
						</a>
							<p>도서</p>
					</div>
					<div class="col-sm-8">
						<a href="bookdetail.jsp?bookno=<%=book.getNo() %>"><h3><%=book.getTitle() %></h3></a>
						<p><%=book.getAuthor() %> | <%=book.getPublisher() %> | <%=book.getPublishDate() %></p>
						<p><%=book.getFixedPrice() %>원 [<%=book.getDiscountRate() %>%할인] </p>
						<p><%=book.getIntroduce() %> </p>
					</div>
					<div class="col-sm-2">
		<%
			if ("N".equals(book.getOutStatus())) {
		%>	
						<p>
						  <a href="cart.jsp?bookno=<%=book.getNo() %>" class="btn btn-info btn-block" >장바구니에 담기</a>
						  <a href="orderview.jsp?bookno=<%=book.getNo() %>" class="btn btn-success btn-block" >바로구매하기</a>
						</p>
		<% } %>
					</div>
				</div>
				<hr class ="border:none; border:1px dashed">
		<%		
		}
		%>	
		</form>
	
	<div class="row">
		<nav>
			<div class="list_button text-right">
				<button class="btn btn-primary" onclick="allSelectUnselect()" id="chbox">전체선택</button >
				<button class="btn btn-primary" onclick="addAllBooksToCart()">장바구니 담기</button>
			</div>
			<ul class="pagination">
			<%
			for(int i=1; i<=pages; i++){
			%>
				<li class="<%=currentPage == i ? "active":"" %>" >
					<a href="search.jsp?pno=<%=i %>&opt=<%=opt %>&keyword=<%=keyword%>&rows=<%=rows%>"><%=i %></a>
				</li>
			<%		
			}
			%>
			</ul>
		</nav>
	</div>
</div>
		<%@ include file="../navigation/footer.jsp" %>
</body>
</html>