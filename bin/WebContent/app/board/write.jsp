<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>write</title>
    <link href="${cp}/css/style.css" rel="stylesheet">
</head>
<body class="write">
    <div id="wrap">
        <div></div>
        <table class="header_area">
            <tbody>
                <tr>
                    <td>
                        <span>${loginUser}님 환영합니다.</span>
                        <a class="btn" href="${cp}/userlogout.us">로그아웃</a>
                    </td>
                </tr>
            </tbody>
        </table>
        <table class="title">
            <tbody>
                <tr>
                    <td>
                        <h3>
                            <img src="${cp}/images/타이틀.png" class="tit_img">
                        </h3>
                    </td>
                </tr>
            </tbody>
        </table>
        <form id="boardForm" method="post" name="boardForm" action="${cp}/boardwriteok.bo">
            <table border="1">
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="boardtitle" maxlength="50" placeholder="제목을 입력하세요">
                    </td>
                </tr>
                <tr>
                    <th>작성자</th>
                    <td>
                        <input type="text" name="userid" maxlength="50" value="${loginUser}" readonly>
                    </td>
                </tr>
                <tr>
                    <th>카테고리</th>
                    <td>
                        <input type="checkbox" id="myCheckbox01" name="myCheckbox" value="#스포츠/레저">
                        <label for="myCheckbox01">스포츠/레저</label>
						<input type="checkbox" id="myCheckbox02" name="myCheckbox" value="#취미">
						<label for="myCheckbox02">취미</label>
						<input type="checkbox" id="myCheckbox03" name="myCheckbox" value="#친목/모임">
						<label for="myCheckbox03">친목/모임</label>
						<input type="checkbox" id="myCheckbox04" name="myCheckbox" value="#음악">
						<label for="myCheckbox04">음악</label>
						<input type="checkbox" id="myCheckbox05" name="myCheckbox" value="#문화/예술">
						<label for="myCheckbox05">문화/예술</label>
						<input type="checkbox" id="myCheckbox06" name="myCheckbox" value="#여행/캠핑">
						<label for="myCheckbox06">여행/캠핑</label>
						<input type="checkbox" id="myCheckbox07" name="myCheckbox" value="#맛집/요리">
						<label for="myCheckbox07">맛집/요리</label>
						<input type="checkbox" id="myCheckbox08" name="myCheckbox" value="#어학/외국어">
						<label for="myCheckbox08">어학/외국어</label>
						<input type="checkbox" id="myCheckbox09" name="myCheckbox" value="#교육/공부">
						<label for="myCheckbox09">교육/공부</label>
						<input type="checkbox" id="myCheckbox10" name="myCheckbox" value="#인문/과학">
						<label for="myCheckbox10">인문/과학</label>
						<input type="checkbox" id="myCheckbox11" name="myCheckbox" value="#종교/봉사">
						<label for="myCheckbox11">종교/봉사</label>
						<input type="checkbox" id="myCheckbox12" name="myCheckbox" value="#반려동물/동물">
						<label for="myCheckbox12">반려동물/동물</label>
						<input type="checkbox" id="myCheckbox"13 name="myCheckbox" value="#자연/귀농">
						<label for="myCheckbox">자연/귀농</label>
						<input type="checkbox" id="myCheckbox14" name="myCheckbox" value="#게임">
						<label for="myCheckbox14">게임</label>
						<input type="checkbox" id="myCheckbox15" name="myCheckbox" value="#IT/컴퓨터">
						<label for="myCheckbox15">IT/컴퓨터</label>
						<input type="checkbox" id="myCheckbox16" name="myCheckbox" value="#팬클럽">
						<label for="myCheckbox16">팬클럽</label>
						<input type="checkbox" id="myCheckbox17" name="myCheckbox" value="#애니메이션">
						<label for="myCheckbox17">애니메이션</label>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea name="boardcontents"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td>
                        <input type="text" name="boardaddr" maxlength="50" placeholder="만날 지역을 입력하세요">
                    </td>
                </tr>
            </table>
        </form>
        <table class="btn_area">
            <tbody>
                <tr>
                    <td>
                        <a class="btn" href="javascript:sendit();">등록</a>
                        <a class="btn" href="${cp}/boardlist.bo?page=${param.page}&keyword=${param.keyword}">목록</a>
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
    window.setTimeout(function(){
        document.querySelector("#wrap>div:nth-child(1)").style.display="none";
    },1200)

    function sendit() {
    const checkboxes = document.getElementsByName("myCheckbox");
    const selectedCategories = [];
    checkboxes.forEach(checkbox => {
        if (checkbox.checked) {
            const hiddenInput = document.createElement('input');
            hiddenInput.setAttribute('type', 'hidden');
            hiddenInput.setAttribute('name', 'selectedCategories');
            hiddenInput.setAttribute('value', checkbox.value);
            document.getElementById("boardForm").appendChild(hiddenInput);
        }
    });
    // 폼 전송
    document.boardForm.submit();
}
</script>
</html>





