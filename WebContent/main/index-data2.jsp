<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.SearchDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String bookCategory = request.getParameter("category");
SearchDao searchDao = new SearchDao();
List<Book> books = searchDao.newCategorylists(bookCategory);
Gson gson = new Gson();
String jsonText= gson.toJson(books);
String jsonText2= gson.toJson(jsonText);
out.write(jsonText);
%>