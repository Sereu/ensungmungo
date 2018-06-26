<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="silverstar.bookstore.StatisticsDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cartegory = request.getParameter("cartegory");
	int bookNo = Integer.parseInt(request.getParameter("bookNo"));
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("cartegory", cartegory);
	param.put("bookNo", bookNo);

	StatisticsDao statisticsDao = new StatisticsDao();
	List<Integer> bookNos = statisticsDao.getBookNoByCartegory(param);
	
	Gson gson = new Gson();
	String jsonText = gson.toJson(bookNos);
	out.write(jsonText);
%>