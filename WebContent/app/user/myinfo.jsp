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
		<div class="User_moreframe">
			<%-- <div class="more_group" onclick="javascript:goGroup(${group.groupnum})">
					<p>소모임 멤버 모집!</p><span>재밌는 게임</span>
			</div> --%>
		<div class="lpost_wrap">
			<div class="lpost_banner">내 게시판</div>
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
										<p>게시판을 만들어봐요!</p>
									</div>
								</div>
							</div>
						</a>
						<c:forEach var="lpost" items="${lpost}">
							<div class="myinfo_card_list LPost"
								onclick="javascript:goLPost(${lpost.lpostnum})">
								<div>
									<p id="lpost_title">${lpost.lposttitle}</p>
									<p id="lpost_likecnt">${lpost.lpostlikecnt} 명이 좋아요를 눌렀어요!</p>
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
			<div class="group_banner">내 모임 </div>
			<div class="group_body">
				<c:choose>
					<c:when test="${not empty group}">
						<a href="${cp}/creategroup.gr">
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
							<c:set var="grouplist" value="${group[i]}" />
							<c:set var="groupimglist" value="${groupimg[i]}" />
							<div class="myinfo_card_list GPost"
							onclick="javascript:goGPost(${grouplist.groupnum})">
								<c:choose>
									<c:when test="${not empty groupimglist}">
										<img src="${cp}/file/groupimg/${groupimglist.imgsysname}"
											alt="">
									</c:when>
									<c:otherwise>
										<img src="${cp}/images/group/main_img.jpg" alt="default" />
									</c:otherwise>
								</c:choose>
								<div class="gboard_list">
									<div class="gboard_list_frame">
										<p>${grouplist.groupcategory}</p>
										<p>${grouplist.groupname}</p>
										<p 
										style="width:100px;">${grouplist.groupmaster}</p>
										<div class="like">
											<img src="./images/like.webp" alt="좋아요 수" style="width:20px; height:20px; border: none; margin: 0 auto;">
											<p>${grouplist.grouplikecnt}</p>
										</div>
									</div>
								</div>
							</div>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<a href="${cp}/creategroup.gr">
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
		 <!-- <div class="banner_frame">
			<div class="banner">
				<a href="ㅋ">
					<img src="/WebContent/images/banner.PNG" alt="">
				</a>
			</div>
		</div>  -->
		</div>
	</div>
	<footer>
		<jsp:include page="${cp}/app/footer.jsp"></jsp:include>
	</footer>
</body>	
<script>
	const cp = '${cp}';
</script>
<script>
	function goLPost(lpostnum) {
		location.href=cp+"/boardview.bo?lpostnum="+lpostnum;
	}
	function goGPost(groupnum){
		location.href=cp+"/groupinner.gp?groupnum="+groupnum;
	}
</script>
</html>
