<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>messagelist</title>
<style>
    * {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
    }

    a{
    	/* 링크의 밑줄 제거 */
        text-decoration: none; 
        /* 링크의 텍스트 색상을 투명하게 설정 */
        color: black;
    }

    table, tr, th, td{
        border-collapse: collapse;
        vertical-align: middle;
    }
    
    button{
        background-color: unset;
        border: none;
        font-size: 14px;
        cursor: pointer;
    }
    .msg_button:hover{
        font-weight: bold;
        color: #ff6d1d;
    }
    #msgl_wrap{
        width: 1000px;
        margin: 0 auto;
    }
    #msgl_box{
        width: 1000px;
        margin: 0 auto;
        margin-top: 50px;
    }
    .msg_list{
        width: 100%;
        /* 테이블 넓이 고정*/
        word-break: break-all;
        table-layout: fixed;
    }
    .msgl_head{
        height: 40px;
    }
    
    .msg_tit:nth-child(1){width:8%;}
    .msg_tit:nth-child(2){width:50%;}
    .msg_tit:nth-child(3){width:12%;}
    .msg_tit:nth-child(4){width:14%;}
    .msg_tit:nth-child(5){width:8%;}
    .msg_tit:nth-child(6){width:8%;}
    
    .msg_con{
        height: 40px;
        text-align: center;
        font-size: 14px;
        border-bottom: 1px solid rgb(190, 190, 190);
    }
    .msgl_content{
        text-align: left;
        /* 넘칠 경우 숨김 */
        overflow: hidden;
        /* 넘칠 경우 줄임표(...)를 표시 */
        text-overflow: ellipsis;
        /* 텍스트가 넘칠 경우 줄 바꿈을 방지*/
        white-space: nowrap;
    }

    .sysmsg_check_no{
    	color : #ff371d;;
    }
    .usermsg_check_no{
    	color : blue;
    }
    .usermsg_check_ok, .sysmsg_check_ok{
    	color : rgb(100,100,100);
    }
    
    .usermsg_check_ok:hover, .usermsg_check_no:hover, .sysmsg_check_no:hover{
    	font-weight: bold;
    }
    
    h1{
    	width: 1000px;
    	margin: 0 auto;
    	margin-top: 300px;
    	color:chocolate;
    	text-align: center;
    }
    
    .msg_check_ok_img, .msg_check_no_img{
        width: 80px;
        height: 40px;
        object-fit:scale-down;
        scale: 70%;
        opacity: 70%;
    }

    .msg_check_no_img{
        animation-name: check;
	    animation-duration: 2.5s; /* 애니메이션 지속 시간 */
	    animation-timing-function: ease-in-out; /* 애니메이션의 시간 곡선 */
	    animation-iteration-count: infinite; /* 애니메이션 반복 횟수 */
    }

    @keyframes check {
	    0%{
	    	opacity: 50%;
	    }
	    50%{
	    	opacity: 100%;
	    	filter: invert(27%) sepia(67%) saturate(3605%) hue-rotate(350deg) brightness(107%) contrast(101%);
	    }
	    100%{
	    	opacity: 50%;
	    }
	}
    
    
    /* 모달 스타일 */
    .sysmsg_modal {
        display: none; /* 모달 숨김 */
        position: fixed; /* 고정 위치 */
        z-index: 1000; /* 위에 표시 */
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        overflow: auto; /* 스크롤 가능 */
        background-color: rgba(0,0,0,0.1);
    }

    /* 모달 내용 스타일 */
    .sysmsg_modal-content {
        background-color: #fefefe;
        margin: 15% auto; /* 중앙에 표시 */
        padding: 20px;
        border-radius: 10px; 
        width: 400px;
        height: 400px;
        box-shadow: 0 0px 5px rgba(0,0,0,0.8);
    }

    /* 모달 닫기 버튼 스타일 */
    .sysmsg_close {
        padding: 10px 20px;
	    background-color: rgb(253, 202, 6);
	    color: rgb(50, 50, 50);
        float: right;
        font-size: 14px;
        font-weight: bold;
        box-shadow: 0 0 3px rgba(0, 0, 0, 0.359);
        
    }
    
    .sysmsg_close:hover,
    .sysmsg_close:focus {
        color: black;
        text-decoration: none;
        cursor: pointer;
    }
    
    
</style>
</head>
<header>
	<jsp:include page="${cp}/app/header.jsp"></jsp:include>
