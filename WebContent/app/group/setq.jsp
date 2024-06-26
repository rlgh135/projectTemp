<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>setq</title>
<link href="${cp}/css/groupinnerstyle.css" rel="stylesheet">
<style>
   .qlorig{
      display: none;
   }
   * 가입 관리 스타일 */
	.gpostListwrap{
	    background-color: rgb(232, 218, 202);
	}
	.qList > p{
	 background-color:  rgba(255, 255, 255,0.2);
	 border-radius: 5px;
	}
	
	/* 편집 가입관리  스타일 */
	.jointxt {
	    font-size: 18px;
	    padding: 10px;
	    border-bottom: 1px solid rgba(51, 39, 29,0.2);
	    margin-bottom: 20px;
	    }
	    .jointxt span > a{
	    width: 40px;
	    display: inline-block;
	    border-radius: 10px;
	    border: 1px solid rgb(51, 39, 29);
	    margin-left: 290px;
	    text-align: center;
	    }
	.qList span{
	    padding: 10px;
	    font-size: 18px;
	}
	.qList > p input[type="button"]{
	    border: 1px solid rgb(51, 39, 29);
	    border-radius: 10px;
	    width: 40px;
	    text-align: center;
	    margin-left: 410px;
	}
	
	
	.questionarea textarea {
	background-color: rgb(232, 218, 202);
	font-size: 20px;
	padding: 8px;
	width: 540px;
	outline: none;
	}
	
	.addbtn  p  a{
	    width: 45px;
	    display: inline-block;
	    background-color: rgba(255, 255, 255,0.4);
	    border-radius: 5px;
	    border: rgb(51, 39, 29);
	    text-align: center;
	    margin-left: 10px;
	}
	.adddone p  a{
	    width: 60px;
	    display: inline-block;
	    background-color: rgba(255, 255, 255,0.4);
	    border-radius: 5px;
	    border: rgb(51, 39, 29);
	    text-align: center;
	    margin-left: 10px;
	    margin: 10px 0px 10px 10px;
	}
	
	.qList p span{
	    margin-right: 10px;
	}
	.deletebtn{
	    border-radius: 5px;
	    border: rgb(51, 39, 29);
	    z-index: 22;
	}
	.gpostListwrap{
		background-color: rgb(232, 218, 202);
	}
	#top_wrap {
	background-color: rgb(232, 218, 202);
	margin-top: 0px !important;
	}
	
