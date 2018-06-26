<%@page import="silverstar.customer.Customer"%>
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
<%@ include file="header.jsp" %>
<div class="container" style="min-width:1080px; margin-top: 70px;">
	<div class="row" style="margin-left: 800px; margin-bottom: 150px;">
	</div>
	<div class="row">
		<div class="col-sm-offset-2 col-sm-3">
			<a href="booklist.jsp?pno=1&col=book_no&sort=desc"><img src="../images/book.jpg" width="150" height="150" /></a>
		</div>
		<div class="col-sm-3">
			<a href="customerlist.jsp?pno=1"><img src="../images/cust.png" width="150" height="150" /></a>
		</div>
		<div class="col-sm-3">
			<a href="qnaview.jsp?pno=1"><img src="../images/qanda.jpg" width="150" height="150" /></a>
		</div>
	</div>
	<div class="row" style="margin-left: 28px;">
		<div class="col-sm-offset-2 col-sm-3">
			<h4><a href="booklist.jsp?pno=1&col=book_no&sort=desc">도서 관리</a></h4>
		</div>
		<div class="col-sm-3">
			<h4><a href="customerlist.jsp?pno=1">회원 관리</a></h4>
		</div>
		<div class="col-sm-3">
			<h4><a href="qnaview.jsp?pno=1">Q&A 관리</a></h4>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-offset-3 col-sm-3">
			<a href="reviewlist.jsp?pno=1" style="margin-left:36px"><img src="../images/reviewicon.png" width="150" height="150" /></a>
		</div>
		<div class="col-sm-3">
			<a href="statistics.jsp" style="margin-left:36px"><img src="../images/statsicon.png" width="150" height="150" /></a>
		</div>
	</div>
	<div class="row" style="margin-left: 28px;">
		<div class="col-sm-offset-3 col-sm-3">
			<h4><a href="reviewlist.jsp?pno=1" style="margin-left:40px">리뷰 관리</a></h4>
		</div>
		<div class="col-sm-3">
			<h4><a href="statistics.jsp" style="margin-left:69px">통계</a></h4>
		</div>
	</div>
</div>
</body>
</html>
    