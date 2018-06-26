<%@page import="silverstar.review.ReviewDao"%>
<%@page import="silverstar.review.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	int bookNo = Integer.parseInt(request.getParameter("bookno"));
	int custNo = Integer.parseInt(request.getParameter("custno"));
	int star = Integer.parseInt(request.getParameter("star"));
	String contents = request.getParameter("contents");
	
	Review re = new Review();
	re.setBookNo(bookNo);
	re.setCustomerNo(custNo);
	re.setStar(star);
	re.setContents(contents);
	
	ReviewDao revDao = new ReviewDao();
	revDao.insertReview(re);
	
	response.sendRedirect("../bookstore/bookdetail.jsp?bookno="+bookNo);
	
%>