<%@page import="silverstar.customer.CustomerGrade"%>
<%@page import="silverstar.customer.CustomerDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>

<style>
	
	th, td {
		border: 1px;
		border-left: none;
		border-right: none;
		padding:8px;
		text-align:center;
	}
	tr {
		background-color:white;
		text-align:center;
	}
	.column {
            padding:20px;
            width: 270px;
    }
    .menu ul, .aside ul {
            list-style-type: none;
            margin=0;
            padding=0;
            text-align:center;
    }
    .menu li, .aside li{
            padding: 8px;
            margin-bottom: 8px;
            background-color: cornflowerblue;
            color: white;
            text-align:center;
    }
    
</style>
<body>
<%@ include file="../navigation/header.jsp" %>
<%@ include file="../navigation/recentbookview.jsp" %>
<%
	request.setCharacterEncoding("utf-8");
	Customer cust = (Customer) session.getAttribute("loginedCustomer");
%>

<div class="container" style="min-width:1080px; margin-top:10px;">
	<div class="row">
			<div class="col-sm-3">
				<h2>마이룸</h2>
				<div class="column menu">
					<ul>
						<li><a href="myorderlist.jsp">구매내역 관리</a></li>
						<li><a href="../bookstore/cartview.jsp">장바구니</a></li>
						<li><a href="updatemyinfo.jsp">회원정보 수정</a></li>
						<li><a href="reconfirmpwd.jsp">회원 탈퇴</a></li>
					</ul>
				</div>
			</div>
			<div class="col-sm-9">
				<h4><span class="glyphicon glyphicon-tower"></span> 나의 등급 현황</h4>
				<form id="grade-form" class="well">
					<table style="width: 700px; border-right:none; border-left:none; text-align: center;">
						<tbody>
							<tr>
								<th rowspan="2">
									<p>현재등급</p>
									<%
										String grade = cust.getCustomerGrade();
										CustomerDao custDao = new CustomerDao();
										CustomerGrade custgrade = custDao.getCustomerGrade(grade);
									%>
									<img src="../images/<%=custgrade.getImage() %>" width="90" height="80" />
									<p>포인트 : <%=cust.getCustomerPoint() %>p</p>
								</th>
								<th>
									<img src="../images/grade.JPG" width="600" height="150" />
									
								</th>
						</tbody>
					</table>	
				</form>
				<h4><span class="glyphicon glyphicon-tags"></span> 비밀번호 재확인</h4>
				<p>회원님의 정보를 안전하게 보호하기 위해 비밀번호를 다시 한 번 확인합니다.</p>
				<hr>
				<%	
					String fail = request.getParameter("fail");
					if(fail != null && "invalid".equals(fail)){
				%>
					<div class="alert alert-danger">
						<strong>[확인 실패]</strong> 아이디 혹은 비밀번호를 확인해주세요.
					</div>
				<%
					}
				%>
				
				<div class="col-sm-offset-2 col-sm-6"> 
					<form id="login-form" class="well" method="post" action="deletecustomer.jsp">
						<div class="form-group" >
							<label>아이디</label>
							<input type="text" class="form-control" id="id-field" name="id" value="<%=cust.getCustomerId() %>" readonly="readonly"/>
						</div>
						<div class="form-group">
							<label>비밀번호</label>
							<input type="password" class="form-control" id="pwd-field" name="pwd" placeholder="대/소문자 구분하여 입력하세요" />
						</div>
						<div class="text-right">
						<input type="submit" class="btn btn-danger" value="탈퇴" />
				</div>
				</form>
				</div>
			</div>
		</div>
</div>
		<%@ include file="../navigation/footer.jsp" %>	
</body>
</html>
    