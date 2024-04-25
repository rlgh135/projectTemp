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
	<jsp:include page="${cp}/app/user/myinfobreif.jsp"></jsp:include>
	<div class="User_more">
		<!-- 내 모임 시작 -->
		<div class="User_moreframe">
		<div class="lpost_wrap">
			<div class="lpost_banner">내 게시글</div>
			<div class="lpost_body">
						<a href="/boardwrite.bo">
							<div class="create_box myinfo_card_list">
								<div class="create_sub">
									<div class="coverout">
										<div class="coverin">+</div>
									</div>
									<div class="MoreName">
										<p>게시글을 작성해보세요!</p>
									</div>
								</div>
							</div>
						</a>
						<div id="lpostListWrap">
						<div id="left-Lpost-Btn">
							<img alt="" src="${cp}/images/arrow_left_icon.png" onclick="loadLp(-1)">
						</div>
						<c:forEach var="i" begin="${0}" end="${2}">
							<div id="LPost${i}" class="myinfo_card_list LPost${i}"
								onclick="javascript:goLPost(${lpost.lpostnum})">
								<div>
									<p id="lpost_title${i}">lpost.lpostitle</p>
									<p id="lpost_likecnt${i}">lpost.lpostlikecnt 명이 좋아요를 눌렀어요!</p>
								</div>
							</div>
						</c:forEach>
						<div id="right-Lpost-Btn">
							<img alt="" src="${cp}/images/arrow_right_icon.png" onclick="loadLp(1)">
						</div>
						</div>
			</div>
		</div>
		<!-- 내 그룹 시작 -->
		<div class="group_wrap">
			<div class="group_banner">내 모임 </div>
			<div class="group_body">
						<a href="${cp}/creategroup.gr">
							<div class="create_box myinfo_card_list">
								<div class="create_sub">
									<div class=coverout>
										<div class="coverin">+</div>
									</div>
									<div class="MoreName">
										<p>새 모임을 만들어 보세요!</p>
									</div>
								</div>
							</div>
						</a>
						<div id="groupListWrap">
						<div id="left-Group-Btn">
							<img alt="" src="${cp}/images/arrow_left_icon.png" onclick="loadGr(-1)">
						</div>
						<c:forEach var="i" begin="0" end="2">
							<div id="myGroup${i}" class="myinfo_card_list GPost"
							onclick="javascript:goGPost(grouplist.groupnum)">
										<img id="gthumbnail${i}" src="${cp}/file/groupimg/groupimglist.imgsysname"
											alt="">
								<div class="gboard_list">
									<div class="gboard_list_frame">
										<p id="gcategory${i}">group.groupcategory</p>
										<p id="gname${i}">group.groupname</p>
										<p id="gmaster${i}" style="width:100px;">group.groupmaster</p>
									</div>
								</div>
							</div>
						</c:forEach>
						<div id="right-Group-Btn">
							<img alt="" src="${cp}/images/arrow_right_icon.png" onclick="loadGr(1)">
						</div>
						</div>
						
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
	const userid = '${loginUser}';
</script>
<script>
	var lpage = 0;
	var gpage = 0;
	
	document.addEventListener("DOMContentLoaded", function() {
        loadLp(1);
        loadGr(1);
    });
	
	function goLPost(lpostnum) {
		location.href=cp+"/boardview.bo?lpostnum="+lpostnum;
	}
	function goGPost(groupnum){
		location.href=cp+"/groupinner.gp?groupnum="+groupnum;
	}
	
	function loadLp(direction){
		lpage += direction;
		console.log("불러오는 lpage: "+lpage);
	    const xhr = new XMLHttpRequest();
	    	
	    xhr.onreadystatechange = function(){
	    	if(xhr.readyState == 4){
	    		if(xhr.status==200){
	    			//let targetnode = id="LPost${i}";
	    			console.log(xhr.responseText);
	    			const obj = JSON.parse(xhr.responseText);
					//console.log(obj);
					const lplist = obj.lplist;
					console.log(lplist);
					
					var idx = 0;
					
					for (var i in lplist) {
						var targetdivnode = document.getElementById("LPost"+i);
						targetdivnode.setAttribute("onclick","javascript:goLPost("+lplist[i].lpostnum+")");
						
						var targetpnode = document.getElementById("lpost_title"+i);
						targetpnode.innerHTML = lplist[i].lposttitle;
						
						var targetppnode = document.getElementById("lpost_likecnt"+i);
						targetppnode.innerHTML = lplist[i].lpostlikecnt+"명이 좋아요를 눌렀어요!";
						idx++;
					}
					
					//리스트 마지막일때 로직 추가
	    		}
	    	}
	    }
	    xhr.open("GET", cp+"/myboard.us?userid="+userid+"&page="+lpage);
	    xhr.send();
	}
	function loadGr(direction){
		gpage += direction;
		console.log("불러오는 gpage: "+gpage);
		const xhr = new XMLHttpRequest();
    	
	    xhr.onreadystatechange = function(){
	    	if(xhr.readyState == 4){
	    		if(xhr.status==200){
	    			//let targetnode = id="myGroup${i}";
					console.log(xhr.responseText);
	    			const obj = JSON.parse(xhr.responseText);
					const grouplist = obj.grouplist;
					console.log(grouplist);
					const sysnamelist = obj.sysnamelist;
					console.log(sysnamelist);
					
					var idx = 0;
					
					for (var i in grouplist) {
						var targetdivnode = document.getElementById("myGroup"+i);
						targetdivnode.setAttribute("onclick","javascript:goGPost("+grouplist[i].groupnum+")");
						
						var targetimgnode = document.getElementById("gthumbnail"+i);
						if(sysnamelist[i] !== "main_img.jpg"){
							targetimgnode.setAttribute("src","${cp}/file/groupimg/"+sysnamelist[i]+"");
						} else {
							targetimgnode.setAttribute("src","${cp}/file/groupimg/main_img.jpg");
						}
						
						var targetpnode = document.getElementById("gcategory"+i);
						targetpnode.innerHTML = grouplist[i].groupcategory;
						
						var targetppnode = document.getElementById("gname"+i);
						targetppnode.innerHTML = grouplist[i].groupname;

						var targetppnode = document.getElementById("gmaster"+i);
						targetppnode.innerHTML = grouplist[i].groupmaster;
						
						idx++;
					}
	    		}
	    	}
	    }
	    xhr.open("GET", cp+"/mygroup.us?userid="+userid+"&page="+gpage);
	    xhr.send();
	}
</script>
</html>
