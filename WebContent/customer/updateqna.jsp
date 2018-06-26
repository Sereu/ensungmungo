<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.qna.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

	request.setCharacterEncoding("UTF-8");

	String pno = request.getParameter("pno");
	int qnaNo = Integer.parseInt(request.getParameter("qnaNo"));
	String qnaTitle = request.getParameter("qna-title");
	String qnaContents = request.getParameter("qna-contents");
	String qnaPw = request.getParameter("customer-pw");
	String id = request.getParameter("customer-id");
	String sort = request.getParameter("sort");
	
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.getCustomerById(id);
	
	QnADao qnADao = new QnADao();
	HashMap<String, Object> param = new HashMap<>();
	param.put("qnaNo", qnaNo);
	param.put("qnaTitle", qnaTitle);
	param.put("qnaContents", qnaContents);
	
	
	if("".equals(qnaTitle)) {
		response.sendRedirect("updateqnaform.jsp?pno="+pno+"&qnaNo="+qnaNo+"&send=nullTitle");
	} else if("".equals(qnaContents)) {	
		response.sendRedirect("updateqnaform.jsp?pno="+pno+"&qnaNo="+qnaNo+"&send=nullContents");
	} else if("".equals(qnaPw)){
		response.sendRedirect("updateqnaform.jsp?pno="+pno+"&qnaNo="+qnaNo+"&send=nullPw");
	} else if(!qnaPw.equals(customer.getCustomerPw())) {
		response.sendRedirect("updateqnaform.jsp?pno="+pno+"&qnaNo="+qnaNo+"&send=differentPw");
	} else if("update".equals(sort)) {
		qnADao.updateQnA(param);
		response.sendRedirect("qnadetail.jsp?pno="+pno+"&qnaNo="+qnaNo);
	} else if("delete".equals(sort)) {
		qnADao.deleteQnA(qnaNo);
		response.sendRedirect("qnaview.jsp?pno="+pno);
	}
%>