<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String[] subcategory = {
		/* 소설  */
		"한국소설, 일본소설, 영미소설, 추리, 해외, 미스터리, 로맨스, 드라마, SF/과학, 기타 ",
		/* 만화  */
		"웹툰, 국내만화, 일본만화, 해외만화",
		/* 인문  */
		"교양심리, 인문교양, 글쓰기, 지식과학문",
		/* 시/에세이  */
		"한국에세이, 현대시, 영미에세이, 철학에세이, 수필",
	};
	
	String maincategory = request.getParameter("maincategory");
	String content = "";
	if("소설".equals(maincategory)){
		content = subcategory[0];
	}else if("만화".equals(maincategory)){
		content = subcategory[1];
	}else if("인문".equals(maincategory)){
		content = subcategory[2];
	}else if("시/에세이".equals(maincategory)){
		content = subcategory[3];
	}
	
	out.write(content);
%>