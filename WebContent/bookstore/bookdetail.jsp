<%@page import="silverstar.utils.StringUtils"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
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
	</script>
	

<%
	CustomerDao customerDao = new CustomerDao();
	Customer customer = new Customer();
	
	if(session.getAttribute("loginedCustomer") != null) {
		customer = (Customer) session.getAttribute("loginedCustomer");
	}
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	BookDao bookDao = new BookDao();
	Book book = bookDao.bookSearchDetailByNo(bookno);
	int rno = book.getNo();
	
	StringUtils stringUtils = new StringUtils();
	
	Review review = new Review();
	ReviewDao reviewDao2 = new ReviewDao();
	System.out.println(reviewDao2.getReviewByBookNo(book.getNo()));
%>





<div class = "container" style="margin-top:30px;padding-left:90px;">
	<!-- 책정보  -->
	<div class="row">
		<div class = "col-xs-3" style="margin-top:30px;">
		<img src="/silverstar/images/<%=book.getImage() %>" width="170px" height="200px"/>
		<p><a id="priview-img-<%=book.getNo()%>" onclick="openpriviewImageWindow();">크게보기</a></p>
		</div>
		<div class = "col-xs-6">
		<h2><%=book.getTitle() %></h2>
		<p><a style="text-decoration: none; color: black;" href="search.jsp?opt=A&keyword=<%=book.getAuthor() %>"><%=book.getAuthor() %></a>
		 | 
		 <a style="text-decoration: none; color: black;" href="search.jsp?opt=P&keyword=<%=book.getPublisher() %>"><%=book.getPublisher() %></a>
		 | 
		  <%=book.getPublishDate() %></p>
		<%
		  	if(reviewDao2.getReviewByBookNo(book.getNo()) > 0){
		%>
		<p>평가 : <%=reviewDao2.avgStarByBookNo(book.getNo()) %>점</p>
		<%
		  	} else {
		%>		
		<p>평가 : 0.0 점</p>
		<%
		  	}
		%>
		<p>도서 순위</p>
		<hr />
		<p>정가 : <%=stringUtils.numberWithComma(book.getFixedPrice()) %>원</p>
		<p>판매가 : <strong style="color:red;"><%=stringUtils.numberWithComma(book.getSalePrice()) %>원</strong>[<%=stringUtils.numberWithComma(book.getDiscountRate()) %>%↓ <%=stringUtils.numberWithComma(book.getFixedPrice()-book.getSalePrice()) %>원 할인]</p>
		
		</div>
		<div class = "col-xs-3" style="margin-top:120px; padding-left:30px">
		<table>
			<tr><td></td></tr>
			<tr>
				<td>
					<form  method="post" action="cart.jsp" >
					<%
					if("N".equals(book.getOutStatus())) {
					%>					
						<p><a href="bookspeck.jsp" class="btn btn-info">스펙비교</a></p>
						<p><button type="submit" class="btn btn-primary">장바구니 담기</button></p>				
						<p>
							<a href="orderview.jsp?bookno=<%=book.getNo()%>" class="btn btn-success">바로주문</a>
						</p>
						<input type="hidden" name="bookno" value="<%=book.getNo()%>" />
					<%
					}
					%>
					</form>
				</td>
			</tr>
			<tr><td></td></tr>
		</table>
		</div>
	</div>
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
	<%
		if(!"N".equals(book.getOutStatus())) {
	%>	
			<div class="alert alert-info">
				<strong>[해당 도서는 절판되었습니다.]</strong>
			</div>
	<%
		}
	%>
	<div class="row" style="margin:20px; padding:20px;">		
		<!-- 책 상세 정보  -->
		<div class="row">
			<p>ISBN : <%=book.getNo() %></p>
			<p>도서 분류 : <%=book.getMainCartegory() %>><%=book.getSubCartegory() %></p>
			<h2>책 소개</h2>
			<p><%=book.getIntroduce() %></p>
			<%
			if(book.getDetailImage() != null){
			%>
			<h3>상세 이미지</h3>
			<p style="text-align: center;"><img src="/silverstar/images/<%=book.getDetailImage() %>" /></p>
			<%
			}
			%>
		</div>
		<!-- 책 리뷰  -->
		<div class="row">
			<table class="table">
				<thead>
					<tr>
						<th><h2>리뷰</h2></th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<%@ include file="../customer/review.jsp" %>
						</td>
					</tr>
				</tbody>
			</table>
		
		</div>
		<!-- 교환 반품 품절안내  -->
		<div class="row">
			<table class="table" >
			<colgroup>
					<col width="15">
					<col width="85%">
				</colgroup>
				<thead>
					<tr>
						<th colspan="2">
							<h2>교환/반품/품절안내</h2>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td style="background-color: #ddd;">
							<p>교환 방법</p>
						</td>
						<td>
							<p>마이룸 > 주문관리 > 주문/배송내역 > 주문조회 > 반품/교환신청 , 
								[1:1상담>반품/교환/환불] 또는 고객센터 (1544-1900)
							</p>
							<p>
								※ 오픈마켓, 해외배송주문, 기프트 주문시 [1:1상담>반품/교환/환불]
   								또는 고객센터 (1544-1900)
   							</p>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- footer 경로를 다시 설정해주세요 -->
	</div>
</div>
<%@ include file="../navigation/footer.jsp" %>
</body>

<script type="text/javascript">
	function openpriviewImageWindow() {
		event.preventDefault();
		var booknoid = event.target.id;
		var bookno = booknoid.replace("priview-img-","")
		
		window.open("/silverstar/bookstore/priviewimage.jsp?bookno="+bookno);
	}
</script>
</html>