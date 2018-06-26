
<%@page import="silverstar.bookstore.StatisticsDao"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.review.ReviewDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.utils.StringUtils"%>
<%@page import="java.util.Date"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	GsonBuilder gsonBuilder = new GsonBuilder();
	gsonBuilder.registerTypeAdapter(Date.class, new StringUtils.DateSerializer());
	Gson gson = gsonBuilder.create();
	

	int bookNo = Integer.parseInt(request.getParameter("bookNo"));
	BookDao bookDao = new BookDao();
	Book book = bookDao.bookSearchDetailByNo(bookNo);
	
	ReviewDao reviewDao = new ReviewDao();
	int star = reviewDao.getAvgStarByBookNo(bookNo);
	StatisticsDao statisticsDao = new StatisticsDao();
	double rank = statisticsDao.getRankByBookNo(bookNo);
	
	HashMap<String, Object> data = new HashMap<>();
	data.put("book",book );
	data.put("star", star);
	data.put("rank", rank);
	String text = gson.toJson(data);
	out.write(text);
    %>