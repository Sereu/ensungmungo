<%@page import="silverstar.qna.QnADao"%>
<%@page import="silverstar.qna.QnaAsk"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String pno = request.getParameter("pno");
	int qnaNo = Integer.parseInt(request.getParameter("qna-no"));
	String qnaAskTitle = request.getParameter("qna-ask-title");
	String qnaAskContents = request.getParameter("qna-ask-contents");
	
	QnADao qnADao = new QnADao();
	
	QnaAsk qnaAsk = new QnaAsk();
	qnaAsk.setQnaNo(qnaNo);
	qnaAsk.setQnaAskTitle(qnaAskTitle);
	qnaAsk.setQnaAskContents(qnaAskContents);
	
	if("".equals(qnaAskTitle)) {
		response.sendRedirect("qnaanswerupdate.jsp?pno="+ pno +"&qnaNo="+qnaNo);
	} else if("".equals(qnaAskContents)) {
		response.sendRedirect("qnaanswerupdate.jsp?pno="+ pno +"&qnaNo="+qnaNo);
	} else {
		qnADao.updateQnaAskByNo(qnaAsk);
		response.sendRedirect("qnaview.jsp?pno="+ pno);
	}
%>