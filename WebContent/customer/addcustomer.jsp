<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String customerId = request.getParameter("customer-id");
	String customerPw = request.getParameter("customer-pw");
	String customerName = request.getParameter("customer-name");
	String customerEmail1 = request.getParameter("customer-email1");
	String customerEmail2 = request.getParameter("customer-email2");
	String customerEmail = customerEmail1 + "@" + customerEmail2;
	String gender = request.getParameter("gender");
	String customerTel1 = request.getParameter("customer-tel1");
	String customerTel2 = request.getParameter("customer-tel2");
	String customerTel3 = request.getParameter("customer-tel3");
	String customerTel = customerTel1 +"-"+ customerTel2 +"-"+ customerTel3;
	String customerAddress1 = request.getParameter("customer-address1");
	String customerAddress2 = request.getParameter("customer-address2");
	String customerAddress = customerAddress1+"/"+customerAddress2;
	String birth = request.getParameter("customer-birth");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
	Date customerBirth = sdf.parse(birth);
	
	Customer customer = new Customer();
	customer.setCustomerId(customerId);
	customer.setCustomerPw(customerPw);
	customer.setCustomerName(customerName);
	customer.setCustomerEmail(customerEmail);
	customer.setGender(gender);
	customer.setCustomerTel(customerTel);
	customer.setCustomerAddress(customerAddress);
	customer.setCustomerBirth(customerBirth);
	
	
	CustomerDao customerDao = new CustomerDao();

	if(null == customerDao.getCustomerById(customerId)) {
		
		customerDao.insertCustomer(customer);
		response.sendRedirect("completesignup.jsp");
	} else {
		response.sendRedirect("registerview.jsp?check=fail");
	}
	
	
%>