</style>
</head>
<body>
   <c:if test="${empty loginUser}">
      <script>
         alert("돌아가");
         location.href = "/";
      </script>
   </c:if>
   <div id="group_inner_wrap">
        <header>
       	 	<jsp:include page="${cp}/app/header.jsp"></jsp:include>
        </header>
        <div class="group-inner contents" id="group_inner_container">
            <div id="groupinfobox" class="infobox">
                <div class="groupimg imgbox">
                    <img src="../../file/groupimg/${thumbnail}" style="background-size: cover; width: 100%; height: auto;">
                </div>
                <div class="groupinfobox-inner">
                    <p id="groupname">${group.groupname}</p>
                    <p id="groupinfo">
                        <span class="gmem">멤버: ${usercnt}</span>
                        <span class="glead">리더: ${group.groupmaster}</span>
                    </p>
               <p>${group.groupcontents}</p>
               <ul class="grouptaglist">
                  <li class="groupaddrinfo circle-list-btn">
                      <a href="#">${group.groupaddr}</a>
                  </li>
                  <li class="groupcategoryinfo circle-list-btn">
                      <a href="">${group.groupcategory}</a>
                  </li> 
                </ul>
                    <div>
                        <div class="group-btn-box btnBox">
                                <input type="button" value="돌아가기" class="joinMoim" onclick="backToMoim(${group.groupnum})">
                        </div>
                    </div>
                </div>
            </div>
                  <div id="gpostsection">
                      <div id="gpost" class="postsection">
                         <div class="gpostListwrap">
                            <form action="/setqok.gp?groupnum=${group.groupnum}" method="post" name="qlistForm">
                               
                                     <div class="jointxt">
                                        <p>${group.groupname}의 가입 양식이에요<span><a href="${cp}/setq.gp?groupnum=${group.groupname}" style="cursor: pointer">편집</a></span></p>
                                        <input type="hidden" name="auto" value="no">
                                        <input type="hidden" name="groupnum" value="${group.groupnum}">
                                    <input type="hidden" name="index" value="${questionlist.size()-1}" id="hiddenidx">
                                     </div>
                                     <ul class="qListWrap" id="qLWrap">
                                    <li class="qList qlorig">
                                            <p>
                                               <span></span><input type="button" value="제거" onclick="deleteQ()" style="cursor: pointer;">
                                            </p>
                                            <div class="questionarea">
                                               <textarea name="questionorig"></textarea>
                                            </div>
                                         </li>
                                     <c:choose>
                                     <c:when test="${not empty questionlist && questionlist.size() != 0}">
                                        <c:forEach var="i" begin="0" end="${questionlist.size() -1}">
                                            
                                            <li class="qList ql${i}">
                                               <p>
                                                  <span>${i+1}번 질문</span><input type="button" value="제거" onclick="deleteQ(${i})" style="cursor: pointer;">
                                               </p>
                                               <div class="questionarea">
                                                  <textarea name="question${i}">${questionlist[i]}</textarea>
                                               </div>
                                            </li>
                                         </c:forEach>
                                     </c:when>
                                     <c:otherwise>
                                        <li class="qList ql0">
                                               <p>
                                                  <span>1번 질문</span><input type="button" value="제거" onclick="deleteQ(0)"class="deletebtn" style="border-radius: 5px;
                                             border: rgb(51, 39, 29); cursor: pointer;">
                                               </p>
                                               <div class="questionarea">
                                                  <textarea name="question0"></textarea>
                                               </div>
                                            </li>
                                     </c:otherwise>
                                     </c:choose>
                                     </ul>
                                     <div class="addbtn">
                                        <p><a href="javascript:addQList()" style="cursor: pointer;">+추가</a></p>
                                     </div>
                                     <div class="adddone">
                                        <p><a href="javascript:sendit(${group.groupnum})" style="cursor: pointer;">등록완료</a></p>
                                     </div>
                                     
                        </form>
                     </div>
                      </div>
                  </div>
        </div>
    </div>
</body>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script>
   const cp = '${cp}';
</script>
<script>
   function backToMoim(groupnum){
      location.href = cp+"/groupinner.gp?groupnum="+groupnum;
   }
   function deleteQ(listindex) {
      let targetnode = document.getElementsByClassName("ql"+listindex)[0];
      targetnode.remove();

      let targetlist = document.getElementById("qLWrap");
      var cnt = targetlist.childElementCount-1;

      const parentnode = document.querySelector("#qLWrap");
      for (let l = 0; l < cnt; l++) {
         const newnode = parentnode.children[l+1];
         newnode.className = 'qList';
         newnode.className += ' ql'+(l);
         newnode.querySelector("span").innerHTML = (l+1)+'번 질문';
         newnode.querySelector("input").setAttribute("onclick", "deleteQ("+l+")");
         newnode.querySelector("textarea").setAttribute("name", "question"+l);
      }

   }
   function addQList() {
      let targetlist = document.getElementById("qLWrap");
      var cnt = targetlist.childElementCount - 1;
      const orgnode = document.getElementsByClassName("qlorig")[0];
      const newnode = orgnode.cloneNode(true);

      newnode.className = 'qList';
      newnode.className += ' ql'+cnt;
      newnode.querySelector("span").innerHTML = (cnt+1)+'번 질문';
      newnode.querySelector("input").setAttribute("onclick", "deleteQ("+cnt+")");
      newnode.querySelector("textarea").setAttribute("name", "question"+cnt);
      newnode.querySelector("textarea").innerHTML="";

      targetlist.appendChild(newnode);
   }
   function sendit(groupnum) {
      let targetlist = document.getElementById("qLWrap");
      var cnt = targetlist.childElementCount;

      let hidx = document.getElementById("hiddenidx");
      hidx.setAttribute("value", (cnt-2));

      let qlistform = document.qlistForm;
      qlistform.submit();
   }
</script>
</html>