<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="${cp}/css/createGroupstyle.css" rel="stylesheet">
</head>
<header>
	<jsp:include page="${cp}/app/header.jsp"></jsp:include>
	<%-- <jsp:include page="${cp}/app/message/sendmessage.jsp"></jsp:include> --%>
</header>
<style>
	.hide{
		display: none;
	}
	.file0_cont img {
		width: 204px;
		height: 192px;
	}
</style>
<body>
<div id="wrap">

<form id="createGroupForm" method="post" name="createGroupForm" action="${cp}/groupcreateok.gr" enctype="multipart/form-data">

    <div id="grouptit">
       <p><strong>모임</strong>등록</p>
    </div>
    <div class="form-list">
        <div class="form-list border partner-fomr-list">
	        <ul>
	            <li>
	                <div class="groupname">ㆍ모임 이름</div>
	                <input type="hidden" name="pt_tag" value="" id="pt_tag">
	                <input type="text" name="it_name" id="it_name"  class="width-400" size="50" placeholder="모임 이름을 지어주세요!"> 	
	            </li>
	            <li id="fileList">
	            	<div id="filewrap0">
	                    <div class="groupimg">
	                    	<p>모임 커버사진</p>
	                    	<div class="file0_cont"></div>
	                    </div>
	                    <div style="padding-left: 10px;" class="childtwo">
	                        <input type="file" name="file0" id="file0" style="display:none">
	                        <span id="file0name">선택된 파일 없음</span>
	                     </div>
	                     <div style="margin-right:100px;" class="filebtns childthree">
	                        <a href="javascript:upload(0)" class="fileselect">파일 선택</a>
	                        <a href="javascript:cancelFile(0)" class="filedelete">첨부 삭제</a>
	                     </div>
	            	</div>
	            </li>
	            <li>
	                <div class="groupregion">ㆍ모임지역</div>
	                <input type="hidden" name="pt_tag" value="" id="pt_tag">
	                <input type="text" name="it_region" value="" id="it_region"  class="width-400" size="50" placeholder="ex)ㅇㅇ구"> 	
	            </li>
	            <li>
	                
	                <div class="groupcategory">ㆍ모임 카테고리</div>
	                            <div class="bo_w_select write_div">
	                    <select name="ca_id_s" id="category"  onchange="category_main_change(this.form)" class="width-200">
	                        <option value="">기본 분류를 선택하세요</option>
	                        <option value="10">스포츠/레저</option>
	                        <option value="20">취미</option>
	                        <option value="30">친목/모임</option>
	                        <option value="40">음악</option>
	                        <option value="50">문화/예술</option>
	                        <option value="60">여행/캠핑</option>
	                        <option value="70">맛집/요리</option>
	                        <option value="80">어학/외국어</option>
	                        <option value="90">교육/공부</option>
	                        <option value="100">인문/과학</option>
	                        <option value="110">종교/봉사</option>
	                        <option value="120">반려동물/동물</option>
	                        <option value="130">자연/귀농</option>
	                        <option value="140">게임</option>
	                        <option value="150">IT/컴퓨터</option>
	                        <option value="150">팬클럽</option>
	                        <option value="160">애니메이션</option>
	
	                        <option value="190">기타</option>
	                    </select>
	                </div>
	                		
	            </li>
	            <li>
	                <div class="groupinfo">ㆍ모임 소개말</div>
	                <input type="hidden" name="pt_tag" value="" id="pt_tag">
	                <input type="text" name="it_info" value="" id="it_info"  class="width-400" size="50" placeholder="모임을 설명해주세요!"> 	
	            </li>
	            <li>
	                <div class="groupselect">ㆍ가입 신청 방법</div>
                        <div class="toggles">
                            <div class="toggletxt">
                                <strong>가입 신청 받기</strong>
                                <p>멤버 가입 시 리더의 승인이 필요합니다.</p>
                            </div>
                            <div class="toggleimg">
                            	<input type="hidden" name="autoreg" id="auto" value="1">
                            	<input type="hidden" name="groupmaster" value="${loginUser}">
                                <img src="${cp}/images/toggleleft.png" name="img1" id="img1" style="width: 35px; height: 35px;" onclick="toggleImg()">
                                <img src="${cp}/images/toggleright.png" name="img1" id="img2" style="display:none; width: 35px; height: 35px;" onclick="toggleImg()">
                            </div>
                        </div>
	            </li>
	            
	            <li>
	                <div class="notice">ㆍ 주의사항</div>
	                <!-- <textarea name="it_explan" id="it_explan" rows="10"></textarea> -->
	                <br>
	                * 개인 연락처 또는 카카오톡, 개인간 거래 유도 행위는 불법으로 간주하며, 적발시 사전동의 없이 모임장 권한이 중지 됩니다.
	                <br>
	                * 작성된 정보는 moa에 수집되며 진행 중인 모임에 문제가 발생한 경우에 확인 및 해결을 위해 활용 될 수 있습니다.
	                <span style="color:red">
	                                    <br>
	                    * 모임 생성 후 15일이 경과 될때까지 참여자가 없을 경우 모임은 자동 삭제 처리 됩니다.
	                                </span>
	            </li>
	            <!-- <li>
	                <div class="subject">ㆍ 모집인원</div>
	                <select name="it_stock_qty" id="it_stock_qty" class="width-100" value="" onchange="familyurl(this.form)">
	                <option value="0">본인제외</option>
	                <option value="0">0</option>
	                <option value="1">1</option>
	                <option value="2">2</option>
	                <option value="3">3</option>
	                <option value="4">4</option>
	                <option value="5">5</option>
	                <option value="6">6</option>
	                <option value="7">7</option>
	                <option value="8">8</option>
	                </select>
	                명
	            </li> -->
	        </ul>
        </div>
    </div>
    <div id="makebtn" >
        <input type="button" value=" 모임 만들기" onclick="sandit()" >
    </div>
  </form>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function sandit(){
        const createGroupForm = document.createGroupForm;
        createGroupForm.submit();
    }
