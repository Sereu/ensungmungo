<%@page import="silverstar.bookstore.SearchDao"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>silverstar</title>
	<meta charset="utf-8">
  	<meta name="viewport" content="width=device-width, initial-scale=1">
  	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
  	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  	<style type="text/css">
  		.highlight {
  			background: #CEECF5;
  		}
  	</style>
  	<script>
  	 function btnclick(el) {
  		 event.preventDefault();//a 태그의 기본동작 방해
 		 for(var i = 1; i < 13; i++){
 			 
   			document.getElementById("btn"+ i).style.color = "#2D67A8";	
   			document.getElementById("td"+ i).style.background = "white";	
   		 }
   		 var btn = document.getElementById(event.target.id);
   		 var td = document.getElementById(event.target.id.replace("btn","td"));
   		 btn.style.color = "white";
   		 td.style.background = "#2D67A8";
   		 
   		 var id =el;
  		 //xhr 객체생성
  		 var xhr = new XMLHttpRequest();
  		 //초기화
  		 xhr.onreadystatechange = function() {
  			if(xhr.readyState == 4 && xhr.status == 200){
  				var categorybooks = xhr.responseText;
  				var book = JSON.parse(categorybooks);
				var rows = "";
				var rows2 = "";
				for(var i=0; i<book.length; i++){
					var item = book[i];
					rows += "<div class='col-sm-3'><p style='color:#1b497c'><strong>0";
					rows += (i+1) + ". ";
					rows += item.title.substring(0,11);
					
					rows += "</strong></p></div>";
					
					rows2 += "<div class='col-sm-3'><a href='../bookstore/bookdetail.jsp?bookno=";
					rows2 += item.no + "'><img src='../images/cover/" + item.image; 
					rows2 += "' class='img-thumbnail' width='170px' height='200px'/></a></div>";
				}
				document.getElementById("categorytitle").innerHTML = rows;
				document.getElementById("categoryinfo").innerHTML = rows2;
			}
  		}
  		xhr.open("GET","index-data.jsp?category=" + id);
  		//보내기
  		xhr.send();
  	 }
  	 function nbtnclick(el) {
    		event.preventDefault();//a 태그의 기본동작 방해
    		 for(var i = 1; i < 13; i++){
    			 document.getElementById("ntd"+ i).setAttribute("class", "");
      		 }
    		 var td = document.getElementById(event.target.id.replace("nbtn","ntd"));
       		 td.setAttribute("class", "highlight");
      		 
      		var id =el;
     		//xhr 객체생성
     		var xhr = new XMLHttpRequest();
     		//초기화
     		xhr.onreadystatechange = function() {
     			if(xhr.readyState == 4 && xhr.status == 200){
     				var newbooks = xhr.responseText;
     				var book = JSON.parse(newbooks);
   					var rows = "";
   					var rows2 = "";
   					var rows3 = "";
   					for(var i=0; i<book.length; i++){
   						var item = book[i];
   						rows += "<th style='text-align:center'><a href='../bookstore/bookdetail.jsp?bookno="+item.no+"'><img src='../images/cover/"+item.image+"' class='img-thumbnail' width='111px' height='120px'/></a></th>"
   						rows2 += "<td>" + item.title.substring(0,8) + "</td>";
   						rows3 += "<td>"+ item.introduce.substring(0,28)+ "</td>";
   					}
   					document.getElementById("newimage").innerHTML = rows;
   					document.getElementById("newtitle").innerHTML = rows2;
   					document.getElementById("newintroduce").innerHTML = rows3;
   				}
     		}
     	  	xhr.open("GET","index-data2.jsp?category=" + id);
     	  	//보내기
     	  	xhr.send();
  	 }
  	 function selectCategory() {
  		var highlight = document.querySelector('td.highlight').id;
  		var num = highlight.replace("ntd","");
  		var cnum = num - 0 + 10;
  		document.querySelector('a.movetoCategory').setAttribute("href","../bookstore/booklist.jsp?maincategory="+cnum);
  	 }
  	</script>
