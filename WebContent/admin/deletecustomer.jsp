<%@page import="silverstar.customer.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pno = request.getParameter("pno");
	int customerNo = Integer.parseInt(request.getParameter("custNo"));
	String tryva = request.getParameter("try");
	
	CustomerDao customerDao = new CustomerDao();
			
	if("delete".equals(tryva)) {
		customerDao.deleteCustomer(customerNo);
		response.sendRedirect("customerlist.jsp?pno=1");
	} else if("cancel".equals(tryva)) {
		customerDao.canacelDeleteCustomer(customerNo);
		response.sendRedirect("customerlist.jsp?pno=1");
	}

%>