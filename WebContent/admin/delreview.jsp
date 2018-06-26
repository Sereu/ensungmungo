<%@page import="silverstar.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	int reviewNo = Integer.parseInt(request.getParameter("reviewNo"));
	String pno = request.getParameter("pno");

	ReviewDao reviewDao = new ReviewDao();
	reviewDao.delReview(reviewNo);
	response.sendRedirect("reviewlist.jsp?pno=1");
%>