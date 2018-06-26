<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="silverstar.bookstore.StatisticsDao"%>
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
  	<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
  	<style type="text/css">
  		.highlight {
  			background: #CEECF5;
  		}
  	</style>
  	<script>
<%

	BookDao bookDao = new BookDao();

	StatisticsDao statisticsDao = new StatisticsDao();
	String[] titleW = new String[5];
	Integer[] qtyW = new Integer[5];
	for(int i =0; i<5; i++) {
		Map<String,Object> status = new HashMap<>();
		status.put("S","W");
		status.put("rn",i);
		Book book = statisticsDao.getStatusByGender(status);
		qtyW[i] = book.getSellqty();
		Book book2 = bookDao.bookSearchDetailByNo(book.getNo());
		titleW[i] = book2.getTitle();
		if(book2.getTitle().length() > 5)
			titleW[i] = book2.getTitle().substring(0,5);
		else
			titleW[i] = book2.getTitle();
	}
	String[] titleM = new String[5];
	Integer[] qtyM = new Integer[5];
	for(int i =0; i<5; i++) {
		Map<String,Object> status = new HashMap<>();
		status.put("S","M");
		status.put("rn",i);
		Book book = statisticsDao.getStatusByGender(status);
		qtyM[i] = book.getSellqty();
		Book book2 = bookDao.bookSearchDetailByNo(book.getNo());
		if(book2.getTitle().length() > 5)
			titleM[i] = book2.getTitle().substring(0,5);
		else
			titleM[i] = book2.getTitle();
	}
	
	Integer[] qtyAge = new Integer[6];
	for(int i =0; i<6; i++) {
		qtyAge[i] = statisticsDao.getStatusByAge(i);
	}
	
	String[] titleB = new String[6];
	Integer[] qtyB = new Integer[6];
	for(int i =0; i<6; i++) {
		Book book = statisticsDao.getStatusByBook((i+1));
		qtyB[i] = book.getSellqty();
		Book book2 = bookDao.bookSearchDetailByNo(book.getNo());
		if(book2.getTitle().length() > 5)
			titleB[i] = book2.getTitle().substring(0,5);
		else
			titleB[i] = book2.getTitle();
	}
%>

window.onload = function () {
    CanvasJS.addColorSet("greenShades",
            [//colorSet Array

            "#d3c1f2",
            "#ace2c1",
            "#9bd7ef",
            "#e2ed9a",
            "#ef9ed1",
            "#fcd4db"
            ]);
	var chart = new CanvasJS.Chart("chartContainerW", {
		animationEnabled: true,
		//theme: "light2",
		colorSet: "greenShades",
		title:{
			text: "여성이 선호하는 책"      
		},
		axisY: {
			title:"판매량"
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "column",
			name: "판매량",
			legendText: "판매량",
			dataPoints: [
				{ label: "<%=titleW[0]%>",  y: <%=qtyW[0]%>  },
				{ label: "<%=titleW[1]%>",  y: <%=qtyW[1]%>  },
				{ label: "<%=titleW[2]%>",  y: <%=qtyW[2]%>  },
				{ label: "<%=titleW[3]%>",  y: <%=qtyW[3]%>  },
				{ label: "<%=titleW[4]%>",  y: <%=qtyW[4]%>  }
			]
		}
		]
	});
	chart.render();
	var chart2 = new CanvasJS.Chart("chartContainerM", {
		animationEnabled: true,
		//theme: "light2",
		colorSet: "greenShades",
		title:{
			text: "남성이 선호하는 책"      
		},
		axisY: {
			title:"판매량"
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "column",
			name: "판매량",
			legendText: "판매량",
			dataPoints: [
				{ label: "<%=titleM[0]%>",  y: <%=qtyM[0]%>  },
				{ label: "<%=titleM[1]%>",  y: <%=qtyM[1]%>  },
				{ label: "<%=titleM[2]%>",  y: <%=qtyM[2]%>  },
				{ label: "<%=titleM[3]%>",  y: <%=qtyM[3]%>  },
				{ label: "<%=titleM[4]%>",  y: <%=qtyM[4]%>  }
			]
		}
		]
	});
	chart2.render();
	var chart3 = new CanvasJS.Chart("chartContainerA", {
		animationEnabled: true,
		colorSet: "greenShades",
		title:{
			text: "연령별 책 판매량"      
		},
		axisY: {
			title:"판매량"
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "column",
			name: "판매량",
			legendText: "판매량",
			dataPoints: [
				{ label: "10대",  y: <%=qtyAge[0]%>  },
				{ label: "20대",  y: <%=qtyAge[1]%>  },
				{ label: "30대",  y: <%=qtyAge[2]%>  },
				{ label: "40대",  y: <%=qtyAge[3]%>  },
				{ label: "50대",  y: <%=qtyAge[4]%>  },
				{ label: "60대",  y: <%=qtyAge[5]%>  }
			]
		}
		]
	});
	chart3.render();
	var chart4 = new CanvasJS.Chart("chartContainerB", {
		animationEnabled: true,
		colorSet: "greenShades",
		title:{
			text: "베스트 책 판매량"      
		},
		axisY: {
			title:"판매량"
		},
		data: [              
		{
			// Change type to "doughnut", "line", "splineArea", etc.
			type: "column",
			name: "판매량",
			legendText: "판매량",
			dataPoints: [
				{ label: "<%=titleB[0]%>",  y: <%=qtyB[0]%>  },
				{ label: "<%=titleB[1]%>",  y: <%=qtyB[1]%>  },
				{ label: "<%=titleB[2]%>",  y: <%=qtyB[2]%>  },
				{ label: "<%=titleB[3]%>",  y: <%=qtyB[3]%>  },
				{ label: "<%=titleB[4]%>",  y: <%=qtyB[4]%>  },
				{ label: "<%=titleB[5]%>",  y: <%=qtyB[5]%>  }
			]
		}
		]
	});
	chart4.render();
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

  	%>

<div class="container" style="margin-top:10px">	
	<div class="row">
		<div class="col-sm-6">	
			<div id="chartContainerA" style="height: 300px">
			</div>
		</div>	
		<div class="col-sm-6">	
			<div id="chartContainerB" style="height: 300px">
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-6">	
			<div id="chartContainerW" style="height: 300px">
			</div>
		</div>
		<div class="col-sm-6">
			<div id="chartContainerM" style="height: 300px">
			</div>
		</div>
	</div>
</div>
	<!-- footer -->
	<%@ include file="../navigation/footer.jsp" %>
</body>
</html>