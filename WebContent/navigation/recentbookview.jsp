<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="java.util.ArrayList"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="panel" style="position:fixed; top:100px; margin-right:-500px; right:35%">
<%
	List<Integer> recentBooks = new ArrayList<Integer>();
	if(session.getAttribute("recentBook") == null){
		session.setAttribute("recentBook", recentBooks);
	}
	recentBooks = (List<Integer>)session.getAttribute("recentBook");
	if(request.getParameter("bookno") != null){
		int bookno = Integer.parseInt(request.getParameter("bookno"));
		for(int i = 0; i <recentBooks.size();i++) { 
			if(recentBooks.get(i) == bookno){
				recentBooks.remove(i);
			}
		}
		recentBooks.add(bookno);
		if(recentBooks.size() > 4) {
			recentBooks.remove(0);
		}
	}
%>
    <ul class="list-group">
      	<li class="list-group-item" style="text-align:center"><span>내가 본 책</span></li>
      	<% 
    	BookDao recentbookdao = new BookDao();
      	for(int i = recentBooks.size()-1; i >= 0 ; i--) { 
      		Book recentbook = recentbookdao.bookSearchDetailByNo(recentBooks.get(i));
      	%>	
      	<li class="list-group-item" style="text-align:center"><a href="../bookstore/bookdetail.jsp?bookno=<%=recentbook.getNo()%>"><img src="../images/cover/<%=recentbook.getImage() %>" class="img-thumbnail" width="56px" height="72px"/><br/><small><%=(recentbook.getTitle().length() > 10) ? recentbook.getTitle().substring(0,9) : recentbook.getTitle() %></small></a></li>
      	<%}%>
    </ul>
</div>
<%session.setAttribute("recentImages", recentBooks);%>