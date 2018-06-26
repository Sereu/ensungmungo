<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	
	String customerId = request.getParameter("customer-id");
	String customerPw = request.getParameter("customer-pw");
	String customerEmail1 = request.getParameter("customer-email1");
	String customerEmail2 = request.getParameter("customer-email2");
	String customerEmail = customerEmail1 + "@" + customerEmail2;
	String customerTel1 = request.getParameter("customer-tel1");
	String customerTel2 = request.getParameter("customer-tel2");
	String customerTel3 = request.getParameter("customer-tel3");
	String customerTel = customerTel1 +"-"+ customerTel2 +"-"+ customerTel3;
	String customerAddress1 = request.getParameter("customer-address1");
	String customerAddress2 = request.getParameter("customer-address2");
	String customerAddress = customerAddress1 +"/"+ customerAddress2;
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customer.setCustomerEmail(customerEmail);
	customer.setCustomerTel(customerTel);
	customer.setCustomerAddress(customerAddress);
	
	CustomerDao customerDao = new CustomerDao();
	customerDao.updateCustomer(customer);
	response.sendRedirect("mypageview.jsp");
%>