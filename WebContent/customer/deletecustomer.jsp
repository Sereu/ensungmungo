<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Customer cust = (Customer) session.getAttribute("loginedCustomer");
	String custid = request.getParameter("id");
	String custpwd = request.getParameter("pwd");
	
	CustomerDao custDao = new CustomerDao();
	Customer customer = custDao.getCustomerById(custid);
	if(!custpwd.equals(customer.getCustomerPw())){
		response.sendRedirect("reconfirmpwd.jsp?fail=invalid");
		return;
	} 
	
	custDao.deleteCustomerByNo(cust.getCustomerNo());
	
	session.invalidate();
	response.sendRedirect("../main/index.jsp");

	
%>