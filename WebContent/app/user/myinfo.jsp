<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${cp}/css/myinfo.css">
<meta charset="UTF-8">
</head>
<body>
	<header>
		<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	</header>
	<div class="User_more">
		<!-- 내 모임 시작 -->
		<div class="lpost_wrap">
			<a href="/WebContent/app/board/list1.jsp" class="banner_link">
				<div class="lpost_banner">내 게시판 | More</div>
			</a>
			<div class="lpost_body">
				<c:choose>
					<c:when test="${not empty lpost}">
						<a href="/boardwrite.bo">
							<div class="create_box myinfo_card_list">
								<div class="create_sub">
									<div class="coverout">
										<div class="coverin">+</div>
									</div>
									<div class="MoreName">
										<p>게시판을 더 만들어봐요!</p>
									</div>
								</div>
							</div>
						</a>
						<c:forEach var="lpost" items="${lpost}">
							<div class="myinfo_card_list" onclick="javascript:goLPost(${lpost.lpostnum})">
								<div>
									<p>${lpost.lposttitle}</p>
									<p>${lpost.lpostlikecnt}</p>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<a href="/boardwrite.bo">
							<div class="myinfo_card_list">
								<div class="create_box">
									<div class="create_sub">
										<div class="coverout">
											<div class="coverin">+</div>
										</div>
										<div class=MoreName>
											<p>등록된 게시판이 없네요.</p>
											<p>게시판을 만들어 보세요!!</p>
										</div>
									</div>
								</div>
							</div>
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<!-- 내 그룹 시작 -->
		<div class="group_wrap">
			<a href="/WebContent/app/group/groupAllList.jsp" class="banner_link">
				<div class="group_banner">내 모임 | More</div>
			</a>
			<div class="group_body">
				<c:choose>
					<c:when test="${not empty group}">
						<a href="/boardwrite.bo">
							<div class="create_box myinfo_card_list">
								<div class="create_sub">
									<div class=coverout>
										<div class="coverin">+</div>
									</div>
									<div class="MoreName">
										<p>내 모임을 만들어 보세요!</p>
									</div>
								</div>
							</div>
						</a>
						<c:forEach var="i" begin="0" end="${group.size()-1}">
							<c:set var="grouplist" value="${group[i]}"/>
							<c:set var="groupimglist" value="${groupimg[i]}"/>
							<div class="myinfo_card_list">
								<c:choose>
									<c:when test="${not empty groupimglist}">
										<img src="${cp}/file/groupimg/${groupimglist.imgsysname}" alt="">
									</c:when>
									<c:otherwise>
										<img src="${cp}/images/group/main_img.jpg" alt="default" />
									</c:otherwise>
								</c:choose>
								<div>
									<p>${grouplist.groupname}</p>
									<p>${grouplist.groupcategory}</p>
									<p>${grouplist.groupmaster}</p>
									<p>${grouplist.grouplikecnt}</p>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<a href="/boardwrite.bo">
							<div class="myinfo_card_list">
								<div class="create_sub">
									<div class="coverout">
										<div class="coverin">+</div>
									</div>
									<div class="MoreName">
										<p>등록된 모임이 없네요.</p>
										<p>모임을 만들어 보세요!!</p>
									</div>
								</div>
							</div>
						</a>
					</c:otherwise>
				</c:choose>
			</div>
		</div>
		<div class="banner_frame">
			<div class="banner">광고입니다</div>
		</div>
	</div>
</body>
<script>
	const cp = '${cp}';
</script>
<script>
	function goLPost(lpostnum) {
		location.href=cp+"/boardview.bo?lpostnum="+lpostnum;
	}
</script>
</html>
