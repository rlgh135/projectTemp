<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>get</title>
<link href="${cp}/css/get_re.css" rel="stylesheet">
</head>
<body class="get">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ad5c905a822d4c391e596dfbc9acc6&libraries=services"></script>
	<c:if test="${empty loginUser }">
		<script>
			alert("로그인 후 이용하세요!");
			location.replace("${cp}/");
		</script>
	</c:if>
	<header>
		<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	</header>
	<div class="line_top"></div>
	<div id="get_wrap" class="get">
		<!-- 타이틀 띄워주는 테이블 -->
		<%-- <table class="title">
			<tbody>
				<tr>
					<td>
						<h3>
							<img src="${cp}/images/타이틀.png" class="tit_img">
						</h3>
					</td>
				</tr>
			</tbody>
		</table> --%>
		
		<table border="0" class="board_area">
			<tr>
				<!-- <th class="lboard_tit">제목</th> -->
				<th class="lboard_tit" colspan="2">
					<input type="text" name="boardtitle" value="${board.lposttitle}" id="lboard_title" readonly>
				</th>
			</tr>
			<tr>
				<th class="lboard_master">작성자</th>
				<td>
					<input type="text" name="userid" value="${board.userid}" readonly>
				</td>
			</tr>
			<tr>
				<th class="lboard_category">카테고리</th>
				<td>
					<input type="text" name="boardcategory" value="${board.lpostcategory}" readonly>
				</td>
			</tr>
			<tr>
               <th>마감시간</th>
               <td id="timetd">
                	<input type='text' name="month" id="month" maxlength='2' value="${deadline[0]}" readonly/><span>월 </span>
                	<input type='text' name="day" id="day" maxlength='2' value="${deadline[1]}" readonly/><span>일 </span>
                	<input type='text' name="hour" id="hour" maxlength='2' value="${deadline[2]}" readonly/><span>시 </span>
                	<input type='text' name="minute" id="minute" maxlength='2' value="${deadline[3]}" readonly/><span>분    </span>
                </td>
            </tr>
			<tr>
				<th class="lboard_contents">내용</th>
				<td>
					<input type="text" name="boardcontents" value="${board.lpostcontents}" readonly>
				</td>
			</tr>
			<tr>
				<th class="lboard_joinuser">참여유저</th>
				<c:if test="${lpost_user_list != ''}">
					<td class="lpost_user_list">
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
				<th class="lboard_site">위치</th>
				<td>
				   <div id="map" class="lboard_site_box"></div>
				</td>
			</tr>
			<tr>
				<th class="lboard_cnt">조회수</th>
				<td>
					<input type="text" name="readcount" value="${board.readcount}" readonly>
				</td>
			</tr>
		</table>
		<table class="btn_area">
			<tbody>
				<tr>
					<td>
						<c:if test="${board.userid == loginUser}">
							<a class="btn" href="${cp}/boardupdate.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}"><div class="lp_btn_box">수정</div></a>
							<a class="btn" href="${cp}/boarddelete.bo?boardnum=${board.lpostnum}&page=${param.page}&keyword=${param.keyword}"><div class="lp_btn_box">삭제</div></a>
						</c:if>
						<c:choose>
						    <c:when test="${checkUser == 1}">
						        <a class="btn" href="#" onclick="delectAction()"><div class="lp_btn_box">취소하기</div></a>
						    </c:when>
						    <c:otherwise>
						        <a class="btn" href="#" onclick="joinAction()"><div class="lp_btn_box">참여하기</div></a>
						    </c:otherwise>
						</c:choose>
						
						<a class="btn" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}"><div class="lp_btn_box">목록</div></a>
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
							<th>댓글</th>
							<td>
								<textarea id="lp_replycontents" name="lreplycontents" placeholder></textarea>
								<a class="btn" href="javascript:document.replyForm.submit();"><p id="reply_btn">등록</p></a>
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
					<tbody>
						<c:choose>
							<c:when test="${replies.size()>0}">
								<c:forEach var="i" begin="0" end="${replies.size()-1}">
									<c:set var="reply" value="${replies[i]}"/>
										<table class="update_box" >
											<tr>
												<td id="reply_cont_line">
													<textarea readonly name="lreply${i}" id="reply${i}" class="replycontents">${reply.lreplycontents}</textarea>
												</td>
												<td rowspan="2" id="lreply_sub_btn">
													${reply.lregdate}<c:if test="${reply.updatechk == 'o'}">(수정됨)</c:if>
													<c:if test="${reply.userid == loginUser}">
														<div class="btns">
															<a class="btn" href="javascript:updateReply(${i})" id="start${i}"><p class="lreply_sub_btn_box">수정</p></a>
															<a class="btn" href="javascript:updateReplyOk(${i},${reply.lreplynum})" style="display:none;" id="end${i}"><p class="lreply_sub_btn_box">수정하기</p></a>
															<a class="btn" href="javascript:deleteReply(${reply.lreplynum})"><p class="lreply_sub_btn_box">삭제</p></a>
														</div>
													</c:if>
												</td>
											</tr>
											<tr>
												<td id="reply_id_line">작성자 : ${reply.userid}</td>
											</tr>
										</table>
									</c:forEach>
							</c:when>
							<c:otherwise>
								<p id="no_reply">"등록된 댓글이 없습니다"	</p>
							</c:otherwise>
						</c:choose>
					</tbody>
			</form>
		</div>
	</div>
</body>
<script>
   const roadAddress = '${RoadAddress}';
   const PlaceName = '${PlaceName}';
</script>
<script>
	window.setTimeout(function(){
		document.querySelector("#get_wrap>div:nth-child(1)").style.display="none";
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
	if(PlaceName === "null"){
	   var newHTML = "<p>선택한 주소가 없습니다.</p>";
	    document.getElementById("map").innerHTML = newHTML;
	}else{
	
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
	}
</script>
</html>









