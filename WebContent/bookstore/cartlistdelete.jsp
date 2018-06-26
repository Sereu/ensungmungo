<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.cart.CartDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	String[] booksno = request.getParameterValues("booksno");
	for(String booknoS : booksno){
		int bookno = Integer.parseInt(booknoS);
		CartDao cartDao = new CartDao();

		Customer customer = (Customer)session.getAttribute("loginedCustomer");
	
		HashMap<String,Object> map = new HashMap<>();
		map.put("custNo", customer.getCustomerNo());
		map.put("bookNo", bookno);
	
		cartDao.deleteOneCartByNo(map);
	}
	response.sendRedirect("cartview.jsp");
%>