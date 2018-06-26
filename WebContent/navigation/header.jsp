<%@page import="silverstar.qna.QnaAsk"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.customer.Customer"%>
<%@page import="silverstar.qna.QnADao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<nav class="navbar navbar-default navbar-fixed-top"  style="background-color:#ffffff">
	<div class="container" >
    	<div class="navbar-header">
      		<button class="btn btn-lg btn-info" onclick="show();" style="margin-top:13px"><span class="glyphicon glyphicon-th-list"></span></button>
    	</div>
    	<ul class="nav navbar-nav"  style="background-color:#ffffff">
      		<li><a href="../main/index.jsp"><img src="../images/logo.jpg" width="102px" height="38px" style="margin:0px"/></a></li>
    		<li style="margin-top:17px"><%@include file="searchform.jsp" %></li>
    	</ul>
    	<!-- 첫번째 아이콘 - 로그인 전 : 클릭시 로그인 페이지로 이동. 아이콘도 열쇠모양으로 된 것 찾기
    						로그인 후 : 클릭시 마이 페이지로 이동. 아이콘은 사람 모양. -->

    	<ul class="nav navbar-nav navbar-right">    	
    		<%if(session.getAttribute("loginedCustomer") == null) { %>
    		<li><a href="../customer/loginview.jsp"><span class="glyphicon glyphicon-user"></span></a></li>
    		<%} else {%>
    		<li><a href="../customer/logout.jsp"><span class="glyphicon glyphicon-log-out"></span></a></li>
      		<li><a href="../customer/mypageview.jsp"><span class="glyphicon glyphicon-user"></span></a></li>
      		<%
			QnADao qnADaos = new QnADao(); 
			Customer notReadCust = (Customer)session.getAttribute("loginedCustomer");
			int answerCnt = qnADaos.countNotReadAnswer(notReadCust.getCustomerNo());
			List<QnaAsk> qas = qnADaos.getQnaAskByCustNoNotRead(notReadCust.getCustomerNo());
			
			if(answerCnt != 0) {
			%>
			<li class="dropdown">
		        <a class="dropdown-toggle" data-toggle="dropdown" href="#"><button class="btn btn-warning"><%=answerCnt %></button>
		        <span class="caret"></span></a>
		        <ul class="dropdown-menu">
		        
		        <%
		        for(QnaAsk qa : qas){
		        %>
		          <li>
		         	<a href="../customer/qnaaskview.jsp?pno=1&qnaNo=<%=qa.getQnaNo()%>"><%=qa.getQnaAskTitle() %></a>		        	
		          </li>
		        <%
		        }
		        %>
		          
		        </ul>
		      </li>
			<%
			}
      		%>
      		<%} %>
      		<li><a href="../bookstore/cartview.jsp"><span class="glyphicon glyphicon-shopping-cart"></span></a></li>
      		<li><a href="../customer/qnaview.jsp?pno=1"><span class="glyphicon glyphicon-headphones"></span></a></li>
    	</ul>
  </div>
  <div class="container" id="sidebar" style="display : none;">
		<div class="navbar-header">
      	</div>
    	<ul  class="nav navbar-nav">
    		<li><a href="../bookstore/booklist.jsp?maincategory=10">전체도서</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=11">소설</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=12">만화</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=13">인문</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=14">시/에세이</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=15">그림책</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=16">역사/문화</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=17">과학</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=18">어린이(초등)</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=19">경제/경영</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=20">자기개발</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=21">정치/사회</a></li>
      		<li><a href="../bookstore/booklist.jsp?maincategory=22">외국어</a></li>
    	</ul>
  </div>
</nav>
<script>
function showqna() {
	var sidebar = document.getElementById("contents");
	if(contents.style.display == "block"){
		contents.style.display ="none";
	}
	else{
		contents.style.display ="block";	
	}
}
</script>
