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
<div class="container">

	<%
  		String fail = request.getParameter("fail");
  	
		if(fail != null && "notTitle".equals(fail)){  	
  	%>
  		<div>
  			<p style="color:red">책 제목을 입력해주세요.</p>
  		</div>
  	<%
		} else if(fail != null && "notAuthor".equals(fail)){  	
	%>
		<div>
  			<p style="color:red">저자를 입력해주세요.</p>
  		</div>
	<%
		} else if(fail != null && "notPublisher".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">출판사를 입력해주세요.</p>
	  		</div>		  	
		<%
		} else if(fail != null && "notFixedPrice".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">정가를 입력해주세요.</p>
	  		</div>		  	
		<%
		} else if(fail != null && "notStock".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">재고를 입력해주세요.</p>
	  		</div>		  	
		<%
		} else if(fail != null && "notDiscountrate".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">할인율을 입력해주세요.</p>
	  		</div>		  	
		<%
		} else if(fail != null && "notPublishdate".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">출판일을 입력해주세요.</p>
	  		</div>		  	
		<%
		} else if(fail != null && "notIntroduce".equals(fail)){  	
			%>
			<div>
	  			<p style="color:red">책소개를 입력해주세요.</p>
	  		</div>		  	
		<%
		}
  	%>
	<form method="post" action="addbook.jsp" enctype="multipart/form-data">
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
					<th colspan="5"><h1>도서등록</h1></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>책 이미지</td>		
					<td>카테고리</td>		
					<td>
						<select name="maincartegory" class="form-control" onchange="getsubcategory(event);">
					  		<option value="">메인메뉴</option>
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
							<option value="">서브메뉴</option>
						</select>
					</td>		
				</tr>
				<tr>
					<td rowspan="5"><input name = "imagefile" type="file" /></td>	
					<td>제목</td>		
					<td colspan="3"><input type="text" name="title" class="form-control"></td>		
				</tr>
				<tr>
					<td>저자</td>		
					<td><input type="text" name="author" class="form-control"></td>		
					<td>출판사</td>		
					<td><input type="text" name="publisher" class="form-control"></td>		
				</tr>
				<tr>
					<td>정가</td>		
					<td><input type="number" name="fixedprice" class="form-control" placeholder="숫자만 입력해주세요."></td>		
					<td>재고</td>		
					<td><input type="number" name="stock" class="form-control" placeholder="숫자만 입력해주세요."></td>		
				</tr>
				<tr>
					<td>할인율</td>		
					<td><input type="number" name="discountrate"class="form-control" placeholder="0~100 사이의 값을 입력해주세요."></td>		
					<td>출간일</td>		
					<td><input type="date" name="publishdate"class="form-control"></td>		
				</tr>
				<tr>
					<td colspan="4"></td>				
				</tr>
				<tr>
					<td colspan="5">책소개</td>
				</tr>
				<tr>
					<td colspan="5"><textarea name="introduce" class="form-control" rows="5"></textarea></td>
				</tr>
				<tr>
					<td colspan="5">상세이미지</td>
				</tr>
				<tr>
					<td colspan="5"><input name="detailimage" type="file" /></td>
				</tr>
				
			</tbody>
			
		</table>
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