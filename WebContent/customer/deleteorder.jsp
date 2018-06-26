<%@page import="silverstar.order.BookOrder"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="silverstar.order.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	//orderno 구하기
	int orderno = Integer.parseInt(request.getParameter("orderno"));
	int price = Integer.parseInt(request.getParameter("price"));
	int customerpoint = Integer.parseInt(request.getParameter("customerpoint"));
	
	//order 상태 N으로 바꾸기
	OrderDao orderDao = new OrderDao();
	orderDao.cancelOrder(orderno);
	
	//customer point, total price 되돌리기
	Map<String,Object> cancelResult = new HashMap<>();
	cancelResult.put("customerpoint",customerpoint);
	cancelResult.put("price",price);
	cancelResult.put("orderno",orderno);
	orderDao.cancelCustomerOrder(cancelResult);
	
	//book에서 재고 되돌리기
	List<BookOrder> orders = orderDao.getOrderBook(orderno);
	for(BookOrder bookOrder : orders) {
		
	Map<String,Object> amount = new HashMap<>();
		amount.put("orderNo",orderno);
		amount.put("bookNo",bookOrder.getBookNo());
		orderDao.cancelBookStock(amount);
	}
	response.sendRedirect("myorderview.jsp?orderno="+orderno);
%>