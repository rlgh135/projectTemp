<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>checkMoim</title>
<link href="${cp}/css/groupinnerstyle.css" rel="stylesheet">
</head>
<body>
	<c:if test="${empty loginUser}">
		<script>
			alert("돌아가");
			location.href = "/";
		</script>
	</c:if>
	<div id="group_inner_wrap">
        <header>
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
        </header>
        <div class="group-inner contents" id="group_inner_container">
            <div id="groupinfobox" class="infobox">
                <div class="groupimg imgbox">
                    <img src="../../file/groupimg/abcd25.jpg" style="background-size: cover; width: 100%; height: auto;">
                </div>
                <div class="groupinfobox-inner">
                    <p id="groupname">${group.groupname}</p>
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
                                <input type="button" value="돌아가기" class="joinMoim" onclick="backToMoim(${group.groupnum})">
                        </div>
                    </div>
                </div>
            </div>
            		<div id="gpostsection">
                		<div id="gpost" class="postsection">
	                		<div class="gpostListwrap">
	                			<form action="/joinmoimok.gp?groupnum=${group.groupnum}" method="post" name="qlistForm">
			                		<c:choose>
			                			<c:when test="${autoreg == 1}">
			                				<div>
			                					<p>${group.groupname}은 자동 가입 모임이에요</p>
			                					<input type="hidden" name="auto" value="auto">
			                				</div>
			                				<div>
			                					<p>최근에 ${group.groupname}에 가입했어요</p>
			                					<ul>
			                						<c:if test="${not empty recentguser }">
			                						<c:forEach var="i" begin="0" end="${recentguser.size()-1}">
			                							<c:set var="recuser" value="${recentguser[i] }"/>
			                							<li>
			                								<div>
			                									<p>${recuser.userid}</p>
			                								</div>
			                							</li>
			                						</c:forEach>
			                						</c:if>
			                					</ul>
			                				</div>
			                				<p><a href="javascript:changeAuto(1)">가입 방식 변경하기</a></p>	                				
			                			</c:when>
			                			<c:otherwise>
			                				<div>
			                					<p>${group.groupname}의 가입 양식이에요<span><a href="">편집</a></span></p>
			                					<input type="hidden" name="auto" value="no">
			                				</div>
			                				<ul class="qListWrap">
			                				<c:choose>
			                				<c:when test="${questionlist.size() != 0}">
				                				<c:forEach var="i" begin="0" end="${questionlist.size() -1}">
			                    					<c:set var="index" value="${i}"/>
			                    					<li class="qList">
			                    						<p>${i+1}. ${questionlist[i]}</p>
			                    						<div>
			                    							<textarea name="answer${i}"></textarea>
			                    						</div>
			                    					</li>
			                    				</c:forEach>
			                				</c:when>
			                				<c:otherwise>
			                					<li>
			                						<p>등록된 질문이 없습니다</p>
			                					</li>
			                				</c:otherwise>
			                				</c:choose>
			                				</ul>
			                				<%--가입신청 유저 리스트 --%>
			                				<ul class="joinuserWrap">
			                				<c:choose>
			                				<c:when test="${empty ansbaselist}">
			                					<li>
			                						<p>가입신청한 인원이 없어요</p>
			                					</li>
			                				</c:when>
			                				<c:otherwise>
			                					<c:forEach var="i" begin="0" end="${ansbaselist.size() -1}">
			                						<c:set var="ansbase" value="${ansbaselist[i]}"/>
			                						<c:set var="answerlists" value="${answerlist[i]}"/>
			                						<li>
			                							<p>${ansbase.userid} 님의 답변 <input type="button" value="승인"><input type="button" value="거절"><input type="button" value="펼치기"></p>
			                							<c:forEach var="j" begin="0" end="${answerlists.size() -1}">
			                								<c:set var="answer" value="${answerlists[j]}"/>
			                								<div>
				                								<p>${questionlist[j]}</p>
				                								<p>${answer}</p>
			                								</div>
			                							</c:forEach>
			                						</li>
			                					</c:forEach>
			                				</c:otherwise>
			                				</c:choose>
			                				</ul>			                				
		                    				<p><a href="javascript:changeAuto(0)">자동 가입으로 변경하기</a></p>
			                			</c:otherwise>
			                		</c:choose>
								</form>
							</div>
                		</div>
            		</div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
	function backToMoim(groupnum){
		location.href = "/groupinner.gp?groupnum="+groupnum;
	}
</script>
</html>