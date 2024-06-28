<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.outDiv {
	 text-align:center; 
   border-radius:10px;   
   background: lightgray;
   opacity: 0.5;
   margin: 20px 0px;
   color: black;
   line-height: 30px;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	
	<!-- ============================================================== -->
	<!-- Start Page Content here -->
	<!-- ============================================================== -->
	
	<div class="content-page">
	    <div class="content">
	
	        <!-- Start Content-->
	        <div class="container-fluid">
	
	            <!-- start page title -->
	            <div class="row">
	                <div class="col-12">
	                    <div class="page-title-box page-title-box-alt">
	                        <h4 class="page-title">채팅</h4>
	                        <div class="page-title-right">
	                            <ol class="breadcrumb m-0">
	                                <li class="breadcrumb-item"><a href="${contextPath}">메인</a></li>
	                                <li class="breadcrumb-item"><a href="${contextPath}/room/page">채팅</a></li>
	                            </ol>
	                        </div>
	                    </div>
	                </div>
	            </div>     
	            <!-- end page title --> 
	
	            <div class="row">
	                <!-- start chat users-->
	                <div class="col-xl-3 col-lg-4">
	                    <div class="card">
	                        <div class="card-body">
	
	                            <div class="d-flex align-items-start align-items-start mb-3">
	                                <img src="${ contextPath }<c:out value='${loginUser.profilePath}' default='/resources/images/defaultProfile.png'/>" class="me-2 rounded-circle" height="42" alt="">
	                                <div class="flex-1">
	                                    <h5 class="mt-0 mb-0 font-15">
	                                        <a href="contacts-profile.html" class="text-reset">${loginUser.userName}</a>
	                                    </h5>
	                                    <p class="mt-1 mb-0 text-muted font-14">
	                                        <small class="mdi mdi-circle text-success"></small> Online
	                                    </p>
	                                </div>
	                                <div>
	                                    
	                                </div>
	                            </div>
	
	                            <!-- start search box -->
	                            <form class="search-bar mb-3">
	                                
	                            </form>
	                            <!-- end search box -->
	
	                            <h6 class="font-13 text-muted text-uppercase mb-2">채팅방 목록</h6>
	
	                            <!-- users -->
	                            <div class="row">
	                                <div class="col">
	                                    <div data-simplebar style="max-height: 498px" id="roomlist">
	                                        
	
	
	                                    </div> <!-- end slimscroll-->
	                                </div> <!-- End col -->
	                            </div>
	                            <!-- end users -->
	                        </div> <!-- end card-body-->
	                    </div> <!-- end card-->
	                </div>
	                <!-- end chat users-->
	
	                <!-- chat area -->
	                <div class="col-xl-9 col-lg-8">
	
	                    <div class="card">
	                        <div class="card-body py-2 px-3 border-bottom border-light">
	                            <div class="d-flex py-1">
	                                <img src="${ contextPath }<c:out value='${loginUser.profilePath}' default='/resources/images/defaultProfile.png'/>" class="me-2 rounded-circle" height="36" alt="">
	                                <div class="flex-1">
	                                    <h5 class="mt-0 mb-0 font-15">
	                                        <a href="javascript: void(0);" id="currentName" class="text-reset">${room.roomName}</a>
	                                        <i class="ri-edit-line" id="editRoomName"></i> 
	                                    </h5>
	                                    <p class="mt-1 mb-0 text-muted font-12">
	                                        <small class="mdi mdi-circle text-success"></small> Online
	                                    </p>
	                                </div>
	                                <div class="flex-1">
	                                    <h4 class="mt-0 mb-0 font-15">대화상대 : ${targetName}</h4>
	                                </div>
	                                <div id="tooltip-container">
	                                    <a href="javascript: void(0);" class="text-reset font-19 py-1 px-2 d-inline-block">
	                                        <i class="fe-trash-2" id="out" data-bs-container="#tooltip-container" data-bs-toggle="tooltip" data-bs-placement="top" title="Delete Chat"></i>
	                                    </a>
	                                </div>
	                            </div>
	                        </div>
	                        <div class="card-body"> <!-- 채팅영역 -->
	                            <ul class="conversation-list chat-app-conversation chat-area"  style="max-height: 460px; overflow-y: auto;">
	                                <c:forEach var="m" items="${messages}" > 
	                                	<c:choose>
	                                		<c:when test="${m.type eq 'OUT' }">
	                                			<div class="outDiv">${m.message}</div>
	                                		</c:when>
	                                		<c:otherwise>
	                                			<!-- 기존 채팅 내력불러오기 -->
			                                	<c:choose>
			                                		<c:when test="${m.userId eq loginUser.userId }">
			                                			<li class="clearfix odd" >
			                                		</c:when>
			                                		<c:otherwise>
			                                			<li class="clearfix">
			                                		</c:otherwise>
			                                	</c:choose>
			                                    <div class="chat-avatar">
			                                        <img src="${ contextPath }<c:out value='${m.profilePath}' default='/resources/images/defaultProfile.png'/>" class="rounded" />
			                                        <i>${m.sendTime}</i>
			                                    </div>
			                                    <div class="conversation-text">
			                                    	<c:choose>
					                                		<c:when test="${m.userId eq loginUser.userId }">
					                                			<div class="ctext-wrap" style="background-color: lightyellow;">
					                                		</c:when>
					                                		<c:otherwise>
					                                			<div class="ctext-wrap">
					                                		</c:otherwise>
					                                	</c:choose>
			                                            <i>${m.writer}</i>
			                                            <p>
			                                                ${m.message}
			                                            </p>
			                                        </div>
			                                    </div>
				                                </li>
			                                </c:otherwise>
		                                </c:choose>
	                                </c:forEach>
	                                
	                            </ul>
	
	                            <div class="row">
	                                <div class="col">
	                                    <div class="mt-2 bg-light p-3 rounded">
	                                        <form class="needs-validation" novalidate="" name="chat-form"
	                                            id="chat-form" onsubmit="return false;" >
	                                            <div class="row">
	                                                <div class="col mb-2 mb-sm-0">
	                                                    <input type="text" class="form-control border-0" id="message" placeholder="Enter your text" required>
	                                                    <div class="invalid-feedback mt-2">
	                                                        Please enter your messsage
	                                                    </div>
	                                                </div>
	                                                <div class="col-sm-auto">
	                                                    <div class="btn-group">
	                                                        <div class="d-grid">
	                                                            <button id="send" type="button" class="btn btn-success chat-send" ><i class='fe-send'></i></button>
	                                                        </div>
	                                                    </div>
	                                                </div> <!-- end col -->
	                                            </div> <!-- end row-->
	                                        </form>
	                                    </div> 
	                                </div> <!-- end col-->
	                            </div>
	                            <!-- end row -->
	                        </div> <!-- end card-body -->
	                    </div> <!-- end card -->
	                </div>
	                <!-- end chat area-->
	
	            </div> <!-- end row-->
	            
	        </div> <!-- container -->
	
	    </div> <!-- content -->
	
	</div>
	
	<!-- ============================================================== -->
	<!-- End Page content -->
	<!-- ============================================================== -->
	
	
	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	
  <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
	<script>
		$(function(){
	  	  $.ajax({
	  		  url:"${contextPath}/room/list",
	  		  success:function(list){
	  			  console.log(list);
	  			  let alist = "";
	  			  
	  			  for(let i=0; i<list.length; i++){
	  				  if(list[i].userId == "${loginUser.userId}" && list[i].status =="Y"){
	  					  if(list[i].roomId =="${room.roomId}"){
	  							alist += '<a id="currentRoom" href="${contextPath}/room/' + list[i].roomId +'"' + ' class="btn btn-outline-info rounded-pill"' + 'style="color: #4A55A2; border: none;">' + list[i].roomName + '</a><br>'  
	  					  }else{
	  							alist += '<a href="${contextPath}/room/' + list[i].roomId +'"' + ' class="btn btn-outline-info rounded-pill"' + 'style="color: #4A55A2; border: none;">' + list[i].roomName + '</a><br>'
	  					  }
	  				  }
	  			  }
	  			  
	  			  $("#roomlist").html(alist);
	  			  
	  		  }
	  	   
	  	  })
	  	  
	    })
		const $chatArea = $(".chat-area");
		var now = new Date();
		var hours = now.getHours().toString().padStart(2, '0');
    var minutes = now.getMinutes().toString().padStart(2, '0');
    var currentTime = hours + ":" + minutes;
    
	    
    const sock = new SockJS("${contextPath}/chat");  
    const stomp = Stomp.over(sock);
    stomp.connect({}, function(frame){
      console.log("STOMP Connection");
      //이아래 부터 메시지 온거 처리하는 구문
      stomp.subscribe("/sub/chat/room/${room.roomId}", function(chat){
    	  var content = JSON.parse(chat.body);
    	  console.log("writer", content.writer);
    	  console.log("message", content.message);
    	  var writer = content.writer;
        console.log(content);
       	//퇴장메시지일경우 실행
				if(content.type =="OUT"){
					let $outDiv = $("<div>");
					$outDiv.addClass("outDiv").text(content.message);
					
					$chatArea.append($outDiv);
				}else{
         
         let $chatLi = $("<li>"); // 채팅창에 append시킬 요소 
      		// <div> 요소를 생성하고 클래스 설정
         let $chatAvatarDiv = $("<div>").addClass("chat-avatar");
				 let $conversationTextDiv = $("<div>").addClass("conversation-text");
				
         if(content.userId === "${loginUser.userId}"){
					$chatLi.addClass("clearfix odd");
         }
         else{
       	  $chatLi.addClass("clearfix");  
         }
			  // 내가보낸메세지든 상대방이보내메세지든 공통적으로 만들어야되는 요소작업
				
				
			
				// <img> 요소를 생성하고 속성 설정
				let $avatarImg = $("<img>").attr({
				    src: "${contextPath}/resources/images/defaultProfile.png",
				    alt: "test",
				    class: "rounded"
				}).on('error', function() {
					if ($(this).attr('src') !== '${contextPath}/resources/images/defaultProfile.png') {
				        // 기본 이미지를 설정할 때만 에러 핸들러 실행
				        $(this).attr('src', '${contextPath}/resources/images/defaultProfile.png');
				    }
				});
			
				// <i> 요소를 생성하고 텍스트 설정
				let $timeIcon = $("<i>").text(content.sendTime);
			
				// 생성한 <img>와 <i> 요소를 <div>에 추가
				$chatAvatarDiv.append($avatarImg).append($timeIcon);
				
				// <div> 요소를 <div class="ctext-wrap">로 구성
				let $ctextWrapDiv = $("<div>").addClass("ctext-wrap");
				//내가보낸 메시지면 배경색 변경
				if(content.userId === "${loginUser.userId}"){
					$ctextWrapDiv.css("background-color", "lightyellow");
         }
				
				let $ctextWrapName = $("<i>").text(content.writer);
				let $ctextWrapMessage = $("<p>").text(content.message);
			
				// <ctext-wrap> 내부에 요소 추가
				$ctextWrapDiv.append($ctextWrapName).append($ctextWrapMessage);
				
				// <conversation-text> 내부에 ctext-wrap 요소 추가
				$conversationTextDiv.append($ctextWrapDiv);
				//메시지 삭제기능빼서 드롭다운 버튼 구문 뺐음
			
				// <li> 요소에 구성된 <div> 요소들을 추가
				$chatLi.append($chatAvatarDiv).append($conversationTextDiv);
				
				$chatArea.append($chatLi);
				$chatArea.scrollTop($chatArea[0].scrollHeight);
         
         //$("#chat-area").append(str);
				}
      })
      
      //stomp.send("/pub/chat/enter", {}, JSON.stringify({roomId:"${room.roomId}", writer:"${loginUser.userName}",userId:"${loginUser.userId}"}))
    })
    
    $("#message").keydown(function(event){
    	if (event.keyCode === 13) {
    		stomp.send("/pub/chat/message", {}, JSON.stringify({roomId:"${room.roomId}", writer:"${loginUser.userName}",userId:"${loginUser.userId}",sendTime:currentTime,type:"MESSAGE" ,message:$("#message").val()}))
    		$("#message").val('')
    	}
    })
    
    $("#send").click(function(){
    	stomp.send("/pub/chat/message", {}, JSON.stringify({roomId:"${room.roomId}", writer:"${loginUser.userName}",userId:"${loginUser.userId}",sendTime:currentTime,type:"MESSAGE" ,message:$("#message").val()}))
    	$("#message").val('')
    })
  	
    $("#out").click(function(){
    	stomp.send("/pub/chat/out", {}, JSON.stringify({roomId:"${room.roomId}", writer:"${loginUser.userName}",userId:"${loginUser.userId}",sendTime:currentTime,type:"OUT"}))
    	location.href="${contextPath}/room/page";
    })
		
		$("#editRoomName").click(function(){
			var newName = prompt("새로운 이름을 입력하세요:");
			if(newName){
				$("#currentName").text(newName);
				$.ajax({
					url : '${contextPath}/room/update.name',
					type : 'post',
					data : {newName : newName, roomId : "${room.roomId}",userId : "${loginUser.userId}"}, 
					success: function(response) {
			        alert("방 이름이 성공적으로 업데이트되었습니다.");
			    },
			    error: function(error) {
			        alert("방 이름 업데이트 중 오류가 발생했습니다.");
			    }
				})
			}
			$("#currentRoom").text(newName);
		})
		
		
		
	</script>
</body>
</html>