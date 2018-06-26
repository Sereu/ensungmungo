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
  <style type="text/css">
  	#style>tr>th {
  		width: 10%;
  	}
  	#style>tr>td {
  		width: 15%
  	}
  </style>
</head>
<body>
<%@ include file="../navigation/header.jsp" %>
	<script type="text/javascript">
	function show() {
		var sidebar = document.getElementById("sidebar");
		if(sidebar.style.display == "block"){
			sidebar.style.display ="none";
		}
		else{
			sidebar.style.display ="block";	
		}
	}
	</script>
	<div class="container" style="margin-top: 100px;">
		<h1>스펙비교</h1>
		<div class="well">
			<div class="row" style="align-items: center">
				<div class="col-sm-2" style="margin-top: 50px;">
					<a class="btn btn-default" onclick="auto()">자동추천</a>
					<button class="btn btn-warning">VS 스펙비교</button>
				</div>
				<div class="col-sm-2" style="margin-left: 10px;" id="img1">
				
				</div>
				<div class="col-sm-2" style="margin-left: 10px;" id="img2">
					
				</div>
				<div class="col-sm-2" style="margin-left: 40px;" id="img3">
					
				</div>
				<div class="col-sm-2" style="margin-left: 50px;" id="img4">
					
				</div>
			</div>
		</div>
		<div style="display: none;">
			<input type="hidden" value=0 id="firstbookNo" >
		</div>
		<table class="table table-bordered">
			<tbody id="style">
				<tr>
					<th>도서명</th>
					<td id="title1"></td>
					<td id="title2"></td>
					<td id="title3"></td>
					<td id="title4"></td>
				</tr>
				<tr>
					<th>장르</th>
					<td id="mainCartegory1"></td>
					<td id="mainCartegory2"></td>
					<td id="mainCartegory3"></td>
					<td id="mainCartegory4"></td>
				</tr>
				<tr>
					<th>가격</th>
					<td id="price1"></td>
					<td id="price2"></td>
					<td id="price3"></td>
					<td id="price4"></td>
				</tr>
				<tr>
					<th>출판사</th>
					<td id="publisher1"></td>
					<td id="publisher2"></td>
					<td id="publisher3"></td>
					<td id="publisher4"></td>
				</tr>
				<tr>
					<th>저자</th>
					<td id="author1"></td>
					<td id="author2"></td>
					<td id="author3"></td>
					<td id="author4"></td>
				</tr>
				<tr>
					<th>출간일자</th>
					<td id="publishdate1"></td>
					<td id="publishdate2"></td>
					<td id="publishdate3"></td>
					<td id="publishdate4"></td>
				</tr>
				<tr>
					<th>판매순위</th>
					<td id="rank1"></td>
					<td id="rank2"></td>
					<td id="rank3"></td>
					<td id="rank4"></td>
				</tr>
				<tr>
					<th>평점</th>
					<td id="star1"></td>
					<td id="star2"></td>
					<td id="star3"></td>
					<td id="star4"></td>
				</tr>
				<tr>
					<th></th>
					<td><a onclick="del(1)" class="btn btn-info">선택 취소</a></td>
					<td><a onclick="del(2)" class="btn btn-info">선택 취소</a></td>
					<td><a onclick="del(3)" class="btn btn-info">선택 취소</a></td>
					<td><a onclick="del(4)" class="btn btn-info">선택 취소</a></td>
				</tr>
			</tbody>
		</table>
		<form  action="getbook.jsp" onsubmit="searchbook(event)">
			<div class="form-group">
				<input type="hidden" value="1" name="pno" id="pno">
				<p>비교할 도서검색:&nbsp;<input type="text" name="bookTitle" id="bookTitle"><input type="submit" value="검색"></p>
			</div>
		</form>
		<table class="table table-bordered">
			<thead>
				<tr>
					<th>도서명</th>
					<th>가격</th>
					<th>출판사</th>
					<th>저자</th>
					<th>출간일자</th>
					<th>비고</th>
				</tr>
			</thead>
			<tbody id="searchedbook-box">
				<tr>
				</tr>
			</tbody>
		</table>
		<div class="text-center">
			<ul class="pagination" id="navi">
				
			</ul>
		</div>
	</div>
	<script type="text/javascript">
		function searchbook(event,pno) {
			
			event.preventDefault();
			
			if(pno){
				document.getElementById("pno").value=pno;
			}
			
			var xhr = new XMLHttpRequest();
			var bookTitle = document.getElementById("bookTitle").value;
			var pno = document.getElementById("pno").value;
			
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var jsonData = xhr.responseText;
					var data = JSON.parse(jsonData);
					var books = data.books;
					var pages = data.pages;
					
					var row = "";
					for(var i=0; i<books.length; i++) {
						var book = books[i];
						row += "<tr>";
						row += "<input type='hidden' id='bookNo"+(i+1)+"' value='"+book.no+"'>"
						row += "<td>"+book.title+"</td>";
						row += "<td>"+numberWithCommas(book.fixedPrice)+"</td>";
						row += "<td>"+book.publisher+"</td>";
						row += "<td>"+book.author+"</td>";
						row += "<td>"+book.publishDate+"</td>";
						row += "<td><a class='btn btn-info' onclick='load("+(i+1)+")'>선택<a>";
						row += "</tr>";
					}
					var rows= "";
					for(var j=1; j<=pages; j++) {
						rows += "<li><a href='#' onclick='searchbook(event, "+j+")'>"+j+"</a></li>";
					}
			
					document.getElementById("searchedbook-box").innerHTML = row;
					document.getElementById("navi").innerHTML = rows;
				}
			}
			xhr.open("GET", "getbook.jsp?bookTitle="+bookTitle+"&pno="+pno);
			xhr.send();
		}
		
		function load(i, bookno) {
			var xhr = new XMLHttpRequest();
			var bookNo = 0;
			
			if(bookno){
				bookNo = bookno
			} else {
				bookNo = document.getElementById("bookNo"+i).value;
			}
			
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var jsonData = xhr.responseText;
					var data = JSON.parse(jsonData);
					var book = data.book;
					var star = data.star;
					var rank = data.rank;
					
					var title = "";
					var fixedPrice = "";
					var publisher = "";
					var publishdate = "";
					var author = "";
					var img = "";
					var page = 0;
					var mainCartegory = "";
					for(var i=1; i<5; i++) {
						if(document.getElementById("title"+i).innerHTML == "") {
							if(i ==1) {
								document.getElementById("firstbookNo").value = book.no;
							}
							page = i;
							break;
						}
					}
							title += book.title;
							fixedPrice += numberWithCommas(book.fixedPrice);
							publishdate += book.publishDate;
							publisher += book.publisher;
							mainCartegory += book.mainCartegory;
							author += book.author;
							rank += rank;
							img += "<a href='bookdetail.jsp?bookno="+book.no+"'><img src='../images/"+book.image+"' width='100%'></a>";
			
					document.getElementById("title"+page).innerHTML = title;
					document.getElementById("price"+page).innerHTML = fixedPrice;
					document.getElementById("publishdate"+page).innerHTML = publishdate;
					document.getElementById("publisher"+page).innerHTML = publisher;
					document.getElementById("author"+page).innerHTML = author;
					document.getElementById("mainCartegory"+page).innerHTML = mainCartegory;
					document.getElementById("rank"+page).innerHTML = rank;
					document.getElementById("star"+page).innerHTML = star;
					document.getElementById("img"+page).innerHTML = img;
				}
			}
			xhr.open("GET", "getbookbyno.jsp?bookNo="+bookNo);
			xhr.send();
		}
		
		function auto() {
			var firstbookNo = 0;
			if(document.getElementById("title1").innerHTML == "") {
				alert("기준이될 첫번째 책을 선택해주세요.");
				document.getElementById("bookTitle").focus();
				return;
			} else {
				firstbookNo = document.getElementById("firstbookNo");
			}
			
			var mainCartegory = document.getElementById("mainCartegory1").innerHTML;
			var firstbookNo = document.getElementById("firstbookNo").value;
			var xhr = new XMLHttpRequest();
			
			xhr.onreadystatechange = function() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					var jsonData = xhr.responseText;
					var bookNos = JSON.parse(jsonData);
					
					for(i=0; i<bookNos.length; i++) {
						var bookNo = bookNos[i];
						
						load((i+2),bookNo);
					}
				}
			}
			xhr.open("GET", "getbookbycartegory.jsp?cartegory="+mainCartegory+"&bookNo="+firstbookNo);
			xhr.send();
		}
		
		function numberWithCommas(x) {
		    return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		}
		
		function del(num) {
			document.getElementById("title"+num).innerHTML = "";
			document.getElementById("price"+num).innerHTML = "";
			document.getElementById("publishdate"+num).innerHTML = "";
			document.getElementById("publisher"+num).innerHTML = "";
			document.getElementById("author"+num).innerHTML = "";
			document.getElementById("mainCartegory"+num).innerHTML = "";
			document.getElementById("rank"+num).innerHTML = "";
			document.getElementById("star"+num).innerHTML = "";
			document.getElementById("img"+num).innerHTML = "";
		}

	</script>
</body>
</html>