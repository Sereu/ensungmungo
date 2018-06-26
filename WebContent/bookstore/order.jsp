<%@page import="java.util.ArrayList"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.order.BookOrder"%>
<%@page import="silverstar.order.CustomerOrder"%>
<%@page import="silverstar.cart.CartDao"%>
<%@page import="silverstar.cart.Cart"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="silverstar.order.ShippingAddress"%>
<%@page import="silverstar.order.OrderPayment"%>
<%@page import="silverstar.order.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	request.setCharacterEncoding("UTF-8");
	//주문정보 받아오기!!! 카트나 주문정보에서
	//주소와 결제정보
	String address = "";
	String payment = "";
	
	address += request.getParameter("recipient");
	address += ",";
	address += request.getParameter("num1");
	address += ",";
	address += request.getParameter("num2");
	address += ",";
	address += request.getParameter("num3");
	address += ",";
	address += request.getParameter("address1");
	address += ",";
	address += request.getParameter("address2");
	
	payment += request.getParameter("pay");
	
	OrderDao orderDao = new OrderDao();
	int no = orderDao.seq();

	Customer customer = (Customer)session.getAttribute("loginedCustomer");
	CartDao cartDao = new CartDao();
	CustomerOrder customerOrder = new CustomerOrder();

	int price =Integer.parseInt(request.getParameter("totalprice"));
	int usepoint =Integer.parseInt(request.getParameter("usepoint"));
	int addpoint =Integer.parseInt(request.getParameter("addpoint"));
	int leftpoint =Integer.parseInt(request.getParameter("leftpoint"));
	
	//customer_order에 주문정보 넣기
	customerOrder.setCustomerNo(customer.getCustomerNo());
	customerOrder.setOrderNo(no);
	customerOrder.setPoint(usepoint);
	customerOrder.setAddpoint(addpoint);
	customerOrder.setPrice(price);
	orderDao.addCustomerOrder(customerOrder);
	
	BookOrder bookOrder = new BookOrder();
	Map<String, Object> count = new HashMap<>();
	List<Cart> carts = new ArrayList<>();
	BookDao bookDao = new BookDao();
	
	//바로주문여부 확인
	if(request.getParameter("booksno") != null){
		String[] booksno = request.getParameterValues("booksno");
		for(int i = 0; i < booksno.length; i++) {
			HashMap<String, Object> book = new HashMap<>();
			book.put("bookno",Integer.parseInt(booksno[i]));
			book.put("customerno",customer.getCustomerNo());
			Cart tempcart = cartDao.searchBookByCustomerNoAndOutStatusN(book);
			carts.add(tempcart);
			orderDao.deleteCart(book);
		}
	} else if(request.getParameter("bookno") != null) {
		//바로주문일 경우
		int bookno = Integer.parseInt(request.getParameter("bookno"));
		Book book = bookDao.bookSearchDetailByNo(bookno);
		Cart tempcart = new Cart();
		tempcart.setBookNo(bookno);
		tempcart.setCustNo(customer.getCustomerNo());
		tempcart.setBookQuantity(1);
		tempcart.setDiscountRate(book.getDiscountRate());
		tempcart.setFixedPrice(book.getFixedPrice());
		tempcart.setBookStock(book.getStock());
		carts.add(tempcart);
	} else {
		//cart에서 가져오기
		carts = cartDao.searchCartByCustomerNoAndOutStatusN(customer.getCustomerNo());
		//cart에서 뺴기
		orderDao.deleteCart(customer.getCustomerNo());
	}

	//book에서 재고 빼기, book_order에 주문정보 넣기
	for(Cart cart : carts) {
		bookOrder.setOrderNo(no);
		bookOrder.setBookNo(cart.getBookNo());
		bookOrder.setOrderQuantity(cart.getBookQuantity());
		orderDao.addBookOrder(bookOrder);
		count.put("no",cart.getBookNo());
		count.put("count",cart.getBookQuantity());
		orderDao.reduceBook(count);
	}
		
	//결제정보 넣기
	Map<String, Object> paymentMap = new HashMap<>();
	paymentMap.put("no",no);
	paymentMap.put("payment",payment);
	
	orderDao.addPayment(paymentMap);
	
	//주소 넣기
	Map<String, Object> addressMap = new HashMap<>();
	addressMap.put("no",no);
	addressMap.put("address",address);
	
	orderDao.addAddress(addressMap);
	
	//customer에서 마일리지 차감 또 마일리지 더함
	Map<String, Object> calculatepoint = new HashMap<>();
	calculatepoint.put("no",customer.getCustomerNo());
	calculatepoint.put("point",(addpoint+leftpoint));
	orderDao.addPoint(calculatepoint);
	
	//customer에서 구매액수 더함
	Map<String, Object> addprice = new HashMap<>();
	addprice.put("no",customer.getCustomerNo());
	addprice.put("price",price);
	orderDao.addPrice(addprice);
	
	response.sendRedirect("../customer/myorderview.jsp?orderno=" + no);
%>