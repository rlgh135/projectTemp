const result = document.getElementById("result");
//비밀번호 유효성 검사를 위한 배열
let pwTest = [false,false,false,false,false]

function sendit(){
    const joinForm = document.joinForm;

    const userid = joinForm.userid;
    if(userid.value == ""){
    	alert("아이디를 입력하세요!");
    	userid.focus();
    	return;
    }
    if(userid.value.length<5 || userid.value.length>12){
    	alert("아이디는 5자 이상 12자 이하로 입력하세요!");
    	userid.focus();
    	return;
    }
    
    if(result.innerHTML == ""){
    	alert("아이디 중복검사를 진행해주세요!");
    	userid.focus();
    	return;	
    }
    if(result.innerHTML == "중복된 아이디가 있습니다!"){
    	alert("중복체크 통과 후 가입이 가능합니다!");
    	userid.focus();
    	return;
    }
    
    //아래쪽의 pwcheck() 함수를 통해 유효성 검사를 통과했다면 pwTest 배열에는 true값만 존재한다.
    //무언가 실패했다면 false가 포함되어 있으므로, 반복문을 통해 해당 배열을 보며 false값이 있는지 검사
    for(let i=0;i<5;i++){
    	if(!pwTest[i]){
    		alert("비밀번호 확인을 다시하세요!");
    		userpw.value="";
    		userpw.focus();
    		return;
    	}
    }
    const username = joinForm.username;
    const exp_name = /^[가-힣]+$/;
    if(!exp_name.test(username.value)){
    	alert("이름에는 한글만 입력하세요!");
    	username.focus();
    	return false;
    }
    
    const usergender = joinForm.usergender;
    if(!usergender[0].checked && !usergender[1].checked){
    	alert("성별을 선택하세요!");
    	return;
    }
    
    const zipcode = joinForm.zipcode;
    if(zipcode.value == ""){
        alert("주소찾기를 진행해 주세요!");
        findAddr();
        return;
    }
    const addrdetail = joinForm.addrdetail;
    if(addrdetail.value == ""){
        alert("상세주소를 입력해 주세요!");
        addrdetail.focus();
        return;
    }

    if(receive_hobby.length == 0){
    	alert("취미는 적어도 1개 이상 입력해 주세요!");
    	joinForm.hobby.focus();
    	return;
    }
    const hobbyTag = joinForm.userhobby;
    hobbyTag.value = arHobby.join("☆");// "축구\농구\영화";
    

    alert("회원가입에 성공했어요!");
    joinForm.submit();
}
function pwcheck(){
    const userpw = document.joinForm.userpw;
    const userpw_re = document.joinForm.userpw_re;
    //아래쪽에 있는 귀여운 span 태그들 가져오기
    const c = document.querySelectorAll(".pw_check span");
    const suc = document.querySelector(".pw_check");
    //영어 대문자, 영어 소문자, 숫자, 특수문자를 한 글자씩 포함하는지 확인하는 정규식
    const reg = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[~?!@-]).{4,}$/;
    
    if(userpw.value == ""){
    	for(let i=0;i<5;i++){
    		pwTest[i] = false;
    		c[i].classList = "";
    		c[i].style.display = ""; // display를 초기화
    	}
    	return;
    }
    if(!reg.test(userpw.value)){
    	c[0].classList = "pcf";
    	pwTest[0] = false;
    }
    else{
    	c[0].classList = "pct";
    	pwTest[0] = true;
    }
    if(userpw.value.length < 8){
    	c[1].classList = "pcf";
    	pwTest[1] = false;
    }
    else{
    	c[1].classList = "pct";
    	pwTest[1] = true;
    }
    //같은 문자가 네번 연속해서 있는지 검사하는 정규식
    if(/(\w)\1\1\1/.test(userpw.value)){
    	c[2].classList = "pcf";
    	pwTest[2] = false;
    }
    else{
    	c[2].classList = "pct";
    	pwTest[2] = true;
    }
    //[]안의 문자들로 문자열이 이루어져 있는지 검사하는 정규식
    if(!/^[a-zA-Z0-9~?!@-]*$/.test(userpw.value)){
    	c[3].classList = "pcf";
    	pwTest[3] = false;
    }
    else{
    	c[3].classList = "pct";
    	pwTest[3] = true;
    }
    if(userpw.value != userpw_re.value){
    	c[4].classList = "pcf";
    	pwTest[4] = false;
    }
    else{
    	c[4].classList = "pct";
    	pwTest[4] = true;
    }
    
    const previousSuccessText = suc.querySelector('.success-text');
    if (previousSuccessText) {
        previousSuccessText.remove();
    }
    
    for (let i = 0; i < 5; i++) {
        if (pwTest[i]) {
            c[i].style.display = "none";
        } else {
            c[i].style.display = "block"; // span 태그를 보이게 함
        }
    }

    if (pwTest.slice(0, 5).every(valid => valid)) {
        const successText = document.createElement('span');
        successText.textContent = "완벽한 비밀번호예요!";
        successText.classList.add('success-text');
        suc.appendChild(successText);
    }
}
function findAddr() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을 때 실행할 코드를 작성하는 부분.

            // 주소 변수
            var addr = ''; 
            // 참고항목 변수
            var addrgu = ''; 

            // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져옵니다.
            if (data.userSelectedType === 'R') { 
                addr = data.roadAddress;
            } else { 
                addr = data.jibunAddress;
            }

            if(addr !== ''){
            	const parts = addr.split(" ");
            	for (const part of parts) {
            		// '구'로 끝나는 부분을 찾으면 추출합니다.
            		if (part.endsWith('구')) {
            			addrgu = part;
            			break; // '구'를 찾았으므로 루프를 종료합니다.
            		}
            	}
            }
            
            // 건물명이 있고, 공동주택일 경우 추가합니다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
            	addrgu += (addrgu !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만듭니다.
            if(addrgu !== ''){
            	addrgu = addrgu;
            }
           /*// 사용자가 선택한 주소가 도로명 타입일 때 참고항목을 조합합니다.
            if(data.userSelectedType === 'R'){
                // 법정동명이 있을 경우 추가합니다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝납니다.
            } else {
                // 주소가 도로명 타입이 아닐 때는 '없어요'라는 값을 할당합니다.
                addrgu = '없어요';
            }*/
            
            // 조합된 참고항목을 해당 필드에 넣습니다.
            document.getElementById("useraddrgu").value = addrgu;

            // 우편번호와 주소 정보를 해당 필드에 넣습니다.
            document.getElementById('zipcode').value = data.zonecode;
            document.getElementById("useraddr").value = addr;
            
            // 커서를 상세주소 필드로 이동합니다.
            document.getElementById("useraddrdetail").focus();
        }
    }).open();
}


function checkId(){	
	const xhr = new XMLHttpRequest();
	const userid = document.joinForm.userid;
	if(userid.value == ""){
		alert("아이디를 입력하세요!");
		userid.focus();
		return;
	}
	
	xhr.onreadystatechange = function(){
		if(xhr.readyState == 4){
			if(xhr.status == 200){
				let txt = xhr.responseText.trim();
				if(txt == "O"){
					result.innerHTML = "사용할 수 있는 아이디입니다!";
					document.joinForm.userpw.focus();
				}
				else{
					result.innerHTML = "중복된 아이디가 있습니다!";
					userid.value = "";
					userid.focus();
				}
			}
		}
	}
	xhr.open("GET",cp+"/checkidok.us?userid="+userid.value);
	xhr.send();
}














