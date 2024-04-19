const arHobby = [];


function createHobby(){
	window.open("../app/user/hobby.jsp", "취미", "width=400,height=300,left=100,top=50");
}

function sendCategoryId(categoryId) {
    window.opener.document.getElementById("receive_hobby").value = categoryId;
    window.close();
}
function addHobby(){
	const joinForm = document.joinForm;
	const hobby_list = document.getElementsByClassName("hobby_list")[0];
	const receive_hobby = joinForm.receive_hobby;
	
	if(receive_hobby.value == ""){
		alert("취미를 입력해 주세요!");
		receive_hobby.focus();
		return;
	}
	if(arHobby.indexOf(receive_hobby.value) != -1){
		alert("중복된 취미입니다!");
		receive_hobby.focus();
		receive_hobby.value="";
		return;
	}
	if(arHobby.length == 3){
		alert("취미는 3개 이하로 입력해주세요!");
		return;
	}
	
	//span 태그 노드 생성
	const inputHobby = document.createElement("span");
	//span 태그 노드 클래스 값으로 userhobby
	inputHobby.classList = "userhobby";
	//span 태그 노드 name 값으로 userhobby
	inputHobby.name = "userhobby";
	//span 태그 노드 내부 내용으로 입력한 취미 문자열 설정
	inputHobby.innerHTML = receive_hobby.value;
	//취미 목록 배열에 입력한 취미 문자열 추가
	arHobby.push(receive_hobby.value);
	
	//a태그 노드 생성
	const xBox = document.createElement("a");
	//디자인을 위한 클래스 설정
	xBox.classList = "xBox";
	//위에서 만든 span 태그의 자식으로 xBox 추가
	inputHobby.appendChild(xBox);
	//추가되어 있는 span태그 클릭 시 취미를 지워주기 위한 이벤트 설정
	inputHobby.addEventListener('click',deleteHobby);
	//아래쪽의 취미 목록을 보여줄 div의 자식으로 span태그 추가
	hobby_list.appendChild(inputHobby);
	
	hobby.value = "";
	hobby.focus();
	
}

function deleteHobby(e){
	let deleteNode = null;
	if(e.target.classList == "xBox"){
		deleteNode = e.target.parentNode;
	}
	else{
		deleteNode = e.target;
	}
	
	let txt = deleteNode.innerText;
	console.log(txt);
	for(let i in arHobby){
		if(arHobby[i] == txt){
			arHobby.splice(i,1);
			break;
		}
	}
	
	deleteNode.remove();
}

//function sendHobby() {
//    var hobbyValue = document.getElementById("receive_hobby").value;
//    // Do something with the hobbyValue...
//    console.log("사용자가 선택한 취미:", hobbyValue);
//}