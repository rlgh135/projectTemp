<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<style>
.userInfo_box_wrap p{
    margin: 0;
}

.userInfo_box_wrap{
    width: 1400px;
    margin: 50px auto;
    /* background-color: rgb(255, 255, 245); */
}

.userInfo_box{
    width: 100%;
    height: 450px;
    margin: 0 auto;
    border-top: 3px solid rgb(253, 202, 6);
    border-bottom: 3px solid rgb(253, 202, 6);
}

.profile_img{
    margin: 73px 148px;
    width: 300px;
    height: 300px;
    border-radius: 50%;
    float: left;
    border: 2px solid white;
    box-shadow: 0 0 10px rgb(70, 70, 70);
}

.profile_img img{
    width: 296px;
    height: 296px;
    border-radius: 50%;
    background-size: cover;
}

.profile_contents{
    width: 800px;
    height: 400px;
    float: left;
}

.id_box{
    margin-top: 70px;
    display: inline-flex;
    height: 40px;
    margin-bottom: 20px;
}
.userInfo p{
    width: 200px;
    height: 40px;
    line-height: 40px;
}
.id_box p {
	font-size: 40px;
	font-weight:bolder;
}
.addr_box p {
	font-size: 20px;
	font-weight:bolder;
	min-width: 300px;
}
.addr_box{
	margin-bottom: 30px;
}
.id_box button{
	font-weight:bold;
    border: none;
    margin: 5px 0;
    width: 100px;
    height: 30px;
    background-color: lightgray;
    border-radius: 5px;
    box-shadow: 0 0 3px black;
    cursor: pointer;
}
.id_box button:hover {
	transform: scale(1.05);
}

.userLpost, .userGroup{
    width: 750px;
    height: 70px;
    margin-top: 20px;
}

.userLpost div, .userGroup div {
    width: 700px;
    height: 50px;
    float: left;
    background-color: #e6a236;
    border-radius: 10px;
    text-align: center;
    box-shadow: 0 0 6px rgb(150, 150, 150);
    line-height: 50px;
    font-size: 20px;
}
.userLpost div span, .userGroup div span {
	font-weight: bold;
	font-size: 25px;
}

.userGroup{
    margin-top: 10px;
}

.moajoinday_box{
	font-size:20px;
    margin-top: 15px;
    width: 650px;
    height: 50px;
    line-height: 50px;
    text-align: center;
}
#moa, #joinday{
    font-size: 30px;
    font-weight: bolder;
    color: #e6ac0e;

}
#joinday{
    color: #ff6d1d;
}
.myInfo_modify_modal {
    display: none;
    position: fixed;
    z-index: 1;
    left: 0;
    top: 0;
    width: 100%;
    height: 100%;
    overflow: auto;
    background-color: rgba(0,0,0,0.4);
}

.myInfo_modify_modal-content {
    background-color: #fefefe;
    margin: 15% auto;
    padding: 20px;
    border: 1px solid #888;
    width: 500px;
    border-radius: 10px;
}
.myInfo_modify_modal-content th{
    width: 200px;
    height: 40px;
    margin-right: 10px;
}
.myInfo_modify_modal-content tr:nth-child(3) th{
    height: 80px;
}
.myInfo_modify_modal-content td{
    width: 300px;
}
.ms_btn_area{
    background-color: #ff6d1d;
}
.myInfo_modify_close, .myInfo_modify_send {
    display: block;
    padding: 10px 30px;
    background-color: rgb(253, 202, 6);
    border: none;
    border-radius: 5px;
    font-weight: bolder;
    color: rgb(50, 50, 50);
    cursor: pointer;
    transition: box-shadow 0.2s;
    float: left;
    margin: 20px 30px;
    box-shadow: 0 0 3px rgba(0, 0, 0, 0.359);
}
.myInfo_modify_send{
    margin-left: 130px;
}

.myInfo_modify_close:hover,
.myInfo_modify_close:focus {
    color: black;
    text-decoration: none;
    cursor: pointer;
}
#profile_img_filewrap_td{
    width: 200px;
}
.myInfo_modify_modal-content input[type=text]{
	font-size:16px;
 	width:200px;
    border: none;
    outline: none;
}

