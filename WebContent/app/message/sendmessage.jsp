<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
<style>
    /*모달 팝업 영역 스타일링*/
    .ms_modal {

			
        /* 평소에는 보이지 않도록 */
        display: none; 
        position: fixed;
        justify-content: center;
        top:0;
        left: 0;
        width: 100%;
        height: 100vh;
        overflow: hidden;
        background: rgba(0,0,0,0.5);
        left: 50%;
		top: 50%;
		transform: translate(-50%, -50%);
        z-index:100;
    }
    .ms_modal .ms_modal_popup {
    /*팝업*/
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
        padding: 20px;
        background: #ffffff;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.609);
    }
    .ms_modal .ms_modal_popup .ms_close_btn, .ms_btn_area .ms_send_btn {
        display: block;
        padding: 10px 20px;
        background-color: rgb(253, 202, 6);
        border: none;
        border-radius: 5px;
        font-weight: bolder;
        color: rgb(50, 50, 50);
        cursor: pointer;
        transition: box-shadow 0.2s;
        float: left;
        margin: 10px 30px;
        box-shadow: 0 0 3px rgba(0, 0, 0, 0.359);
    }

    .ms_btn_area .ms_send_btn{
        margin-left: 40px;
    }


    .ms_modal_popup input[type=text], .ms_modal_popup textarea{
        position: relative;
        display: inline-block;
        padding: 5px 15px 5px 10px;
        border:1px solid #ccc;
        width:200px; height:30px; line-height: 30px;
        border-radius: 5px;
        margin-left: 10px;
    }
    .ms_modal_popup textarea {
	resize: none;
    height: 100px;
    line-height: 20px;
    }
    .ms_modal_btn:hover{
        color: #ff6d1d;
        font-weight: bolder;
    }
</style>
<body>
    <div id="index_top_wrap">
        <div class="login">
            <div>
            	<main>
                    <section>
                        <button type="button" class="ms_modal_btn"></button>
                    </section>
                </main>
                <!--모달 팝업-->
                <div class="ms_modal">
                    <div class="ms_modal_popup">
                        <form name="sendmessageForm" method="post" action="${cp}/sendmessage.ms">
                            <table>
                                <tbody>
                                    <tbody>
                                        <tr>
                                            <th>보내는사람</th>
                                            <td>
                                                <input type="text" name="sendid" value="${loginUser}" readonly>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>받는사람</th>
                                            <td>
                                                <c:choose>
                                                	<c:when test="not empty ${gpost.userid}">
		                                                <input class="rcvid" type="text" name="receiveid" value="${gpost.userid}">
                                                	</c:when>
                                                	<c:otherwise>
		                                                <input class="rcvid" type="text" name="receiveid" value="${lpost.userid}">
                                                	</c:otherwise>
                                                </c:choose>
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>내용</th>
                                            <td>
                                                <textarea id="msgcontent" name="msgcontent"></textarea>
                                                <input type="hidden" name="msgcheck" value="0">
                                            </td>
                                        </tr>
                                        <td colspan="2">
                                            <div class="ms_btn_area">
                                                <!-- <input type="submit" value="보내기"> -->
                                                <button type="button" class="ms_send_btn" onclick="sendMSG()">보내기</button>
                                                <button type="button" class="ms_close_btn">닫기</button>
                                            </div>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
    	</div>
    </div>
</body>
<script>
	/* ${cp} 설정이 없다면 해줘야된다 */
	/* const cp = '${cp}'; */
    const ms_modal = document.querySelector('.ms_modal');
    const ms_modalOpen = document.querySelector('.ms_modal_btn');
    const ms_modalClose = document.querySelector('.ms_close_btn');
	 
    
    
    //열기 버튼을 눌렀을 때 모달팝업이 열림
    ms_modalOpen.addEventListener('click',function(){
        //display 속성을 block로 변경
        ms_modal.style.display = 'block';
    });
    //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
    ms_modalClose.addEventListener('click',function(){
    	//display 속성을 none으로 변경
        ms_modal.style.display = 'none';
    });
    
    
    
    function sendMSG(){
    	const xhr = new XMLHttpRequest();
    	const sendid = document.sendmessageForm.sendid;
    	const receiveid = document.sendmessageForm.receiveid;
    	const msgcontent = document.sendmessageForm.msgcontent;
    	const msgcheck = document.sendmessageForm.msgcheck;
    	if(msgcontent.value == ""){
    		alert("내용을 입력하세요!");
    		message.focus();
    		return;
    	}
    	
    	xhr.onreadystatechange = function(){
    		if(xhr.readyState == 4){
    			if(xhr.status == 200){
    				let txt = xhr.responseText.trim();
    				if(txt == "O"){
    					alert("메세지 보내기를 성공했습니다.");
    					receiveid.value = "";
    					msgcontent.value = "";
    				}
    				else{
    					alert("실패하였습니다. 다시 시도해주세요");;
    					receiveid.value = "";
    					msgcontent.value = "";
    				}
    			}
    		}
    	}
    	
    	xhr.open("GET", cp + "/sendmessage.ms?sendid=" + sendid.value + "&receiveid=" + receiveid.value + "&msgcontent=" + msgcontent.value + "&msgcheck=" + msgcheck.value);
    	xhr.send();
    	
    	
    	//display 속성을 none으로 변경
        ms_modal.style.display = 'none';
    }
    

</script>