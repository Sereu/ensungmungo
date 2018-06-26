<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//application = 웹페이지당 하나 만들어지는 객체
	
	request.setCharacterEncoding("utf-8");	
	
	String saveDirectory = application.getRealPath("images");
	int maxUploadSize = 1024*1024*10; // 10MB
	
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxUploadSize, "utf-8", new DefaultFileRenamePolicy());
	
	String maincartegory = mr.getParameter("maincartegory");
	String subcartegory = mr.getParameter("subcartegory");
	String title = mr.getParameter("title");
	String author = mr.getParameter("author");
	String publisher = mr.getParameter("publisher");
	String fixedpriceString = mr.getParameter("fixedprice");
	String stockString = mr.getParameter("stock");
	String discountrateString = mr.getParameter("discountrate");
	String publishdate = mr.getParameter("publishdate");
	String introduce = mr.getParameter("introduce");
	String imagename = mr.getFilesystemName("imagefile");
	String detailname = mr.getFilesystemName("detailimage");

	if(title == "") {
		response.sendRedirect("addbookform.jsp?fail=notTitle");
		return;
	}
	
	if(author == "") {
		response.sendRedirect("addbookform.jsp?fail=notAuthor");
		return;
	}
	
	if(fixedpriceString == "") {
		response.sendRedirect("addbookform.jsp?fail=notFixedPrice");
		return;
	}
	if(stockString == "") {
		response.sendRedirect("addbookform.jsp?fail=notStock");
		return;
	}
	if(discountrateString == "") {
		response.sendRedirect("addbookform.jsp?fail=notDiscountrate");
		return;
	}
	if(publishdate == "") {
		response.sendRedirect("addbookform.jsp?fail=notPublishdate");
		return;
	}
	if(introduce == "") {
		response.sendRedirect("addbookform.jsp?fail=notIntroduce");
		return;
	}
	
	
	
	
	
	Book book = new Book();
	book.setMainCartegory(maincartegory);
	book.setSubCartegory(subcartegory);
	book.setTitle(title);
	book.setAuthor(author);
	book.setPublisher(publisher);
	book.setImage(imagename);
	int fixedprice;
	int stock;
	int discountrate;
	if(mr.getParameter("fixedprice") != null) {
		fixedprice = Integer.parseInt(fixedpriceString);
		book.setFixedPrice(fixedprice);
	}
	if(mr.getParameter("stock") != null) {
		stock = Integer.parseInt(stockString);
		book.setStock(stock);
	}
	if(mr.getParameter("discountrate") != null) {
		discountrate = Integer.parseInt(discountrateString);
		book.setDiscountRate(discountrate);
	}
	
	book.setPublishDate(publishdate);
	book.setIntroduce(introduce);
	book.setDetailImage(detailname);
	
	BookDao bookDao = new BookDao();
	bookDao.insertBook(book);
	
	response.sendRedirect("booklist.jsp?pno=1");
	
	
%>