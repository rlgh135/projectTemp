<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>get</title>
<link href="${cp}/css/style.css" rel="stylesheet">
</head>
<body class="get">
	<c:if test="${empty loginUser }">
		<script>
			alert("로그인 후 이용하세요!");
			location.replace("${cp}/");
		</script>
	</c:if>
	<div id="wrap" class="get">
		<div></div>
		<!-- 로그아웃 버튼 배치할 테이블 -->
		<table class="header_area">
			<tbody>
				<tr>
					<td>
						<span>${loginUser}님 환영합니다.</span>
						<a class="btn" href="${cp}/userlogout.us">로그아웃</a>
					</td>
				</tr>
			</tbody>
		</table>
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
		</table>
		<table border="1" class="board_area">
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="boardtitle" value="${board.lposttitle}" readonly>
				</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>
					<input type="text" name="userid" value="${board.userid}" readonly>
				</td>
			</tr>
			<tr>
				<th>조회수</th>
				<td>${board.readcount}</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<input type="text" name="boardcategory" value="${board.lpostcategory}" readonly>
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="boardcontents" readonly>${board.lpostcontents}</textarea>
				</td>
			</tr>
			
			<%-- <tr>
				<th>참여유저</th>
				<td>
					<td>${board.imageCount}</td>
				</td>
			</tr> --%>
			<c:choose>
				<c:when test="${files != null and files.size()>0 }">
					<c:forEach var="i" begin="0" end="${files.size()-1}">
						<c:set var="file" value="${files[i]}"/>
						<tr>
							<th>첨부파일${i+1}</th>
							<td>
								<a href="${cp}/filedownload.bo?systemname=${file.systemname}&orgname=${file.orgname}">${file.orgname}</a>
							</td>
						</tr>
						<%-- items에 있는 문자열을 delims 기준으로 분할하고, 분할된 갯수만큼 반복 --%>
						<%-- 분할된 애들을 매 반복마다 token이라는 변수로 가져오면서 반복 --%>
						<%-- varStatus에 적힌 변수에 "token" 변수의 상태들이 저장됨(몇 번째인지, 첫번째 반복인지, ...) --%>
						<%-- ex) apple.png ---> token : 첫 반복 때 apple, 마지막 반복 때 png --%>
						<%-- ex) png.txt ---> token : 첫 반복 때 png, 마지막 반복 때 txt --%>
						<c:forTokens items="${file.orgname }" delims="." var="token" varStatus="tokenStat">
							<%-- c:forTokens 반복의 가장 마지막 반복일 때 --%>
							<c:if test="${tokenStat.last}">
								<%-- 그 때 가져오는 token은 확장자 일것이고, 그림 파일인지 확인 --%>
								<c:if test="${token eq 'jpeg' or token eq 'jpg' or token eq 'png' or token eq 'gif' or token eq 'webp' }">
									<!-- 썸네일 제작 -->
									<tr>
										<th></th>
										<td>
											<img class="thumbnail" src="${cp}/file/${file.systemname}">
										</td>
									</tr>
								</c:if>
							</c:if>
						</c:forTokens>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<tr class="no-file">
						<td colspan="2">첨부 파일이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		<table class="btn_area">
			<tbody>
				<tr>
					<td>
						<c:if test="${board.userid == loginUser}">
							<a class="btn" href="${cp}/boardupdate.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}">수정</a>
							<a class="btn" href="${cp}/boarddelete.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}">삭제</a>
						</c:if>
						<a class="btn" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}">목록</a>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="reply_line">
			<form name="replyForm" method="post" action="${cp}/lreplywrite.rp">
				<input type="hidden" name="boardnum" value="${board.lpostnum}">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="keyword" value="${param.keyword}">
				<table class="write_box">
					<tbody>
						<tr>
							<td>댓글</td>
							<td>
								<textarea name="lreplycontents"></textarea>
								<a class="btn" href="javascript:document.replyForm.submit();">등록</a>
							</td>
							<td>참여하기</td>
						</tr>
					</tbody>
				</table>
			</form>
			<form name="updateForm" method="post">
				<input type="hidden" name="boardnum" value="${board.lpostnum}">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="keyword" value="${param.keyword}">
				<input type="hidden" name="replynum" value="">
				<input type="hidden" name="i" value="">
				<table class="update_box">
					<tbody>
						<c:if test="${replies.size()>0}">
							<c:forEach var="i" begin="0" end="${replies.size()-1}">
								<c:set var="reply" value="${replies[i]}"/>
								<tr>
									<td>${reply.userid}</td>
									<td>
										<textarea readonly name="reply${i}" id="reply${i}" class="replycontents">${reply.lreplycontents}</textarea>
									</td>
									<td>
										${reply.lregdate}<c:if test="${reply.updatechk == 'o'}">(수정됨)</c:if>
										<c:if test="${reply.userid == loginUser}">
											<div class="btns">
												<a class="btn" href="javascript:updateReply(${i})" id="start${i}">수정</a>
												<a class="btn" href="javascript:updateReplyOk(${i},${reply.lreplynum})" style="display:none;" id="end${i}">수정완료</a>
												<a class="btn" href="javascript:deleteReply(${reply.lreplynum})">삭제</a>
											</div>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${replies.size() <= 0}">
							<tr>
								<td colspan="3">등록된 댓글이 없습니다</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</form>
		</div>
	</div>
</body>
<script>
	window.setTimeout(function(){
		document.querySelector("#wrap>div:nth-child(1)").style.display="none";
	},1200)
	const updateForm = document.updateForm;
	let flag = false;
	function deleteReply(replynum){
		updateForm.setAttribute("action","${cp}/replydelete.rp");
		updateForm.replynum.value = lreplynum;
		updateForm.submit();
	}
	function updateReply(i){
		const start = document.getElementById("start"+i);
		const end = document.getElementById("end"+i);
		const reply = document.getElementById("reply"+i);
		
		if(!flag){
			start.style.display = "none";
			end.style.display = "inline-block";
			reply.removeAttribute("readonly");
			flag = true;
		}
		else{
			alert("수정중인 댓글이 있습니다!");
		}
	}
	function updateReplyOk(i,lreplynum){
		updateForm.setAttribute("action","${cp}/replyupdate.rp");
		updateForm.replynum.value = lreplynum;
		updateForm.i.value = i;
		updateForm.submit();
	}
</script>
</html>









