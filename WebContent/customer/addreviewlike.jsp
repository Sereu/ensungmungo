<%@page import="java.util.HashMap"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.review.ReviewDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Customer cust = (Customer) session.getAttribute("loginedCustomer");
	int reno = Integer.parseInt(request.getParameter("reno"));
	int bookNo = Integer.parseInt(request.getParameter("bookno"));

	ReviewDao reviewDao = new ReviewDao();

	
	HashMap<String, Object> param = new HashMap<>();
	param.put("reviewNo", reno);
	param.put("custNo", cust.getCustomerNo());
	reviewDao.addreviewlike(reno);
	response.sendRedirect("../bookstore/bookdetail.jsp?bookno="+bookNo);
	
	int custReviewNo = reviewDao.getBookByCustomerNo(param);
	
		

%>
    