</script>
<script>
	//현재 업로드된 파일의 개수(가장 마지막 행 번호)
	let i = 0;
	function sendit(){
	   const boardForm = document.boardForm;
	   //유효성 검사
	   boardForm.submit();
	}
	function upload(num){
	   $("#file"+num).click();
	}
	//$(선택자).change(함수) : 해당 선택자의 요소에 변화가 일어난다면 넘겨주는 함수 호출
	$("[type=file]").change(function(e){
	   //e : 파일이 업로드된 상황 자체를 담고있는 이벤트 객체
	   //e.target : 파일이 업로드가 된 input[type=file] 객체(태그객체)
	   const fileTag = e.target;
	   console.log(fileTag);
	   //e.target.files : 파일태그에 업로드가 된 파일들의 배열
	   const file = fileTag.files[0];
	   console.log(file);
	   
	   if(file == undefined){
	      //업로드 창을 띄웠다가 취소한 경우(파일이 업로드 되었다가 없어진 경우)
	      cancelFile(fileTag.id.split("e").pop());
	   }
	   else{
	      //파일을 업로드를 한 경우(없었다가 업로드, 있었는데 다른 파일로 업로드)
	      //#file0name 찾아서 내부 텍스트 변경(파일의 이름으로)
	      $("#"+fileTag.id+"name").text(file.name);
	      //업로드 된 파일의 확장자명         
	      let ext = file.name.split(".").pop();
	      if(ext == "jpeg" || ext == "png" || ext == "jpg" || ext == "webp" || ext == "gif"){
	         //".  file0       _cont"
	         $("."+fileTag.id+"_cont .thumbnail").remove();
	         const reader = new FileReader();
	         reader.onload = function(ie){
	            const img = document.createElement("img");
	            img.setAttribute("src",ie.target.result);
	            img.setAttribute("class","thumbnail");
	            console.log(document.querySelector("."+fileTag.id+"_cont"));
	            document.querySelector("."+fileTag.id+"_cont").appendChild(img);
	         }
	         reader.readAsDataURL(file);
	      }
	      else{
	         $("."+fileTag.id+"_cont .thumbnail").remove();
	      }
	      
	      //가장 마지막 [파일 선택] 버튼을 눌렀을 때
	      if(fileTag.id == "file"+i){
	         const cloneElement = $("#filewrap"+i).clone(true);
	         i++;
	         cloneElement.attr("id","filewrap"+i);
	         cloneElement.attr("class","hide");
	       
	         cloneElement.find("input[type='file']").attr("name","file"+i);
	         cloneElement.find("input[type='file']").attr("id","file"+i);
	         cloneElement.find("input[type='file']").val("");
	         
	         cloneElement.find("span").attr("id","file"+i+"name");
	         cloneElement.find("span").text("선택된 파일 없음");
	         
	         //                          javascript:upload(  1  )
	         cloneElement.find("a")[0].href = "javascript:upload("+i+")";
	         //                          javascript:cancelFile(  1  )
	         cloneElement.find("a")[1].href = "javascript:cancelFile("+i+")";
	         
	         //jQuery객체.appendTo("부모선택자") : 해당 선택자의 자식으로 jQuery 객체 추가
	         cloneElement.appendTo("#fileList");
	         
	      }
	   }
	})
	function cancelFile(num){
	   //파일 업로드 했다가 취소로 파일을 삭제하는 경우에는 문자열로 넘어온다.
	   num = Number(num);
	   //가장 마지막 [첨부 삭제] 버튼을 누른 경우
	   if(num == i){ return; }
	   //tr 지우기
	   $(".r"+num).remove();
	   //지워진 다음 행 부터 숫자 바꿔주기
	   for(let j=num+1;j<=i;j++){
	      console.log(j);
	      const el = $("#boardForm tbody .r"+j);
	      el.attr("class","r"+(j-1));
	      
	      el.find("th").text("파일 첨부"+j);
	      el.find("td").attr("class","file"+(j-1)+"_cont");
	      
	      el.find("input[type=file]").attr("name","file"+(j-1));
	      el.find("input[type=file]").attr("id","file"+(j-1));
	      
	      el.find("span").attr("id","file"+(j-1)+"name");
	      
	      el.find("a")[0].href = "javascript:upload("+(j-1)+")";
	      el.find("a")[1].href = "javascript:cancelFile("+(j-1)+")";
	   }
	   i--;
	}
	
	
	function toggleImg(){
	 var img1 = document.getElementById("img1");
	 var img2 = document.getElementById("img2");
	 
	 let targetnode = document.getElementById("auto");
	 
	 if (img1.style.display !== 'none') {
	   img1.style.display = 'none';
	   img2.style.display = 'block';
	   targetnode.value = "0";
	 } else {
	   img1.style.display = 'block';
	   img2.style.display = 'none';
	   targetnode.value = "1";
	 }
	}
   </script>
</html>


