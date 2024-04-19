<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<link rel="stylesheet" href="${cp}/css/group/grouplist.css">
	<!-- 탑 해더 부분 -->
    <div id="top_wrap">
        <div class="gnb">
            <div class="logo_box">
                <a href="">
                    <div class="logo"></div>
                </a>
            </div>
            <nav class="gnb_menu">
                <ul class="gnb_menu_1">
                    <li>
                        <a href="/myinfo.bo">내모임</a>
                    </li>
                </ul>
                <ul class="gnb_menu_1">
                    <li>
                        <a href="/boardlist.bo">게시판</a>
                    </li>
                </ul>
                <ul class="gnb_menu_1">
                    <li>
                        <a href="/groupList.gr">모임</a>
                    </li>
                </ul>
            </nav>
            <div class="user_gnb">
                <div>
                    <a class="btn" href="${cp}/myinfolist.mc">
                    	<div id="userinfo_gnb">
                    	<img alt="" src="${cp}/images/myinfo_icon.png">
                    	</div>
                    </a>
                    <a class="btn" href="${cp}/getmessage.ms">
                    	<div id="usermsg_gnb">
                    	<img alt="" src="${cp}/images/msg_icon.png">
                    	</div>
                    </a>
                    <a class="btn" href="${cp}/userlogout.us">
                    	<div id="logout_gnb">
                    	<img alt="" src="${cp}/images/logout_icon.png">
                    	</div>
                    </a>
                </div>
            </div>
        </div>
    </div>