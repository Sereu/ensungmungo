<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>
	<%
		int bookno = Integer.parseInt(request.getParameter("bookno"));
		BookDao bookDao = new BookDao();
		Book book = bookDao.bookSearchDetailByNo(bookno);
	%>
	<img src="/silverstar//images/cover/<%=book.getImage() %>" width ="350"/>
</body>
</html>