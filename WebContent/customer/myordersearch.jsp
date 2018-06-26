<%@page import="silverstar.order.SearchMyorder"%>
<%@page import="java.util.ArrayList"%>
<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.order.OrderNoBook"%>
<%@page import="java.util.Map"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="silverstar.order.CustomerOrder"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.order.OrderDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	//GsonBuilder gsonBuilder = new GsonBuilder();
	//gsonBuilder.registerTypeAdapter(Date.class, new StringUtils.DateSerializer());
	//Gson gsonDate = gsonBuilder.create();

	request.setCharacterEncoding("UTF-8");
	Customer cust = (Customer) session.getAttribute("loginedCustomer");
	String from = request.getParameter("from");
	String end = request.getParameter("end");
	String bookName = request.getParameter("bookname");
	
	OrderDao orderDao = new OrderDao();
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("custNo", cust.getCustomerNo());
	param.put("fromIndex", from);
	param.put("endIndex", end);
	param.put("bookName", bookName);
	
	final int row = 10;
	int records = orderDao.getMyorderCnt(param);
	int pages = (int) (Math.ceil( (double) records/row));
	int currentPage = Integer.parseInt(request.getParameter("mypno"));
	int beginIndex = (currentPage -1) * row + 1;
	int endIndex = currentPage * row;
	
	HashMap<String, Object> orderRange = new HashMap<>();
	orderRange.put("custNo", cust.getCustomerNo());
	orderRange.put("beginDate", from);
	orderRange.put("endDate", end);
	orderRange.put("beginIndex", beginIndex);
	orderRange.put("endIndex", endIndex);
	orderRange.put("bookName", bookName);
	
	List<SearchMyorder> orders = orderDao.getCustByDate(orderRange);
	List<SearchMyorder> ordersStatus = new ArrayList<>();

	for(SearchMyorder order : orders){
		if(order.getOrderStatus().equals("Y")){
			order.setOrderStatus("주문완료");
		} else if(order.getOrderStatus().equals("N")){
			order.setOrderStatus("주문취소");
		}
	}
	
	HashMap<String, Object> result = new HashMap<>();
	result.put("totalPages", pages);
	result.put("myOrders", orders);
	
	GsonBuilder gsonBuilder = new GsonBuilder();
	gsonBuilder.registerTypeAdapter(Date.class, new StringUtils.DateSerializer());
	Gson gson = gsonBuilder.create();
	
	String jsonText = gson.toJson(result);
	out.write(jsonText);
%>
