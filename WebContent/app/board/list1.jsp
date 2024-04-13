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

    </header>
    <div id="wrap">


        <h2 id="title">곧 모집이 마감되는 게시글!</h2>
        <div class="firstpost">
        	<c:forEach begin="0" end="3">
	            <div class="postbox">
	                <div class="title">강아지 산책 같이 가실분</div>
	                <div class="content">7시에 만나요 제가 강아지 간식을 챙겨갈게요</div>
	
	                <div class="adgory">
	                    <div class="addr">동작구</div>
	                    <div class="category">#산책 #공원</div>
	                </div>
	                <div class="img">
	                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
	                        style="width: 25px; height: 25px;">
	                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
	                        style="width: 25px; height: 25px;">
	                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
	                        style="width: 25px; height: 25px;">
	                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
	                        style="width: 25px; height: 25px;">
	                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
	                        style="width: 25px; height: 25px;">
	                </div>
	                <div class="regcnt">
	                    <div class="regdate">240405 09:59:25</div>
	                    <div class="likecnt">
	                        <p class="like_cnt">1</p>
	                        <img class="heart" src="./image/like.webp" style="width: 15px; height: 15px;">
	                    </div>
	                </div>
	            </div>
            </c:forEach>
        </div>
        <div class="townboard">
            <div class="tbtop">
                <h2 id="title">우리동네 게시글</h2>
                <input type="text" placeholder="검색어 입력" id="keyword">
                <input type="button" value="검색" onclick="search()"> 
            </div>
<!-- 반복할 영역 -->
		<c:choose>
			<c:when test="${list != null and list.size() > 0}">
            <c:forEach var="i" begin="0" end="${list.size() - 1}">
               <c:set var="board" value="${list[i]}"/>
                     <div class="secondpost">
                         <div class="tpostbox">
                         
								<div>
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
				                <!-- 이미지 카운트에 따라 이미지 생성 -->
				                <c:forEach var="j" begin="0" end="${board.imageCount}">
				                    <img src="./image/User_Avatar_Human_Profile_Face_Circle-256.webp" alt="모집인원"
				                        style="width: 25px; height: 25px;">
				                </c:forEach>
				            </div>
                             <div class="tregcnt">
                                 <div class="tregdate">${board.lpostregdate }</div>
                                 <div class="tlikecnt">
                                     <p class="tlike_cnt">${board.lpostlikecnt }</p>
                                     <img class="theart" src="./image/like.webp" alt="좋아요수" style="width: 15px; height: 15px;">

                                 </div>
                             </div>
                         </div>
                     </div>
                  </c:forEach>
               </c:when>
            </c:choose>
        </div>
        
        <!-- 페이징 처리하는 테이블 -->
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
									<a class="btnnum" href="${cp}/boardlist.bo?page=${i}&keyword=${keyword}">${i}</a>
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
		<table class="btn_table">
			<tbody>
				<tr>
					<td>
						<a class="write btn" href="${cp}/boardwrite.bo?page=${page}&keyword=${keyword}">글쓰기</a>
					</td>
				</tr>
			</tbody>
		</table>
    </div>
</body>
<script>

    function search(){
        console.log("로그 들어옴");
        const keyword = document.getElementById("keyword").value;
        console.log(keyword);
        //유효성 검사
        location.replace("${cp}/boardlist.bo?keyword="+keyword);
    }

</script>
</html>