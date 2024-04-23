<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify</title>
<link href="${cp}/css/style.css" rel="stylesheet">
</head>
<body class="modify">
	<header>
		<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	</header>
	<div id="wrap" class="modify">
		<!-- 타이틀 띄워주는 테이블 -->
		<table class="title">
			<tbody>
				<tr>
					<td>
						<h3>
							<img src="${cp}/images/타이틀.png" class="tit_img">
						</h3>
					</td>
				</tr>
			</tbody>
		</table>																			<!-- 파일 데이터를 전송하기 위한 형식 -->
		<form id="boardForm" method="post" name="boardForm" action="${cp}/boardupdateok.bo"> <!-- enctype="multipart/form-data" -->
			<input type="hidden" name="boardnum" value="${board.lpostnum }">
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="keyword" value="${param.keyword}">
			<table border="1">
				<tr>
					<th>제목</th>
					<td>
						<input type="text" name="boardtitle" maxlength="50" value="${board.lposttitle}">
					</td>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input type="text" name="userid" maxlength="50" value="${loginUser}" readonly>
					</td>
				</tr>
				<tr>
                	<th>마감시간</th>
                	<td id="timetd">
                		<input type='text' name="month" id="month" maxlength='2' value="${deadline[0]}"/><span>월 </span>
                		<input type='text' name="day" id="day" maxlength='2' value="${deadline[1]}"/><span>일 </span>
                		<input type='text' name="hour" id="hour" maxlength='2'value="${deadline[2]}"/><span>시 </span>
                		<input type='text' name="minute" id="minute" maxlength='2' value="${deadline[3]}"/><span>분    </span>
                		<span id="alertnode" style="color: red"></span>
                		
                		<input type="checkbox" name="notime" value="yes"><span>없음</span>
                	</td>
                </tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="boardcontents">${board.lpostcontents}</textarea>
					</td>
				</tr>
			</table>
			<input type="hidden" value="" name="updateCnt" id="updateCnt">
		</form>
		<table class="btn_area">
			<tbody>
				<tr>
					<td>
						<a class="btn" href="javascript:sendit();">수정완료</a>
						<a class="btn" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}">목록</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function sendit(){
		const boardForm = document.boardForm;
		//유효성 검사
		boardForm.submit();
	}
	
	const alertnode = document.getElementById("alertnode");
	var replaceNotInt = /[^0-9]/gi;
	    
	    $(document).ready(function(){
	    	$("#month").on("focusout", function() {
	            var x = $(this).val();
	            if (x.length > 0) {
	                if (x.match(replaceNotInt)) {
	                   x = x.replace(replaceNotInt, "");
	                }
	                if (parseInt(x) > 12) {
	                    x = "";
	                }
	                $(this).val(x);
	            }
	        }).on("keyup", function() {
	            var x = $(this).val();
	            if (x.match(replaceNotInt)) {
	               x = x.replace(replaceNotInt, "");
	            }
	            if (parseInt(x) > 12) {
	                x = "";
	            }
	            $(this).val(x);
	        });

	    	$("#day").on("focusout", function() {
	            var day = $(this).val();
	            var month = $("#month").val();

	            if (day.length > 0) {
	                if (day.match(replaceNotInt)) {
	                   day = day.replace(replaceNotInt, "");
	                }
	                if (parseInt(day) > 12 && parseInt(day) % 2 === 1) {
	                    x = "";
	                }
	                $(this).val(x);
	            }
	        }).on("keyup", function() {
	            var day = $(this).val();
	            var month = $("#month").val();

	            if (day.match(replaceNotInt)) {
	               day = day.replace(replaceNotInt, "");
	            }
	            if (parseInt(day) > 28){
	            	if(parseInt(month)===2){
	            		day="";
	            	}
	            	if(parseInt(day) > 30){
	            		if(parseInt(month)===4 || parseInt(month)===6 || parseInt(month)===9 || parseInt(month)===11){
	            			day="";
	            		}
	            	}
	            	if(parseInt(day) > 31){
	            		day="";
	            	}
	            } 
	            $(this).val(day);
	        });
	    	
	    	$("#hour").on("focusout", function() {
	            var hour = $(this).val();
	            if (hour.length > 0) {
	                if (hour.match(replaceNotInt)) {
	                	hour = hour.replace(replaceNotInt, "");
	                }
	                if (parseInt(hour) > 12) {
	                	hour = "";
	                }
	                $(this).val(hour);
	            }
	        }).on("keyup", function() {
	            var hour = $(this).val();
	            if (hour.match(replaceNotInt)) {
	            	hour = hour.replace(replaceNotInt, "");
	            }
	            if (parseInt(hour) > 24) {
	            	hour = "";
	            }
	            $(this).val(hour);
	        });
	    	
	    	$("#minute").on("focusout", function() {
	            var minute = $(this).val();
	            if (minute.length > 0) {
	                if (minute.match(replaceNotInt)) {
	                	minute = minute.replace(replaceNotInt, "");
	                }
	                if (parseInt(minute) > 60) {
	                	hour = "";
	                }
	                $(this).val(minute);
	            }
	        }).on("keyup", function() {
	            var minute = $(this).val();
	            if (minute.match(replaceNotInt)) {
	            	minute = minute.replace(replaceNotInt, "");
	            }
	            if (parseInt(minute) > 60) {
	            	minute = "";
	            }
	            $(this).val(minute);
	        });
	    });
</script>
</html>








