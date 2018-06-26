<%@page import="silverstar.customer.Customer"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%
	Customer loginedCustomer = (Customer) session.getAttribute("loginedCustomer");
%>
<title>은성 문고</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="/silverstar/style/none-responsive.css">  
<script type="text/javascript">
	function issame() {
		var pw = document.getElementById('customer-pw').value;
		var pw2 = document.getElementById('customer-pw2').value;
		if(pw.length<6 || pw.length>8) {
			window.alert("비밀번호는 6글자이상, 8글자미만 이하만 사용 가능합니다.");
			document.getElementById("customer-pw").value=document.getElementById("customer-pw2").value="";
			document.getElementById("same").innerHTML="";
		}
		if( pw !="" && pw2 !="") {
			if(document.getElementById("customer-pw").value==document.getElementById("customer-pw2").value) {
				document.getElementById("same").innerHTML='비밀번호 일치.';
				document.getElementById("same").style.color="blue";
			} else {
				document.getElementById("same").innerHTML="비밀번호 불일치.";
				document.getElementById("same").style.color="red";
			}
		}
	}


	function checkInputField(event) {
		event.preventDefault();
		
		var tel1Field = document.getElementById("customer-tel1");
		var tel2Field = document.getElementById("customer-tel2");
		var tel3Field = document.getElementById("customer-tel3");
		var email1Field = document.getElementById("customer-email1");
		var email2Field = document.getElementById("customer-email2");
		var pwField = document.getElementById("customer-pw");
		var addressField1 = document.getElementById("customer-address1");
		var addressField2 = document.getElementById("customer-address2");
		var checkPwField = document.getElementById("same");
		var nowPwField = document.getElementById("nowPw");
		
		var nowPw = nowPwField.value;
		if(nowPw =="") {
			alert("현재비밀번호를 입력해주세요");
			nowPwField.focus();
			return;
		} else if (nowPw != "<%=loginedCustomer.getCustomerPw()%>") {
			alert("비밀번호가 일치하지 않습니다.");
			nowPwField.focus();
			return;
		}
		
		var checkPw = checkPwField.innerHTML;
		if(checkPw == "비밀번호 불일치.") {
			alert("비밀번호를 확인해주세요");
			pwField.focus();
			return;	// 만나는 순간 즉시 종료
		}
		var tel1 = tel1Field.value;
		var tel2 = tel2Field.value;
		var tel3 = tel3Field.value;
		if (tel1 =="" || tel2 =="" || tel3 =="") {
			alert("휴대폰번호를 확인해주세요");
			tel1Field.focus();
			return;	// 만나는 순간 즉시 종료
		}
		
		var email1 = email1Field.value;
		var email2 = email2Field.value;
		if (email1 =="" || email2 =="") {
			alert("이메일을 입력하세요");
			email1Field.focus();
			return;	// 만나는 순간 즉시 종료
		}
		
		var pw = pwField.value;
		if (pw =="") {
			alert("비밀번호를 입력하세요");
			pwField.focus();
			return;	// 만나는 순간 즉시 종료
		}
		
		var address1 = addressField1.value;
		var address2 = addressField1.value;
		if (address1 =="" || address2 =="") {
			alert("주소를 입력하세요");
			adressField1.focus();
			return;	// 만나는 순간 즉시 종료
		}
	
	
		var customerForm = document.getElementById("customer-form");
		customerForm.submit();
}
</script>
</head>
<body>
<%
	if(session.getAttribute("loginedCustomer") == null) {
		response.sendRedirect("../main/index.jsp");
		return;
	}
	
	Customer customer = (Customer) session.getAttribute("loginedCustomer");
	String[] tells = customer.getCustomerTel().split("-");
	String[] emails = customer.getCustomerEmail().split("@");
	
