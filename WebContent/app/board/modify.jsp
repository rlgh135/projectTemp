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
</script>
</html>








