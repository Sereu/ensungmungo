<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//application = 웹페이지당 하나 만들어지는 객체
	String saveDirectory = application.getRealPath("images");
	int maxUploadSize = 1024*1024*10; // 10MB
	
	MultipartRequest mr = new MultipartRequest(request, saveDirectory, maxUploadSize, "utf-8", new DefaultFileRenamePolicy());
	
	int bookno = Integer.parseInt(mr.getParameter("bookno"));
	String maincartegory = mr.getParameter("maincartegory");
	String subcartegory = mr.getParameter("subcartegory");
	String title = mr.getParameter("title");
	String author = mr.getParameter("author");
	String publisher = mr.getParameter("publisher");
	int fixedprice = Integer.parseInt(mr.getParameter("fixedprice"));
	int stock = Integer.parseInt(mr.getParameter("stock"));
	int discountrate = Integer.parseInt(mr.getParameter("discountrate"));
	String publishdate = mr.getParameter("publishdate");
	String introduce = mr.getParameter("introduce");
	String imagename = null;
	String detailname = null;
	if(mr.getFilesystemName("imagefile") != null){
		imagename = mr.getFilesystemName("imagefile");
	}
	if(mr.getFilesystemName("detailimage") != null){
		detailname = mr.getFilesystemName("detailimage");
	}
	
	BookDao bookDao = new BookDao();
	Book book = new Book();
	book = bookDao.bookSearchDetailByNo(bookno);
	book.setMainCartegory(maincartegory);
	book.setSubCartegory(subcartegory);
	book.setTitle(title);
	book.setAuthor(author);
	book.setPublisher(publisher);
	book.setFixedPrice(fixedprice);
	book.setStock(stock);
	book.setDiscountRate(discountrate);
	book.setPublishDate(publishdate);
	book.setIntroduce(introduce);

	if(imagename != null){
		book.setImage(imagename);	
	} else {
		book.setImage(book.getImage());
	}
	if(detailname != null) {
		book.setDetailImage(detailname);	
	} else {
		book.setDetailImage(book.getDetailImage());
	}
	
	
	bookDao.updateBook(book);
	
	response.sendRedirect("booklist.jsp?pno=1");
	
	
%>