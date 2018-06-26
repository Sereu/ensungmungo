<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String custid = request.getParameter("id");
	String custpwd = request.getParameter("pwd");
	
	CustomerDao custDao = new CustomerDao();
	Customer customer = custDao.getCustomerById(custid);
	if(customer == null){
		response.sendRedirect("loginview.jsp?fail=invalid");
		return;
	}
	if(!customer.getCustomerPw().equals(custpwd)){
		response.sendRedirect("loginview.jsp?fail=invalid");
		return;
	}
	
	if(customer.getCustomerStatus().equals("Y")){
		session.setAttribute("loginedCustomer", customer);
		response.sendRedirect("../main/index.jsp");
	} else if(customer.getCustomerStatus().equals("N")){
		response.sendRedirect("loginview.jsp?fail=quit");
		return;
	}
	
	
%>
    