%>

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
	<div class="container" style="min-width: 1080px; margin-top: 100px;">
		<h1>회원정보 수정</h1>
		<hr style="border: solid 1px black;" />
			<h3 style="font-size: 8pt;"><strong>필수입력사항</strong></h3>
			<hr style="border: solid 1px #0099ff;" />
				<form method="post" action="updatecustomer.jsp" class="form-horizontal"  onsubmit="checkInputField(event)" id="customer-form">
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">이름</label>
						<div class="col-sm-4">
							<input type="text" value="<%=customer.getCustomerName() %>" class="form-control" disabled="disabled">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">성별</label>
						<div class="form-inline">
						<div class="col-sm-4">
							<div class="radio">
							<%
								if("M".equals(customer.getGender())) {
							%>
									<input type="radio" class="form-control" disabled="disabled">여성
									<input type="radio" class="form-control" checked="checked" disabled="disabled">남성
							<%
								} else {
							%>
									<input type="radio" class="form-control" checked="checked" disabled="disabled">여성
									<input type="radio" class="form-control" disabled="disabled">남성
							<%	
								}
							%>
							</div>
						</div>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label"  style="text-align: left">생년월일</label>
						<div class="col-sm-4">
							<input type="date" value="<%=customer.getStringCustomerBirth() %>" class="form-control" disabled="disabled">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">휴대폰번호</label>
						<div class="col-sm-4">
							<select name="customer-tel1" id="customer-tel1">
								<option value="" selected="selected">선택</option>
								<option value="010">010</option>
								<option value="011">011</option>
								<option value="016">016</option>
								<option value="017">017</option>
								<option value="018">018</option>
								<option value="019">019</option>
					       	</select>
					     		-<input type="text" name="customer-tel2" id="customer-tel2" size="2" maxlength="4" value="<%=tells[1]%>">
					      		-<input type="text" name="customer-tel3" id="customer-tel3" size="2" maxlength="4" value="<%=tells[2]%>">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">이메일(e-mail)</label>
					<div class="col-sm-4">
						<input type="text" name="customer-email1" id="customer-email1" size="10" value="<%=emails[0]%>">
						@<input type="text" name="customer-email2" id="customer-email2" size="10" value="<%=emails[1]%>">
					</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">아이디</label>
						<div class="col-sm-2">
							<input type="text" class="form-control" name="customer-id" value="<%=customer.getCustomerId() %>" readonly="readonly" >
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">현재비밀번호</label>
						<div class="col-sm-2">
							<input type="password" id="nowPw" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left" onkeyup="issame()">비밀번호</label>
						<div class="col-sm-2">
							<input type="password" name="customer-pw" id="customer-pw" class="form-control">
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left">비밀번호 확인</label>
						<div class="col-sm-2">
							<input type="password" name="customer-password2" onkeyup="issame()" id="customer-pw2" class="form-control">&nbsp;&nbsp;<span id="same"></span>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-2 control-label" style="text-align: left;">주소</label>
						<div class="col-sm-3">
							<input type="text" class="form-control" name="customer-address1" id="customer-address1">
						</div>
						<div class="com-sm-7">
							<button class="btn btn-info" onclick="sample4_execDaumPostcode()">우편번호</button>
						</div>
						<div class="col-md-offset-2 col-sm-8">
							<input type="text" class="form-control" name="customer-address2" id="customer-address2">
						</div>
					</div>
					<div class="form-group">
						<div class="col-sm-1 col-sm-offset-9">
							<input type="submit" class="btn btn-primary" value="수정" >
						</div>
						<div class="col-sm-1">
							<a href="mypageview.jsp" class="btn btn-default">취소</a>
						</div>
					</div>
			</form>
		</div>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function sample4_execDaumPostcode() {
    	event.preventDefault();
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullRoadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 도로명 조합형 주소 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 도로명, 지번 조합형 주소가 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }
                // 도로명, 지번 주소의 유무에 따라 해당 조합형 주소를 추가한다.
                if(fullRoadAddr !== ''){
                    fullRoadAddr += extraRoadAddr;
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('customer-address1').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('customer-address2').value = fullRoadAddr + data.jibunAddress;
            }
        }).open();
    }
</script>
<%@ include file="../../navigation/footer.jsp" %>
</body>
</html>