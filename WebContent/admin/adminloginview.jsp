<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>silverstar</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
</head>
<style>
	hr {text-align: left; color: black; margin-left: 0px; width: 1000px; }
</style>

<body>
<%@ include file="header.jsp" %>
<div class="container" style="min-width:1080px; margin-top: 50px;">

	<div class="row">
	<h1>은성문고 로그인</h1>
		<%
			String fail = request.getParameter("fail");
			if(fail != null && "invalid".equals(fail)){
		%>
			<div class="alert alert-danger">
				<strong>[로그인 실패]</strong> 아이디 혹은 비밀번호를 확인해주세요.
			</div>
		<%
			}
		%>
	<hr class="one">
	</div>
	<div class="row">
		<div class="col-sm-2">
			
		</div>
		<div class="col-sm-offset-2 col-sm-4">
		<h3>관리자 로그인</h3>
			<form id="login-form" class="well" method="post" action="adminlogin.jsp">
				<div class="form-group" >
					<label>아이디</label>
					<input type="text" class="form-control" id="id-field" name="id" placeholder="대/소문자 구분하여 입력하세요" />
				</div>
				<div class="form-group">
					<label>비밀번호</label>
					<input type="password" class="form-control" id="pwd-field" name="pwd" placeholder="대/소문자 구분하여 입력하세요" />
				</div>
				<div class="text-right">
					<input type="submit" class="btn btn-primary" value="로그인" />
				</div>
			</form>
		</div>
		<div class="col-sm-offset-2 col-sm-3">
			
		</div>
	</div>

</div>
</body>
</html>
    