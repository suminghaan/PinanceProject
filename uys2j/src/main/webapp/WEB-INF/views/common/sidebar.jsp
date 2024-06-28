<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
		function addStarList(menu){
			let sideList = $("#side-menu");
			let menuList =''; 
			if(menu === 'boardList'){
		menuList = '<li class="menu-title board">게시판</li>'
						 + '<li>'
						 + '<a href="#board" data-bs-toggle="collapse" aria-expanded="false" aria-controls="board" class="waves-effect">'
						 + '<i class="mdi mdi-clipboard-text-multiple-outline"></i>'
						 + '<span> 게시판 </span>'
						 + '<span	class="menu-arrow"></span>'
						 + '</a>'
						 + '<div class="collapse" id="board">'
						 + '<ul class="nav-second-level">'
						 + '<c:forEach var="bn" items="${bNo}">'
						 + '<c:if test="${bn.boardType == \'BA001\'}">'
						 + '<li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>'
						 + '</c:if>'
						 + '<c:if test="${bn.boardType == \'BA002\'}">'
						 + '<li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>'
						 + '</c:if>'
						 + '<c:if test="${bn.boardType == \'BG\'}">'
						 + '<li><a href="${contextPath}/board/boardList.do?type=${bn.boardNo}">${bn.boardName}</a></li>'
						 + '</c:if>'
						 + '</c:forEach>'
						 + '</ul>'
						 + '</div>'
						 + '</li>'	
						 + '<c:if test="${loginUser.status eq \'A\' or loginUser.status eq \'G\'}">'
						 + '<li><a href="${contextPath}/board/boardManage.do"><i class="mdi mdi-clipboard-edit-outline"></i><span> 게시판관리 </span></a></li>'
						 + '<li><a href="${contextPath}/board/boardCreate.page"><i class="mdi mdi-clipboard-plus-outline"></i><span> 게시판만들기 </span></a></li>'
						 + '</c:if>';
			} else if (menu === 'attendList'){
		menuList = '<li>'
						 + '<a href="#sidebarAttend" data-bs-toggle="collapse"	aria-expanded="false" aria-controls="sidebarEmail"> '
						 + '<i class="mdi mdi-calendar-account"></i>'
						 + '<span> 근태관리 </span>'
						 + '<span	class="menu-arrow"></span>'
						 + '</a>'
						 + '<div class="collapse" id="sidebarAttend">'
						 + '<ul class="nav-second-level">'
						 + '<li><a href="${contextPath}/attendance/myAttendance.page?no=${loginUser.userNo}">내 근태</a></li>'
						 + '<li><a href="${contextPath}/attendance/vacationInfo.page?no=${loginUser.userNo}">내 휴가정보</a></li>'
						 + '<c:if test="${loginUser.status eq \'A\' or loginUser.status eq \'G\'}">'
						 + '<li><a href="${contextPath}/attendance/attendanceManage.page">직원근태관리</a></li>'
						 + '</c:if>'
						 + '</ul>'
						 + '</div>'
						 + '</li>';
			} else if (menu === 'ecommerceList'){
		menuList = '<li>'
						 + '<a href="#sidebarEcommerce" data-bs-toggle="collapse" aria-expanded="false" aria-controls="sidebarEcommerce">'
						 + '<i class="mdi mdi-file-document-edit-outline"></i>'
					 	 + '<span> 전자결재 </span>'
					 	 + '<span	class="menu-arrow"></span>'
					   + '</a>'
						 + '<div class="collapse" id="sidebarEcommerce">'
						 + '<ul class="nav-second-level">'
						 + '<li><a href="${contextPath}/edoc/uploadApprovalList.page">결재상신함</a></li>'
						 + '<li><a href="${contextPath}/edoc/finishApprovalList.page">결재완료함</a></li>'
						 + '<li><a href="${contextPath}/edoc/approvalList.page">결재대기함</a></li>'
						 + '<c:if test="${loginUser.status eq \'A\' or loginUser.status eq \'G\'}">'
						 + '<li><a href="${contextPath}/sample/sampleList.page">결재양식</a></li>'
						 + '</c:if>'
						 + '<li><a href="${contextPath}/edoc/tempSaveApprovalList.page">임시저장함</a></li>'
						 + '<li><a href="${contextPath}/edoc/myApproval.page">자주쓰는 결재선</a></li>'
						 + '</ul>'
						 + '</div>'
						 + '</li>';
			} else if (menu === 'commuteList'){
		menuList = '<li>'
						 + '<a href="#sidebarCommute" data-bs-toggle="collapse"   aria-expanded="false" aria-controls="sidebarEmail">'
						 + '<i class="mdi mdi-city-variant-outline"></i>'
						 + '<span> 비품/시설관리 </span>'
						 + '<span   class="menu-arrow"></span>'
						 + '</a>'
						 + '<div class="collapse" id="sidebarCommute">'
						 + '<ul class="nav-second-level">'
						 + '<li><a href="${contextPath}/eq/eq.page">비품 관리</a></li>'
						 + '<li><a href="${contextPath}/fac/fac.page">시설 관리</a></li>'
						 + '<c:if test="${loginUser.status eq \'A\' or loginUser.status eq \'G\'}">'
						 + '<li><a href="${contextPath}/fac/fac_stock.page">시설 등록</a></li>'
						 + '</c:if>'
						 + '</ul>'
						 + '</div>'
						 + '</li>';
			} else if (menu === 'scheduleList'){
		menuList = '<li>'
				     + '<a href="${contextPath}/schedule/schedule.page">'
				     + '<i class="mdi mdi-calendar-month"></i>'
				     + '<span> 일정 관리 </span>'
				     + '</a>'
				     + '</li>';
			}
			sideList.append(menuList);
		}
	</script>
	<!-- ========== Left Sidebar Start ========== -->
	<div class="left-side-menu">

		<!-- LOGO -->
		<div class="logo-box">
			<a href="index.html" class="logo logo-dark text-center"> 
				<span	class="logo-sm"> 
					<img src="${contextPath}/resources/images/logo-sm-dark.png"	alt="" height="24"> <!-- <span class="logo-lg-text-light">Minton</span> -->
				</span> 
				<span class="logo-lg"> 
					<img src="${contextPath}/resources/images/logo-dark.png" alt="" height="20"> <!-- <span class="logo-lg-text-light">M</span> -->
				</span>
			</a> 
			<a href="index.html" class="logo logo-light text-center"> 
				<span	class="logo-sm"> 
					<img src="${contextPath}/resources/images/logo-sm.png" alt=""	height="24">
				</span> 
				<span class="logo-lg"> 
					<img src="${contextPath}/resources/images/logo-light.png" alt="" height="20">
				</span>
			</a> 
			<a href="index.html" class="logo logo-light text-center"> 
				<span	class="logo-sm"> 
					<img src="${ contextPath }/resources/images/logo-sm.png" alt=""	height="24">
				</span>
				<span class="logo-lg">
					<img src="${ contextPath }/resources/images/logo-light.png" alt="" height="20">
				</span>
			</a>
		</div>

		<div class="h-100" data-simplebar>
		<c:if test="${ not empty loginUser }">
			<!-- User box -->
			<div class="user-box text-center">
				<img src="${ contextPath }<c:out value='${loginUser.profilePath}' default='/resources/images/defaultProfile.png' />" class="rounded-circle avatar-md">
				<div class="dropdown">
					<a href="#" class="text-reset dropdown-toggle h5 mt-2 mb-1 d-block fw-medium"	data-bs-toggle="dropdown">
						${ loginUser.userName }
					</a>
					<div class="dropdown-menu user-pro-dropdown">
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
							<span>&nbsp;&nbsp;채팅방 입장</span>
						</a>
						
						<!-- item(관리자일 경우)-->
						<c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }">
							<a href="${ contextPath }/member/signup.page" class="dropdown-item notify-item">
								<i class="ri-settings-3-line"></i> 
								<span>&nbsp;&nbsp;사원 추가</span>
							</a>
						</c:if>

						<div class="dropdown-divider"></div>

						<!-- item-->
						<a href="${ contextPath }/member/signout.do" class="dropdown-item notify-item">
							<i class="ri-logout-box-line"></i> <span>&nbsp;로그아웃</span>
						</a>
					</div>
				</div>
				<p class="text-reset">${ loginUser.rank }</p>
			</div>
			<div class="d-flex">
				<button class="btn btn-primary btn-bordered rounded-pill waves-effect col-4 ms-3" onclick="workIn();" ${ attend.workIn == null ? '' : 'disabled' }>${ attend.workIn == null ? '출근' : attend.defaultDto.regTime }</button>
				<button class="btn btn-secondary btn-bordered rounded-pill waves-effect col-4 ms-3" onclick="workOut();" ${ attend.workOut == null ? '' : 'disabled' }>${ attend.workOut == null ? '퇴근' : attend.defaultDto.modTime }</button>
			</div>
		</c:if>
		<br>
			<!--- Sidemenu -->
			<div id="sidebar-menu">

				<ul id="side-menu">
					<li>
						<a href="${ contextPath }" class="waves-effect"> 
							<i class="mdi mdi-home-outline"></i> 
							<span> 홈 </span>
						</a>
					</li>
				<%-- <c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }"> --%>
					<li>
						<a href="${contextPath}/department/departmentList.page">
							<i class="mdi mdi-family-tree"></i>
							<span> 조직도 </span>
						</a>
					</li> 
					<li>
						<a href="#" data-bs-toggle="modal" data-bs-target="#show-menu">
							<i class="mdi mdi-folder-account-outline"></i>
							<span> 메뉴 관리 </span>
						</a>
					</li> 
				<%-- </c:if> --%>
				</ul>
			</div>
			<!-- End Sidebar -->

		</div>
		<!-- Sidebar -left -->

	</div>
	<!-- Left Sidebar End -->
	<div id="show-menu" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
	    <form action="${contextPath}/menu/update.do" method="get">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <h4 class="modal-title">메뉴 관리</h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            <div class="modal-body p-4">
	                <div class="row">
	                    <div class="col-md-12">
	                        <div class="mb-3">
	                        		<div>
		                            <label class="form-label">메뉴 선택</label>
	                        		</div>
	                        		<c:forEach var="menu" items="${ menuList }">
	                        			<c:if test="${menu.menuTop eq 0 }">
			                            <div class="form-check form-switch">
		                                  <input class="form-check-input" type="checkbox" name="menuNo" value="${ menu.menuNo }" id="${menu.menuType}" ${ menu.menuShow eq '1' ? 'checked' : '' }>
		                                  <label class="form-check-label" for="${menu.menuType}">${ menu.menuName }</label>
		                              </div>
		                              <c:if test="${menu.menuShow eq '1'}">
			                              <script>addStarList('${menu.menuType}');</script>
		                              </c:if>
	                        			</c:if>
	                        		</c:forEach>
	                        </div>
	                    </div>
	                </div>
	            </div>
	            <div class="modal-footer">
	                <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">취소</button>
	                <button type="submit" class="btn btn-primary waves-effect waves-light">추가</button>
	            </div>
	        </div>
	    </div>
	    </form>
	</div>
	<!-- /.modal -->
	
	
	<script>
		function workIn(){
			location.href="${ contextPath }/attendance/workIn.do";
			notification("workIn", "${loginUser.userId}");
		}
		
		function workOut(){
			location.href="${ contextPath }/attendance/workOut.do";
			notification("workOut", "${loginUser.userId}");
		}
		
		function notiTest(){
			notification("workOut", "A00002");
		}
	</script>
</body>
</html>