<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <c:set var="cp" value="${pageContext.request.contextPath}" scope="session"/>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hobby | More</title>
    <link rel="stylesheet" href="<c:url value='${cp}/css/hobby.css'/>">

</head>

<body>
     <div class="main_hobby_wrap">
        <div class="main_h_title"><p>전체보기</p></div>
            <div class="main_h_contents">

                <a href="#">
                	<div class="main_contents_title" onclick="sendCategoryId('스포츠/레저');">스포츠/레저</div>
                </a>
                <a href="#">
                <div class="main_contents_title" onclick="sendCategoryId('친목/모임')">친목/모임</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('문학/예술')">문학/예술</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('여행/캠핑')">여행/캠핑</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('맛집/요리')">맛집/요리</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('어학/외국어')">어학/외국어</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('교육/공부')">교육/공부</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('인문/과학')">인문/과학</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('종교/봉사')">종교/봉사</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('반려동물/동물')">반려동물/동물</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('자연/귀농')">자연/귀농</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('게임')">게임</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('IT/컴퓨터')">IT/컴퓨터</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('팬클럽')">팬클럽</div>
                </a>
                <a href="#">
                    <div class="main_contents_title" onclick="sendCategoryId('애니메이션')">애니메이션</div>
                </a>
                <a href="#">
                <div class="main_contents_title" onclick="sendCategoryId('기타')">기타</div>
                </a>
                <!-- <div class="box bg-1">
                    <button class="button button--antiman button--round-l button--text-medium"><i class="button__icon icon icon-plus"></i><span>Add New</span></button>
                    <button class="button button--antiman button--round-l button--text-medium"><i class="button__icon icon icon-map-marker"></i><span>Locate</span></button>
	                    <button class="button button--antiman button--round-l button--text-medium"><i class="button__icon icon icon-clock"></i><span>Schedule</span></button>
	                  </div> -->
             </div>
        </div>
    </body>
    <script> const cp = '${cp}';</script>
    <script src="${cp}/js/user.js"></script>
    <script src="${cp}/js/hobby.js"></script>
</html>