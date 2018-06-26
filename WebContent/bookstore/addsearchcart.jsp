<%@page import="java.net.URLEncoder"%>
<%@page import="silverstar.cart.Cart"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.cart.CartDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	if(session.getAttribute("loginedCustomer") == null){
		response.sendRedirect("../customer/login.jsp");
		return;
	}

	CustomerDao customerDao = new CustomerDao();
	Customer customer = (Customer) session.getAttribute("loginedCustomer");
	String opt = request.getParameter("opt");
	String keyword = request.getParameter("keyword");
	String status = request.getParameter("status");
	int booknoS = Integer.parseInt(request.getParameter("bookno"));
	int pno = Integer.parseInt(request.getParameter("pno"));
	
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	BookDao bookDao = new BookDao();
	Book book = bookDao.bookSearchDetailByNo(bookno);
	String[] booksno = request.getParameterValues("bookno");

	CartDao cartDao = new CartDao();
	List<Cart> carts = cartDao.searchCartByCustomerNo(customer.getCustomerNo());

	for (Cart cart : carts) {
		int booknoC = cart.getBookNo();	
		
		if(booknoC == booknoS) {
			if("n".equals(status)){
				response.sendRedirect("search.jsp?keyword="+URLEncoder.encode(keyword, "utf-8")+"&opt="+opt+"&fail=overlap");
			}
			else {
				response.sendRedirect("simplesearch.jsp?keyword="+URLEncoder.encode(keyword, "utf-8")+"&opt="+opt+"&fail=overlap");
			}
			return;
		}
	}
	
	for(int i=0; i<booksno.length; i++) {
		Cart cart = new Cart();
		cart.setBookNo(Integer.parseInt(booksno[i]) );
		cart.setCustNo(customer.getCustomerNo());
		cart.setBookQuantity(1);
		
		cartDao.insertCart(cart);
	}
	
	response.sendRedirect("cartview.jsp");
	
%>