#myid, #myaddr{
    border: none;
}
.myInfo_modify_modal-content h2{
    text-align: center;
}
.profile_img_file1{
	width: 200px;
}
#profile_img_filename{
	text-align: center;
}
.profile_img_fileselect:hover, .profile_img_filedelete:hover{
	font-weight:bold;
 	color: #ff6d1d;
}
img.thumbnail{
	display: block;
	width:200px;
	clear: both;
}
</style>
</head>
<body>
    <div class="userInfo_box_wrap">
        <div class="userInfo_box">
            <div class="profile_img">
            	<c:choose>
            		<c:when test="${not empty userimg}">
		                <img src="${cp}/file/userimg/${userimg.userimgsysname}" alt="">
            		</c:when>
            		<c:otherwise>
		                <img src="${cp}/file/userimg/free-animated-icon-face-scan-7920844.gif" alt="">
            		</c:otherwise>
            	</c:choose>
            </div>
            <div class="profile_contents">
                <div class="userInfo id_box">
                    <p>${user.userid}</p>
                    <button type="button" onclick="myInfo_modify_openModal()">프로필 편집</button>
                </div>
                <div class="userInfo addr_box">
                    <p>${user.useraddr}</p>
                </div>

                <div class="userLpost">
                	<c:choose>
                		<c:when test="${lpostcnt == 0}">
		                    <div>
		                        <p>작성하신 게시글이 없어요</p>
		                    </div>
                		</c:when>
                		<c:otherwise>
		                    <div>
		                        <p>내가 작성한 게시글 수 : <span>"${lpostcnt}" 개</span></p>
		                    </div>
                		</c:otherwise>
                	</c:choose>
                </div>
                <div class="userGroup">
                	<c:choose>
                		<c:when test="${groupjoincnt == 0}">
		                    <div>
		                        <p>참여하신 모임이 없어요</p>
		                    </div>
                		</c:when>
                		<c:otherwise>
		                    <div>
                        		<p>내가 참여한 모임 수 : <span>"${groupjoincnt}" 개</span></p>
                    		</div>
                		</c:otherwise>
                	</c:choose>
                </div>
                <div class="moajoinday_box">
                    <p><span id="moa">"모아"</span>와 함께한지 <span id="joinday">"${daysBetween}"</span>일 째에요</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- 수정하기 모달 -->
    <div id="myInfo_modify_editModal" class="myInfo_modify_modal">
        <div class="myInfo_modify_modal-content">
            
            <!-- 모달 내용 추가 -->
            <h2>프로필 편집</h2>
                <form name="myInfoModifyForm" method="post" action="${cp}/usermodify.us" enctype="multipart/form-data">
                    <table>
                        <tbody>
                            <tbody>
                                <tr>
                                    <th>아이디</th>
                                    <td>
                                        <input class="myid" type="text" name="sendid" value="${loginUser}" readonly>
                                    </td>
                                </tr>
                                <tr>
                                    <th>주소</th>
                                    <td>
                                        <input class="myaddr" type="text" name="myaddr" value="${user.useraddr}">
                                    </td>
                                </tr>
                                <tr class="pf_img">
                                    <th>프로필 이미지</th>
                                    <td id="file_cont">
                                        <div id="profile_img_filewrap">
                                            <div class="profile_img_file1">
                                                <input type="file" name="file" id="file" style="display:none">
                                                <span id="filename">선택된 파일 없음</span>
                                             </div>
                                             <div class="profile_img_filebtns profile_img_file2">
                                                <a href="javascript:upload()" class="profile_img_fileselect">파일 선택</a>
                                                <a href="javascript:cancelFile()" class="profile_img_filedelete">첨부 삭제</a>
                                             </div>
                                        </div>
                                    </td>
                                </tr>
                                <td colspan="2">
                                    <div class="ms_btn_area">
                                        <button type="submit" class="myInfo_modify_send" onclick="sendit()">수정</button>
                                        <button type="button" class="myInfo_modify_close" onclick="myInfo_modify_closeModal()">닫기</button>
                                    </div>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </form>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    function myInfo_modify_openModal(){
        var modal = document.getElementById('myInfo_modify_editModal');
        modal.style.display = 'block';
    }

    function myInfo_modify_closeModal() {
        var modal = document.getElementById('myInfo_modify_editModal');
        // 모달을 숨깁니다.
        modal.style.display = 'none';
    }
    
    function upload(num){
		$("#file").click();
	}
    
    $("[type=file]").change(function(e) {
		const fileTag = e.target;
		const file = fileTag.files[0];
		
		if(file == undefined){
			cancelFile(fileTag.id.split("e").pop());
		}
		else{
			$("#"+fileTag.id+"name").text(file.name);
			let ext = file.name.split(".").pop();
			if(ext == "jpeg" || ext == "png" || ext == "jpg" || ext == "webp" || ext == "gif"){
				$("."+fileTag.id+"_cont .thumbnail").remove();
				const reader = new FileReader();
				reader.onload = function(ie){
					const img = document.createElement("img");
					img.setAttribute("src",ie.target.result);
					img.setAttribute("class","thumbnail");
					document.querySelector("."+fileTag.id+"_cont").appendChild(img);
				}
				reader.readAsDataURL(file);
			}
			else{
				$("."+fileTag.id+"_cont .thumbnail").remove();
			}
		}
    })
	
    function cancelFile(){
    	const filetext = document.getElementById('filename');
    	
    	filetext.innerHTML = "선택된 파일 없음";
    }
    
</script>
</html>