</head>
<body>
	<!-- header  -->
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
	<!-- 스크립트까지 같이 붙여넣기해야 서브메뉴가 동작합니다 -->
	
	<!-- recentbookview 플로팅 메뉴-->
	<%@ include file="../navigation/recentbookview.jsp" %>
  	<%
		SearchDao searchDao = new SearchDao();
  		List<Book> books = searchDao.famousBooklists();
  		String mainCategory = "소설";
  		int i = 1;
  	%>
  	<div class="row" style="margin-top: -25px; background-color: #d7e3ef; height:509px">
  	<!-- 화제의 책 공간 -->			
  		<div class="container">
			<div class="row" style="margin-top:30px; padding:10px">
				<span style="font-size: 33px; color: #1b497c"><strong>화제의 책 &nbsp;</strong></span>
			</div>
			<div class="row" id="categorytitle" style="padding:10px">
				<%
				List<Book> categorybooks = searchDao.famousCategorylists(mainCategory);
				for (Book book : categorybooks) {
				%>
				<div class="col-sm-3"><p style="color:#1b497c"><strong>0<%=i++ %>. <%=(book.getTitle().length() > 12 ) ? book.getTitle().substring(0,11) : book.getTitle() %></strong></p>
				</div>
				<% } %>
			</div>
			<div class="row">
				<div  id="categoryinfo" style="margin-top:-10px; height:320px">
				<% for (Book book : categorybooks) { %>
					<div class="col-sm-3"><a href="../bookstore/bookdetail.jsp?bookno=<%=book.getNo() %>" ><img src="../images/cover/<%=book.getImage() %>" class="img-thumbnail" width="170px" height="200px"/></a>
					</div>
				<% } %>
				</div>
			</div>
			<div class="row" style="margin-top: -15px">
				<table class="table">
					<tbody>
						<tr style="background-color:white" style="text-align:center">
							<td id="td1" style="background-color:#2D67A8; text-align:center"><a href="#" id="btn1" style="color:white" onmouseover="btnclick('소설')">소설</a></td>
							<td id="td2" style="text-align:center"><a href="#" id="btn2" style="color:#2D67A8" onmouseover="btnclick('인문')">인문</a></td>
							<td id="td3" style="text-align:center"><a href="#" id="btn3" style="color:#2D67A8" onmouseover="btnclick('그림책')">그림책</a></td>
							<td id="td4" style="text-align:center"><a href="#" id="btn4" style="color:#2D67A8" onmouseover="btnclick('역사/문화')">역사/문화</a></td>
							<td id="td5" style="text-align:center"><a href="#" id="btn5" style="color:#2D67A8" onmouseover="btnclick('과학')">과학</a></td>
							<td id="td6" style="text-align:center"><a href="#" id="btn6" style="color:#2D67A8" onmouseover="btnclick('어린이(초등)')">어린이</a></td>
							<td id="td7" style="text-align:center"><a href="#" id="btn7" style="color:#2D67A8" onmouseover="btnclick('만화')">만화</a></td>
							<td id="td8" style="text-align:center"><a href="#" id="btn8" style="color:#2D67A8" onmouseover="btnclick('경제/경영')">경제/경영</a></td>
							<td id="td9" style="text-align:center"><a href="#" id="btn9" style="color:#2D67A8" onmouseover="btnclick('자기계발')">자기계발</a></td>
							<td id="td10" style="text-align:center"><a href="#" id="btn10" style="color:#2D67A8" onmouseover="btnclick('정치/사회')">정치/사회</a></td>
							<td id="td11" style="text-align:center"><a href="#" id="btn11" style="color:#2D67A8" onmouseover="btnclick('시/에세이')">시/에세이</a></td>
							<td id="td12" style="text-align:center"><a href="#" id="btn12" style="color:#2D67A8" onmouseover="btnclick('외국어')">외국어</a></td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>

<div class="container" style="margin-top:10px">	
	<!-- 인기차트 -->
  	<div class="row" style="margin-top: 15px" >
  		<div class="col-sm-4">
  			<div class="panel">	
    			<div class="panel-heading" style="background-color:#4587d1">
    				<strong style="color:white">인기차트</strong><p style="float:right"><small><a href="mainstatistics.jsp" style="color:white">통계 가기 >></a></small></p>
    			</div>
  				<div class="panel-body">
    			<%
    			 i = 1;
    			for (Book b : books) {%>
    			<p class="text-primary"><a href="../bookstore/bookdetail.jsp?bookno=<%=b.getNo() %>" style="color:black"><span class="label label-<%if(i == 1) {%>danger<%} else {%>primary<%}%>"><%=i++ %></span> <small><%=(b.getTitle().length() > 17) ? b.getTitle().substring(0,17) : b.getTitle() %></small></a></p>
    			<%}%>
    			</div>
  			</div>
    	</div>	
    <!-- 슬라이드 -->
    	<div class="col-sm-7" style="margin-left:-28px">
    		<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    		<div class="w3-content w3-display-container" style="width:645px; height:407px">
  				<img class="mySlides" src="../images/slideimage1.jpg" style="width:100%">
  				<img class="mySlides" src="../images/slideimage2.jpg" style="width:100%">
 				<img class="mySlides" src="../images/slideimage3.jpg" style="width:100%">

  				<button class="w3-button w3-black w3-display-left" onclick="plusDivs(-1)">&#10094;</button>
  				<button class="w3-button w3-black w3-display-right" onclick="plusDivs(1)">&#10095;</button>
			</div>

