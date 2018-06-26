<%@page import="java.util.List"%>
<%@page import="silverstar.bookstore.Book"%>
<%@page import="silverstar.bookstore.BookDao"%>
<%@page import="silverstar.bookstore.StatisticsDao"%>
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
  <script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">
<%
	if(session.getAttribute("loginedAdmin") == null) {
		response.sendRedirect("adminloginview.jsp");
		return;
	}

	StatisticsDao statisticsDao = new StatisticsDao();
	Integer[] prices = new Integer[7];
	Integer[] qty = new Integer[7];
	for(int i =0; i<7; i++) {
		prices[i] = statisticsDao.getSellingPrice(i)/10000;
		qty[i] = statisticsDao.getSellingQty(i);
	}
	
	int bookNoByWoman = statisticsDao.getPopularBookNoByGender("W");
	int bookNoByMan = statisticsDao.getPopularBookNoByGender("M");
	
	BookDao bookDao = new BookDao();
	Book bookByWoman = bookDao.bookSearchDetailByNo(bookNoByWoman);
	Book bookByMan = bookDao.bookSearchDetailByNo(bookNoByMan);
	
	List<Book> rowStockBooks = statisticsDao.getRowStockBook();
	
	
%>

window.onload = function () {
	var chart = new CanvasJS.Chart("chartContainer", {
		title:{
			text: "최근 일주일 판매"      
		},
		axisY: {
			title:"판매수익(만원)"
		},
		axisY2: {
			title:"판매량(개)"
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "column",
			axisYType: "secondary",
			name: "판매수익",
			showInLegend: true,
			legendText: "수익",
			dataPoints: [
				{ label: "오늘",  y: <%=prices[0]%>  },
				{ label: "1일전", y: <%=prices[1]%>  },
				{ label: "2일전", y: <%=prices[2]%>  },
				{ label: "3일전", y: <%=prices[3]%>  },
				{ label: "4일전", y: <%=prices[4]%>  },
				{ label: "5일전", y: <%=prices[5]%>  },
				{ label: "6일전", y: <%=prices[6]%>  }
			]
		},
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "line",
			name: "판매량",
			showInLegend: true,
			legendText: "수량",
			dataPoints: [
				{ label: "오늘",  y: <%=qty[0]%>  },
				{ label: "1일전", y: <%=qty[1]%>  },
				{ label: "2일전", y: <%=qty[2]%>  },
				{ label: "3일전", y: <%=qty[3]%>  },
				{ label: "4일전", y: <%=qty[4]%>  },
				{ label: "5일전", y: <%=qty[5]%>  },
				{ label: "6일전", y: <%=qty[6]%>  }
			]
		}
		]
	});
	chart.render();
}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<div class="container">
<h1>은성문고 통계자료</h1>
	<div id="chartContainer" style="height: 300px; width: 100%; margin-top: 100px;">
	</div>
	
	<div class="row">
	
	<h2>성별별 인기있는 책</h2>
	<div class="col-sm-6">
		<label>여성에게 가장 인기가 많은 책</label>
		<img src="/silverstar/images/<%=bookByWoman.getImage() %>" width="170px" height="200px"/>
	</div>
	
	<div class="col-sm-6">
		<label>남성성에게 가장 인기가 많은 책</label>
		<img src="/silverstar/images/<%=bookByMan.getImage() %>" width="170px" height="200px"/>
	</div>
	
	<h2>재고가 가장 적은 책 5권</h2>
	<%
		for(Book book : rowStockBooks) {
	%>
		<div class="col-sm-2">
			<img src="/silverstar/images/<%=book.getImage() %>" width="170px" height="200px"/>
		</div>
	<%
		}
	%>
	</div>
	
</div>
</body>
</html>