</header>
<body>
	<jsp:include page="${cp}/app/message/sendmessage.jsp"></jsp:include>
	<c:choose>
		<c:when test="${sysmsglist != null && usermsglist != null}">
		    <div id="msgl_wrap">
		        <div id="msgl_box">
		            <table class="msg_list">
		                <thead>
		                    <tr class="msgl_head">
		                        <th class="msg_tit">확인</th>
		                        <th class="msg_tit">내용</th>
		                        <th class="msg_tit">보낸사람</th>
		                        <th class="msg_tit">날짜</th>
		                        <th class="msg_tit">답장하기</th>
		                        <th class="msg_tit">삭제</th>
		                    </tr>
		                </thead>
		                	
		                	<!-- 시스템 메세지  -->
		                	<c:forEach var="i" begin="0" end="${sysmsglist.size() - 1}">
		                		<c:set var="sys_msg" value="${sysmsglist[i]}"/>
				                    <tr id="sys_msgview${i}">
				                    	<c:choose>
				                    		<c:when test="${sys_msg.msgcheck != 0}">
						                        <td class="msgl_check msg_con">
						                           	<img src=".${cp}/images/msg_ok.png" class="msg_check_ok_img">
						                        </td>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<td class="msgl_check msg_con">
						                           	<img src="${cp}/images/msg_no.png" class="msg_check_no_img">
						                        </td>
				                    		</c:otherwise>
				                    	</c:choose>
				                    	<c:choose>
				                    		<c:when test="${sys_msg.msgcheck != 0}">
						                        <td class="msgl_content msg_con" >
						                        	<button class="sysmsg_check_ok sysmsg_button" onclick="openModal('${sys_msg.msgcontent}')">${sys_msg.msgcontent}</button>
						                        </td>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<td class="msgl_content msg_con">
				                    				<button class="sysmsg_check_no sysmsg_button" onclick="openModal('${sys_msg.msgcontent}')">${sys_msg.msgcontent}</button>
						                        </td>
				                    		</c:otherwise>
				                    	</c:choose>
				                    	
				                    	<!-- 시스템메세지 모달부분  -->
				                    	<div id="sysmsg_Modal" class="sysmsg_modal">
										    <div class="sysmsg_modal-content">
										    	<h4>메세지 내용 : </h4>
										    	<br>
										        <p id="sysmsg_modalContent"></p>
										        <p id="linkaddr"></p>
										        <button type="button" class="sysmsg_close" onclick="sysmsg_closeModal()">닫기</button>
										        <!-- <span class="close" onclick="closeModal()">&times;</span> -->
										    </div>
										</div>
						                        
				                        <td class="msg_con"><input class="sys_sendid${i+1}" type="hidden" name="sys_sendid${i+1}" value="${sys_msg.sendid}">${sys_msg.sendid}</td>
				                        <input class="sys_sendnum${i+1}" type="hidden" name="sys_sendnum${i+1}" value="${sys_msg.messagenum}">
				                        <td class="msg_con">${sys_msg.msregdate}</td>
				                        <td class="msg_con">
				                        	<!-- 답장하기 관련해서 어디에 넣을기 고민  -->
				                            <%-- <button type="button" class="msg_send msg_button" onclick="sys_sendMessage(${i+1})">-</button> --%>
				                            -
				                        </td>
				                        <td class="msg_con">
				                            <button type="button" class="msg_delete msg_button" onclick="sys_deleteMessage(${i+1})">삭제하기</button>
				                        </td>
				                    </tr>
		                	</c:forEach>
		                	
		                	
		                	<!-- 유저간의 메세지  -->
		                	<c:forEach var="i" begin="0" end="${usermsglist.size() - 1}">
		                		<c:set var="msg" value="${usermsglist[i]}"/>
				                    <tr id="msgview${i}">
				                    	<c:choose>
				                    		<c:when test="${msg.msgcheck != 0}">
						                        <td class="msgl_check msg_con">
						                           	<img src="${cp}/images/msg_ok.png" class="msg_check_ok_img">
						                        </td>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<td class="msgl_check msg_con">
						                           	<img src="${cp}/images/msg_no.png" class="msg_check_no_img">
						                        </td>
				                    		</c:otherwise>
				                    	</c:choose>
				                    	<c:choose>
				                    		<c:when test="${msg.msgcheck != 0}">
						                        <td class="msgl_content msg_con" >
						                        	<button class="usermsg_check_ok usermsg_button">${msg.msgcontent}</button>
						                        </td>
				                    		</c:when>
				                    		<c:otherwise>
				                    			<td class="msgl_content msg_con">
				                    				<button class="usermsg_check_no usermsg_button">${msg.msgcontent}</button>
						                        </td>
				                    		</c:otherwise>
				                    	</c:choose>
						                        
				                        <td class="msg_con"><input class="sendid${i+1}" type="hidden" name="sendid${i+1}" value="${msg.sendid}">${msg.sendid}</td>
				                        <input class="sendnum${i+1}" type="hidden" name="sendnum${i+1}" value="${msg.messagenum}">
				                        <td class="msg_con">${msg.msregdate}</td>
				                        <td class="msg_con">
				                            <button type="button" class="msg_send msg_button" onclick="sendMessage(${i+1})">답장하기</button>
				                        </td>
				                        <td class="msg_con">
				                            <button type="button" class="msg_delete msg_button" onclick="deleteMessage(${i+1})">삭제하기</button>
				                        </td>
				                    </tr>
		                	</c:forEach>
		            </table>
		        </div>
		    </div>
		</c:when>
		<c:otherwise>
			<h1>"${loginUser}"님께 온 메세지가 없습니다.</h1>
		</c:otherwise>
	</c:choose>