<script>
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
  showDivs(slideIndex += n);
}

function showDivs(n) {
  var i;
  var x = document.getElementsByClassName("mySlides");
  if (n > x.length) {slideIndex = 1}    
  if (n < 1) {slideIndex = x.length}
  for (i = 0; i < x.length; i++) {
     x[i].style.display = "none";  
  }
  x[slideIndex-1].style.display = "block";  
}
</script>

		</div>
    </div>
 
  	<div class="row" style="margin-top: 15px" >
  	<!-- 신간도서 -->
    	<div class="col-sm-9 ext-center">
    	<% int category = 10; %>
			<span style="margin:10px; font-size: 12px;"><strong>새 도서&nbsp;</strong></span>
			<span style="float: right"><small><a class="movetoCategory" href="../bookstore/booklist.jsp?maincategory=10" onclick="selectCategory()">&raquo; 더 보기</a></small></span>
			<table class="table">
					<tbody>
						<tr style="font-size: 12px">
						<td id="ntd1"><a href="#" id="nbtn1" onmouseover="nbtnclick('소설')">소설</a></td>
						<td id="ntd2"><a href="#" id="nbtn2" onmouseover="nbtnclick('만화')">만화</a></td>
						<td id="ntd3"><a href="#" id="nbtn3" onmouseover="nbtnclick('인문')">인문</a></td>
						<td id="ntd4"><a href="#" id="nbtn4" onmouseover="nbtnclick('시/에세이')">시/에세이</a></td>
						<td id="ntd5"><a href="#" id="nbtn5" onmouseover="nbtnclick('그림책')">그림책</a></td>
						<td id="ntd6"><a href="#" id="nbtn6" onmouseover="nbtnclick('역사/문화')">역사/문화</a></td>
						<td id="ntd7"><a href="#" id="nbtn7" onmouseover="nbtnclick('과학')">과학</a></td>
						<td id="ntd8"><a href="#" id="nbtn8" onmouseover="nbtnclick('어린이(초등)')">어린이</a></td>
						<td id="ntd9"><a href="#" id="nbtn9" onmouseover="nbtnclick('경제/경영')">경제/경영</a></td>
						<td id="ntd10"><a href="#" id="nbtn10" onmouseover="nbtnclick('자기계발')">자기계발</a></td>
						<td id="ntd11"><a href="#" id="nbtn11" onmouseover="nbtnclick('정치/사회')">정치/사회</a></td>
						<td id="ntd12"><a href="#" id="nbtn12" onmouseover="nbtnclick('외국어')">외국어</a></td>
					</tr>
				</tbody>
			</table>
			<table class="table" style="text-align:center">
				<thead>
					<tr id="newimage">
						<%
						List<Book> newbooks = searchDao.newCategorylists(mainCategory);
						for (Book nbook : newbooks) {
						%>
						<th style="text-align:center"><a href="../bookstore/bookdetail.jsp?bookno=<%=nbook.getNo() %>"><img src="../images/cover/<%=nbook.getImage() %>" class="img-thumbnail" width="111px" height="120px"/></a></th>
						<% } %>
					</tr>
				</thead>
				<tbody>
					<tr id="newtitle">
						<% for (Book nbook : newbooks) { %>
						<td><%=(nbook.getTitle().length() > 9) ? nbook.getTitle().substring(0,8) : nbook.getTitle() %></td>
						<% } %>
					</tr>
					<tr id="newintroduce"  style="font-size:13px">
						<% for (Book nbook : newbooks) { %>
						<td><%=(nbook.getIntroduce().length() > 28) ? nbook.getIntroduce().substring(0,28) : nbook.getIntroduce()%></td>
						<% } %>
					</tr>
				</tbody>
			</table>
  		</div>
  	<!-- 맵 -->
  		<div class="col-sm-3">
  			<div class="panel" style="height:330px; width:220px; margin-top:20px">
    				<div id="map" style="height:300px; width:210px"></div>
    				<script>
				      function initMap() {
				        var uluru = {lat: 37.573141, lng: 126.992037};
				        var map = new google.maps.Map(document.getElementById('map'), {
				          zoom: 17,
				          center: uluru
				        });
				        var marker = new google.maps.Marker({
				          position: uluru,
				          map: map
				        });
				      }
				    </script>
    				<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAMsfZrOXyjGNLx8rh6MrGJzHJrq9CGtBg&callback=initMap">
    				</script>
    			</div>
    	</div>
    </div>
 </div>
	<!-- footer -->
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>