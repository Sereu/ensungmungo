<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="silverstar.review.ReviewLike"%>
<%@page import="silverstar.review.ReviewCustomer"%>
<%@page import="silverstar.review.Review"%>
<%@page import="java.util.List"%>
<%@page import="silverstar.review.ReviewDao"%>
<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
	<%
		request.setCharacterEncoding("utf-8");
		Customer cust = (Customer) session.getAttribute("loginedCustomer");
		
		
		int bookNo = Integer.parseInt(request.getParameter("bookno"));
		
		ReviewDao reviewDao = new ReviewDao();
		List<ReviewLike> likes = reviewDao.getReviewStarBno(bookNo);
			int reviewNo = 0;
			int five = 0;
			int four = 0;
			int three = 0;
			int two = 0;
			int one = 0;
			double starScore = 0.0;
			double totalCnt = 0.0;
			double avgStar = 0.0;
			for(ReviewLike like : likes){
				if(like.getStartLike()==5){
					five = like.getStartCnt();
					starScore += like.getStarScore();
					totalCnt += like.getStartCnt();
				} else if(like.getStartLike()==4){
					four = like.getStartCnt();
					starScore += like.getStarScore();
					totalCnt += like.getStartCnt();
				} else if(like.getStartLike()==3){
					three = like.getStartCnt();
					starScore += like.getStarScore();
					totalCnt += like.getStartCnt();
				} else if(like.getStartLike()==2){
					two = like.getStartCnt();
					starScore += like.getStarScore();
					totalCnt += like.getStartCnt();
				} else if(like.getStartLike()==1){
					one = like.getStartCnt();
					starScore += like.getStarScore();
					totalCnt += like.getStartCnt();
				}
			}
			double avg = starScore/totalCnt;
			if(starScore==0.0){
				avgStar = 0.0;
			} else {
				avgStar = Double.parseDouble(String.format("%.1f", avg));
			}
			
	%>
	<%
		final int rows = 10;
		String col = request.getParameter("col");
		if (col == null) {
			col = "review_no";
		}
		String sort = request.getParameter("sort");
		if (sort == null) {
			sort = "desc";
		}
		int rpno = 1;
		if(request.getParameter("rpno") != null)
			rpno = Integer.parseInt(request.getParameter("rpno"));
		int records = reviewDao.getReviewCnt(bookNo);
		int pages = (int)Math.ceil((double)records/rows);
		int beginIndex = (rpno-1)*rows+1;
		int endIndex = rpno*rows;
		
		Map<String, Object> param = new HashMap<>();
		param.put("col", col);
		param.put("sort", sort);
		param.put("beginIndex", beginIndex);
		param.put("endIndex", endIndex);
		param.put("bookNo", bookNo);
		List<ReviewCustomer> reviews = reviewDao.getReviewRange(param);
		//한 책의 리뷰 등록 여부 확인 기능
		int num = 0;
		if(cust!=null){
			HashMap<String, Object> custReview = new HashMap<>();
			custReview.put("bookNo", bookNo);
			custReview.put("custNo", cust.getCustomerNo());
				
			num = reviewDao.getBookByCustomerNo(custReview);
		}
		
	%>
	
	<div class="row">
		<div class="col-sm-3">
			<div class="panel panel-default">
				<div class="panel-heading">
					평점/리뷰
				</div>
				<div class="panel-body text-center">
					<img src="../images/star.png" style="width: 80px;">
				</div>
				<div class="panel-footer
				 text-center">
					<strong style="font-size: 25px;"><%=avgStar %></strong> / 5점
				</div>
			</div>
			
		</div>
		<div class="col-sm-7">
			<ul class="list-group">
				<li class="list-group-item" ><strong style="color: green">★★★★★</strong>매우좋아요 <span class="badge" ><%=five %></span></li>
				<li class="list-group-item" ><strong style="color: green">★★★★</strong> 좋아요<span class="badge" ><%=four %></span></li>
				<li class="list-group-item" ><strong style="color: green">★★★ </strong>보통이예요 <span class="badge" ><%=three %></span></li>
				<li class="list-group-item" ><strong style="color: green">★★ </strong>그저그래요 <span class="badge" ><%=two %></span></li>
				<li class="list-group-item" ><strong style="color: green">★ </strong>별로예요 <span class="badge" ><%=one %></span></li>
			</ul>
		</div>
		<div class="row">
			<div class="col-sm-10" style = "text-align: right;"><strong style="font-size: 13px; color: green;"><span class="glyphicon glyphicon-pencil"></span> 은성문고 리뷰 등록은 회원만 가능합니다.</strong></div>
			<div class="col-sm-10" style = "text-align: right;"><strong style="font-size: 13px; color: green;"><span class="glyphicon glyphicon-pencil"></span> 한 도서당 한번의 리뷰등록이 가능합니다.</strong></div>
		</div>
	</div>
	<div class="row">
		<div class="col-sm-10 well" style="<%=cust==null||num>0?"display:none":"" %>">
			<form  class="form-horizontal"  method="post" action="../customer/addreview.jsp">
				<input type="hidden" name="bookno" value="<%=bookNo %>">
				<%
				if (cust!=null) {
				%>
						<input type="hidden" name="custno" value="<%=cust.getCustomerNo() %>">
				<%
				}
				%>
				<div class="form-group">
      				<label class="control-label col-sm-1" >별점</label>
      				<div class="col-sm-10">
        				<label class="radio-inline">
  							<input type="radio" name="star" id="five-star" value="5" checked><strong style="color: green"> ★★★★★</strong>
					 	</label>
						<label class="radio-inline">
  							<input type="radio" name="star" id="four-star" value="4"><strong style="color: green"> ★★★★ </strong>
						</label>
						<label class="radio-inline">
  							<input type="radio" name="star" id="three-star" value="3"><strong style="color: green"> ★★★ </strong>
						</label>
						<label class="radio-inline">
  							<input type="radio" name="star" id="two-star" value="2"><strong style="color: green"> ★★ </strong>
						</label>
						<label class="radio-inline">
  							<input type="radio" name="star" id="one-star" value="1"><strong style="color: green"> ★ </strong>
						</label>
      				</div>
    			</div>
    			<div class="form-group">
      				<div class="col-sm-12">          
        				<textarea rows="2" class="form-control" name="contents"></textarea>
      				</div>
      				
    			</div>
    			<div class="form-group">
      				<div class="col-sm-12 text-right">          
        				<input type="submit" class="btn btn-primary btn-sm" value="평가/리뷰쓰기">
      				</div>
    			</div>
			</form>
		</div>
	</div>
		<%
		%>
		<hr style="width: 800px; border-bottom: 0px; text-align: left; margin-left: 0px;">
			<div style="text-align: right; width: 800px;">
				<p>
					<div class="form-group">
					<a onclick="sort('R.review_no','desc');" class="btn btn-default btn-sm">최신순</a>
					<a onclick="sort('R.likes','desc');" class="btn btn-default btn-sm" >공감순</a>
					</div>
				<form class="form-inline" action="bookdetail.jsp" id="frm">
						<input name="sort" type="hidden" value="<%=sort != null? sort :"desc"%>" />
						<input name="col" type="hidden" value="<%=col != null? col :"review_no"%>" />
						<input name="bookno" type="hidden" value="<%=bookNo%>" />
				</form>
				</p>
			</div>
			<div class="row" style="text-align: left; margin-left: 0px; margin-top: 0px;">
				
				<%
						if(reviews.isEmpty()){
				%>
					<table id="table" class="table table-condensed border=0" style="table-layout:fixed; width: 800px; margin: 0px; padding: 0px;">
						<thead>
							<tr style="width: 800px;">
								<th></th>
								<th></th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<tr style="width: 800px;">
								<td colspan="12" class="text-center" >등록된 리뷰가 없습니다. 리뷰를 등록해 주세요.</td>
							</tr>
						</tbody>						
					</table>
				<%
						}else {
							for(ReviewCustomer re : reviews){
				%>
					<table id="table" class="table table-condensed border=0" style="table-layout:fixed; width: 800px; margin: 0px; padding: 0px;" >
							<thead>
								<tr style="width: 800px;">
									<th style="width: 50px; text-align: left"><%=reviewNo += 1 %></th>
									<th style="width: 408px; text-align: left"><%=re.getCustId() %></th>
									<th style="width: 100px; text-align: left"><%=re.getReviewDateFormat() %></th>
									<th style="width: 100px; text-align: left">	
									<%
										for(int i = 0; i<re.getStar(); i++){
									%>
										<span class="glyphicon glyphicon-star" style="color: green;"></span>
									<%
										}
									
									%>
									</th>
									<%
										int like = reviewDao.likecount(re.getReviewNo());
									%>
										<th style="width: 60px">
											<a href="javascript:likes(<%=bookNo %>, <%=re.getReviewNo() %>)" class="btn btn-default btn-sm" ><strong style="color: red; font-size: 15px;">♥</strong>
											(<%=like %>)</a>
										</th>
									<%
										if(cust == null){
									%>
										<th style="width: 60px; ">
											<a href="#"></a>
										</th>
									<%
										}else if(cust.getCustomerNo()==re.getCustomerNo()){
									%>
										<th style="width: 60px">
											<a href="../customer/deletereview.jsp?bookno=<%=bookNo %>&reno=<%=re.getReviewNo() %>" class="btn btn-danger btn-sm">삭제</a>
										</th>
									<%
										}
									%>
									
								</tr>
							</thead>
							<tbody>
								<tr style="width: 800px;">
									<td></td>
									<td colspan="12"><%=re.getContents() %></td>
								</tr>
							</tbody>
					</table>
				<%
						}
					}
				%>
			</div>
			<div class="text-center">
				
				<ul class="pagination">
					<%
						for (int index=1; index <= pages; index++){
					%>
						<li class="<%=rpno==index?"active":""%>"><a href="../bookstore/bookdetail.jsp?bookno=<%=bookNo %>&rpno=<%=index %>"><%=index %></a></li>
					<%
						}
					%>
				</ul>
				
			</div>
	</div>
	<input type="hidden" id="login-status" value="<%=cust==null ? 0 : 1 %>" />
	
<script type="text/javascript">
function likes(bookNo, reviewNo){
	var loginStatus = document.getElementById("login-status").value
	if(loginStatus === "0"){
		alert("로그인 후 사용가능 합니다.");
		return;
	} 
	
	location.href= "../customer/addreviewlike.jsp?bookno="+bookNo+"&reno="+reviewNo;
}
function sort(columnName, sortDirection){
	
	document.querySelector("input[name='col']").value= columnName;
	document.querySelector("input[name='sort']").value= sortDirection;
	
	document.querySelector("#frm").submit();
	
}
</script>
