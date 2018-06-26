<%@page import="silverstar.qna.QnA"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.qna.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	QnADao qnADao = new QnADao();
	CustomerDao customerDao = new CustomerDao();
	
	String customerId = request.getParameter("customer-id");
	Customer customer = customerDao.getCustomerById(customerId);
	int customerNo = customer.getCustomerNo();
	String qnaTitle = request.getParameter("qna-title").trim();
	String qnaContents = request.getParameter("qna-contents").trim();
	
	QnA qna = new QnA();
	qna.setCustomerNo(customerNo);
	qna.setQnaTitle(qnaTitle);
	qna.setQnaContents(qnaContents);
	
	if("".equals(qnaTitle)) {
		response.sendRedirect("qnaform.jsp?send=nullTitle");
	} else if("".equals(qnaContents)) {	
		response.sendRedirect("qnaform.jsp?send=nullContents");
	} else {
		qnADao.insertQnA(qna);
		response.sendRedirect("qnaview.jsp?pno=1");
	}
%>