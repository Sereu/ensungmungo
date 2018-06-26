<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="text-right" >
		<form class="form-inline" method="get" action="/silverstar/bookstore/search.jsp" >
			<div class="form-group">
				<select name="opt" class="form-control">
					<option value="T"> 제목</option>
					<option value="P"> 출판사</option>
					<option value="A"> 작가</option>
				</select>
			</div>
			<div class="form-group">
				<input type="text" name="keyword" class="form-control"/>
			</div>
			<input type="submit" class="btn btn-default btn-sm" value="검색"/>
		</form>
	</div>
</body>
</html>