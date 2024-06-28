<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">  -->
<!-- -->
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- ------------------------alertify-------------------------------- -->  
  <!-- JavaScript -->
	<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
	
	<!-- CSS -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
	<!-- Default theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
	<!-- Semantic UI theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
	<!-- Bootstrap theme -->
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/bootstrap.min.css"/>
<!-- ----------------------- -->
	<!-- App favicon -->
  <link rel="shortcut icon" href="${ contextPath }/resources/images/favicon.ico">

  <!-- plugin css -->
  <link href="${ contextPath }/resources/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet" type="text/css" />

	<!-- App css -->
	<link href="${ contextPath }/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
	<link href="${ contextPath }/resources/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet" />

	<!-- icons -->
	<link href="${ contextPath }/resources/css/icons.min.css" rel="stylesheet" type="text/css" />

	<!-- Theme Config Js -->
	<script src="${ contextPath }/resources/js/config.js"></script>
		
</head>
<body>
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
	<script>
		// 실시간으로 알람 개수 카운팅해줄 변수
		let notiCount = 0;
		if("${alertMsg}" != ""){// 어떤 메세지 문구가 존재할 경우
			alertify.alert("${alertTitle}", "${alertMsg}", function(){
				if("${historyBackYN}" == "Y"){
					history.back();
				}
			});
		}
		
		const notiSock = new SockJS("${contextPath}/noti"); // * 웹소켓 서버와 연결됨(=> ChatEchoHandler에 재정의해둔 afterConnectionEstablished 메소드가 실행됨)
		notiSock.onmessage = onMessage;
		notiSock.onclose = onClose;
	
		function sendMessage(type, refUser){// 알람 웹소켓으로 전송
			console.log("type",type);
			let data = type + ',' + refUser;
			notiSock.send(data); // * websocket으로 메세지 전달 (=> ChatEchoHandler의 handleMessage 메소드 실행)
		}
	
		// 나에게 메세지가 왔을 때 실행되는 function
		function onMessage(evt){ // evt : 웹소켓에서 클라이언트에게 보내준 데이터
			console.log("evt", evt);
			console.log("evt.data", evt.data); // new TextMessage객체로 보내준 텍스트 메세지
			var notiData = JSON.parse(evt.data);
			console.log("notiData", notiData); // [notificationContent, notificationIcon, refType, refAddress]
			
			if(notiData.refAddress != null){
				notiData.refAddress = "${contextPath}" + notiData.refAddress;
			} else{
				notiData.refAddress = "#";
			}
			
			//실시간 알람 개수
			notiCount++;
			
			//실시간 알람 띄워줄 위치
			$("#notiCount").remove();
			let count = '<span id="notiCount" class="badge bg-danger rounded-circle noti-icon-badge">' + notiCount + '</span>'
			$("#noti").append(count);
			let newNoti = '';
			newNoti += '<a href="' + notiData.refAddress + '"	class="dropdown-item notify-item">'
			 +  '<div class="notify-icon bg-soft-primary text-primary">'
			 +  '<i class="' + notiData.notificationIcon + '"></i>'
			 +  '</div>'
			 +  '<p class="notify-details">' + notiData.notificationContent
			 +  '<small class="text-muted">' + notiData.refType + '</small>'
			 +  '</p>'
			 +  '</a>';
			 
			$(".navbar-custom .simplebar-content").prepend(newNoti);
		}
		
		// 퇴장하기 클릭시 실행되는 function
		function onClose(){
			console.log("알람방 퇴장");
		}
		
		$(document).ready(function(){
			ajaxSelectNoti();
		})
		
		function ajaxSelectNoti(){
			$.ajax({
				url:"${contextPath}/noti/list.do",
				type:"post",
				data:"userId=" + "${loginUser.userId}",
				success:function(result){
					console.log(result);
					if(result.length > 0){
						let curNotiCount = 0;
						
						let list = '';
						
						for(let i = 0; i < result.length; i++){
							if(result[i].status == 'Y'){
								curNotiCount++;
							}
							if(result[i].refAddress == null){
								result[i].refAddress = "#";
							} else {
								result[i].refAddress = "${contextPath}" + result[i].refAddress;
							}
							list += '<a href="' + result[i].refAddress + '"	class="dropdown-item notify-item">'
									 +  '<div class="notify-icon bg-soft-primary text-primary">'
									 +  '<i class="' + result[i].notificationIcon + '"></i>'
									 +  '</div>'
									 +  '<p class="notify-details">' + result[i].notificationContent
									 +  '<small class="text-muted">' + result[i].refType + '</small>'
									 +  '</p>'
									 +  '</a>';
						}
						let count = '<span id="notiCount" class="badge bg-danger rounded-circle noti-icon-badge">' + curNotiCount + '</span>'
						if(curNotiCount > 0){
							$("#noti").append(count);
						}
						$(".navbar-custom .simplebar-content").append(list);
					}
					
				},error:function(){
					console.log("알람 검색 ajax 통신 실패");
				}
			})
			
		}
		
		function ajaxDeleteAll(){
			$.ajax({
				url:"${contextPath}/noti/deleteAll.do",
				type:"post",
				success:function(result){
					console.log(result);
					if(result != null){
						$("#noti").empty;
						$(".simplebar-content").empty;
					}
				},error:function(){
					console.log("알람 검색 ajax 통신 실패");
				}
			})
		}
		
		function ajaxUpdateNoti(){
			$.ajax({
				url:"${contextPath}/noti/update.do",
				type:"post",
				success:function(result){
					console.log(result);
					if(result != null){
						console.log("업데이트 성공");
					}
				},error:function(){
					console.log("알람 검색 ajax 통신 실패");
				}
			})
		}
		
		function ajaxInsertNoti(type, refUser){
			jQuery.ajaxSettings.traditional = true;
			$.ajax({
				url:"${contextPath}/noti/insert.do",
				type:"post",
				data:{
					type:type,
					refUser:refUser
				},
				success:function(result){
					console.log(result);
					if(result != null){
						console.log("insert성공");
					}
				},error:function(){
					console.log("알람 검색 ajax 통신 실패");
				}
			})
		}
		
		//실시간 알람 및 알람테이블 추가 ajax
		function notification(type, refUser){
			ajaxInsertNoti(type, refUser);
			sendMessage(type, refUser);
		}
		
		function notiCountEmpty(){
			notiCount = 0;
			$("#notiCount").remove();
			ajaxUpdateNoti();
		}
	</script>
	<!-- Topbar Start -->
	<div class="navbar-custom">
		<div class="container-fluid">

			<ul class="list-unstyled topnav-menu float-end mb-0">

				<li class="dropdown notification-list topbar-dropdown">
					<a id="noti" class="nav-link dropdown-toggle waves-effect waves-light" data-bs-toggle="dropdown" href="#" role="button" aria-haspopup="false" aria-expanded="false" onclick="notiCountEmpty();"> 
						<i class="fe-bell noti-icon"></i> 
					</a>
					<div class="dropdown-menu dropdown-menu-end dropdown-lg">
						<!-- item-->
						<div class="dropdown-item noti-title">
							<h5 class="m-0">
								<span class="float-end"> <a href="" class="text-dark" onclick="ajaxDeleteAll();">
										<small>모두 지우기</small>
								</a>
								</span>알림
							</h5>
						</div>

						<div id="notiList" class="noti-scroll" data-simplebar>
						</div>
					</div>
				</li>
				<!-- 로그인 전 -->
				<c:choose>
					<c:when test="${ empty loginUser }">
						<li class="dropdown notification-list topbar-dropdown">
							<a class="nav-link dropdown-toggle nav-user me-0 waves-effect waves-light" href="${ contextPath }/member/login.page"> 
								<i class="mdi mdi-account-outline noti-icon" style="width:300px;"></i>
							</a>
						</li>
					</c:when>
					<c:otherwise>
					<!-- 로그인 후 -->
						<li class="dropdown notification-list topbar-dropdown">
							<a class="nav-link dropdown-toggle nav-user me-0 waves-effect waves-light" data-bs-toggle="dropdown" href="#" role="button"	aria-haspopup="false" aria-expanded="false"> 
								<img src="${ contextPath }<c:out value='${loginUser.profilePath}' default='/resources/images/defaultProfile.png'/>" class="rounded-circle avatar-md"> 
								<span class="pro-user-name ms-1">	${ loginUser.userName }
									<i class="mdi mdi-chevron-down"></i>
								</span>
							</a>
							
							<div class="dropdown-menu dropdown-menu-end profile-dropdown ">
								<!-- item-->
								<div class="dropdown-header noti-title">
									<h6 class="text-overflow m-0">${ loginUser.userName }님 안녕하세요.</h6>
								</div>
		
								<!-- item-->
								<a href="${ contextPath }/member/mypage.page" class="dropdown-item notify-item">
									<i class="fe-user me-1"></i> 
									<span>${ loginUser.status == 'A' ? '사원정보관리' : loginUser.status == 'G' ? '사원정보관리' : '마이페이지' }</span>
								</a>
								
								<a href="${ contextPath }/room/page" class="dropdown-item notify-item">
									<i class="mdi mdi-chat-processing"></i> 
									<span>채팅방 입장</span>
								</a>
								
								<!-- item(관리자일 경우)-->
								<c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }">
									<a href="${ contextPath }/member/signup.page" class="dropdown-item notify-item">
										<i class="ri-settings-3-line"></i> 
										<span>사원 추가</span>
									</a>
								</c:if>
		
								<div class="dropdown-divider"></div>
		
								<!-- item-->
								<a href="${ contextPath }/member/signout.do" class="dropdown-item notify-item">
									<i class="ri-logout-box-line"></i> <span>로그아웃</span>
								</a>
		
							</div>
						</li>
					</c:otherwise>
				</c:choose>
			</ul>

			<!-- LOGO -->
			<div class="logo-box">
				<a href="${ contextPath }" class="logo logo-dark text-center"> 
					<span	class="logo-sm"> 
						<img src="${ contextPath }/resources/images/dark-sm-logo.png"	alt="" height="24"> <!-- <span class="logo-lg-text-light">Minton</span> -->
					</span> 
					<span class="logo-lg"> 
						<img src="${ contextPath }/resources/images/dark-logo.png" alt="" height="20"> <!-- <span class="logo-lg-text-light">M</span> -->
					</span>
				</a> 
				<a href="${ contextPath }" class="logo logo-light text-center">
					<span	class="logo-sm"> 
						<img src="${ contextPath }/resources/images/white-sm-logo.png"	alt="" height="24"> <!-- <span class="logo-lg-text-light">Minton</span> -->
					</span>  
					<span class="logo-lg"> 
						<img src="${ contextPath }/resources/images/white-logo.png" alt="" height="30">
					</span>
				</a>
			</div>

			<ul class="list-unstyled topnav-menu topnav-menu-left m-0">
				<li>
					<button class="button-menu-mobile waves-effect waves-light">
						<i class="fe-menu"></i>
					</button>
				</li>

				<li>
					<!-- Mobile menu toggle (Horizontal Layout)--> <a
					class="navbar-toggle nav-link" data-bs-toggle="collapse"
					data-bs-target="#topnav-menu-content">
						<div class="lines">
							<span></span> <span></span> <span></span>
						</div>
				</a> <!-- End mobile menu toggle-->
				</li>

				<li class="dropdown dropdown-mega d-none d-xl-block">
					<a class="nav-link dropdown-toggle waves-effect waves-light" data-bs-toggle="dropdown" href="#" role="button"	aria-haspopup="false" aria-expanded="false"> 
					모든 메뉴 <i class="mdi mdi-chevron-down"></i>
					</a>
					<div class="dropdown-menu dropdown-megamenu">
						<div id="all-menu-list" class="row"> <!-- 테이블에 저장된 메뉴 데이터들 넣을곳 -->
							<div class="col-sm-16">
								<div class="row">
									<div class="col-md-3">
										<h5 class="text-dark mt-0">게시판</h5>
										<ul class="list-unstyled megamenu-list">
											<c:forEach var="bn" items="${bNo}">
										    <c:if test="${bn.boardType == 'BA001'}">
										        <li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>
										    </c:if>
										    <c:if test="${bn.boardType == 'BA002'}">
										        <li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>
										    </c:if>
										    <c:if test="${bn.boardType == 'BG'}">
										        <li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>
										    </c:if>
											</c:forEach>
											<c:if test="${loginUser.status eq 'A' or loginUser.status eq 'G'}">
												<li>
													<a href="${contextPath}/board/boardManage.do">
														<span> 게시판관리 </span>
													</a>
												</li>
												<li>
													<a href="${contextPath}/board/boardCreate.page">
														<span> 게시판만들기 </span>
													</a>
												</li>
											</c:if>
										</ul>
									</div>

									<div class="col-md-3">
										<h5 class="text-dark mt-0">일정</h5>
										<ul class="list-unstyled megamenu-list">
											<li id="scheduleList">
												<a href="${contextPath}/schedule/schedule.page">
													<span> 일정 관리 </span>
												</a>
											</li>
										</ul>
									</div>
									<div class="col-md-3">
										<h5 class="text-dark mt-0">비품/시설관리</h5>
										<ul class="list-unstyled megamenu-list">
											<li><a href="${contextPath}/eq/eq.page">비품 관리</a></li>
											<li><a href="${contextPath}/fac/fac.page">시설 관리</a></li>
											<c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }">
												<li><a href="${contextPath}/fac/fac_stock.page">시설 등록</a></li>
											</c:if>
										</ul>
										</div>
										<div class="col-md-3">
										<h5 class="text-dark mt-0">전자 결재</h5>
										<ul class="list-unstyled megamenu-list">
											<li><a href="${contextPath}/edoc/uploadApprovalList.page">결재상신함</a></li>
											<li><a href="${contextPath}/edoc/finishApprovalList.page">결재완료함</a></li>
											<li><a href="${contextPath}/edoc/approvalList.page">결재대기함</a></li>
											<c:if test="${loginUser.status eq 'A' or loginUser.status eq 'G' }">
												<li><a href="${contextPath}/sample/sampleList.page">결재양식</a></li>
											</c:if>
											<li><a href="${contextPath}/edoc/tempSaveApprovalList.page">임시저장함</a></li>
											<li><a href="${contextPath}/edoc/myApproval.page">자주쓰는 결재선</a></li>
										</ul>
										</div>
										<div class="col-md-3">
										<h5 class="text-dark mt-0">근태</h5>
										<ul class="list-unstyled megamenu-list">
											<li>
												<a href="#sidebarAttend" data-bs-toggle="collapse"	aria-expanded="false" aria-controls="sidebarEmail"> 
														<span> 근태관리 </span>
												</a>
											</li>
											<li><a href="${contextPath}/attendance/myAttendance.page?no=${loginUser.userNo}">내 근태</a></li>
											<li><a href="${contextPath}/attendance/vacationInfo.page?no=${loginUser.userNo}">내 휴가정보</a></li>
											<c:if test="${loginUser.status eq 'A' or loginUser.status eq 'G' }">
												<li><a href="${contextPath}/attendance/attendanceManage.page">직원근태관리</a></li>
											</c:if>
										</ul>
										</div>
									</div>
									</div>
									</div>
									</div>
								</li>
							</ul>
						</div>
					</div>
	<!-- Topbar End -->
	<!-- Right bar overlay-->
	<div class="rightbar-overlay"></div>
</body>
</html>