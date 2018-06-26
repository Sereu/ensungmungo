<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-default" style="background-color: #222;" >
	<div class="container-fluid">
		<div class="navbar-header">
	      		<a class="navbar-brand" href="adminmain.jsp?pno=1">은성문고 관리자페이지</a>
	    </div>
		<ul class="nav navbar-nav" >
			<li><a href="../main/index.jsp" class="btn btn-default">문고메인</a></li>
			<li><a href="adminmain.jsp" class="btn btn-default">홈</a></li>	
			<li><a href="booklist.jsp?pno=1&col=book_no&sort=desc" class="btn btn-default">도서 관리</a></li>	
			<li><a href="customerlist.jsp?pno=1" class="btn btn-default">회원 관리</a></li>	
			<li><a href="qnaview.jsp?pno=1" class="btn btn-default">Q&A 관리</a></li>	
			<li><a href="reviewlist.jsp?pno=1" class="btn btn-default">리뷰 관리</a></li>	
			<li><a href="statistics.jsp" class="btn btn-default">통계</a></li>	
		<%
			if(session.getAttribute("loginedAdmin") == null) {
		%>			
				<li><a href="adminloginview.jsp" class="btn btn-default">관리자 로그인</a></li>
		<%
			} else {
		%>
				<li><a href="adminlogout.jsp" class="btn btn-default">관리자 로그아웃</a></li>
		<%
			}
		%>
		</ul>
	</div>
</nav>
