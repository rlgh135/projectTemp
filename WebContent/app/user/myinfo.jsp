<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 모임 | more</title>
</head>
<body>
	<header>
		<div id="top_tit">
			<h1>내 More</h1>
		</div>
	</header>
		<div class="User_more">
			<c:choose>
				<c:when test="${not empty lpost}">
					<c:forEach var="post" items="${lpost}">
						<div class="myinfo_card_list">
							<div>
								<p>${post.lposttitle}</p>
								<p>${post.lpostlikecnt}</p>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<%-- 사용자의 게시물이 없는 경우 --%>
					<div class="myinfo_card_list">
						<div>
							<p>등록된 게시판이 없네요.</p>
							<p>게시판을 만들어 보세요!!</p>
							<div class="create_sub">
								<a href="/boardwrite.bo">
									<div id="create_box_sub">+</div>
								</a>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
			
			<c:choose>
				<c:when test="${not empty lpost}">
					<c:forEach var="post" items="${lpost}">
						<div class="myinfo_card_list">
							<div>
								<p>${post.lposttitle}</p>
								<p>${post.lpostlikecnt}</p>
							</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					<%-- 사용자의 게시물이 없는 경우 --%>
					<div class="myinfo_card_list">
						<div>
							<p>등록된 모임이 없네요.</p>
							<p>모임을 만들어 보세요!!</p>
							<div class="create_sub">
								<a href="/boardwrite.bo">
									<div id="create_box_sub">+</div>
								</a>
							</div>
						</div>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
</body>
</html>
