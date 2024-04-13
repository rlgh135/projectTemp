<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 모임 | more</title>
</head>
<body>
    <header></header>
    <div id="top_tit">
        <h1>내 More</h1>
    </div>
    <div class="User_more">
        <c:choose>
            <c:when test="${addboard != null && addboard.size() -1}">
                <c:forEach var="i" begin="0" end="${addboard.size() -1}">
                    <c:set var="blist" value="${addboard[i]}"/>
                    <div class="myinfo_card_list">
                        <a href="#">
                            <img src="">
                            <div class="content">
                                <p>내 ${blist.lposttitle}</p>
                                <p>멤버 ${blist.lpostlikecnt}</p>
                            </div>
                        </a>
                    </div>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <div class="myinfo_card_list">
                    <div class="content">
                        <p>등록된 모임이 없네요.</p>
                        <p>모임을 만들어 보세요!!</p>
                        <div class="create_sub">
                            <a href="/app/user/create.jsp">
                                <div id="create_box_sub">+</div>
                            </a>
                        </div>
                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

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
    </script>
</body>
</html>