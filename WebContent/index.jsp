<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="cp" value="${pageContext.request.contextPath}" scope="session"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="${cp}/css/index.css">
</head>
<body>
	<div id="index_top_wrap">
        <div class="gnb">
            <div class="logo_box">
                <a href="">
                    <div class="logo"></div>
                </a>
            </div>
           
            <div class="login">
                <div>
                    <!--모달 팝업-->
                    <div class="modal">
                        <div class="modal_popup">
                            <form action="${cp}/userloginok.us" method="post" name="loginForm">
                                <table>
                                    <tbody>
                                        <tr>
                                            <th>아이디</th>
                                            <td>
                                                <input type="text" name="userid" value="">
                                            </td>
                                        </tr>
                                        <tr>
                                            <th>비밀번호</th>
                                            <td>
                                                <input type="password" name="userpw">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <div class="btn_area">
                                                    <input type="submit" value="로그인">
                                                    <button type="button" class="close_btn">닫기</button>
                                                </div>
                                            </td>
                                        </tr>
                                    </tbody>
                                </table>
                            </form>
                        </div>
                    </div>
                    <!--end 모달 팝업-->
                    <main>
                        <section>
                            <button type="button" class="modal_btn">로그인</button>
                        </section>
                    </main>
                    <a class="joinbtn" href="${cp}/userjoin.us">회원가입</a>
                </div>
            </div>
        </div>
    </div>

    <div id="index_body_wrap">
        <div id="index_body_box">
            <div class="index_box_1">
                <div id="img_box1"></div>
                <p id="content1">더 나은 삶을 만드는<br>공간 <span>"모아"</span></p>
            </div>
            
            <div class="index_box_2">
                <img src="${cp}/images/6111095.jpg">
                <p class="content" id="content3">우리동네<br>소통의 공간</p>

            </div>

            <div class="index_box_2">
                <img src="${cp}/images/27828891_7359867.jpg">
                <p class="content" id="content3">함께할 수 있는<br>모임의 공간</p>
            </div>
        </div>


    </div>

</body>
<footer>
    <a href="#" class="btn_gotop" id="click">
        <img src="${cp}/images/group/top_img.png" > 
    </a>
</footer>
<script>
    const modal = document.querySelector('.modal');
    const modalOpen = document.querySelector('.modal_btn');
    const modalClose = document.querySelector('.close_btn');

    //열기 버튼을 눌렀을 때 모달팝업이 열림
    modalOpen.addEventListener('click',function(){
        //display 속성을 block로 변경
        modal.style.display = 'block';
    });
    //닫기 버튼을 눌렀을 때 모달팝업이 닫힘
    modalClose.addEventListener('click',function(){
    //display 속성을 none으로 변경
        modal.style.display = 'none';
    });



    let observer = new IntersectionObserver((e)=>{
        e.forEach((박스)=>{
            if(박스.isIntersecting){
                박스.target.style.opacity = 1;
            } else{
                박스.target.style.opacity = 0;
            }
        })
    })

    let ib = document.querySelectorAll('.index_box_2')
    observer.observe(ib[0])
    observer.observe(ib[1])

    window.addEventListener('scroll', function(){
        var btn_gotop = document.querySelector('.btn_gotop'); // btn_gotop 요소를 선택
        if(this.scrollY > 200) {
            btn_gotop.style.display = 'block'; // 스크롤 위치에 따라 보이게 설정
        }
        else{
            btn_gotop.style.display = 'none'; // 스크롤 위치에 따라 숨김
        }
    })

    var Top = document.getElementById('click'); // click 요소를 선택
    Top.addEventListener('click', function(e){
        e.preventDefault();

        window.scrollTo({top:0, behavior:"smooth"})
    })
</script>
</html>