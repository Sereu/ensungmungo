<%@page import="java.util.ArrayList"%>
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
	
	int booknoS = Integer.parseInt(request.getParameter("bookno"));
	int maincategory = Integer.parseInt(request.getParameter("maincategory"));
	int pno = Integer.parseInt(request.getParameter("pno"));

	CustomerDao customerDao = new CustomerDao();
	Customer customer = new Customer();
	
	if(session.getAttribute("loginedCustomer") != null) {
		customer = (Customer) session.getAttribute("loginedCustomer");
	}
	
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	
	BookDao bookDao = new BookDao();
	Book book = bookDao.bookSearchDetailByNo(bookno);
	
	CartDao cartDao = new CartDao();
	

	List<Cart> carts = cartDao.searchCartByCustomerNo(customer.getCustomerNo());
	
	for (Cart cart : carts) {
		int booknoC = cart.getBookNo();	
		
		if(booknoC == booknoS) {
			response.sendRedirect("booklist.jsp?maincategory="+maincategory+"&fail=overlap");
			return;
		}
	}
			
	Cart cart = new Cart();
	cart.setBookNo(bookno);
	cart.setCustNo(customer.getCustomerNo());
	cart.setBookQuantity(1);
			
	cartDao.insertCart(cart);	
	
	response.sendRedirect("cartview.jsp");
%>