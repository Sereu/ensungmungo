<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
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
	<style>
		table {
			min-width: 960px;
		}
	</style>
</head>
<body>

<%
	int bookno = Integer.parseInt(request.getParameter("bookno"));
	
	BookDao bookDao = new BookDao();

	Book book = bookDao.bookSearchDetailByNo(bookno);

%>

<div class="container">
	<form method="post" action="updatebook.jsp" enctype="multipart/form-data">
		<table class="table">
		<!-- 
		출간일, 책소개, 저자소개, 상세이미지
		-->
			<colgroup>
				<col width="24%">
				<col width="11%">
				<col width="27%">
				<col width="11%">
				<col width="27%">
			</colgroup>
			<thead>
				<tr>
					<th colspan="5"><h1>도서수정</h1></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>책 이미지</td>		
					<td>카테고리</td>		
					<td>
						<select name="maincartegory" class="form-control" onchange="getsubcategory(event);">
					  		<option value="<%=book.getMainCartegory()%>"><%=book.getMainCartegory()%></option>
					  		<option value="소설">소설</option>
					  		<option value="만화">만화</option>
					  		<option value="인문">인문</option>
					  		<option value="시/에세이">시/에세이</option>
						</select>
					</td>		
					<td>서브카테고리</td>		
					<!-- 아래의 내용은 선택한 카테고리에 따라 다르게 출력되도록 만든다. -->
					<td>
						<select name="subcartegory"class="form-control" id ="sub-form">
							<option value="<%=book.getSubCartegory()%>"><%=book.getSubCartegory()%></option>
						</select>
					</td>		
				</tr>
				<tr>
					<td rowspan="5"><input name = "imagefile" value="<%=book.getImage()%>"type="file" /></td>	
					<td>제목</td>		
					<td colspan="3"><textarea name="title" class="form-control" rows="1"><%=book.getTitle()%></textarea></td>		
				</tr>
				<tr>
					<td>저자</td>		
					<td><input type="text" name="author" value="<%=book.getAuthor()%>" class="form-control"></td>
					<td>출판사</td>
					<td><input type="text" name="publisher" value="<%=book.getPublisher()%>" class="form-control"></td>
				</tr>
				<tr>
					<td>정가</td>
					<td><input type="number" name="fixedprice" class="form-control" value="<%=book.getFixedPrice()%>" placeholder="숫자만 입력해주세요."></td>
					<td>재고</td>
					<td><input type="number" name="stock" class="form-control" value="<%=book.getStock()%>" placeholder="숫자만 입력해주세요."></td>
				</tr>
				<tr>
					<td>할인율</td>		
					<td><input type="number" name="discountrate"class="form-control" value="<%=book.getDiscountRate()%>" placeholder="0~100 사이의 값을 입력해주세요."></td>		
					<td>출간일</td>		
					<td><input type="date" name="publishdate" value="<%=book.getPublishDate().substring(0, 4)+"-"+book.getPublishDate().substring(6,8)+"-"+book.getPublishDate().substring(10,12)%>" class="form-control"></td>		
				</tr>
				<tr>
					<td colspan="4"></td>				
				</tr>
				<tr>
					<td colspan="5">책소개</td>
				</tr>
				<tr>
					<td colspan="5"><textarea name="introduce" class="form-control" rows="5"><%=book.getIntroduce() %></textarea></td>
				</tr>
				<tr>
					<td colspan="5">상세이미지</td>
				</tr>
				<tr>
					<td colspan="5"><input name="detailimage" value="<%=book.getDetailImage()%>" type="file" /></td>
				</tr>
			</tbody>
		</table>
		<input type="hidden" name="bookno" value="<%=book.getNo()%>"/>
		<div style="text-align: center;">
			<button class="btn btn-primary">등록</button>
			<a href="booklist.jsp"class="btn btn-default">취소</a>
		</div>
		
	</form>
</div>
</body>
<script type="text/javascript">
	function getsubcategory(event) {
		event.preventDefault();
		
		var value = event.target.value;
		
		var xhr = new XMLHttpRequest();
		
		xhr.onreadystatechange = function() {
			if(xhr.readyState == 4 && xhr.status == 200) {
				var subCategory = xhr.responseText;
				var arr = subCategory.split(", ");
				
				var html = "";
				for(var i = 0; i <arr.length; i ++) {
					var sub = arr[i].trim();
					html += "<option value='"+sub+"'>" + sub + "</option>";
				}
				
				var el = document.getElementById("sub-form");
				el.innerHTML = html;
			}
		}
		
		xhr.open("GET","subcategorydata.jsp?maincategory="+value);
		
		xhr.send();
	}
</script>
</html>