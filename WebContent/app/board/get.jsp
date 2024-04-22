<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>get</title>
<%-- <link href="${cp}/css/style.css" rel="stylesheet"> --%>
<link href="${cp}/css/wirte/get.css" rel="stylesheet">
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
				<td>
					<input type="text" name="readcount" value="${board.readcount}" readonly>
				</td>
			</tr>
			<tr>
				<th>카테고리</th>
				<td>
					<input type="text" name="boardcategory" value="${board.lpostcategory}" readonly>
				</td>
			</tr>
			<tr>
				<th>참여유저</th>
				<c:if test="${lpost_user_list != ''}">
					<td>
						<%-- <input type="text" name="lpost_user_list" value="${fn:escapeXml(lpost_user_list)}" readonly> --%>
						${lpost_user_list}
					</td>
				</c:if>
				<c:if test="${lpost_user_list == ''}">
					<td>
						<input type="text" name="lpost_user_list" value="아직 참여자가 없습니다." readonly>
					</td>
				</c:if>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea name="boardcontents" readonly>${board.lpostcontents}</textarea>
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<div id="map" style="width:100%;height:350px;"></div>
				</td>
			</tr>
		</table>
		<table class="btn_area">
			<tbody>
				<tr>
					<td>
						<c:if test="${board.userid == loginUser}">
							<a class="btn" href="${cp}/boardupdate.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}">수정</a>
							<a class="btn" href="${cp}/boarddelete.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}">삭제</a>
						</c:if>
						<c:choose>
						    <c:when test="${checkUser == 1}">
						        <a class="btn" href="#" onclick="delectAction()">취소하기</a>
						    </c:when>
						    <c:otherwise>
						        <a class="btn" href="#" onclick="joinAction()">참여하기</a>
						    </c:otherwise>
						</c:choose>
						
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
						</tr>
					</tbody>
				</table>
			</form>
			<form name="updateForm" method="post">
				<input type="hidden" name="boardnum" value="${board.lpostnum}">
				<input type="hidden" name="page" value="${param.page}">
				<input type="hidden" name="keyword" value="${param.keyword}">
				<input type="hidden" name="lreplynum" value="">
				<input type="hidden" name="i" value="">
				<table class="update_box">
					<tbody>
						<c:if test="${replies.size()>0}">
							<c:forEach var="i" begin="0" end="${replies.size()-1}">
								<c:set var="reply" value="${replies[i]}"/>
								<tr>
									<td>${reply.userid}</td>
									<td>
										<textarea readonly name="lreply${i}" id="reply${i}" class="replycontents">${reply.lreplycontents}</textarea>
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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=b80d880bf487c48bfc24c5920bfb84f0&libraries=services"></script>
<script>
	const roadAddress = '${RoadAddress}';
	console.log(roadAddress);
	const PlaceName = '${PlaceName}';
	console.log(placeName);
	
	
	
</script>
<script>
	window.setTimeout(function(){
		document.querySelector("#wrap>div:nth-child(1)").style.display="none";
	},1200)
	const updateForm = document.updateForm;
	let flag = false;
	function deleteReply(lreplynum){
		console.log("함수 실행")
		updateForm.setAttribute("action","${cp}/replydelete.rp");
		updateForm.lreplynum.value = lreplynum;
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
		updateForm.setAttribute("action","${cp}/lreplyupdate.rp");
		updateForm.lreplynum.value = lreplynum;
		updateForm.i.value = i;
		updateForm.submit();
	}
	
	function joinAction() {
        if (confirm("참여하시겠습니까?")) {
            window.location.href = "${cp}/adduser.lu?page=${param.page}&keyword=${param.keyword}&boardnum=${board.lpostnum}";
            
            var message = "참여되었습니다.";
            if (message !== "") {
                alert(message);
            }
        }
        return false;
    }
	function delectAction(){
		if (confirm("취소하시겠습니까?")) {
            window.location.href = "${cp}/deluser.lu?page=${param.page}&keyword=${param.keyword}&boardnum=${board.lpostnum}";
            
            var message = "취소되었습니다.";
            if (message !== "") {
                alert(message);
            }
        }
        return false;
	}
</script>

<script>
var mapContainer = document.getElementById('map'); // 지도를 표시할 div 
var mapOption = {
    center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    level: 3 // 지도의 확대 레벨
};  

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption); 

// 지도의 크기를 부모 요소의 넓이에 맞게 조정합니다
function resizeMap() {
	    var mapParentWidth = mapContainer.parentElement.offsetWidth;
	    mapContainer.style.width = mapParentWidth + 'px';
	    map.relayout();
	}
	
	// 창 크기가 변경될 때마다 지도의 크기를 다시 조정합니다
	window.addEventListener('resize', function() {
	    resizeMap();
	});
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
	
	// 주소로 좌표를 검색합니다
	geocoder.addressSearch(roadAddress, function(result, status) {
	    // 정상적으로 검색이 완료됐으면 
	    if (status === kakao.maps.services.Status.OK) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords
	        });
	
	        // 인포윈도우로 장소에 대한 설명을 표시합니다
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">'+PlaceName+'</div>'
	        });
	        infowindow.open(map, marker);
	
	        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
	        map.setCenter(coords);
	    } 
	}); 
	
	// 초기에 한번 지도의 크기를 조정합니다
	resizeMap();  
</script>
</html>









