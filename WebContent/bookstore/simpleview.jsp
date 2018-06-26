<%@page import="java.text.DecimalFormat"%>
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
  <title>도서리스트 간략보기</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <script type="text/javascript">
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
</head>
<body>

	<%@ include file="../navigation/header.jsp" %>
	<%@ include file="../navigation/recentbookview.jsp" %>

	<%
	BookDao bookDao = new BookDao();

	int rows = 20;
	if (request.getParameter("list") != null)
		rows = Integer.parseInt(request.getParameter("list"));
	int currentPage = 1;
	if (request.getParameter("pno") != null)
		currentPage = Integer.parseInt(request.getParameter("pno"));
	
	int mainCategory = Integer.parseInt(request.getParameter("maincategory"));
	String cat = null;
	if (mainCategory == 11) {
		cat = "소설";
	} else if (mainCategory == 12) {
		cat = "만화";
	} else if (mainCategory == 13) {
		cat = "인문";
	} else if (mainCategory == 14) {
		cat = "시/에세이";
	} else if (mainCategory == 9) {
		cat = "베스트셀러";
	} else if (mainCategory == 15) {
		cat = "그림책";
	} else if (mainCategory == 16) {
		cat = "역사/문화";
	} else if (mainCategory == 17) {
		cat = "과학";
	} else if (mainCategory == 18) {
		cat = "어린이(초등)";
	} else if (mainCategory == 19) {
		cat = "경제/경영";
	} else if (mainCategory == 20) {
		cat = "자기계발";
	} else if (mainCategory == 21) {
		cat = "정치/사회";
	} else if (mainCategory == 22) {
		cat = "외국어";
	}
	
	int records = 0;
	if (cat == null) {
		records = bookDao.getAllBooksCount();
	} else {
		records = bookDao.getBooksCount(cat);
	} 
	
	int pages = (int)Math.ceil((double)records/rows);
	int beginIndex = (currentPage-1)*rows +1;
	int endIndex = currentPage*rows;
	
	Map<String, Object> map = new HashMap<>();
	map.put("beginIndex", beginIndex);
	map.put("endIndex", endIndex);
	map.put("cat", cat);
	
	List<Book> books = null;
	if (cat == null) {
		books = bookDao.getAllBookByRange(map);
	} else if (cat == "베스트셀러") {
		books = bookDao.getFamousBookSearch(map);		
	} else {
		books = bookDao.getBookByRangeWithCategory(map);
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
			<ul class="nav nav-pills nav-justified" >
				<li class="<%=mainCategory== 10 ? "active": ""%>" >
				<a href="simpleview.jsp?pno=<%=currentPage %>&maincategory=10" >전체도서</a></li>
				<li class="<%=mainCategory== 9 ? "active": ""%>" >
				<a href="simpleview.jsp?maincategory=9" >베스트셀러</a></li>
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
						  <button class="btn btn-default dropdown-toggle" type="button" 
						  id="dropdownMenu1"  data-toggle="dropdown" aria-expanded="true">
						    20개씩 보기
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="simpleview.jsp?list=20&maincategory=<%=mainCategory %>">20개씩 보기</a></li>
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="simpleview.jsp?list=50&maincategory=<%=mainCategory %>">50개씩 보기</a></li>
						  </ul>
					</label>

					<label class="dropdown">
						  <button class="btn btn-default dropdown-toggle" type="button" 
						  id="dropdownMenu2"  data-toggle="dropdown" aria-expanded="true">
						    펼쳐보기
						    <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu2">
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="booklist.jsp?pno=<%=currentPage %>&maincategory=<%=mainCategory %>&status=normal">펼쳐보기</a></li>
						    <li role="presentation"><a role="menuitem" tabindex="-1" 
						    href="simpleview.jsp?pno=<%=currentPage %>&maincategory=<%=mainCategory %>&status=simple">간략보기</a></li>
						  </ul>
					</label>
				</div>
		
	</div>		
			<hr class ="border:none; border:1px double">
	
	<div class="list_button text-right">
		<button class="btn btn-primary" onclick="allSelectUnselect()" id="chbox">전체선택</button >
		<button class="btn btn-primary" onclick="addAllBooksToCart()">장바구니 담기</button>
	</div>

<nav>
  <ul class="pagination">
		<%
			for(int i=1; i<=pages; i++){
		%>
				<li class="<%=currentPage==i ? "active":"" %>" >
				<a href="simpleview.jsp?pno=<%=i %>&maincategory=<%=mainCategory %>&list=<%=rows%>"><%=i %></a></li>
		<%		
			}
		%>
  </ul>
</nav>

	<form id="book-form" action="addcart.jsp">			
		<div class="row" >
	<%
	DecimalFormat df = new DecimalFormat("###,###");
		for (Book book : books) {
	%>		
			<div class="col-sm-3 text-center"
				 style="border: 1px ; padding: 10px; height: 300px;">
				<div>
				<input type="hidden" name="pno" value="<%=currentPage%>"/>
				<input type="hidden" name="maincategory" value="<%=mainCategory%>"/> 
	<%
		
			if ("N".equals(book.getOutStatus())) {
	%>
					<span class="check">
					<input type="checkbox" name="bookno" value="<%=book.getNo() %>">
					</span>
	<%
			}
	%>
					<span>
					<a href="bookdetail.jsp?bookno=<%=book.getNo() %>">
					<img src="../images/cover/<%=book.getImage() %>" width="150" height="150" />
					</a>
					</span>
				</div>
				<div>
					<p><%=book.getTitle() %></p></a>
					<p><a style="text-decoration: none; color: black;" href="search.jsp?opt=A&keyword=<%=book.getAuthor() %>"><%=book.getAuthor() %></a>/ <a style="text-decoration: none; color: black;" href="search.jsp?opt=P&keyword=<%=book.getPublisher() %>"><%=book.getPublisher() %></a></p>
					<p><%=df.format(book.getFixedPrice()) %></p>
					<hr class ="border:none; border:1px double">
				</div>
			</div>
	<%
		}
	%>
	  	</div>
	</form>

<nav>
  <ul class="pagination">
		<%
			for(int i=1; i<=pages; i++){
		%>
				<li class="<%=currentPage==i ? "active":"" %>" >
				<a href="simpleview.jsp?pno=<%=i %>&maincategory=<%=mainCategory %>&list=<%=rows%>"><%=i %></a></li>
		<%		
			}
		%>
  </ul>
</nav>	
</div>
	
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>
    