<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${cp}/css/groupinnerstyle.css" id="basic" rel="stylesheet">
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
  
</style>
</head>
<body>
<!-- 
 -->
	<c:if test="${empty loginUser}">
		<c:set var="loginUser" value="${null}"/>
	</c:if>
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
            <nav>

            </nav>
        </header>
        <div class="group-inner contents" id="group_inner_container">
            <div id="groupinfobox" class="infobox">
                <div class="groupimg imgbox">
                    <img>
                </div>
                <div class="groupinfobox-inner">
                    <p id="groupname">${group.groupname}</p>
                    <p id="groupinfo">
                        <span class="gmem">멤버: ${usercnt}</span>
                        <span class="glead">리더: ${group.groupmaster}</span>
                    </p>
                    <div>
                        <div class="group-btn-box btnBox">
                                <input type="button" value="모임 가입하기">
                        </div>
                    </div>
                </div>
            </div>
            <div id="gpostsection">
                <div class="summary">
                    <div class="summarytitle">
                        <p>그룹 소개</p>
                    </div>
                    <div class="summaryinfo">
                        <p>${group.groupcontents}</p>
                        <ul class="grouptaglist">
                           <li class="groupaddrinfo circle-list-btn">
                                <a href="#">${group.groupaddr}</a>
                           </li>
                           <li class="groupcategoryinfo circle-list-btn">
                                <a href="">${group.groupcategory}</a>
                           </li> 
                        </ul>
                    </div>
                </div>
                <div class="groupsearch searchArea">
                    <div class="searchBox">
                        <input type="text" name="groupsearch" id="gpsearch">
                    </div>
                    <div class="searchBtnBox">
                        <input type="button" value="검색" onclick="makeDOMKeyword()">
                    </div>
                </div>
                <div id="gpost" class="postsection">
                    <ul class="gpostList" id="gpList">
                    	<li class="write_wrap">
								<div class="write_btn">
									<input type="button" value="글 쓰기" onclick="showWrite(${gpost.gpostnum})"> 
								</div>
							<div class="writeform" id="writeForm" style="display: none;">
								<form id="writeform">
									<ul>
										<li>
											<h3>글쓰기</h3>
										</li>
										<li>
											<label for="writetit"></label>
											<input type="text" id="writetit" placeholder="제목을 입력해주세요.">
										</li>
										<li>
											<label for="writebox"></label>
											<textarea name="글 쓰기" id="writebox" cols="30" rows="10" placeholder="새로운 소식을 남겨보세요"></textarea>
										</li>
										<li>
											<label for="writefile"></label>
											<input type="file" id="writefile">
										</li>
										<li>
											<input type="button" id="writesubmit" value="제출하기">
										</li>
									</ul>
								</form>
							</div>
						</li>
                    	<c:choose>
                    		<c:when test="${list != null and list.size()>0}">
                    			<c:forEach var="i" begin="0" end="${list.size() -1}">
                    				<c:set var="gpost" value="${list[i]}"/>
                    					<li class="gpostListwrap">
				                            <div class="gpostHead default-group-Head">
				                                <div class="badgeimg">
				                                    <input type="button" value="버튼" id="profilebtn" onclick="showprofile(true)">
				                                </div>
				                                <div class="writerinfo badgeimg-right-info">
				                                    <p>
				                                        <a href="" class="usernamelink">${gpost.userid}</a>
				                                        <span>이런사람이에요</span>
				                                    </p>
				                                    <p class="regtime">${gpost.gpostregdate}</p>
				                                </div>
				                            </div>
				                            <div class="profile_wrap">
												<div class="profile_container" id="profile_container" style="display: none;">
													<div class="design1"></div>
													<!-- <img src="" id="profileimg"> -->
													<button type="button"><img src="../../images/x.webp" style="width: 15px; height: 15px;" alt="나가기" id="quitimg" onclick="quitprofile(true)"></button>
													<p>내가보이니?</p>
													<p>${user.userid}</p>
													<p>${user.userhobby}</p>
													<p>${user.gender}</p>
													<p>${user.userpoint}</p>
												</div>
											</div>
				                            <div class="gpostContents">
				                                <div>
				                                    <p>
				                                    	<textarea class="GPCIN gpostConetentsIn${gpost.gpostcontents}" style="width: 100%; height: 100%">
				                                    	${gpost.gpostcontents}
				                                    	</textarea>
				                                    </p>
				                                    <div>
				                                    	<input type="button" value="첨부파일" onclick="showFiles(${gpost.gpostnum})">
				                                    </div>
								                    <div class="gpostfile${gpost.gpostnum} replyHide">
								                    	<ul class="gfileList${gpost.gpostnum}"></ul>
								                    </div>
								                    <div class="likereply">
														<img id="likeButton" class="like-button" src="${cp}/images/redheart.webp" alt="좋아요" style="width: 15px; height: 15px;">
														<div class="point-area showreplyBtn">
														<div style="display: inline-block;">
															<input type="button" value="좋아요 i개">
														</div>
														<div style="display: inline-block;">
															<input type="button" value="댓글  ${reply_cnt_list[i]}개"
																onclick="showReply(${gpost.gpostnum})"
																style="cursor: pointer;">
														</div>
														<c:if test="${gpost.userid == loginUser}">
															<div style="display:inline-block; margin-left:210px;">
					                                        	<input type="button" class="replyHide" value="수정" style="cursor: pointer; width:70px; text-align:right;" onclick="showUpdateForm(${gpostnum})">
					                                        	<input type="button"  value="수정완료" style="cursor: pointer; width:70px; text-align:right;" onclick="updateGPost()">
					                                        	<input type="button" value="삭제" style="cursor: pointer; width:50px; text-align:right;" onclick="deleteGPost()">
					                                        </div>
														</c:if>
														</div>
													</div>
				                                </div>
				                            </div>
				                            <div class="gpostReply${gpost.gpostnum} replyHide">
				                            	<div class="inputGPR reply${gpost.gpostnum} replyHide"></div>
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
                    <p>공지사항</p>
                    <ul class="gpostList" id="gpGongji">
                        <li class="gpostListwrap">
                            <div class="gpostHead default-group-Head">
                                <div class="badgeimg">
                                    <img src="">
                                </div>
                                <div class="writerinfo badgeimg-right-info">
                                    <p>
                                        <a href="" class="usernamelink">블루</a>
                                        <span>이런사람이에요</span>
                                    </p>
                                    <p class="regtime">2시간전</p>
                                </div>
                            </div>
                            <div class="gpostContents">
                                <div>
                                    <p>
                                        내용이에요
                                        내용내용
                                        
                                        내용용내용
                                        <br><br><br><br><br><br><br><br>
                                    </p>
                                    <div>
                                        <input type="button" value="굿">
                                        <input type="button" value="배드">
                                    </div>
                                    <div class="point-area showreplyBtn">
                                        <div style="display: inline-block;">
                                            <input type="button" value="좋아요 3개">
                                        </div>
                                        <div style="display: inline-block;">
                                            <input type="button" value="댓글 3개">
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            <div class="gpostReply">
                                <ul class="greplyList"></ul>
                            </div>
                        </li>
                    </ul>
                </div>
               <div id="grouppopular">
                    <p>이번 주 인기글!</p>
                    <ul class="gpostList" id="gpPopular">
                        <li class="gpostListwrap">
                            <div class="gpostHead default-group-Head">
                                <div class="badgeimg">
                                    <img src="">
                                </div>
                                <div class="writerinfo badgeimg-right-info">
                                    <p>
                                        <a href="" class="usernamelink">블루</a>
                                        <span>이런사람이에요</span>
                                    </p>
                                    <p class="regtime">2시간전</p>
                                </div>
                            </div>
                            <div class="gpostContents">
                                <div>
                                    <p>
                                        내용이에요
                                        내용내용
                                        
                                        내용용내용
                                        <br><br><br><br><br><br><br><br>
                                    </p>
                                    <div>
                                        <input type="button" value="굿">
                                        <input type="button" value="배드">
                                    </div>
                                    <div class="point-area showreplyBtn">
                                        <div style="display: inline-block;">
                                            <input type="button" value="좋아요 3개">
                                        </div>
                                        <div style="display: inline-block;">
                                            <input type="button" value="댓글 3개">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="gpostReply">
                                <ul class="greplyList"></ul>
                            </div>
                        </li>
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
	    				    
	    				newLi.innerHTML='<p>파일이 없습니다.</p>';
	    				    
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
							'    <p class="replywriter">블루</p>' +
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
					    '<div class="badgeimg">' +
					    '<input type="button" value="버튼" id="profilebtn" onclick="showprofile(true)">' +
					    '</div>' +
					    '<div class="writerinfo badgeimg-right-info">' +
					    '<p>' +
					    '<a href="" class="usernamelink">' + gpost.userid + '</a>' +
					    '<span>이런사람이에요</span>' +
					    '</p>' +
					    '<p class="regtime">' + gpost.gpostregdate + '</p>' +
					    '</div>' +
					    '</div>' +
					    '<div class="profile_wrap">' +
					    '<div class="profile_container" id="profile_container" style="display: none;">' +
					    '<div class="design1"></div>' +
					    '<button type="button"><img src="../../images/x.webp" style="width: 15px; height: 15px;" alt="나가기" id="quitimg" onclick="quitprofile(true)"></button>' +
					    '<p>내가보이니?</p>' +
					    '<p>user.user.userid' + + '</p>' +
					    '<p>user.user.userhobby' + + '</p>' +
					    '<p>user.user.userid' + + '</p>' +
					    '<p>user.user.userpoint' + + '</p>' +
					    '</div>' +
					    '</div>' +
					    '<div class="gpostContents">' +
					    '<div>' +
					    '<p>' +
					    '<textarea class="GPCIN gpostConetentsIn' + gpost.gpostcontents + '" style="width: 100%; height: 100%">' +
					    gpost.gpostcontents +
					    '</textarea>' +
					    '</p>' +
					    '<div>' +
					    '<input type="button" value="첨부파일" onclick="showFiles(' + gpost.gpostnum + ')">' +
					    '</div>' +
					    '<div class="gpostfile' + gpost.gpostnum + ' replyHide">' +
					    '<ul class="gfileList' + gpost.gpostnum + '"></ul>' +
					    '</div>' +
					    '<div class="likereply">' +
					    '<img id="likeButton" class="like-button" src="' + cp + '/images/redheart.webp" alt="좋아요" style="width: 15px; height: 15px;">' +
					    '<div class="point-area showreplyBtn">' +
					    '<div style="display: inline-block;">' +
					    '<input type="button" value="좋아요 i개">' +
					    '</div>' +
					    '<div style="display: inline-block;">' +
					    '<input type="button" value="댓글  i개" onclick="showReply('+gpost.gpostnum+')" ' +
					    'style="cursor: pointer;">' +
					    '</div>';
					    
					    if(gpost.userid===loginUser){
                      	  newLi.innerHTML +='<div style="display:inline-block; margin-left:210px;">'+
                      	  '<input type="button" class="replyHide" value="수정" style="cursor: pointer; width:70px; text-align:right;" onclick="showUpdateForm('+gpost.gpostnum+')">'+
                      	  '<input type="button"  value="수정완료" style="cursor: pointer; width:70px; text-align:right;" onclick="updateGPost('+gpost.gpostnum+')">'+
                      	  '<input type="button" value="삭제" style="cursor: pointer; width:50px; text-align:right;" onclick="deleteGPost('+gpost.gpostnum+')">'+
                      	  '</div>';
                        }
					    
					    newLi.innerHTML += '</div>' +
					    '</div>' +
					    '</div>' +
					    '</div>' +
					    '<div class="gpostReply' + gpost.gpostnum + ' replyHide">' +
					    '<div class="inputGPR reply' + gpost.gpostnum + ' replyHide">' +
					    '</div>' +
					    '<ul class="greplyList' + gpost.gpostnum + '"></ul>';

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

      const likeButton = document.getElementById("likeButton");
        let isLiked = false;

        likeButton.addEventListener("click", function() {
          if (isLiked) {
            likeButton.src = "${cp}./images/redheart.webp"; // 원래 이미지로 변경
            isLiked = false;
          } else {
            likeButton.src = "${cp}./images/whiteheart.webp"; // 새로운 이미지로 변경
            isLiked = true;
          }
        });

    	//글쓰기 폼 나오는 기능 

    function showWrite() {
        var writeForm = document.getElementById("writeForm");
        if (writeForm.style.display === "none") {
            writeForm.style.display = "block"; // 보이게 함
        } else {
            writeForm.style.display = "none"; // 감춤
        }
    }
    	
    $('textarea').each(function () {
    	this.setAttribute('style', 'height:' + (this.scrollHeight) + 'px;overflow-y:hidden;');
    	}).on('input', function () {
    	this.style.height = 'auto';
    	this.style.height = (this.scrollHeight) + 'px';
    });
</script>
</html>