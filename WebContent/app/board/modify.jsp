<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>modify</title>
<link href="${cp}/css/write/mapApi.css" rel="stylesheet">
<link href="${cp}/css/get_re.css" rel="stylesheet">
</head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ad5c905a822d4c391e596dfbc9acc6&libraries=services"></script>
<body class="modify">
	<header>
		<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	</header>
	<div class="line_top"></div>
	<div id="wrap" class="modify">
		<div></div>
		<form id="boardForm" method="post" name="boardForm" action="${cp}/boardupdateok.bo">
			<input type="hidden" name="boardnum" value="${board.lpostnum }">
			<input type="hidden" name="page" value="${param.page}">
			<input type="hidden" name="keyword" value="${param.keyword}">
			<table border="0" class="board_area">
				<tr>
					<th class = "lboard_tit" colspan="2">
						<input type="text" name="boardtitle" maxlength="50" value="${board.lposttitle}">
					</th>
				</tr>
				<tr>
					<th>작성자</th>
					<td>
						<input type="text" name="userid" maxlength="50" value="${loginUser}" readonly>
					</td>
				</tr>
				<tr>
                    <th class="lboard_category">카테고리 수정</th>
                    <td class="lboard_category_body">
                        <p><input type="checkbox" id="myCheckbox01" name="myCheckbox" value="#스포츠/레저">
                        <label for="myCheckbox01">스포츠/레저</label></p>
						<p><input type="checkbox" id="myCheckbox02" name="myCheckbox" value="#취미">
						<label for="myCheckbox02">취미</label></p>
						<p><input type="checkbox" id="myCheckbox03" name="myCheckbox" value="#친목/모임">
						<label for="myCheckbox03">친목/모임</label></p>
						<p><input type="checkbox" id="myCheckbox04" name="myCheckbox" value="#음악">
						<label for="myCheckbox04">음악</label></p>
						<p><input type="checkbox" id="myCheckbox05" name="myCheckbox" value="#문화/예술">
						<label for="myCheckbox05">문화/예술</label></p>
						<p><input type="checkbox" id="myCheckbox06" name="myCheckbox" value="#여행/캠핑">
						<label for="myCheckbox06">여행/캠핑</label></p>
						<p><input type="checkbox" id="myCheckbox07" name="myCheckbox" value="#맛집/요리">
						<label for="myCheckbox07">맛집/요리</label></p>
						<p><input type="checkbox" id="myCheckbox08" name="myCheckbox" value="#어학/외국어">
						<label for="myCheckbox08">어학/외국어</label></p>
						<p><input type="checkbox" id="myCheckbox09" name="myCheckbox" value="#교육/공부">
						<label for="myCheckbox09">교육/공부</label></p>
						<p><input type="checkbox" id="myCheckbox10" name="myCheckbox" value="#인문/과학">
						<label for="myCheckbox10">인문/과학</label></p>
						<p><input type="checkbox" id="myCheckbox11" name="myCheckbox" value="#종교/봉사">
						<label for="myCheckbox11">종교/봉사</label></p>
						<p><input type="checkbox" id="myCheckbox12" name="myCheckbox" value="#반려동물/동물">
						<label for="myCheckbox12">반려동물/동물</label></p>
						<p><input type="checkbox" id="myCheckbox13" name="myCheckbox" value="#자연/귀농">
						<label for="myCheckbox">자연/귀농</label></p>
						<p><input type="checkbox" id="myCheckbox14" name="myCheckbox" value="#게임">
						<label for="myCheckbox14">게임</label></p>
						<p><input type="checkbox" id="myCheckbox15" name="myCheckbox" value="#IT/컴퓨터">
						<label for="myCheckbox15">IT/컴퓨터</label></p>
						<p><input type="checkbox" id="myCheckbox16" name="myCheckbox" value="#팬클럽">
						<label for="myCheckbox16">팬클럽</label></p>
						<p><input type="checkbox" id="myCheckbox17" name="myCheckbox" value="#애니메이션">
						<label for="myCheckbox17">애니메이션</label></p>
                    </td>
                </tr>
				<tr id="timetr">
                	<th>마감시간</th>
                	<td id="timetd">
                		<input type='text' name="month" id="month" maxlength='2' value="${deadline[0]}" style="width: 50px;"/><span>월</span>
                		<input type='text' name="day" id="day" maxlength='2' value="${deadline[1]}" style="width: 50px;"/><span>일</span>
                		<input type='text' name="hour" id="hour" maxlength='2'value="${deadline[2]}" style="width: 50px;"/><span>시</span>
                		<input type='text' name="minute" id="minute" maxlength='2' value="${deadline[3]}" style="width: 50px;"/><span>분</span>
                		<span id="alertnode" style="color: red" ></span>
                		<input type="checkbox" name="notime" value="yes"><span>없음</span>
                	</td>
                </tr>
                <tr>
					<th>내용</th>
					<td>
						<textarea name="boardcontents" rows="20" cols="100">${board.lpostcontents}</textarea>
					</td>
				</tr>
				<tr>
                    <th>주소</th>
                    <td>
	                   <div class="map_wrap">
						    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
						    <div id="menu_wrap" class="bg_white">
						        <div class="option">
						            <div>
						                <div class="search-form" onsubmit="searchPlaces(); return false;" style="display:inline">
											<span>키워드</span><input type="text" value="${addr.placeName}" id="keyword" onkeydown="if(event.keyCode==13){mapApi(); return false;}"> 
											<button type="button" onclick="mapApi()">검색</button> 
										</div>
						            </div>
						        </div>
						        <hr>
						        <ul id="placesList"></ul>
						        <div id="pagination"></div>
						    </div>
						</div>
                    </td>
                </tr>
                <tr>
                	<th></th>
                	<td id="map2">
                		<!-- 장소 정보를 표시할 요소 -->
					    <div id="placeInfo"></div>
					    <input type="hidden" id="jsonDataInput" name="jsonData">
                	</td>
                </tr>
			</table>
			<input type="hidden" value="" name="updateCnt" id="updateCnt">
		</form>
		<table class="btn_area">
			<tbody>
				<tr>
					<td>
						<a class="lp_btn_box" href="javascript:sendit();">수정완료</a>
						<a class="lp_btn_box" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}">목록</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="${cp}/js/board_write/writeAddr.js"></script>