</body>
<script>
	const cp = '${cp}';
	
	function sendMessage(index){
    	let targetnode= document.getElementsByClassName("sendid"+index)[0];
    	/* console.log(tagetnode);
    	console.log(tagetnode.value); */
    	let realtarget = document.getElementsByClassName("rcvid")[0]; 
    	realtarget.value = targetnode.value;
    	document.querySelector('.ms_modal_btn').click();
    }
	
	/* user가 보낸 메세지 삭제  */
	function deleteMessage(index){
		let targetnodenum= document.getElementsByClassName("sendnum"+index)[0];
    	/* console.log(targetnodenum);
    	console.log(targetnodenum.value); */
	    			    	
		const msgdeleteok = window.confirm("메세지를 삭제하시겠습니까?");
		
		const xhr = new XMLHttpRequest();
		if(msgdeleteok){
			xhr.onreadystatechange = function(){
	    		if(xhr.readyState == 4){
	    			if(xhr.status == 200){
	    				let txt = xhr.responseText.trim();
	    				if(txt == "O"){
	    			    	/* 해당하는 tr 삭제 */
	    			    	let targettr = document.getElementById("msgview" + (index - 1));
	    			    	/* console.log(targettr);
	    			    	console.log(targettr.value); */
	    			    	targettr.remove();
	    					alert("메세지를 삭제했습니다.");
	    				}
	    				else{
	    					alert("실패하였습니다. 다시 시도해주세요");
	    				}
	    			}
	    		}
	    	}
	    	xhr.open("GET", cp + "/deletemessage.ms?messagenum=" + targetnodenum.value);
	    	xhr.send();
    	}
	}
	
	/* system이 보낸 메세지 삭제  */
	function sys_deleteMessage(index){
		let targetnodenum= document.getElementsByClassName("sys_sendnum"+index)[0];
    	/* console.log(targetnodenum);
    	console.log(targetnodenum.value); */
	    			    	
		const msgdeleteok = window.confirm("메세지를 삭제하시겠습니까?");
		
		const xhr = new XMLHttpRequest();
		if(msgdeleteok){
			xhr.onreadystatechange = function(){
	    		if(xhr.readyState == 4){
	    			if(xhr.status == 200){
	    				let txt = xhr.responseText.trim();
	    				if(txt == "O"){
	    			    	/* 해당하는 tr 삭제 */
	    			    	let targettr = document.getElementById("sys_msgview" + (index - 1));
	    			    	/* console.log(targettr);
	    			    	console.log(targettr.value); */
	    			    	targettr.remove();
	    					alert("메세지를 삭제했습니다.");
	    				}
	    				else{
	    					alert("실패하였습니다. 다시 시도해주세요");
	    				}
	    			}
	    		}
	    	}
	    	xhr.open("GET", cp + "/deletemessage.ms?messagenum=" + targetnodenum.value);
	    	xhr.send();
    	}
	}
    

    /* 시스템이 보낸 메세지 확인 */
    function openModal(content) {
        var modal = document.getElementById('sysmsg_Modal');
        var modalContent = document.getElementById('sysmsg_modalContent');
        
        // 클릭된 버튼의 내용을 모달에 표시합니다.
        modalContent.textContent = content;
        
        // 모달을 보이도록 설정합니다.
        modal.style.display = 'block';
    }
    
    function sysmsg_closeModal() {
        var modal = document.getElementById('sysmsg_Modal');
        
        // 모달을 숨깁니다.
        modal.style.display = 'none';
    }
</script>
</html>