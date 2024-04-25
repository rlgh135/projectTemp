<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>groupInner</title>
<link href="${cp}/css/groupinnerstyle.css" rel="stylesheet">
<link href="${cp}/css/chatstyle.css" rel="stylesheet">
<style>
.replyHide {
	display: none;
}

.gfileli {
	display: flex;
}

.gfileli>p {
	margin-left: 10px;
}

.fileIcon>img {
	width: 20px;
	height: 20px;
}

.gpostContents>div>p {
	min-height: 80px;
}

button {
	cursor: pointer;
}

.GPCIN {
	border: none;
	background: transparent;
	overflow: hidden;
	resize: none;
	min-height: 132px;
	min-width: 470px;
}

.GPCIN:focus {
	outline: none;
}

.sujung {
	position: fixed;
	display: none;
	justify-content: center;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.4);
	z-index: 10;
	left: 50%;
	top: 50%;
	transform: translate(-50%, -50%);
}

.sujung_body {
	position: absolute;
	top: 50%;
	width: 700px;
	height: 600px;
	padding: 40px;
	text-align: center;
	background-color: rgb(255, 255, 255);
	border-radius: 10px;
	box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
	transform: translateY(-50%);
	z-index: 10;
}

#top_wrap {
	background-color: rgb(232, 218, 202);
	margin-top: 0px !important;
}
</style>
</head>
<body>
	<div class="betaversion">개발 중인 베타버전입니다. (It's a beta version
		that's being developed)</div>
	<c:if test="${empty isInGroup}"></c:if>
	<c:if test="${empty loginUser}">
		<c:set var="loginUser" value="${null}" />
	</c:if>
	<jsp:include page="${cp}/app/message/sendmessage.jsp"></jsp:include>
	<div class="sujung">
		<div class="sujung_body">
			<div style="display: flex;">
				<p style="margin-left: 10px;">
				<h3>글 수정</h3>
				</p>
				<img src="../../images/x.webp" alt="" onclick="clkSujungCBtn()"
					style="width: 30px; height: 30px; margin-left: auto; cursor: pointer;">
			</div>
			<Form method="post" action="/modifygp.gp?groupnum=${group.groupnum}"
				name="sujungForm">
				<ul>
					<li><input type="text" name="userid" value="${loginUser}"
						readonly></li>
					<li><input type="hidden" name="gposttitle" value="없음">
					</li>
					<li><input type="hidden" name="gpostnum" value=""></li>
					<li><input type="hidden" name="groupnum" value=""></li>
					<li><input type="hidden" name="gpostregdate" value="">
					</li>
					<li><textarea name="gpostcontents" id="sujungpost" cols="30"
							rows="10"></textarea></li>
				</ul>
				<div>
					<a href="javascript:modifyOk()">수정완료</a>
				</div>
			</Form>
		</div>
	</div>
	<button class="btn-open-sujung" id="sujungBtn" style="display: none;">Modal열기</button>
	<button class="btn-close-sujung" id="sujungCBtn" style="display: none;">Modal닫기</button>
	<!-- 
 -->
	<c:set var="page" value="${pararm.page}" />
	<c:choose>
		<c:when test="${empty page or param.page <= 0}">
			<c:set var="page" value="1" />
		</c:when>
		<c:otherwise>
			<c:set var="page" value="page" />
		</c:otherwise>
	</c:choose>
	<div id="group_inner_wrap">
		<header>
			<jsp:include page="${cp}/app/header.jsp"></jsp:include>
		</header>
		<div class="group-inner contents" id="group_inner_container">
			<div id="groupinfobox" class="infobox">
				<div class="groupimg imgbox">
					<img src="../../file/groupimg/${thumbnail}"
						style="background-size: cover; width: 100%; height: auto;">
				</div>
				<div class="groupinfobox-inner">
					<div id="groupname">
						<span>${group.groupname}</span>
						<c:if test="${loginUser == group.groupmaster}">
							<div class="moimcontroll">
								<div class="alertsign-red"></div>
								<a href="${cp}/checkmoim.gp?groupnum=${group.groupnum}">가입관리</a>
							</div>
						</c:if>
					</div>
					<p id="groupinfo">
						<span class="gmem">멤버: ${usercnt}</span> <span class="glead">리더:
							${group.groupmaster}</span>
					</p>
					<p>${group.groupcontents}</p>
					<ul class="grouptaglist">
						<li class="groupaddrinfo circle-list-btn"><a href="#">${group.groupaddr}</a>
						</li>
						<li class="groupcategoryinfo circle-list-btn"><a href="">${group.groupcategory}</a>
						</li>
					</ul>
					<div>
						<div class="group-btn-box btnBox">
							<c:choose>
								<c:when test="${usertype eq 1}">
									<c:choose>
										<c:when test="${loginUser eq group.groupmaster}">
											<input type="button" value="모임 탈퇴하기" class="joinMoim"
												onclick="quitMoim(${group.groupnum}, 1)">
										</c:when>
										<c:otherwise>
											<input type="button" value="모임 탈퇴하기" class="joinMoim"
												onclick="quitMoim(${group.groupnum}, 0)">
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
										<input type="button" value="모임 가입하기" class="joinMoim"
											onclick="joinMoim(${group.groupnum})">
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
			<div id="gpostsection">
				<c:choose>
					<c:when test="${empty ingi}">
						<div class="summary" style="border: none; background: none;">
							<div style="margin: 10px 0px 10px 10px;">
								<p>
								<h2>인기글이 없어요</h2>
								</p>
							</div>
							<ul class="gpostList">
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head"></div>
								</li>
							</ul>
						</div>
					</c:when>
					<c:otherwise>
						<div class="summary" style="border: none; background: none;">
							<div style="margin: 10px 0px 10px 10px;">
								<p>
								<h2>${group.groupname}이번 주 인기글</h2>
								</p>
							</div>
							<ul class="gpostList">
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head">
										<%-- 프로필 펼치기 --%>
										<button class="badgeimg modalOpenBtn"
											id="modalOpenBtn${ingi.gpostnum+10000}"
											onclick="modalClk(${ingi.gpostnum+10000})">★</button>
										<div id="modalContainer${ingi.gpostnum+10000}"
											class="modalContainer replyHide">
											<div id="modalContent${ingi.gpostnum+10000}"
												class="modalContent">
												<div id="modalinner${ingi.gpostnum+10000}"
													class="modalinner" style="width: 177px;">
													<button id="modalCloseBtn${ingi.gpostnum+10000}"
														class="modalCloseBtn"
														onclick="modalClose(${ingi.gpostnum+10000})">
														<img src="../../images/x.webp"
															style="width: 10px; height: 10px; border: none;">
													</button>
													<div class="imgid">
														<div class="mbadgeimg">
															<img src="" alt="">
														</div>
														<p>${ingi.userid}</p>
													</div>

													<div class="profilemenu">

														<%--쪽지 보내기 --%>
														<img src="../../images/mail6.webp"
															style="width: 20px; height: 20px;">
														<button type="button" class="msg_send"
															onclick="sendMessage('${ingi.userid}')"
															style="cursor: pointer;">쪽지보내기</button>
													</div>
													<div class="profilemenu">
														<img src="../../images/write.png"
															style="width: 18px; height: 18px;">
														<button type="button" class="msg_send" onclick="showPost('${ingi.userid}')"
															style="cursor: pointer;">작성글보기</button>
													</div>
												</div>
											</div>
										</div>

										<div class="writerinfo badgeimg-right-info">
											<p>
												<a href="" class="usernamelink">${ingi.userid}</a> <span>인기쟁이에요</span>
											</p>
											<p class="regtime">${ingi.gpostregdate}</p>
										</div>
									</div>

									<div class="gpostContents">
										<div>
											<p>
												<textarea
													class="GPCIN gpostConetentsIn${ingi.gpostnum+10000}"
													style="width: 100%; height: 100%">${ingi.gpostcontents}</textarea>
											</p>
											<div>
												<input type="button" style="cursor: pointer;" value="첨부파일"
													onclick="showFiles(${ingi.gpostnum+10000})">
											</div>
											<div class="gpostfile${ingi.gpostnum+10000} replyHide">
												<ul class="gfileList${ingi.gpostnum+10000}"></ul>
											</div>
											<div class="likereply">
												<img id="likeButton"
													onclick="pressLike(${ingi.gpostnum+10000})"
													class="like-button likeButton${ingi.gpostnum+10000}"
													src="${cp}/images/redheart.webp" alt="좋아요"
													style="width: 15px; height: 15px;">
												<div class="point-area showreplyBtn">
													<div style="display: inline-block;">
														<input type="button" value="좋아요 ${ingi.gpostlike }개">
													</div>
													<div style="display: inline-block;">
														<input type="button"
															class="showrpcnt${ingi.gpostnum+10000}"
															value="댓글 ${ingi.gprcnt}개"
															onclick="showReply(${ingi.gpostnum+10000})"
															style="cursor: pointer;">
													</div>

												</div>
											</div>
										</div>
									</div>
									<div class="gpostReply${ingi.gpostnum+10000} replyHide">
										<div class="repForm reply${ingi.gpostnum+10000}">
											<Form method="post" class="inputGPR"
												action="writegpreply.gp?gpostnum=${ingi.gpostnum}&?groupnum=${group.groupnum}"
												name="writeRPForm${ingi.gpostnum}">
												<div class="badgeimg">
													<img src="">
												</div>
												<div class="badgeimg-right-info">
													<p class="replywriter">${loginUser}HiImTester</p>
													<textarea name="gprcontents" id="" cols="50" rows="3"
														placeholder="새로운 댓글을 남겨보세요"></textarea>
												</div>
												<div>
													<input type="submit" value="등록">
												</div>
											</Form>
										</div>
										<ul class="greplyList${ingi.gpostnum+10000}"></ul>
									</div>
								</li>

							</ul>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="groupsearch searchArea">
					<div class="searchBox"
						style="margin-bottom: 2px; margin-left: 5px;">
						<div>
							<input type="text" name="groupsearch" id="gpsearch"
								style="border: none; outline: none; background-color: transparent;">
						</div>
						<div class="searchBtnBox">
							<input type="button" value="" onclick="makeDOMKeyword()"
								style="cursor: pointer; display: block; width: 28px; height: 28px;">
						</div>
					</div>
					<div class="write_btn">
						<input type="button" value="글쓰기"
							onclick="showWrite(${gpost.gpostnum})">
					</div>
				</div>
				<div id="gpost" class="postsection">
					<div class="write_wrap">
						<div class="writeform" id="writeForm" style="display: none;">
							<form id="writeform" method="post" action="/gpwrite.gp"
								enctype="multipart/form-data">
								<ul>
									<li>
										<h3>글쓰기</h3> <input type="hidden" name="userid"
										value="${loginUser}"> <input type="hidden"
										name="groupnum" value="${group.groupnum}">
									</li>
									<li><label for="writetit"></label> <input type="text"
										name="gptitle" id="writetit" placeholder="제목을 입력해주세요.">
									</li>
									<li><label for="writebox"></label> <textarea
											name="gpcontents" id="writebox" cols="30" rows="10"
											placeholder="새로운 소식을 남겨보세요"></textarea></li>
									<li class="uploadarea0"
										style="display: flex; padding-left: 10px"><a
										href="javascript:upload(0)" class="cFile"
										style="margin-left: -10px;">파일 선택</a> <input type="file"
										name="writefile0" id="writefile0" style="display: none">
										<span id="writefile0name" style="margin-left: 10px;">선택된
											파일 없음</span> <a href="javascript:cancelFile(0)" class="dFile"
										style="margin-left: auto;">첨부 삭제</a></li>
									<li><input type="submit" id="writesubmit" value="제출하기">
									</li>
								</ul>
							</form>
						</div>
					</div>
					<ul class="gpostList" id="gpList"></ul>
				</div>
			</div>
			<div id="grouprightsection">
				<div id="gannounce">
					<div id="gin">
						<span><h2>최신 공지사항</h2></span>

						<%--챗 --%>
						<div>
							<div id="chat-circle" class="btn btn-raised">
								<div id="chat-overlay"></div>
								<span class="material-symbols-outlined">그룹채팅+</span>
							</div>
							<div class="chat-box">
								<div class="chat-box-header">
									${group.groupname }
									<div class="chat-box-toggle">
										<img src="/images/closechat.svg"><span
											class="material-symbols-outlined"></span>
									</div>
								</div>
								<div class="chat-box-body">
									<div class="chat-box-overlay"></div>
									<div class="chat-logs"></div>
									<!--chat-log -->
								</div>
								<div class="chat-input">
									<form>
										<input type="hidden" id="userid" name="userid"
											value="${loginUser}"> <span class="echo-receiver"></span>
										<input type="text" id="chat-input"
											placeholder="Send a message..." onkeyup="sendEcho();" />
										<button type="submit" class="chat-submit" id="chat-submit">
											<img src="/images/sendchat.svg">
										</button>
									</form>
								</div>
							</div>
							<%--챗 --%>
						</div>
					</div>
					<ul class="gpostList" id="gpGongji" style="margin-top: 10px;">
						<c:choose>
							<c:when test="${empty gongji}">
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head">
										<div class="badgeimg">
											<img src="">
										</div>
										<div class="writerinfo badgeimg-right-info">
											<p>
												<a href="" class="usernamelink"></a> <span></span>
											</p>
											<p class="regtime"></p>
										</div>
									</div>
									<div class="gpostContents">
										<div>
											<p>
												<textarea class="GPCIN gpostConetentsInNo"
													style="width: 100%; height: 100%">공지가 없어요
												</textarea>
											</p>
										</div>
									</div>
								</li>
							</c:when>
							<c:otherwise>
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head">
										<div class="badgeimg">
											<img src="">
										</div>
										<div class="writerinfo badgeimg-right-info">
											<p>
												<a href="" class="usernamelink">${gongji.userid}</a> <span>공지에요</span>
											</p>
											<p class="regtime">${gongji.gpostregdate}</p>
										</div>
									</div>
									<div class="gpostContents">
										<div>
											<p>
												<textarea class="GPCIN gpostConetentsIn${gongji.gpostnum}"
													style="width: 100%; height: 100%">${gongji.gpostcontents}
												</textarea>
											</p>
										</div>
									</div>
								</li>
							</c:otherwise>
						</c:choose>
					</ul>
				</div>

			</div>
		</div>
	</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	const cp = '${cp}';
    let page = '${page}';
    let keyword = '${keyword}';
	const groupnum = '${group.groupnum}';
	const loginUser = '${loginUser}';	
</script>
<script>
    let lastScroll = 0;
    var curPage = 0;
    let searchFlag = false;
    const sec = document.getElementById("gpsearch");
    let searchkeyword = sec.value;
	
    document.addEventListener("DOMContentLoaded", function() {
        makeDOM();
    });
    
    function showPost(userid) {
		location.href=cp+"/showpost.gp?groupnum="+groupnum+"&showuser="+userid;
	}
    
    function showFiles(gpostnum){
    	console.log("호출");
    	var targetnode = document.getElementsByClassName("gpostfile"+gpostnum)[0];
    	targetnode.classList.toggle("replyHide");
    	
    	let parentRNode = document.getElementsByClassName("gfileList"+gpostnum)[0];
    	console.log(parentRNode);
    	console.log(parentRNode.childNodes);
    	console.log(parentRNode.childNodes.length);
    	if(parentRNode.childNodes.length === 0){
    		//긁기
    		console.log("들어옴?");
    		getGFiles(gpostnum);
    		//리스트 받아오고 이전,다음 버튼 만들기
    	}
    }
    
    function getGFiles(gpostnum){
    	const parentFnode = document.getElementsByClassName("gfileList"+gpostnum)[0];
	    const xhr = new XMLHttpRequest();
	    console.log(gpostnum+"파일");
	    xhr.onreadystatechange = function(){
	    	if(xhr.readyState == 4){
	    		if(xhr.status==200){
	    			console.log(xhr.responseText);
	    			const obj = JSON.parse(xhr.responseText);
	    			const datas = obj.datas;
	    			console.log(datas);
	    			console.log(datas.length);
	    			
	    			if(datas.length===0){
	    				let newLi = document.createElement('li');
	    				newLi.className = 'gfileli';
	    				    
	    				newLi.innerHTML='<div class="fileIcon">' +
			                 '<img src="../../images/groupinnerfileimg.png">' +
			                 '</div>' +
			                 '<p style="color:red">파일이 없습니다</p>';
	    				 
	    				parentFnode.appendChild(newLi);
	    			} else {
	    				for(let gfile of datas){
		    				let newLi = document.createElement('li');
							newLi.className = 'gfileli';
							    
							newLi.innerHTML='<div class="fileIcon">' +
			                 '<img src="../../images/groupinnerfileimg.png">' +
			                 '</div>' +
			                 '<p>' +
			                     '<a href='+cp+'"/filedownload.gp?systemname='+gfile.gfilesysname+'&orgname='+gfile.gfileorgname+'">'+gfile.gfileorgname+'</a>' +
			                 '</p>';
							    
							parentFnode.appendChild(newLi);	
	    					
	    				}
	    			}
	    		}
	    	}
	    }
	    
	    xhr.open("GET", cp+"/getgfile.gp?gpostnum="+gpostnum);
	    xhr.send();
    }
    
    function showReply(gpostnum){
    	console.log("호출");
    	var targetnode = document.getElementsByClassName("gpostReply"+gpostnum)[0];
    	targetnode.classList.toggle("replyHide");
    	
    	let parentRNode = document.getElementsByClassName("greplyList"+gpostnum)[0];
    	console.log(parentRNode);
    	console.log(parentRNode.childNodes);
    	console.log(parentRNode.childNodes.length);
    	if(parentRNode.childNodes.length === 0){
    		//긁기
    		console.log("들어옴?");
    		makeReply(gpostnum, 1);
    		//리스트 받아오고 이전,다음 버튼 만들기
    		if(parentRNode.childNodes.length === 0){
    			//댓글이 없습니다
    			console.log("노댓");
    		}
    	}
    }
    
    function makeReply(gpostnum, rpage){
	    var curRPage = 1;
    	if(rpage>1){
    		curPage = rpage;
    	}
	    const parentRnode = document.getElementsByClassName("greplyList"+gpostnum)[0];
	    const xhr = new XMLHttpRequest();
	    	
	    xhr.onreadystatechange = function(){
	    	if(xhr.readyState == 4){
	    		if(xhr.status==200){
	    			console.log(xhr.responseText);
	    			const obj = JSON.parse(xhr.responseText);
	    			const datas = obj.datas;
	    			console.log(datas);
	    			console.log(datas.length);
	    			

	    			if(datas.length===0){
	    				if(curPage>1){
	    					return;
	    				} else {
		    				let newLi = document.createElement('li');
		    				newLi.className = 'greplyListwrap default-group-Head';
		    				    
		    				newLi.innerHTML='<p>댓글이 없습니다.</p>';
		    				    
		    				parentRnode.appendChild(newLi);
	    				}
	    			} else {
		    			for(let greply of datas){
		    				let newLi = document.createElement('li');
							newLi.className = 'greplyListwrap default-group-Head';
							    
							newLi.innerHTML='<div class="gprnum' + greply.gprnum + '" style="display:none;"></div>' +
							'<div class="badgeimg">' +
							'    <img src="">' +
							'</div>' +
							'<div class="badgeimg-right-info">' +
							'    <p class="replywriter">'+greply.userid+'</p>' +
							'    <p class="replycontents">' +greply.gprcontents+
							'    </p>' +
							'    <p class="gprregdate">'+greply.gprregdate+'</p>' +
							'</div>';
							    
							parentRnode.appendChild(newLi);	
	    					
	    				}
	    			}
	    		}
	    	}
	    }
	    
		if(gpostnum>10000){
			var temp = gpostnum-10000
			xhr.open("GET", cp+"/groupreply.gp?gpostnum="+temp+"&page="+curRPage);
		}
	    xhr.open("GET", cp+"/groupreply.gp?gpostnum="+gpostnum+"&page="+curRPage);
	    xhr.send();
    }
    
    function makeDOM(){
    	curPage++;
    	console.log("불러오는 페이지: "+curPage);
        let orgnode = document.getElementsByClassName("gpostListwrap")[0];
		const xhr = new XMLHttpRequest();
		const parentnode = document.getElementById("gpList");
		searchkeyword = sec.value;
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4){
				if(xhr.status==200){
					console.log(xhr.responseText);
					const obj = JSON.parse(xhr.responseText);
					//console.log(obj);
					const datas = obj.datas;
					console.log(datas);
					const likelist = obj.likelist;
					console.log(likelist);
					
					//돔돔
					for(let i in datas){
						let newLi = document.createElement('li');
					    newLi.className = 'gpostListwrap';
					 // gpostHead 요소 생성 및 추가
					    var gpostHeadDiv = document.createElement('div');
					    gpostHeadDiv.className = 'gpostHead default-group-Head';
					    newLi.appendChild(gpostHeadDiv);

					    // modalOpenBtn 요소 생성 및 추가
					    var modalOpenBtn = document.createElement('button');
					    modalOpenBtn.className = 'badgeimg modalOpenBtn';
					    modalOpenBtn.id = 'modalOpenBtn' + datas[i].gpostnum;
					    modalOpenBtn.onclick = function() { modalClk(datas[i].gpostnum); };
					    modalOpenBtn.innerText = '★';
					    gpostHeadDiv.appendChild(modalOpenBtn);

					    // modalContainer 요소 생성 및 추가
					    var modalContainerDiv = document.createElement('div');
					    modalContainerDiv.id = 'modalContainer' + datas[i].gpostnum;
					    modalContainerDiv.className = 'modalContainer replyHide';
					    gpostHeadDiv.appendChild(modalContainerDiv);

					    // modalContent 요소 생성 및 추가
					    var modalContentDiv = document.createElement('div');
					    modalContentDiv.id = 'modalContent' + datas[i].gpostnum;
					    modalContentDiv.className = 'modalContent';
					    modalContainerDiv.appendChild(modalContentDiv);

					    // modalinner 요소 생성 및 추가
					    var modalinnerDiv = document.createElement('div');
					    modalinnerDiv.id = 'modalinner' + datas[i].gpostnum;
					    modalinnerDiv.className = 'modalinner';
					    modalinnerDiv.style.width = '177px';
					    modalContentDiv.appendChild(modalinnerDiv);

					    // modalCloseBtn 요소 생성 및 추가
					    var modalCloseBtn = document.createElement('button');
					    modalCloseBtn.id = 'modalCloseBtn' + datas[i].gpostnum;
					    modalCloseBtn.className = 'modalCloseBtn';
					    modalCloseBtn.onclick = function() { modalClose(datas[i].gpostnum); };
					    modalinnerDiv.appendChild(modalCloseBtn);

					    // 이미지 요소 생성 및 추가
					    var modalCloseBtnImg = document.createElement('img');
					    modalCloseBtnImg.src = '../../images/x.webp';
					    modalCloseBtnImg.style.width = '10px';
					    modalCloseBtnImg.style.height = '10px';
					    modalCloseBtnImg.style.border = 'none';
					    modalCloseBtn.appendChild(modalCloseBtnImg);

					    // imgid 요소 생성 및 추가
					    var imgidDiv = document.createElement('div');
					    imgidDiv.className = 'imgid';
					    modalinnerDiv.appendChild(imgidDiv);

					    // mbadgeimg 요소 생성 및 추가
					    var mbadgeimgDiv = document.createElement('div');
					    mbadgeimgDiv.className = 'mbadgeimg';
					    imgidDiv.appendChild(mbadgeimgDiv);

					    // 이미지 요소 생성 및 추가
					    var imgidImg = document.createElement('img');
					    imgidImg.src = '';
					    imgidImg.alt = '';
					    mbadgeimgDiv.appendChild(imgidImg);

					    // p 요소 생성 및 추가
					    var gpostuseridP = document.createElement('p');
					    gpostuseridP.id = 'gpostuserid';
					    gpostuseridP.innerText = datas[i].userid;
					    imgidDiv.appendChild(gpostuseridP);

					    // profilemenu 요소 생성 및 추가
					    var profilemenuDiv = document.createElement('div');
					    profilemenuDiv.className = 'profilemenu';
					    modalinnerDiv.appendChild(profilemenuDiv);

					    // 이미지 요소 생성 및 추가
					    var profilemenuImg = document.createElement('img');
					    profilemenuImg.src = '../../images/mail6.webp';
					    profilemenuImg.style.width = '20px';
					    profilemenuImg.style.height = '20px';
					    profilemenuDiv.appendChild(profilemenuImg);

					    // 쪽지보내기 버튼 요소 생성 및 추가
					    var msg_sendButton = document.createElement('button');
					    msg_sendButton.type = 'button';
					    msg_sendButton.className = 'msg_send';
					    msg_sendButton.onclick = function() { sendMessage(datas[i].userid); };
					    msg_sendButton.innerText = '쪽지보내기';
					    profilemenuDiv.appendChild(msg_sendButton);

					    // profilemenu 요소 생성 및 추가
					    var profilemenuDiv2 = document.createElement('div');
					    profilemenuDiv2.className = 'profilemenu';
					    modalinnerDiv.appendChild(profilemenuDiv2);

					    // 이미지 요소 생성 및 추가
					    var profilemenuImg2 = document.createElement('img');
					    profilemenuImg2.src = '../../images/write.png';
					    profilemenuImg2.style.width = '18px';
					    profilemenuImg2.style.height = '18px';
					    profilemenuDiv2.appendChild(profilemenuImg2);

					    // p 요소 생성 및 추가
					    var pTag = document.createElement('p');
					    pTag.innerText = '작성글보기';
					    profilemenuDiv2.appendChild(pTag);

					    // writerinfo 요소 생성 및 추가
					    var writerinfoDiv = document.createElement('div');
					    writerinfoDiv.className = 'writerinfo badgeimg-right-info';
					    gpostHeadDiv.appendChild(writerinfoDiv);

					    // p 요소 생성 및 추가
					    var pTag2 = document.createElement('p');
					    writerinfoDiv.appendChild(pTag2);

					    // a 요소 생성 및 추가
					    var aTag = document.createElement('a');
					    aTag.href = '';
					    aTag.className = 'usernamelink';
					    aTag.innerText = datas[i].userid;
					    pTag2.appendChild(aTag);

					    // span 요소 생성 및 추가
					    var spanTag = document.createElement('span');
					    spanTag.innerText = '이런사람이에요';
					    pTag2.appendChild(spanTag);

					    // p 요소 생성 및 추가
					    var regtimeP = document.createElement('p');
					    regtimeP.className = 'regtime';
					    regtimeP.innerText = datas[i].gpostregdate;
					    writerinfoDiv.appendChild(regtimeP);

					    // gpostContents 요소 생성 및 추가
					    var gpostContentsDiv = document.createElement('div');
					    gpostContentsDiv.className = 'gpostContents';
					    newLi.appendChild(gpostContentsDiv);

					    // div 요소 생성 및 추가
					    var divTag = document.createElement('div');
					    gpostContentsDiv.appendChild(divTag);

					    // p 요소 생성 및 추가
					    var pTag3 = document.createElement('p');
					    divTag.appendChild(pTag3);

					    // textarea 요소 생성 및 추가
					    var textareaTag = document.createElement('textarea');
					    textareaTag.className = 'GPCIN gpostConetentsIn' + datas[i].gpostnum;
					    textareaTag.style.width = '100%';
					    textareaTag.style.height = '100%';
					    textareaTag.innerText = datas[i].gpostcontents;
					    pTag3.appendChild(textareaTag);

					    // div 요소 생성 및 추가
					    var divTag2 = document.createElement('div');
					    gpostContentsDiv.appendChild(divTag2);

					    // input 요소 생성 및 추가
					    var inputTag = document.createElement('input');
					    inputTag.type = 'button';
					    inputTag.style.cursor = 'pointer';
					    inputTag.value = '첨부파일';
					    inputTag.onclick = function() { showFiles(datas[i].gpostnum); };
					    divTag2.appendChild(inputTag);

					    // gpostfile 요소 생성 및 추가
					    var gpostfileDiv = document.createElement('div');
					    gpostfileDiv.className = 'gpostfile' + datas[i].gpostnum + ' replyHide';
					    gpostContentsDiv.appendChild(gpostfileDiv);

					    // ul 요소 생성 및 추가
					    var ulTag = document.createElement('ul');
					    ulTag.className = 'gfileList' + datas[i].gpostnum;
					    gpostfileDiv.appendChild(ulTag);

					    // likereply 요소 생성 및 추가
					    var likereplyDiv = document.createElement('div');
					    likereplyDiv.className = 'likereply';
					    gpostContentsDiv.appendChild(likereplyDiv);

					    // img 요소 생성 및 추가
					    var imgTag = document.createElement('img');
					    imgTag.id = 'likeButton';
					    imgTag.onclick = function() { pressLike(datas[i].gpostnum, datas[i].userid); };
					    imgTag.className = 'like-button likeButton' + datas[i].gpostnum;
					    if(likelist[i]===0){
						    imgTag.src = '/images/whiteheart.webp';
					    } else {
						    imgTag.src = '/images/redheart.webp';
					    }
					    imgTag.alt = '좋아요';
					    imgTag.style.width = '15px';
					    imgTag.style.height = '15px';
					    likereplyDiv.appendChild(imgTag);

					    // div 요소 생성 및 추가
					    var divTag3 = document.createElement('div');
					    divTag3.className = 'point-area showreplyBtn';
					    likereplyDiv.appendChild(divTag3);

					    // div 요소 생성 및 추가
					    var divTag4 = document.createElement('div');
					    divTag4.style.display = 'inline-block';
					    divTag3.appendChild(divTag4);

					    // input 요소 생성 및 추가
					    var inputTag2 = document.createElement('input');
					    inputTag2.type = 'button';
					    inputTag2.value = '좋아요 ' + datas[i].gpostlike + '개';
					    divTag4.appendChild(inputTag2);

					    // div 요소 생성 및 추가
					    var divTag5 = document.createElement('div');
					    divTag5.style.display = 'inline-block';
					    divTag3.appendChild(divTag5);

					    // input 요소 생성 및 추가
					    var inputTag3 = document.createElement('input');
					    inputTag3.type = 'button';
					    inputTag3.className = 'showrpcnt' + datas[i].gpostnum;
					    inputTag3.value = '댓글 ' + datas[i].gprcnt + '개';
					    inputTag3.onclick = function() { showReply(datas[i].gpostnum); };
					    inputTag3.style.cursor = 'pointer';
					    divTag5.appendChild(inputTag3);

					    if(datas[i].userid===loginUser){
						    // div 요소 생성 및 추가
						    var divTag6 = document.createElement('div');
						    divTag6.style.display = 'inline-block';
						    divTag6.style.marginLeft = '210px';
						    divTag3.appendChild(divTag6);
	
						    // input 요소 생성 및 추가
						    var inputTag4 = document.createElement('input');
						    inputTag4.type = 'button';
						    inputTag4.className = 'replyHide modify' + datas[i].gpostnum;
						    inputTag4.value = '수정';
						    inputTag4.style.cursor = 'pointer';
						    inputTag4.style.width = '70px';
						    inputTag4.style.textAlign = 'right';
						    inputTag4.onclick = function() { showUpdateForm(datas[i].gpostnum, ${group.groupnum}); };
						    divTag6.appendChild(inputTag4);
	
						    // input 요소 생성 및 추가
						    var inputTag5 = document.createElement('input');
						    inputTag5.type = 'button';
						    inputTag5.value = '삭제';
						    inputTag5.style.cursor = 'pointer';
						    inputTag5.style.width = '50px';
						    inputTag5.style.textAlign = 'right';
						    inputTag5.onclick = function() { deleteGPost(datas[i].gpostnum, ${group.groupnum}); };
						    divTag6.appendChild(inputTag5);
					    }

					    // gpostReply 요소 생성 및 추가
					    var gpostReplyDiv = document.createElement('div');
					    gpostReplyDiv.className = 'gpostReply' + datas[i].gpostnum + ' replyHide';
					    newLi.appendChild(gpostReplyDiv);

					    // repForm 요소 생성 및 추가
					    var repFormDiv = document.createElement('div');
					    repFormDiv.className = 'repForm reply' + datas[i].gpostnum;
					    gpostReplyDiv.appendChild(repFormDiv);

					    // form 요소 생성 및 추가
					    var formTag = document.createElement('form');
					    formTag.method = 'post';
					    formTag.className = 'inputGPR';
					    formTag.action = 'writegpreply.gp?gpostnum=' + datas[i].gpostnum + '&amp;groupnum=${group.groupnum}';
					    formTag.name = 'writeRPForm' + datas[i].gpostnum;
					    repFormDiv.appendChild(formTag);

					    // div 요소 생성 및 추가
					    var divTag7 = document.createElement('div');
					    divTag7.className = 'badgeimg';
					    formTag.appendChild(divTag7);

					    // img 요소 생성 및 추가
					    var imgTag2 = document.createElement('img');
					    divTag7.appendChild(imgTag2);

					    // div 요소 생성 및 추가
					    var divTag8 = document.createElement('div');
					    divTag8.className = 'badgeimg-right-info';
					    formTag.appendChild(divTag8);

					    // p 요소 생성 및 추가
					    var pTag4 = document.createElement('p');
					    pTag4.className = 'replywriter';
					    pTag4.innerText = '${loginUser}';
					    divTag8.appendChild(pTag4);

					    // textarea 요소 생성 및 추가
					    var textareaTag2 = document.createElement('textarea');
					    textareaTag2.name = 'gprcontents';
					    textareaTag2.id = '';
					    textareaTag2.cols = '50';
					    textareaTag2.rows = '3';
					    textareaTag2.placeholder = '새로운 댓글을 남겨보세요';
					    divTag8.appendChild(textareaTag2);

					    // div 요소 생성 및 추가
					    var divTag9 = document.createElement('div');
					    formTag.appendChild(divTag9);

					    // input 요소 생성 및 추가
					    var inputTag6 = document.createElement('input');
					    inputTag6.type = 'hidden';
					    inputTag6.name = 'userid';
					    inputTag6.value = '${loginUser}';
					    divTag9.appendChild(inputTag6);

					    // input 요소 생성 및 추가
					    var inputTag7 = document.createElement('input');
					    inputTag7.type = 'submit';
					    inputTag7.value = '등록';
					    divTag9.appendChild(inputTag7);

					    // ul 요소 생성 및 추가
					    var ulTag2 = document.createElement('ul');
					    ulTag2.className = 'greplyList' + datas[i].gpostnum;
					    gpostReplyDiv.appendChild(ulTag2);
					    /* newLi.innerHTML = '<li class="gpostListwrap">' +
					    '<div class="gpostHead default-group-Head">' +
					    '<button class="badgeimg modalOpenBtn" id="modalOpenBtn'+datas[i].gpostnum+'" onclick="modalClk('+datas[i].gpostnum+')">★</button>' +
					    '<div id="modalContainer'+datas[i].gpostnum+'" class="modalContainer replyHide">' +
					    '<div id="modalContent'+datas[i].gpostnum+'" class="modalContent">' +
					    '<div id="modalinner'+datas[i].gpostnum+'" class="modalinner" style="width: 177px;">' +
					    '<button id="modalCloseBtn'+datas[i].gpostnum+'" class="modalCloseBtn" onclick="modalClose('+datas[i].gpostnum+')">' +
					    '<img src="../../images/x.webp" style="width: 10px; height: 10px; border: none;">' +
					    '</button>' +
					    '<div class="imgid">' +
					    '<div class="mbadgeimg">' +
					    '<img src="" alt="">' +
					    '</div>' +
					    '<p id="gpostuserid">'+datas[i].userid+'</p>' +
					    '</div>' +
					    '<div class="profilemenu">' +
					    '<img src="../../images/mail6.webp" style="width: 20px; height: 20px;">' +
					    '<button type="button" class="msg_send" onclick="sendMessage(\''+datas[i].userid+'\')">쪽지보내기</button>' +
					    '</div>' +
					    '<div class="profilemenu">' +
					    '<img src="../../images/write.png" style="width: 18px; height: 18px;">' +
					    '<p>작성글보기</p>' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '<div class="writerinfo badgeimg-right-info">' +
					    '<p>' +
					    '<a href="" class="usernamelink">'+datas[i].userid+'</a>' +
					    '</p>' +
					    '<p class="regtime">'+datas[i].gpostregdate+'</p>' +
					    '</div>' +
					    '</div>' +
					    '<div class="gpostContents">' +
					    '<div>' +
					    '<p>' +
					    '<textarea class="GPCIN gpostConetentsIn'+datas[i].gpostnum+'" style="width: 100%; height: 100%">'+datas[i].gpostcontents+'</textarea>' +
					    '</p>' +
					    '<div>' +
					    '<input type="button" style="cursor: pointer;" value="첨부파일" onclick="showFiles('+datas[i].gpostnum+')">' +
					    '</div>' +
					    '<div class="gpostfile'+datas[i].gpostnum+' replyHide">' +
					    '<ul class="gfileList'+datas[i].gpostnum+'"></ul>' +
					    '</div>' +
					    '<div class="likereply">' +
					    '<img id="likeButton" onclick="pressLike('+datas[i].gpostnum+', \''+datas[i].userid+'\')" class="like-button likeButton'+datas[i].gpostnum+'" src="/noon/images/redheart.webp" alt="좋아요" style="width: 15px; height: 15px;">' +
					    '<div class="point-area showreplyBtn">' +
					    '<div style="display: inline-block;">' +
					    '<input type="button" value="좋아요 '+datas[i].gpostlike+'개">' +
					    '</div>' +
					    '<div style="display: inline-block;">' +
					    '<input type="button" class="showrpcnt'+datas[i].gpostnum+'" value="댓글 '+datas[i].gprcnt+'개" onclick="showReply('+datas[i].gpostnum+')" style="cursor: pointer;">' +
					    '</div>'+
					    '<div style="display:inline-block; margin-left:210px;">'+
					    '<input type="button" class="replyHide modify'+datas[i].gpostnum+'" value="수정" style="cursor: pointer; width:70px; text-align:right;" onclick="showUpdateForm('+datas[i].gpostnum+', ${group.groupnum})">' +
					    '<input type="button" value="삭제" style="cursor: pointer; width:50px; text-align:right;" onclick="deleteGPost('+datas[i].gpostnum+', ${group.groupnum});">' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '<div class="gpostReply'+datas[i].gpostnum+' replyHide">' +
					    '<div class="repForm reply'+datas[i].gpostnum+'">' +
					    '<form method="post" class="inputGPR" action="writegpreply.gp?gpostnum='+datas[i].gpostnum+'&amp;groupnum=${group.groupnum}" name="writeRPForm'+datas[i].gpostnum+'">' +
					    '<div class="badgeimg"><img src=""></div>' +
					    '<div class="badgeimg-right-info">' +
					    '<p class="replywriter">${loginUser}</p>' +
					    '<textarea name="gprcontents" id="" cols="50" rows="3" placeholder="새로운 댓글을 남겨보세요"></textarea>' +
					    '</div>' +
					    '<div>' +
					    '<input type="hidden" name="userid" value="${loginUser}">' +
					    '<input type="submit" value="등록">' +
					    '</div>' +
					    '</form>' +
					    '</div>' +
					    '<ul class="greplyList'+datas[i].gpostnum+'"></ul>' +
					    '</div>' +
					    '</li>';  */

						parentnode.appendChild(newLi);
					}
				}
			}
		}
		if(searchFlag === true){
			console.log(searchkeyword);
			parentnode.innerHTML = "";
			xhr.open("GET", cp+"/groupinnerMore.gp?groupnum="+groupnum+"&page="+curPage+"&keyword="+searchkeyword);		
		} else {
			xhr.open("GET", cp+"/groupinnerMore.gp?groupnum="+groupnum+"&page="+curPage+"&keyword="+searchkeyword);
		}
        xhr.send();
    }
    
    function makeDOMKeyword(){
    	console.log("낼름");
    	curPage = 1;
    	searchFlag = true;
    	console.log("search: "+searchFlag);
    	makeDOM();
    	searchFlag = false;
    }
    
    //무한스크롤 구현
    $(document).scroll(throttle(function() {
        var currentScroll = $(this).scrollTop();
        var documentHeight = $(document).height();
        var nowHeight = $(this).scrollTop() + $(window).height();

        if (currentScroll > lastScroll) {
            if (documentHeight < (nowHeight + (documentHeight * 0.1))) {
                
                makeDOM();
            }
        }
        lastScroll = currentScroll;
    }, 1000));
    
  	//이벤트 딜레이
    function throttle(func, limit) {
        let lastFunc;
        let lastRan;
        return function() {
            const context = this;
            const args = arguments;
            if (!lastRan) {
                func.apply(context, args);
                lastRan = Date.now();
            } else {
                clearTimeout(lastFunc);
                lastFunc = setTimeout(function() {
                    if ((Date.now() - lastRan) >= limit) {
                        func.apply(context, args);
                        lastRan = Date.now();
                    }
                }, limit - (Date.now() - lastRan));
            }
        }
    }
    // 프로필 보여주기 또는 숨기기 함수
    function showprofile(check) {
        const profilebtn = document.getElementById("profilebtn");
        const profileContainer = document.getElementById("profile_container");

        if (check) {
            profileContainer.style.display = "";
            profilebtn.setAttribute("onclick", "showprofile(false)");
        } else {
            profileContainer.style.display = "block";
            profilebtn.setAttribute("onclick", "showprofile(true)");
        }
    }

    // 프로필 나가기 함수
    function quitprofile() {
        const profileContainer = document.getElementById("profile_container");
        profileContainer.style.display = "none";
    }
    //좋아요 기능 

	function pressLike(gpostnum, userid){
		console.log(userid);
		const likeButton = document.getElementsByClassName("likeButton")[0];
		let isLiked = false;
		
		const xhr = new XMLHttpRequest();
		const parentnode = document.getElementById("gpList");
		searchkeyword = sec.value;
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4){
				if(xhr.status==200){
					let txt = xhr.responseText.trim();
					if(txt == "O"){
						alert("좋아요를 눌렀어요");
						
					} else {
						alert("좋아요를 취소했어요");
					}
				}
			}
		}
		
		xhr.open("GET", cp+"/presslike.gp?gpostnum="+gpostnum+"&userid"+userid);
		xhr.send();
		
		
	}

    //글쓰기 폼 나오는 기능 

    function showWrite() {
        var writeForm = document.getElementById("writeForm");
        if (writeForm.style.display === "none") {
            writeForm.style.display = "block"; // 보이게 함
        } else {
            writeForm.style.display = "none"; // 감춤
        }
    }
