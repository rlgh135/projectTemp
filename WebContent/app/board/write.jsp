<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>write</title>
    <link href="${cp}/css/write/mapApi.css" rel="stylesheet">
    <link href="${cp}/css/write/write.css" rel="stylesheet">
</head>
<body class="write">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=c6ad5c905a822d4c391e596dfbc9acc6&libraries=services"></script>
    <header>
        <jsp:include page="${cp}/app/header.jsp"></jsp:include>
    </header>
    <div id="wrap">
        <div></div>
        <div class="header_area" style="display: none;">
                        <span>${loginUser}님 환영합니다.</span>
                        <a class="btn" href="${cp}/userlogout.us">로그아웃</a>
        </div>      
        <div class="title">
                        <p><strong>게시판</strong>글쓰기</p>
        </div>         
     
        <form id="boardForm" method="post" name="boardForm" action="${cp}/boardwriteok.bo">
            <table>
                <tr>
                    <th>ㆍ제목</th>
                    <td>
                        <input type="text" name="boardtitle" maxlength="50" placeholder="제목을 입력하세요">
                    </td>
                </tr>
                <tr>
                    <th>ㆍ작성자</th>
                    <td>
                        <input type="text" name="userid" maxlength="50" value="${loginUser}" readonly>
                    </td>
                </tr>
                <tr>
                    <th>ㆍ카테고리</th>
                    <td>
                        <input type="checkbox" id="myCheckbox01" name="myCheckbox" value="#스포츠/레저">
                        <label for="myCheckbox01">스포츠/레저</label>
						<input type="checkbox" id="myCheckbox02" name="myCheckbox" value="#취미">
						<label for="myCheckbox02">취미</label>
						<input type="checkbox" id="myCheckbox03" name="myCheckbox" value="#친목/모임">
						<label for="myCheckbox03">친목/모임</label>
						<input type="checkbox" id="myCheckbox04" name="myCheckbox" value="#음악">
						<label for="myCheckbox04">음악</label>
						<input type="checkbox" id="myCheckbox05" name="myCheckbox" value="#문화/예술">
						<label for="myCheckbox05">문화/예술</label>
						<input type="checkbox" id="myCheckbox06" name="myCheckbox" value="#여행/캠핑">
						<label for="myCheckbox06">여행/캠핑</label>
						<input type="checkbox" id="myCheckbox07" name="myCheckbox" value="#맛집/요리">
						<label for="myCheckbox07">맛집/요리</label>
						<input type="checkbox" id="myCheckbox08" name="myCheckbox" value="#어학/외국어">
						<label for="myCheckbox08">어학/외국어</label>
						<input type="checkbox" id="myCheckbox09" name="myCheckbox" value="#교육/공부">
						<label for="myCheckbox09">교육/공부</label>
						<input type="checkbox" id="myCheckbox10" name="myCheckbox" value="#인문/과학">
						<label for="myCheckbox10">인문/과학</label>
						<input type="checkbox" id="myCheckbox11" name="myCheckbox" value="#종교/봉사">
						<label for="myCheckbox11">종교/봉사</label>
						<input type="checkbox" id="myCheckbox12" name="myCheckbox" value="#반려동물/동물">
						<label for="myCheckbox12">반려동물/동물</label>
						<input type="checkbox" id="myCheckbox13" name="myCheckbox" value="#자연/귀농">
						<label for="myCheckbox">자연/귀농</label>
						<input type="checkbox" id="myCheckbox14" name="myCheckbox" value="#게임">
						<label for="myCheckbox14">게임</label>
						<input type="checkbox" id="myCheckbox15" name="myCheckbox" value="#IT/컴퓨터">
						<label for="myCheckbox15">IT/컴퓨터</label>
						<input type="checkbox" id="myCheckbox16" name="myCheckbox" value="#팬클럽">
						<label for="myCheckbox16">팬클럽</label>
						<input type="checkbox" id="myCheckbox17" name="myCheckbox" value="#애니메이션">
						<label for="myCheckbox17">애니메이션</label>
                    </td>
                </tr>
                <tr>
                	<th>마감시간</th>
                	<td id="timetd">
                		<input type='text' name="month" id="month" maxlength='2' placeholder="MM"><span>월 </span>
                		<input type='text' name="day" id="day" maxlength='2' placeholder="DD" value=""/><span>일 </span>
                		<input type='text' name="hour" id="hour" maxlength='2' placeholder="HH" value=""/><span>시 </span>
                		<input type='text' name="minute" id="minute" maxlength='2' placeholder="MM" value=""/><span>분    </span>
                		<span id="alertnode" style="color: red"></span>
                		
                		<input type="checkbox" name="notime" value="yes"><span>없음</span>
                	</td>
                </tr>
                <tr>
                    <th>ㆍ내용</th>
                    <td>
                        <textarea name="boardcontents"></textarea>
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
						                <div class="search-form" onsubmit="searchPlaces(); return false;"
						                style="display:inline">
										    키워드 : <input type="text" value="검색어 입력" id="keyword" size="15"> 
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
        </form>
        <div class="btn_area">
                        <a class="subbtn" href="javascript:sendit();">등록</a>
                        <a class="subbtn" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}">목록</a>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>    
<script src="${cp}/js/board_write/writeAddr.js"></script>
<script>
	const cp = '${cp}';
</script>
<script>
	window.setTimeout(function(){
	    document.querySelector("#wrap>div:nth-child(1)").style.display="none";
	},1200)

	function sendit() {
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
		console.log($("#month").value);
		//주소정보(lpost_addr정보) 전송하는 함수 호출 
		/* sendDataToServer(htmlString); */
		// 폼 전송
		document.boardForm.submit();
		
	}
	const alertnode = document.getElementById("alertnode");
	var replaceNotInt = /[^0-9]/gi;
	    
	    $(document).ready(function(){
	    	$("#month").on("focusout", function() {
	            var month = $(this).val();
	            if (month.length > 0) {
	                if (month.match(replaceNotInt)) {
	                	month = month.replace(replaceNotInt, "");
	                }
	                if (parseInt(month) > 12) {
	                	month = "";
	                }
	                $(this).val(month);
	            }
	        }).on("keyup", function() {
	            var month = $(this).val();
	            if (month.match(replaceNotInt)) {
	            	month = month.replace(replaceNotInt, "");
	            }
	            if (parseInt(month) > 12) {
	            	month = "";
	            }
	            $(this).val(month);
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
	                $(this).val(day);
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
</script>
</html>





