<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	int bookamount = Integer.parseInt(request.getParameter("bookamount"));
	 
	Customer customer = (Customer)session.getAttribute("loginedCustomer");
	
	HashMap<String,Object> map = new HashMap<>();
	map.put("bookQuantity",bookamount);
	map.put("custNo",customer.getCustomerNo());
	map.put("bookNo",bookno);
	
	CartDao cartDao = new CartDao();
	cartDao.updateCartBookQuantityByNo(map);

	response.sendRedirect("cartview.jsp");
%>