<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>groupInner</title>
<link href="${cp}/css/groupinnerstyle.css" rel="stylesheet">
<link href="${cp}/css/chatstyle.css" rel="stylesheet">
<style>

	.replyHide{
	display: none;
	}
	.gfileli{
        display: flex;
    }
    .gfileli > p{
    	margin-left: 10px;
    }
    .fileIcon > img{
        width: 20px;
        height: 20px;
    }
    .gpostContents > div > p{
    	min-height: 80px;
    }
    button{
    	cursor: pointer;
    }
    .GPCIN{
    	border: none; 
    	background: transparent;
    	overflow: hidden;
    	resize: none;
    	min-height: 132px;
    	min-width: 470px;
    }
    .GPCIN:focus{
    	outline: none;
    }
	.sujung{
            position:fixed;
            display:none;
            
            justify-content: center;
            top:0;
            left:0;

            width:100%;
            height:100%;
            background-color: rgba(0,0,0,0.4);
			z-index: 10;
			left: 50%;
		    top: 50%;
		    transform: translate(-50%, -50%);
    }
	.sujung_body{
            position:absolute;
            top:50%; 
        

            width:700px; 
            height:600px; 

            padding:40px;  

            text-align: center;

            background-color: rgb(255,255,255);
            border-radius:10px;
            box-shadow:0 2px 3px 0 rgba(34,36,38,0.15);

            transform:translateY(-50%);
			z-index: 10;
        }
        
        #top_wrap{
        	background-color: rgb(232, 218, 202);
        	margin-top: 0px !important;
        }
