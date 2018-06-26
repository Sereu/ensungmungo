<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.review.ReviewCustomer"%>
<%@page import="silverstar.review.ReviewDao"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	GsonBuilder gsonBuilder = new GsonBuilder();
	gsonBuilder.registerTypeAdapter(Date.class, new StringUtils.DateSerializer());
	Gson gson = gsonBuilder.create();

	String custId = request.getParameter("custId");
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.getCustomerById(custId);
	int custNo = customer.getCustomerNo();
	
	ReviewDao reviewDao = new ReviewDao();
	
	
	final int rows = 5;
	int records = reviewDao.getReviewCustNo(custNo);
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	param.put("custNo", custNo);
	
	List<ReviewCustomer> rcs = reviewDao.getReviewRangeByCustNo(param);
	
	HashMap<String, Object> data = new HashMap<>();
	data.put("pages",pages );
	data.put("rcs", rcs);
	String text = gson.toJson(data);
	out.write(text);
	
%>