<script>
	const cp = '${cp}';
</script>
<script>
	function sendit(){
		const boardForm = document.boardForm;
		//유효성 검사
		
		//카테고리 파라미터로 준비
		const checkboxes = document.getElementsByName("myCheckbox");
		const selectedCategories = [];
		checkboxes.forEach(checkbox => {
		    if (checkbox.checked) {
		        const hiddenInput = document.createElement('input');
		        hiddenInput.setAttribute('type', 'hidden');
		        hiddenInput.setAttribute('name', 'selectedCategories');
		        hiddenInput.setAttribute('value', checkbox.value);
		        document.getElementById("boardForm").appendChild(hiddenInput);
		    }
		});
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
	                if (parseInt(hour) > 24) {
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
	    
	 // 체크박스 값을 받아서 선택된 체크박스를 출력하는 함수
	    function selectCheckboxes(values) {
	        // 받은 값들을 배열로 변환
	        var selectedValues = values.split(' ');

	        // 첫 번째 값은 빈 문자열일 수 있으므로 제거
	        selectedValues = selectedValues.filter(function(value) {
	            return value !== '';
	        });

	        // 모든 체크박스 요소 가져오기
	        var checkboxes = document.getElementsByName('myCheckbox');

	        // 각 체크박스 요소를 순회하면서 선택 여부 설정
	        checkboxes.forEach(function(checkbox) {
	            if (selectedValues.includes(checkbox.value)) {
	                checkbox.checked = true; // 선택
	            } else {
	                checkbox.checked = false; // 선택 해제
	            }
	        });
	    }

	    window.onload = function() {
	    	var values = "${board.lpostcategory}";
	        console.log(values);

	        // 체크박스 선택 함수 호출
	        selectCheckboxes(values);

	        // mapApi 함수 호출
	        mapApi();
	    };
</script>
</html>








