<%@page import="silverstar.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int bookNo = Integer.parseInt(request.getParameter("bookno"));
	int reNo = Integer.parseInt(request.getParameter("reno"));
	
	ReviewDao reDao = new ReviewDao();
	reDao.delReview(reNo);
	
	response.sendRedirect("adminreview.jsp?bookno="+bookNo);
%>
    