</script>

<script>
    //파일부분
	let i = 0;
	function upload(num){
		$("#writefile"+num).click();
	}
	$("[type=file]").change(function(e){
		const fileTag = e.target;
		console.log(fileTag);
		const file = fileTag.files[0];
		console.log(file);
		
		if(file == undefined){
			cancelFile(fileTag.id.split("e").pop());
		}
		else{
			console.log(fileTag.id);
			$("#"+fileTag.id+"name").text(file.name);
			
			//마지막파일
			if(fileTag.id == "writefile"+i){
				const cloneElement = $(".uploadarea"+i).clone(true);
				i++;
				cloneElement.attr("class","uploadarea"+i);
				
				cloneElement.find("input[type='file']").attr("name","writefile"+i);
				cloneElement.find("input[type='file']").attr("id","writefile0"+i);
				cloneElement.find("input[type='file']").val("");
				
				cloneElement.find("span").attr("id","writefile"+i+"name");
				cloneElement.find("span").text("선택된 파일 없음");
				
				cloneElement.find("a")[0].href = "javascript:upload("+i+")";
				cloneElement.find("a")[1].href = "javascript:cancelFile("+i+")";
				
				$(".uploadarea"+(i-1)).after(cloneElement);
			}
		}
	})
	function cancelFile(num){
		num = Number(num);
		
		//가장 마지막 [첨부 삭제] 버튼을 누른 경우
		if(num == i){ return; }
		$(".uploadarea"+num).remove();
		for(let j=num+1;j<=i;j++){
			console.log(j);
			const el = $("#writeform ul .uploadarea"+j);
			el.attr("class","uploadarea"+(j-1));
			
			el.find("input[type=file]").attr("name","writefile"+(j-1));
			el.find("input[type=file]").attr("id","writefile"+(j-1));
			
			el.find("span").attr("id","writefile"+(j-1)+"name");
			
			el.find("a")[0].href = "javascript:upload("+(j-1)+")";
			el.find("a")[1].href = "javascript:cancelFile("+(j-1)+")";
		}
		i--;
	}
    
	function modalClk(gpostnum){
		const modal = document.getElementById('modalContainer'+gpostnum);

        console.log(modal);
        modal.classList.toggle("replyHide");
	}
	function modalClose(gpostnum){
		const modal = document.getElementById('modalContainer'+gpostnum);
	    modal.classList.toggle("replyHide");
	}
	function deleteGPost(gpostnum, groupnum) {
		if(confirm("정말 삭제하시겠어요?")){
			location.href =cp+"/gpostdelete.gp?groupnum="+groupnum+"&gpostnum="+gpostnum;
		} else {
			return;
		}
	}
	const sujung = document.querySelector('.sujung');
	const btnOpensujung = document.querySelector('.btn-open-sujung');
	const btnClosesujung = document.querySelector('.btn-close-sujung');

	btnOpensujung.addEventListener("click", e=>{
		sujung.style.display="flex";
	});
	btnClosesujung.addEventListener("click", e=>{
    	sujung.style.display ="none";
	});
	function clkSujungBtn(){
		btnOpensujung.click();
	}
	function clkSujungCBtn(){
		btnClosesujung.click();
	}
	function showUpdateForm(gpostnum, groupnum) {
		clkSujungBtn();
		const sujungForm = document.sujungForm;
		let today = new Date();   		
		let year = today.getFullYear();
		let month = today.getMonth() + 1;
		let date = today.getDate();
		let hours = today.getHours();
		let minutes = today.getMinutes();
		let seconds = today.getSeconds(); 
		sujungForm.gpostnum.value = gpostnum
		sujungForm.gpostregdate.value =  year+'-'+month+'-'+date+' '+hours+':'+minutes+':'+ seconds; 
		sujungForm.gpostcontents.textContent = document.getElementsByClassName("gpostConetentsIn"+gpostnum)[0].textContent;
		sujungForm.gpostnum.value = gpostnum;
	}
