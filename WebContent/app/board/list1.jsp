<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet"
	href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />
<link href="${cp}/css/list1.css" rel="stylesheet">
</head>

<body>
    <header>
		<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	</header>
	<div id="wrap">
		<div id="lp_top_tit">
            <h1>우리동네 새로운 이야기</h1>
            <div id="lp_tit_img_box">
                <div id="lp_tit_img"></div>
            </div>
        </div>
        <div id="lp_gather">
            <a class="write btn" href="javascript:boardwrite()">
                <div id="gather_box">글쓰기</div>
            </a>
        </div>
		<h2 id="title">${useraddr}의 곧 마감되는 게시글이에요</h2>
		<div class="firstpost">
			<c:if test="${not empty quickpost}">
			<c:forEach var="i" begin="0" end="${quickpost.size()-1}">
				<c:set var="quickp" value="${quickpost[i]}"/>
					<div class="postbox">
						<div class="title">
							<a class="ttitle" href="${cp}/boardview.bo?lpostnum=${quickp.getLpostnum()}&page=${page}&keyword=${keyword}">
								${quickp.getLposttitle()}
								<span id="reply_cnt">[${reply_cnt_list[i] != null ? reply_cnt_list[i] : ""}]</span>
							</a>
						</div>   
						<div class="content">${quickp.getLpostcontents()}</div>
						<div class="adgory">
							<div class="addr">${loginUserAddr}</div>
							<div class="category">${quickp.getLpostcategory()}</div>
						</div>
						<div class="img">
						<c:choose>
						<c:when test="${quickp.getImageCount()!=0}">
						<p>${quickp.getImageCount()}</p>
							<c:forEach var="j" begin="0" end="${quickp.getImageCount()-1}">
							        <img src="./images/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
							             style="width: 25px; height: 25px;">
							    </c:forEach>
						</c:when>
						<c:otherwise>
							아직 아무도 참여하지 않았어요
						</c:otherwise>	
	
						</c:choose>
						</div>
						<div class="regcnt">
							<div class="regdate">${quickp.getLpostregdate()}</div>
						</div>
					</div>
			</c:forEach>
			</c:if>
		</div>        
		
		<div class="townboard">
			<div class="tbtop">
				<h2 id="title">전체 게시글</h2>
					<!-- <select id="searchMenu">
					    <option value="" selected>전체</option>
					    <option value="lposttitle">제목</option>	
					    <option value="lpostcategory">카테고리</option>
					    <option value="userid">작성자</option>
					</select> -->
				<input type="text" placeholder=" 검색어 입력" id="keyword">
				<input class="search_btn" type="button" value="검색" onclick="search()"> 
			</div>
		</div>

<!-- 반복할 영역 -->
		<div class="secondpostbox">
			<c:choose>
				<c:when test="${list != null and list.size() > 0}">
	            <c:forEach var="i" begin="0" end="${list.size() - 1}">
	               <c:set var="board" value="${list[i]}"/>
	           			<div class="secondpost">
	                         <div class="tpostbox">
								<div class="ttitle_box">
								    <a class="ttitle" href="${cp}/boardview.bo?lpostnum=${board.lpostnum}&page=${page}&keyword=${keyword}">
								        ${board.lposttitle != null ? board.lposttitle : ""} 
								        <span id="reply_cnt">[${reply_cnt_list[i] != null ? reply_cnt_list[i] : ""}]</span>
								    </a>
								</div>
	                             <div class="tcontent">${board.lpostcontents}</div>
	             
	                             <div class="tadgory">
	                                 <div class="taddr">${board.lpostaddr}</div>
	                                 <div class="tcategory">${board.lpostcategory }</div>
	                             </div>
	                             <div class="timg">
					                <!-- 이미지 카운트에 따라 이미지 생성 
					                	forEach는 무조건 한 번은 실행이 되어서 if문을 추가했습니다.-->
					                	<c:choose>
					                		<c:when test="${board.imageCount > 0}">
											    <c:forEach var="j" begin="0" end="${board.imageCount-1}">
											        <img src="./images/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원" style="width: 25px; height: 25px;">
											    </c:forEach>
					                		</c:when>
					                		<c:otherwise>
												아직 아무도 참여하지 않았어요
					                		</c:otherwise>
					                	</c:choose>
					            </div>
	                             <div class="tregcnt">
	                                 <div class="tregdate">${board.lpostregdate }</div>
	                                 <div class="tlikecnt">
	                                     <img class="theart" src="./images/like.webp" alt="좋아요수" style="width: 15px; height: 15px;">
	                                     <p class="tlike_cnt">${board.lpostlikecnt }</p>
	                                 </div>
	                             </div>
	                         </div>
	                     </div>
	                  </c:forEach>
	            </c:when>
            </c:choose>
        </div>
        
        <!-- 페이징 처리하는 테이블 -->
        <div class="postpage_box">
			<table class="postpage">
				<tbody>
					<tr>
						<td>
							<c:if test="${startPage != 1}">
								<a class="btnnum" href="${cp}/boardlist.bo?page=${startPage-1}&keyword=${keyword}">&lt;</a>
							</c:if>
							<c:forEach begin="${startPage}" end="${endPage}" var="i">
								<c:choose>
									<c:when test="${page == i}">
										<span class="nowPage">${i}</span>
									</c:when>
									<c:otherwise>
										<a class="btnnum" href="${cp}/boardlist.bo?page=${i}&keyword=${keyword}&sessionId=${sessionScope.sessionId}">${i}</a>
	
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${endPage != totalPage}">
								<a class="btnnum" href="${cp}/boardlist.bo?page=${endPage+1}&keyword=${keyword}">&gt;</a>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
        </div>
    </div>
</body>
<script>
	const cp = '${cp}';
	const page = '${page}';
	const keyword = '${keyword}';
	const loginUser = '${loginUser}';
	const loginUseraddri = '${loginUserAddrList[i]}'
</script>
<script>
	function boardwrite(){
		location.href = cp+"/boardwrite.bo?page="+page+"&keyword="+keyword;
	}
    window.onload = function() {
        // 세션 아이디 가져오기
        const sessionId = "${sessionScope.sessionId}";
        // 현재 URL 가져오기
        const currentUrl = window.location.href;
        // 세션 아이디가 존재하고 현재 URL에 세션 아이디가 없는 경우에만 세션 아이디를 추가하여 새로운 URL 생성
        if (sessionId && !currentUrl.includes("sessionId")) {
            const prevLink = document.getElementById('prevLink');
            if (prevLink) {
                prevLink.href += "&sessionId=" + sessionId;
            }
        }
    };

    function search() {
        console.log("로그 들어옴");
        const keyword = document.getElementById("keyword").value;
        /* const searchMenu = document.getElementById("searchMenu").value; */
        //console.log(keyword, searchMenu);
        /* location.replace("${cp}/boardlist.bo?keyword=" + keyword + "&searchMenu=" + searchMenu); */
        location.replace("${cp}/boardlist.bo?keyword=" + keyword);
    }

</script>
</html>
