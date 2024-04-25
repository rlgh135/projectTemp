<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>grouplist</title>
    <link rel="stylesheet" href="${cp}/css/group/grouplist.css">
</head>
<header>
	<jsp:include page="${cp}/app/header.jsp"></jsp:include>
</header>
<body>
	    
    <!-- 본문 -->
    <div id="wrap">
        <div id="top_tit">
            <h1>내 삶에 가장 가까운 모임</h1>
            <div id="tit_img_box">
                <div id="tit_img"></div>
            </div>
        </div>
        <div id="gather">
            <a href="${cp}/app/group/createGroup.jsp">
                <div id="gather_box">모집하기</div>
            </a>
        </div>
        <div id="hobby_box">
            <div class="hb_btn_box">
                <input type="button" value="&lt;" id="l_btn" onclick="l_scroll()">
            </div>
            <div id="hobby">
                <a href="/groupList.gr?userid=${user.userid}" class="top_keyword">전체</a>
                <a href="/groupHobbyList.gr?hobbykeyword=스포츠/레저&userid=${user.userid}" class="top_keyword">스포츠/레저</a>
                <a href="/groupHobbyList.gr?hobbykeyword=취미&userid=${user.userid}" class="top_keyword">취미</a>
                <a href="/groupHobbyList.gr?hobbykeyword=친목/모임&userid=${user.userid}" class="top_keyword">친목/모임</a>
                <a href="/groupHobbyList.gr?hobbykeyword=음악&userid=${user.userid}" class="top_keyword">음악</a>
                <a href="/groupHobbyList.gr?hobbykeyword=문화/예술&userid=${user.userid}" class="top_keyword">문화/예술</a>
                <a href="/groupHobbyList.gr?hobbykeyword=여행/캠핑&userid=${user.userid}" class="top_keyword">여행/캠핑</a>
                <a href="/groupHobbyList.gr?hobbykeyword=맛집/요리&userid=${user.userid}" class="top_keyword">맛집/요리</a>
                <a href="/groupHobbyList.gr?hobbykeyword=어학/외국어&userid=${user.userid}" class="top_keyword">어학/외국어</a>
                <a href="/groupHobbyList.gr?hobbykeyword=교육/공부&userid=${user.userid}" class="top_keyword">교육/공부</a>
                <a href="/groupHobbyList.gr?hobbykeyword=인문/과학&userid=${user.userid}" class="top_keyword">인문/과학</a>
                <a href="/groupHobbyList.gr?hobbykeyword=종교/봉사&userid=${user.userid}" class="top_keyword">종교/봉사</a>
                <a href="/groupHobbyList.gr?hobbykeyword=반려동물/동물&userid=${user.userid}" class="top_keyword">반려동물/동물</a>
                <a href="/groupHobbyList.gr?hobbykeyword=자연/귀농&userid=${user.userid}" class="top_keyword">자연/귀농</a>
                <a href="/groupHobbyList.gr?hobbykeyword=게임&userid=${user.userid}" class="top_keyword">게임</a>
                <a href="/groupHobbyList.gr?hobbykeyword=IT/컴퓨터&userid=${user.userid}" class="top_keyword">IT/컴퓨터</a>
                <a href="/groupHobbyList.gr?hobbykeyword=팬클럽&userid=${user.userid}" class="top_keyword">팬클럽</a>
                <a href="/groupHobbyList.gr?hobbykeyword=애니메이션&userid=${user.userid}" class="top_keyword">애니메이션</a>
            </div>
            <div class="hb_btn_box">
                <input type="button" value="&gt;" id="r_btn" onclick="r_scroll()">
            </div>
        </div>
        
        <!-- 유저 주소에서 가입수가 가장 많은 리스트 보여주기 -->
        <div class="LB_group_title"><span>${user.useraddrgu}</span>에서 인기있는 모임</div>
        <div id="LB_group">
        	<c:choose>
        		<c:when test="${addrlist != null and addrlist.size()>0}">
        			<c:forEach var="i" begin="0" end="${addrlist.size() -1}">
        				<c:set var="group" value="${addrlist[i]}"/>
        				<c:set var="groupBI" value="groupBestImg${i}"/>
				            <a href="${cp}/groupinner.gp?groupnum=${group.groupnum}">
				                <div class="group">
					                <c:choose>
					                	<c:when test="${not empty groupBI and groupBI.length() > 0}">
								        	<img src="${cp}/file/groupimg/${requestScope[groupBI].imgsysname}"></img>
					                	</c:when>
					                	<c:otherwise>
								             <img src="${cp}/images/group/main_img.jpg"></img>
					                	</c:otherwise>
					                </c:choose>
				                    <div class="content">
				                        <p>${group.groupname}</p>
				                        <p>멤버 : ${group.groupusercnt}명</p>
				                    </div>
				                </div>
				            </a>
        			</c:forEach>
        		</c:when>
        		<c:otherwise>
        			<div class="group">
				    	<!-- <img src="${cp}/images/group/main_img.jpg"></img>  -->
				        <div class="content">
				        	<p>등록된 모임이 없네요.</p>
				        	<p>모임을 만들어 보세요!!</p>
				        	<div id="gather_sub">
				        		<!-- 모임만드는 링크걸기 -->
           						<a href="#">
                					<div id="gather_box_sub">+</div>
            					</a>
        					</div>
				        </div>
				    </div>
        		</c:otherwise>
        	</c:choose>
        </div>
        
        
        <!-- 유저의 취미 중 모임중 인기순으로 보여주기 -->
        <div id="REC_group">
		    <c:forEach var="i" begin="0" end="${hobbynum - 1}">
		        <c:set var="hobbylistVar" value="hobbylist${i}" />
		        <c:set var="groupHobbyImgVar" value="groupHobbyImg${i}" />
		        <div class="HB_group_1">
		            <c:choose>
		                <c:when test="${not empty requestScope[hobbylistVar] and requestScope[hobbylistVar].size() > 0}">
		                    <div id="HB_group_1_tit">
		                        <p>${requestScope[hobbylistVar][0].groupcategory}</p>
		                        <!-- 유저의 취미를 키워드로 더보기 만들기 -->
		                        <a href="/groupHobbyList.gr?hobbykeyword=${requestScope[hobbylistVar][0].groupcategory}&userid=${user.userid}">+ 더보기</a>
		                    </div>
		                    <c:forEach var="group" items="${requestScope[hobbylistVar]}" varStatus="outerStatus">
		                        <c:set var="groupHI" value="${requestScope[groupHobbyImgVar][outerStatus.index]}" />
		                            <div class="HB_group_1_box">
		                            <div>
		                                <a href="${cp}/groupinner.gp?groupnum=${group.groupnum}">
		                                    <c:choose>
		                                        <c:when test="${not empty groupHI.imgsysname}">
		                                            <div class="HBG_img">
		                                            	<img src="${cp}/file/groupimg/${groupHI.imgsysname}" />
						                			</div>
		                                        </c:when>
		                                        <c:otherwise>
		                                        	<div class="HBG_img">
			                                            <img src="${cp}/images/group/main_img.jpg" />
						                			</div>
		                                        </c:otherwise>
		                                    </c:choose>
		                                </a>
		                                <div class="HBG_info">
		                                    <div class="title">${group.groupname}</div>
		                                    <div class="content">${group.groupcontents}</div>
		                                    <div class="addr">#${group.groupaddr}</div>
		                                    <div class="user_count">${group.groupusercnt}명</div>
		                                </div>
		                                </div>
		                            </div>
		                    </c:forEach>
		                </c:when>
		                <c:otherwise>
		                    <div id="HB_group_1_tit">
		                        <p>${requestScope[hobbylistVar][0].groupcategory}</p>
		                    </div>
		                </c:otherwise>
		            </c:choose>
		        </div>
		    </c:forEach>
		</div>
		        
		
        
    </div>