</style>
</head>
<body>
<div class="betaversion">
		개발 중인 베타버전입니다. (It's a beta version that's being developed)
	</div>
	<c:if test="${empty isInGroup}"></c:if>
	<c:if test="${empty loginUser}">
		<c:set var="loginUser" value="${null}"/>
	</c:if>
	<jsp:include page="${cp}/app/message/sendmessage.jsp"></jsp:include>
	<div class="sujung">
        <div class="sujung_body">
            <div style="display: flex;">
            	<p style="margin-left: 10px;">
					<h3>글 수정</h3>
				</p>
				<img src="../../images/x.webp" alt="" onclick="clkSujungCBtn()" style="width: 30px; height: 30px; margin-left: auto; cursor: pointer;">
			</div>
			<Form method="post" action="/modifygp.gp?groupnum=${group.groupnum}" name="sujungForm">
				<ul>
					<li>
					<input type="text" name="userid" value="${loginUser}" readonly>
					</li>
					<li>
						<input type="hidden" name="gposttitle" value="없음">
					</li>
					<li>
						<input type="hidden" name="gpostnum" value="">
					</li>
					<li>
						<input type="hidden" name="groupnum" value="">
					</li>
					<li>
						<input type="hidden" name="gpostregdate" value="">
					</li>
					<li>
						<textarea name="gpostcontents" id="sujungpost" cols="30" rows="10" ></textarea>
					</li>
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
	<c:set var="page" value="${pararm.page}"/>
	<c:choose>
		<c:when test="${empty page or param.page <= 0}">
			<c:set var="page" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="page" value="page"/>
		</c:otherwise>
	</c:choose>
	<div id="group_inner_wrap">
        <header>
        <jsp:include page="${cp}/app/header.jsp"></jsp:include>
        <%--
            <nav class="groupinnernav">
				<div class="logoimg"><a href=""><img src="../../images/logo.png" alt="" style="background-repeat: no-repeat; display: block; width: auto; height: 40px;"></a></div>
				<div class="widgetarea">
					<ul class="widgetlist">
						<li class="widgetitem alert" style="padding-top: 6px; padding-left: 20px;"><a href=""><img src="../../images/group/bell-3913239.png" style="background-size: cover; display: block; width:25px; height: auto;"></a></li>
						<li class="widgetitem jjok" style="padding-top: 6px; padding-left: 20px;"><a href=""><img src="../../images/group/bubble-151798.png" style="background-size: cover; display: block; width:25px; height: auto;"></a></li>
						<li class="widgetitem profile-badge-btn"><a href=""><img src="../../images/group/basicuser-1946429.png" style="background-size: cover; display: block; width:auto; height: 35px;"></a></li>
					</ul>
				</div>
            </nav>
           --%>
        </header>
        <div class="group-inner contents" id="group_inner_container">
            <div id="groupinfobox" class="infobox">
                <div class="groupimg imgbox">
                    <img src="../../file/groupimg/abcd25.jpg" style="background-size: cover; width: 100%; height: auto;">
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
                        <span class="gmem">멤버: ${usercnt}</span>
                        <span class="glead">리더: ${group.groupmaster}</span>
                    </p>
					<p>${group.groupcontents}</p>
					<ul class="grouptaglist">
						<li class="groupaddrinfo circle-list-btn">
							 <a href="#">${group.groupaddr}</a>
						</li>
						<li class="groupcategoryinfo circle-list-btn">
							 <a href="">${group.groupcategory}</a>
						</li> 
					 </ul>
                    <div>
                        <div class="group-btn-box btnBox">
                                <input type="button" value="모임 가입하기" class="joinMoim" onclick="joinMoim(${group.groupnum})">
                        </div>
                    </div>
                </div>
            </div>
            <div id="gpostsection">
            	<c:choose>
            		<c:when test="${empty ingi}">
            			<div class="summary" style="border: none; background:none;">
							<div style="margin: 10px 0px 10px 10px;">
								<p><h2>인기글이 없어요</h2></p>
							</div>
							<ul class="gpostList">
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head">
									</div>
								</li>
							</ul>
						</div>
            		</c:when>
            		<c:otherwise>
		                <div class="summary" style="border: none; background:none;">
							<div style="margin: 10px 0px 10px 10px;">
								<p><h2>${group.groupname} 이번 주 인기글</h2></p>
							</div>
							<ul class="gpostList">
								<li class="gpostListwrap">
									<div class="gpostHead default-group-Head">
										<%-- 프로필 펼치기 --%>
											<button class="badgeimg modalOpenBtn" id="modalOpenBtn${ingi.gpostnum+10000}"
												onclick="modalClk(${ingi.gpostnum+10000})">★</button>
											<div id="modalContainer${ingi.gpostnum+10000}" class="modalContainer replyHide">
												<div id="modalContent${ingi.gpostnum+10000}" class="modalContent">
													<div id="modalinner${ingi.gpostnum+10000}" class="modalinner" style="width: 177px;">
														<button id="modalCloseBtn${ingi.gpostnum+10000}" class="modalCloseBtn"
															onclick="modalClose(${ingi.gpostnum+10000})">
															<img src="../../images/x.webp" style="width: 10px; height: 10px; border: none;">
														</button>
														<div class="imgid">
															<div class="mbadgeimg">
																<img src="" alt="">
															</div>
															<p>${ingi.userid}</p>
														</div>
														
													<div class="profilemenu">
							
														<%--쪽지 보내기 --%>
															<img src="../../images/mail6.webp" style="width: 20px; height: 20px;">
															<button type="button" class="msg_send" onclick="sendMessage('${ingi.userid}')" style="cursor: pointer;">쪽지보내기</button>
													</div>
													<div class="profilemenu">
														<img src="../../images/write.png" style="width: 18px; height: 18px;">
														<button type="button" class="msg_send" onclick="makeDOM()" style="cursor: pointer;">작성글보기</button>
													</div>
												</div>
											</div>
									</div>
							
									<div class="writerinfo badgeimg-right-info">
										<p>
											<a href="" class="usernamelink">${ingi.userid}</a>
											<span>인기쟁이에요</span>
										</p>
										<p class="regtime">${ingi.gpostregdate}</p>
									</div>
									</div>
							
									<div class="gpostContents">
										<div>
											<p>
												<textarea class="GPCIN gpostConetentsIn${ingi.gpostnum+10000}" style="width: 100%; height: 100%">${ingi.gpostcontents}</textarea>
											</p>
											<div>
												<input type="button" style="cursor: pointer;" value="첨부파일" onclick="showFiles(${ingi.gpostnum+10000})">
											</div>
											<div class="gpostfile${ingi.gpostnum+10000} replyHide">
												<ul class="gfileList${ingi.gpostnum+10000}"></ul>
											</div>
											<div class="likereply">
												<img id="likeButton" onclick="pressLike(${ingi.gpostnum+10000})"
													class="like-button likeButton${ingi.gpostnum+10000}" src="${cp}/images/redheart.webp" alt="좋아요"
													style="width: 15px; height: 15px;">
												<div class="point-area showreplyBtn">
													<div style="display: inline-block;">
														<input type="button" value="좋아요 i개">
													</div>
													<div style="display: inline-block;">
														<input type="button" class="showrpcnt${ingi.gpostnum+10000}" value="댓글 ${ingi.gprcnt}개"
															onclick="showReply(${ingi.gpostnum+10000})" style="cursor: pointer;">
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
												<div class="badgeimg"><img src=""></div>
												<div class="badgeimg-right-info">
													<p class="replywriter">${loginUser}HiImTester</p>
													<textarea name="gprcontents" id="" cols="50" rows="3" placeholder="새로운 댓글을 남겨보세요"></textarea>
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
                    <div class="searchBox" style="margin-bottom: 2px; margin-left: 5px;">
						<div>
							<input type="text" name="groupsearch" id="gpsearch" style="border: none; outline: none; background-color:transparent;">
						</div>
						<div class="searchBtnBox">
							<input type="button" value="" onclick="makeDOMKeyword()" style="cursor: pointer; display: block; width: 28px; height: 28px;">
						</div>
                    </div>
                    <div class="write_btn">
						<input type="button" value="글쓰기" onclick="showWrite(${gpost.gpostnum})"> 
					</div>
                </div>
                <div id="gpost" class="postsection">
	                <div class="write_wrap">
		                <div class="writeform" id="writeForm" style="display: none;">
							<form id="writeform" method="post" action="/gpwrite.gp" enctype="multipart/form-data">
								<ul>
									<li>
										<h3>글쓰기</h3>
										<input type="hidden" name="userid" value="${loginUser}">
										<input type="hidden" name="groupnum" value="${group.groupnum}">
									</li>
									<li>
										<label for="writetit"></label>
										<input type="text" name="gptitle" id="writetit" placeholder="제목을 입력해주세요.">
									</li>
									<li>
										<label for="writebox"></label>
										<textarea name="gpcontents" id="writebox" cols="30" rows="10" placeholder="새로운 소식을 남겨보세요"></textarea>
									</li>
									<li class="uploadarea0" style="display: flex; padding-left: 10px">
										<a href="javascript:upload(0)" class="cFile" style="margin-left: -10px;">파일 선택</a>
										<input type="file" name="writefile0" id="writefile0" style="display:none">
										<span id="writefile0name" style="margin-left: 10px;">선택된 파일 없음</span>
										<a href="javascript:cancelFile(0)" class="dFile" style="margin-left: auto;">첨부 삭제</a>
									</li>
									<li>
										<input type="submit" id="writesubmit" value="제출하기"> 
									</li>
								</ul>
							</form>
						</div>
					</div>
                    <ul class="gpostList" id="gpList">
                    	<c:choose>
                    		<c:when test="${list != null and list.size()>0}">
                    			<c:forEach var="i" begin="0" end="${list.size() -1}">
                    				<c:set var="gpost" value="${list[i]}"/>
                    					<li class="gpostListwrap">
				                            <div class="gpostHead default-group-Head">
				                            
				                            	<%-- 프로필 펼치기 --%>
				                            	<button class="badgeimg modalOpenBtn" id="modalOpenBtn${gpost.gpostnum}" onclick="modalClk(${gpost.gpostnum})">★</button>
			                                    <div id="modalContainer${gpost.gpostnum}" class="modalContainer replyHide">
				                                    <div id="modalContent${gpost.gpostnum}" class="modalContent">
														<div id="modalinner${gpost.gpostnum}" class="modalinner" style="width: 177px;">
														   <button id="modalCloseBtn${gpost.gpostnum}" class="modalCloseBtn" onclick="modalClose(${gpost.gpostnum})">
															  <img src="../../images/x.webp" style="width: 10px; height: 10px; border: none;">
														   </button>
														   <div class="imgid">
															  <div class="mbadgeimg">
																 <img src="" alt="">
															  </div>
															  <p id="gpostuserid">${gpost.userid}</p>
														   </div>
														   <%-- <div class="profilemenu"><p>${user.userhobby}</p></div>
														   <div class="profilemenu"><p>${user.gender}</p></div>
														   <div class="profilemenu"><p>${user.userpoint}</p></div> --%>
														   <div class="profilemenu">
													 
													 <%--쪽지 보내기 --%>
													 <img src="../../images/mail6.webp" style="width: 20px; height: 20px;">
													 <button type="button" class="msg_send" onclick="sendMessage('${gpost.userid}')">쪽지보내기</button>
												  </div>
											 <div class="profilemenu">
												<img src="../../images/write.png" style="width: 18px; height: 18px;">
												<p>작성글보기</p>
											</div>
														</div>
													 </div>
			                                    </div>
					                                
				                                <div class="writerinfo badgeimg-right-info">
				                                    <p>
				                                        <a href="" class="usernamelink">${gpost.userid}</a>
				                                        <span>이런사람이에요</span>
				                                    </p>
				                                    <p class="regtime">${gpost.gpostregdate}</p>
				                                </div>
				                            </div>
				                           
				                            <div class="gpostContents">
				                                <div>
				                                    <p>
				                                    	<textarea class="GPCIN gpostConetentsIn${gpost.gpostnum}" style="width: 100%; height: 100%">${gpost.gpostcontents}
				                                    	</textarea>
				                                    </p>
				                                    <div>
				                                    	<input type="button" style="cursor: pointer;" value="첨부파일" onclick="showFiles(${gpost.gpostnum})">
				                                    </div>
								                    <div class="gpostfile${gpost.gpostnum} replyHide">
								                    	<ul class="gfileList${gpost.gpostnum}"></ul>
								                    </div>
								                    <div class="likereply">
														<img id="likeButton" onclick="pressLike(${gpost.gpostnum}, '${loginUser}')" class="like-button likeButton${gpost.gpostnum}" src="${cp}/images/redheart.webp" alt="좋아요" style="width: 15px; height: 15px;">
														<div class="point-area showreplyBtn">
														<div style="display: inline-block;">
															<input type="button" value="좋아요 i개">
														</div>
														<div style="display: inline-block;">
															<input type="button" class="showrpcnt${gpost.gpostnum}" value="댓글 ${gpost.gprcnt}개"
																onclick="showReply(${gpost.gpostnum})"
																style="cursor: pointer;">
														</div>
														<c:if test="${gpost.userid == loginUser}">
															<div style="display:inline-block; margin-left:210px;">
																<input type="button" class="replyHide modify${gpost.gpostnum}" value="수정" style="cursor: pointer; width:70px; text-align:right;" onclick="showUpdateForm(${gpost.gpostnum}, ${group.groupnum})">															
					                                        	<input type="button" value="삭제" style="cursor: pointer; width:50px; text-align:right;" onclick="deleteGPost(${gpost.gpostnum}, ${group.groupnum});">
					                                        </div>
														</c:if>
														</div>
													</div>
				                                </div>
				                            </div>
				                            <div class="gpostReply${gpost.gpostnum} replyHide">
				                            	<div class="repForm reply${gpost.gpostnum}">
													<Form method="post" class="inputGPR" action="writegpreply.gp?gpostnum=${gpost.gpostnum}&groupnum=${group.groupnum}" name="writeRPForm${gpost.gpostnum}">
														<div class="badgeimg"><img src=""></div>
														<div class="badgeimg-right-info">
															<p class="replywriter">${loginUser}HiImTester</p>
															<textarea name="gprcontents" id="" cols="50" rows="3" placeholder="새로운 댓글을 남겨보세요"></textarea>
														</div>
														<div>
															<input type="hidden" name="userid" value="${loginUser}">
															<input type="submit" value="등록">
														</div>
													</Form>
												</div>
				                                <ul class="greplyList${gpost.gpostnum}"></ul>
				                            </div>
				                        </li>
                    			</c:forEach>
                    		</c:when>
                    	<c:otherwise>
                    		<li>
                    			<p>등록된 게시글이 없습니다</p>
                    		</li>
                    	</c:otherwise>
                    	</c:choose>
                    </ul>
                </div>
            </div>
            <div id="grouprightsection">
                <div id="gannounce">
                    <p><h2>최신 공지사항</h2></p>
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
		                                        <a href="" class="usernamelink"></a>
		                                        <span></span>
		                                    </p>
		                                    <p class="regtime"></p>
		                                </div>
		                            </div>
		                            <div class="gpostContents">
		                                <div>
		                                    <p>
												<textarea class="GPCIN gpostConetentsInNo" style="width: 100%; height: 100%">공지가 없어요
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
		                                        <a href="" class="usernamelink">${gongji.userid}</a>
		                                        <span>공지에요</span>
		                                    </p>
		                                    <p class="regtime">${gongji.gpostregdate}</p>
		                                </div>
		                            </div>
		                            <div class="gpostContents">
		                                <div>
		                                    <p>
												<textarea class="GPCIN gpostConetentsIn${gongji.gpostnum}" style="width: 100%; height: 100%">${gongji.gpostcontents}
												</textarea>
											</p>
		                                </div>
		                            </div>
		                        </li>
                    		</c:otherwise>
                    	</c:choose>
                    </ul>
                </div>
                <%--챗 --%>
                <div id="chat-circle" class="btn btn-raised">
					<div id="chat-overlay"></div>
					<span class="material-symbols-outlined">speaker_phone</span>
				</div>
				<div class="chat-box">
					<div class="chat-box-header">
						사용자 채팅 <span class="chat-box-toggle"><span
							class="material-symbols-outlined">close</span></span>
					</div>
					<div class="chat-box-body">
						<div class="chat-box-overlay"></div>
						<div class="chat-logs"></div>
						<!--chat-log -->
					</div>
					<div class="chat-input">
						<form>
							<input type="hidden" id="userid" name="userid" value="${loginUser}">
							<span class="echo-receiver"></span> <input type="text"
								id="chat-input" placeholder="Send a message..."
								onkeyup="sendEcho();" />
							<button type="submit" class="chat-submit" id="chat-submit">
								<span class="material-symbols-outlined">send</span>
							</button>
						</form>
					</div>
				</div>
				<%--챗 --%>
            </div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	const cp = '${cp}';
    let page = '${page}';
    let keyword = '${keyword}';
	const groupnum = '${gpost.groupnum}';
	const loginUser = '${loginUser}';	
