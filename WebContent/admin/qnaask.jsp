<%@page import="silverstar.qna.QnaAsk"%>
<%@page import="silverstar.qna.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	
	request.setCharacterEncoding("UTF-8");
	
	String pno = request.getParameter("pno");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaAskTitle = request.getParameter("qna-ask-title");
	String qnaAskContents = request.getParameter("qna-ask-contents");
	
	QnaAsk qnaAsk = new QnaAsk();
	qnaAsk.setQnaNo(qnaNo);
	qnaAsk.setQnaAskTitle(qnaAskTitle);
	qnaAsk.setQnaAskContents(qnaAskContents);
	
	QnADao qnADao = new QnADao();
	
	if("".equals(qnaAskTitle)) {
		response.sendRedirect("qnaaswer.jsp?pno="+pno+"qnaNo="+qnaNo);
	} else if("".equals(qnaAskContents)) {
		response.sendRedirect("qnaanswer.jsp?pno="+pno+"qnaNo="+qnaNo);
	}
	
	qnADao.insertQnaAnswer(qnaAsk,qnaNo);
	response.sendRedirect("qnaview.jsp?pno="+pno);
	
	
%>