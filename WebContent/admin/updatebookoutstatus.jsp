<%@page import="silverstar.bookstore.BookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	int pno = Integer.parseInt(request.getParameter("pno"));

	BookDao bookDao = new BookDao();
	
	bookDao.updateBookOutStatusByNo(bookno);
	
	response.sendRedirect("booklist.jsp?pno="+pno);

%>