</script>
<script>
    let lastScroll = 0;
    var curPage = ${page};
    let searchFlag = false;
    const sec = document.getElementById("gpsearch");
    let searchkeyword = sec.value;
	
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
    	console.log("불러오는 페이지: "+curPage);
        let orgnode = document.getElementsByClassName("gpostListwrap")[0];
		const xhr = new XMLHttpRequest();
		const parentnode = document.getElementById("gpList");
		searchkeyword = sec.value;
		
		xhr.onreadystatechange = function(){
			if(xhr.readyState == 4){
				if(xhr.status==200){
					//console.log(xhr.responseText);
					const obj = JSON.parse(xhr.responseText);
					//console.log(obj);
					const datas = obj.datas;
					//console.log(datas);
					
					//돔돔
					for(let gpost of datas){
						let newLi = document.createElement('li');
					    newLi.className = 'gpostListwrap';
					    
					    newLi.innerHTML = '<div class="gpostHead default-group-Head">' +
                        '<button class="badgeimg modalOpenBtn" id="modalOpenBtn'+gpost.gpostnum+'" onclick="modalClk('+gpost.gpostnum+')">★</button>' +
                        '<div id="modalContainer'+gpost.gpostnum+'" class="modalContainer replyHide">' +
                        '<div id="modalContent'+gpost.gpostnum+'" class="modalContent">' +
                        '<div id="modalinner'+gpost.gpostnum+'" class="modalinner" style="width: 177px;">' +
                        '<button id="modalCloseBtn'+gpost.gpostnum+'" class="modalCloseBtn" onclick="modalClose('+gpost.gpostnum+')">' +
                        '<img src="../../images/x.webp" style="width: 10px; height: 10px; border: none;">' +
                        '</button>' +
                        '<div class="imgid">' +
                        '<div class="mbadgeimg">' +
                        '<img src="" alt="">' +
                        '</div>' +
                        '<p id="gpostuserid">'+gpost.userid+'</p>' +
                        '</div>' +
                        '<div class="profilemenu"><p>${user.userhobby}</p></div>' +
                        '<div class="profilemenu"><p>${user.gender}</p></div>' +
                        '<div class="profilemenu"><p>${user.userpoint}</p></div>' +
                        '<div class="profilemenu">' +
						'<img src="../../images/mail6.webp" style="width: 20px; height: 20px;">' +
						'<p>'+
						'<button type="button" class="msg_send" onclick="sendMessage(\'' + gpost.userid + '\')" style="cursor: pointer;">쪽지보내기</button>'+
						'</p>'+
						'</div>' +
						'<div class="profilemenu">' +
						'<img src="../../images/write.png" style="width: 20px; height: 20px;">' +
						'<p>'+
						'<a>작성글보기</a>'+
						'</p>'+
                     	'</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '<div class="writerinfo badgeimg-right-info">' +
                        '<p>' +
                        '<a href="" class="usernamelink">'+gpost.userid+'</a>' +
                        '<span>이런사람이에요</span>' +
                        '</p>' +
                        '<p class="regtime">'+gpost.gpostregdate+'</p>' +
                        '</div>' +
                        '</div>' +
                        '<div class="gpostContents">' +
                        '<div>' +
                        '<p>' +
                        '<textarea class="GPCIN gpostConetentsIn'+gpost.gpostnum+'" style="width: 100%; height: 100%">' +gpost.gpostcontents+
                        '</textarea>' +
                        '</p>' +
                        '<div>' +
                        '<input type="button" style="cursor: pointer;" value="첨부파일" onclick="showFiles('+gpost.gpostnum+')">' +
                        '</div>' +
                        '<div class="gpostfile'+gpost.gpostnum+' replyHide">' +
                        '<ul class="gfileList'+gpost.gpostnum+'"></ul>' +
                        '</div>' +
                        '<div class="likereply">' +
                        '<img id="likeButton" onclick="pressLike('+gpost.gpostnum+', \'${loginUser}\')" class="like-button likeButton'+gpost.gpostnum+'" src="${cp}/images/redheart.webp" alt="좋아요" style="width: 15px; height: 15px;">' +
                        '<div class="point-area showreplyBtn">' +
                        '<div style="display: inline-block;">' +
                        '<input type="button" class="showlikecnt'+gpost.gpostnum+'" value="'+gpost.gpostlike+'개" onclick="pressLike('+gpost.gpostnum+')">' +
                        '</div>' +
                        '<div style="display: inline-block;">' +
                        '<input type="button" class="showrpcnt'+gpost.gpostnum+'" value="댓글 '+gpost.gprcnt+'개" onclick="showReply('+gpost.gpostnum+')" style="cursor: pointer;">' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>' +
                        '</div>';
                        
					    console.log(gpost.gpostcontents);
					    if(gpost.userid===loginUser){
                      	  newLi.innerHTML +='<div style="display:inline-block; margin-left:210px;">'+
                      	  '<input type="button" class="replyHide modify'+gpost.gpostnum+'" value="수정" style="cursor: pointer; width:70px; text-align:right;" onclick="showUpdateForm('+gpost.gpostnum+', ${group.groupnum})">'+
                      	  '<input type="button"  value="수정완료" style="cursor: pointer; width:70px; text-align:right;" onclick="updateGPost('+gpost.gpostnum+', ${group.groupnum})">'+
                      	  '<input type="button" value="삭제" style="cursor: pointer; width:50px; text-align:right;" onclick="deleteGPost('+gpost.gpostnum+', ${group.groupnum})">'+
                      	  '</div>';
                        }
					    
					    newLi.innerHTML +='</div>' +
					    '</div>' +
					    '</div>' +
					    '</div>';
						newLi.innerHTML +='<div class="gpostReply' + gpost.gpostnum + ' replyHide">' +
					    '<div class="repForm reply' + gpost.gpostnum + '">' +
							'<Form method="post" class="inputGPR" action="writegpreply.gp?gpostnum=' + gpost.gpostnum + '&groupnum=${group.groupnum}" name="writeRPForm' + gpost.gpostnum + '">' +
								'<div class="badgeimg"><img src=""></div>'+
								'<div class="badgeimg-right-info">'+
									'<p class="replywriter">${loginUser}&nbsp;</p>'+
									'<input type="hidden" name="userid" value="${loginUser}">'+
									'<textarea name="gprcontents" id="" cols="50" rows="3" placeholder="새로운 댓글을 남겨보세요"></textarea>'+
								'</div>'+
								'<div><input type="submit" value="등록"></div>'+
							'</Form>'+
					    '</div>' +
					    '<ul class="greplyList' + gpost.gpostnum + '"></ul>' +
					    '</div>'; 

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
                curPage++;
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
	function joinMoim(groupnum, loginUser) {
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
	})
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
</script>
</html>