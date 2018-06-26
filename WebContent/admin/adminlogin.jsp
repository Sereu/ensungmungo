<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String custid = request.getParameter("id");
	String custpwd = request.getParameter("pwd");
	
	CustomerDao custDao = new CustomerDao();
	Customer admin = custDao.getAdminById(custid);
	if(admin == null){
		response.sendRedirect("adminloginview.jsp?fail=invalid");
		return;
	}
	if(!admin.getCustomerPw().equals(custpwd)){
		response.sendRedirect("adminloginview.jsp?fail=invalid");
		return;
	}
	
	session.setAttribute("loginedAdmin", admin);
	response.sendRedirect("adminmain.jsp");
%>
    