</script>
<script>
	function modifyOk() {
		const sujung = document.sujungForm;
		sujung.submit();
	}
	function joinMoim(groupnum) {
		location.href="/joinmoim.gp?groupnum="+groupnum;
	}
	function sendMessage(receiveid){
		let realtarget = document.getElementsByClassName("rcvid")[0]; 
    	realtarget.value = receiveid;
    	document.querySelector('.ms_modal_btn').click();
    }
</script>
<script>
	//채팅 구현
	let socket = null;
	let INDEX = 0;
	//현재 이 클라이언트(세션)이 귓속말을 보내는 중인지 확인하기 위한 flag
	//귓속말을 보내게 되면 이 안에는 "/userid " 형태의 문자열이 담긴다.
	let echoFlag = "";
	//채팅 버튼 클릭시 전체 채팅에 접속, 채팅창 열어주기
	$("#chat-circle").click(function(){
		$("#chat-circle").toggle('scale');
		$(".chat-box").toggle('scale');
		socket = new WebSocket('ws://localhost:9090/chat/'+$('#userid').val());
		
		//소켓 연결에 오류가 발생했을 때 수행할 이벤트
		socket.onerror = function(e){
			console.log("연결 실패");
		}
		//소켓 연결이 열렸을 때 수행할 이벤트
		socket.onopen = function(e){
			socket.send('in : '+$('#userid').val())
		}
		//소켓 연결을 통해 메세지가 전달되었을 때 수행할 이벤트
		socket.onmessage = function(e){
			onMessage(e);
		}
		//소켓 연결을 종료할 때 수행할 이벤트
		socket.onclose = function(e){
			$(".chat-logs").html("");
		}
	});
	//닫기 버튼을 클릭했을 때 호출될 이벤트, 창 닫기, 소켓 접속 종료
	$(".chat-box-toggle").click(function(){
		socket.send('out : '+$("#userid").val());
		$("#chat-circle").toggle('scale');
		$(".chat-box").toggle('scale');
		socket.close();
		socket = null;
	})
	$("#chat-submit").click(function(e){
		e.preventDefault();
		let msg = $("#chat-input").val();
		msg = msg.trim();
		//하이
		// /banana 하이
		//귓속말을 보냈을 경우도 있으므로 msg 앞에 echoFlag를 연결하여
		//채팅 로그를 만들 때와 서버측에서 메세지를 처리할 때 귓속말로 처리를 할 수 있도록 만들어 준다.
		msg = echoFlag+msg;
		if(msg == ""){
			return false;
		}
		//DOM 구현되어 있는 채팅 로그 생성 함수 호출
		generate_message(msg,'self');
		//appleKHGB안녕
		socket.send($("#userid").val()+"KHGB"+msg);
	})
	
	
	//클라이언트 측에서 메세지를 받았을 때 호출될 이벤트 함수
	function onMessage(e){
		//in : banana
		const message = e.data;
		//in : ---> 누군가가 접속해서 메세지가 날라온 경우
		if(message.substring(0,4) == "in :"){
			//5번 인덱스부터 잘라내면 접속한 사람의 아이디
			let inId = message.substring(5);
			str = '<div class="inout-Msg">'+inId+'님이 들어오셨습니다.</div>';
			$(".chat-logs").append(str);
		}
		//out : ---> 누군가가 종료하면서 메세지가 날라온 경우
		else if(message.substring(0,5) == "out :"){
			let outId = message.substring(6);
			str = '<div class="inout-Msg">'+outId+"님이 나가셨습니다.</div>";
			$(".chat-logs").append(str);
		}
		else{
			let idx = message.indexOf("KHGB");
			let sender = message.substring(0,idx);
			// /banana 하이
			let content = message.substring(idx+4);
			
			// /apple
			let temp = content.split(" ")[0];
			//띄어쓰기로 split된 것 중 맨 앞의 것의 첫 글자가 "/" 라면 귓속말이라는 뜻 
			if(temp.substring(0,1) == "/"){
				//그 "/" 뒤에 적힌것이 내 아이디라면 나에게 온 귓속말이라는 뜻
				if(temp.replace("/","") == $("#userid").val()){
					// 앞의 /userid 는 건너뛴 후의 실제 내용만 넘겨주며 채팅 로그 생성
					generate_message(content.substring(temp.length+1),"echo",sender);
				}
				//나에게 온 귓속말이 아니라는 뜻
				else{
				}
			}
			//일반적인 메세지이므로
			else{
				//일반적인 채팅 로그로 생성
				generate_message(content,"user",sender);
			}
		}
	}
	
	//채팅창에 /아이디 를 쓰면 귓속말로 바뀌어야 하므로 키업 이벤트 함수로 판단해준다.
	function sendEcho(){
		//스페이스바를 눌렀을 때
		if(window.event.keyCode == 32){
			//채팅창의 첫번째 글자가 / 라면
			if($("#chat-input").val().substring(0,1) == "/"){
				// / 기준으로 나눈 뒤의것은 귓속말을 원하는 사람의 아이디이다.
				//ex) "/banana " 
				let userid = $("#chat-input").val().split("/")[1].trim();
				checkUserId(userid);
			}
		}
	}
	//귓속말 상대가 존재하는 아이디인지 확인하는 함수
	function checkUserId(userid){
		if(userid == $("#userid").val()){
			alert("자신에게는 귓속말이 불가능합니다!");
			$("#chat-input").val("")
			$("#chat-input").focus();
		}
		else{
			const xhr = new XMLHttpRequest();
			xhr.onreadystatechange = function(){
				if(xhr.readyState == 4){
					if(xhr.status == 200){
						let txt = xhr.responseText.trim();
						if(txt == "X"){
							//귓속말이 가능하다는 뜻이므로 echoFlag에 "/상대아이디 " 를 넣어준다
							echoFlag = $("#chat-input").val();
	
							//채팅창은 귓속말 상태로 디자인 변경
							$("#chat-input").addClass("echo");
							$(".echo-receiver").text("["+userid+"]에게 : ")
							$(".echo-receiver").css("width","fit-content");
							$(".echo-receiver").css("padding","0 0 0 10px");
							//					40px							40
							let w = 299 - Number($(".echo-receiver").css("width").replace("px",""));
							
							$("#chat-input").css("width",w+"px");
							$("#chat-input").css("padding-left","0");
							
							//귓속말을 취소할 수 있는 이벤트 생성
							$(".echo-receiver").click(function(e){
								$("#chat-input").removeClass("echo");
								$("#chat-input").attr("style","");
								$(".echo-receiver").attr("style","");
								$(".echo-receiver").text("");
								echoFlag = "";
							})
						}
						else{
							alert("잘못된 아이디입니다!");
						}
						$("#chat-input").val("")
						$("#chat-input").focus();
					}
				}
			}
			xhr.open("GET","${cp}/checkidok.us?userid="+userid);
			xhr.send();
		}
	}
	
	//채팅 로그 생성하는 함수
	//msg : 실제 내용이 될 텍스트 / type : 'self'(내가 보낸 모습으로),'user'(남이 보낸 모습으로)
	function generate_message(msg, type, sender){
		console.log(msg);
		INDEX++;
		var str = "";
		let receiver = "";
		let content = "";
		// /banana 
		if(echoFlag != ""){
			let temp = msg.split(" ")[0];
			console.log(temp)
			receiver = echoFlag.substring(1).trim();
			content = msg.substring(temp.length+1) 
		}
		else{
			content = msg;
		}
		//										만약 내가 귓속말을 보낸 상태라면 self와 echo 클래스 둘 다 달려야 함
		str += "<div id='cm-msg-"+INDEX+"' class=\"chat-msg "+type+(echoFlag!=""?" echo":"")+"\">";
		str += "<span class=\"msg-avatar\">";
		str += "<img src=\"${cp}/images/chat_bg2.jpeg\">";
		str += "<\/span>";
		str += "<div class=\"cm-msg-text\">";
		str += content;
		str += "<\/div>";
		//남이 보낸 메세지를 로그로 찍을 때
		if(sender){
			//귓속말로 날라왔을 때
			if(type == 'echo'){
				str += "<div class='receiver echo'>["+sender+"]의 귓속말</div>";
			}
			//일반 채팅으로 날라왔을 때
			else{
				str += "<div class='receiver'>["+sender+"]</div>";
			}
		}
		//내가 보낸 메세지를 로그로 찍을 때
		else{
			//귓속말로 보냈을 때
			if(echoFlag != ""){
				str += "<div class='receiver echo'>"+receiver+"에게</div>"
			}
			//일반 채팅으로 보냈을 때
			else{
				str += "<div class='receiver'>모두에게</div>"
			}
		}
		str += "<\/div>";
		$(".chat-logs").append(str);
		$("#cm-msg-" + INDEX).hide().fadeIn(300);
		if (type == 'self') {
			$("#chat-input").val('');
		}
		$(".chat-logs").stop().animate({
			scrollTop : $(".chat-logs")[0].scrollHeight
		}, 1000);
		
		
		const arMsg = document.getElementsByClassName("cm-msg-text");
	
		for (let i = 0; i < arMsg.length; i++) {
			let maxLineWidth = arMsg[i].offsetWidth;
	
			let textContent = arMsg[i].textContent;
	
			let textWords = textContent.split("");
	
			let newContent = "";
	
			let tempContent2 = "";
			
			let first = true;
			for (let j = 0; j < textWords.length; j++) {
				let word = textWords[j];
				const tempContent = newContent + word;
				const tempElement = document.createElement('div');
				tempElement.classList = 'tempEl';
				tempElement.textContent = tempContent2;
	
				tempElement.style.display = 'inline-block';
	
				arMsg[i].appendChild(tempElement);
				
				if(tempElement.offsetWidth >= 160 && first){
					newContent += word;
					tempContent2 += word;
					first = false;
				} else if (tempElement.offsetWidth > 159.8) {
					newContent += '<br>' + word;
					tempContent2 = "";
				} else {
					newContent += word;
					tempContent2 += word;
				}
			}
			arMsg[i].innerHTML = newContent.trim();
		}
	}
	
	function quitMoim(groupnum, usertype){
		if(confirm("모임에서 탈퇴하시겠어요?")){
			location.href=cp+"/quitmoim.gp?groupnum="+groupnum;
		}
	}
</script>
</html>