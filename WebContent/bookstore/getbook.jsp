<%@page import="silverstar.bookstore.Book"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.bookstore.SearchDao"%>
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
	
	SearchDao searchDao = new SearchDao();
	String bookTitle = request.getParameter("bookTitle");
	
	final int rows = 5;
	int records = searchDao.countBookByTitle(bookTitle);
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	param.put("keyword", bookTitle);
	
	List<Book> books = searchDao.getBookByTitle(param);
	
	HashMap<String, Object> data = new HashMap<>();
	data.put("pages",pages );
	data.put("books", books);
	String text = gson.toJson(data);
	out.write(text);

%>