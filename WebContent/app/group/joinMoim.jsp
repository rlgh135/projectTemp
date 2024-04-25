<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>joinMoim</title>
<link href="${cp}/css/groupinnerstyle.css" rel="stylesheet">
<link href="${cp}/css/moimstyle.css" rel="stylesheet">
</head>
<body>
	<c:if test="${empty loginUser}">
		<c:set var="loginUser" value="${null}"/>
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
                    <img src="../../file/groupimg/${thumbnail}" style="background-size: cover; width: 100%; height: auto;">
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
	                			<form name="accountForm" action="/joinmoimok.gp?groupnum=${group.groupnum}" method="post">
			                		<c:choose>
			                			<c:when test="${autoreg == 1}">
			                				<div>
			                					<p>${group.groupname}은 자동 가입 모임이에요</p>
			                					<p>정말 가입하시겠어요?</p>
			                					<input type="hidden" name="auto" value="auto">
		                    					<input type="hidden" value="${group.groupname}" name="groupname">
			                					<input type="hidden" value="${group.groupmaster}" name="groupmaster">
			                				</div>			                				
			                				<div class="aWrap"><a href="javascript:sendit(1)">가입신청</a></div>
			                			</c:when>
			                			<c:otherwise>
			                				<div>
			                					<p>${group.groupname}의 가입 양식이에요</p>
			                					<p>질문에 답변해 주세요</p>
			                					<input type="hidden" name="auto" value="no">
			                				</div>
			                				<ul class="qListWrap">
				                				<c:forEach var="i" begin="0" end="${questionlist.size() -1}">
			                    					<c:set var="index" value="${i}"/>
			                    					<li class="qList">
			                    						<p>${i+1}. ${questionlist[i]}</p>
			                    						<div>
			                    							<textarea cols="70" rows="3" name="answer${i}"></textarea>
			                    						</div>
			                    					</li>
			                    				</c:forEach>
			                				</ul>			                				
		                    				<div class="aWrap">
		                    					<input type="hidden" value="${index}" name="index">
		                    					<input type="hidden" value="${group.groupmaster}" name="groupmaster">
		                    					<input type="hidden" value="${group.groupname}" name="groupname">
		                    					<a href="javascript:sendit(0)">가입신청</a>
		                    				</div>
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
	function sendit(auto) {
		const form = document.accountForm;
		if(auto===1){
			alert("가입이 완료되었어요");
			accountForm.submit();
		} else {
			alert("가입 신청이 완료되었어요");
			accountForm.submit();
		}
	}
	function backToMoim(groupnum){
		location.href = "/groupinner.gp?groupnum="+groupnum;
	}
</script>
</html>