</body>
<footer>
    <a href="#" class="btn_gotop" id="click">
        <img src="${cp}/images/group/top_img.png" > 
    </a>
</footer>
<script>
	const cp = '${cp}';
</script>
<script>
    function l_scroll() {
        // hobby 컨테이너 요소 가져오기
        let hobbyContainer = document.getElementById("hobby");
        // 스크롤할 픽셀 수 계산
        let scrollAmount = hobbyContainer.scrollLeft - 400; // 필요에 따라 이 값을 조정하세요.
        // hobby 컨테이너를 계산된 위치로 스크롤
        hobbyContainer.scrollTo({
            left: scrollAmount,
            behavior: 'smooth' // 선택 사항: 부드러운 스크롤 효과 추가
        });
    }

    function r_scroll() {
        // hobby 컨테이너 요소 가져오기
        let hobbyContainer = document.getElementById("hobby");
        // 스크롤할 픽셀 수 계산
        let scrollAmount = hobbyContainer.scrollLeft + 400; // 필요에 따라 이 값을 조정하세요.
        // hobby 컨테이너를 계산된 위치로 스크롤
        hobbyContainer.scrollTo({
            left: scrollAmount,
            behavior: 'smooth' // 선택 사항: 부드러운 스크롤 효과 추가
        });
    }
    
    window.addEventListener('scroll', function(){
        var btn_gotop = document.querySelector('.btn_gotop'); // btn_gotop 요소를 선택
        if(this.scrollY > 200) {
            btn_gotop.style.display = 'block'; // 스크롤 위치에 따라 보이게 설정
        }
        else{
            btn_gotop.style.display = 'none'; // 스크롤 위치에 따라 숨김
        }
        })

    var Top = document.getElementById('click'); // click 요소를 선택
    Top.addEventListener('click', function(e){
        e.preventDefault();

        window.scrollTo({top:0, behavior:"smooth"})
    })
    
</script>
</html>