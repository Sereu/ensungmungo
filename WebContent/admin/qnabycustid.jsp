<%@page import="java.util.HashMap"%>
<%@page import="silverstar.utils.StringUtils"%>
<%@page import="com.google.gson.GsonBuilder"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="silverstar.qna.QnaAsk"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.qna.QnA"%>
<%@page import="silverstar.qna.QnADao"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	GsonBuilder gsonBuilder = new GsonBuilder();
	gsonBuilder.registerTypeAdapter(Date.class, new StringUtils.DateSerializer());
	Gson gson = gsonBuilder.create();

	String custId = request.getParameter("custId");
	
	CustomerDao customerDao = new CustomerDao();
	Customer customer = customerDao.getCustomerById(custId);
	int custNo = customer.getCustomerNo();
	
	
	QnADao qnADao = new QnADao();
	
	final int rows = 5;
	int records = qnADao.getAllCountsQnAByCust(custNo);
	int pages = (int) (Math.ceil( (double) records/rows));
	int currentPage = Integer.parseInt(request.getParameter("pno"));
	int beginIndex = (currentPage -1) * rows + 1;
	int endIndex = currentPage * rows;
	
	HashMap<String, Object> param = new HashMap<>();
	param.put("beginIndex", beginIndex);
	param.put("endIndex", endIndex);
	param.put("customerNo", custNo);
	
	List<QnA> qnAs = qnADao.getQnAsByRangeByCustNo(param);
	
	List<QnA> qnas = new ArrayList<>();
	
	for(QnA qnA : qnAs) {
		QnaAsk qnaAsk = qnADao.getQnaAskByNo(qnA.getQnaNo());
		if(qnaAsk == null) {
			qnA.setQnaContents("N");
		}
		int i = 0;
		qnas.add(i, qnA);
		i += 1;
	}
	HashMap<String, Object> data = new HashMap<>();
	data.put("pages",pages );
	data.put("qnas", qnas);
	String text = gson.toJson(data);
	out.write(text);
	
%>