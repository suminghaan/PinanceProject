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
	                        <h4 class="page-title">Chat</h4>
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
	            
	            <!-- 채팅방 생성용 모달 -->
              <div id="standard-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
                  <div class="modal-dialog">
                      <div class="modal-content">
                          <div class="modal-header">
                              <h4 class="modal-title" id="standard-modalLabel" data-bs-toggle="modal" data-bs-target="#standard-modal">채팅방 추가</h4>
                              <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                          </div>
                          <div class="mb-2">
                              <div class="row row-cols-lg-auto g-2 align-items-center">
                                  <div class="col-12">
                                      <div style="display: none">
                                          <select id="demo-foo-filter-status" class="form-select form-select-sm">
                                              <option value="">Show all</option>
                                              <option value="사용">사용</option>
                                              <option value="대기">대기</option>
                                          </select>
                                      </div>
                                  </div>

                                  <div class="col-1">
                                      <input id="demo-foo-search" type="text" placeholder="Search" class="form-control form-control-sm" autocomplete="on">
                                  </div>
                              </div>
                          </div>
                          
                          <div class="modal-body table-responsive" id="memberList" style="overflow-y: auto;">
                          	<table id="demo-foo-filtering" class="table table-bordered toggle-circle mb-0" data-page-size="7">
                              <thead>
                              <tr>
                                  <th data-toggle="true">아이디</th>
                                  <th>멤버이름</th>
                              </tr>
                              </thead>
                              <tbody id="memberSelect">
                              	<c:forEach var="member" items="${memberList}">
                              		<c:if test="${member.userId ne loginUser.userId}">
	                              		<tr >
	                              			<td class="memberId">${member.userId}</td>
	                              			<td class="memberName">${member.userName}</td>
	                              			<td>
	                              				<button id="addMember" class="btn btn-outline-info rounded-pill" style="color: #4A55A2; border: 1px solid #4A55A2;">추가</button>
	                              			</td>
	                              		</tr>
                              		</c:if>
                              	</c:forEach>
                              </tbody>
                              <tfoot>
                              <tr class="active">
                                  <td colspan="3">
                                      <div>
                                          <ul class="pagination pagination-rounded justify-content-end footable-pagination mb-0"></ul>
                                      </div>
                                  </td>
                              </tr>
                              </tfoot>
                          </table>
                          </div>
                          <div class="mb-2 row">
                            <label class="col-md-2 col-form-label" for="simpleinput">방이름</label>
                            <div class="col-md-10">
                                <input type="text" id="roomName"  class="form-control">
                            </div>
                          </div>
                          <div class="mb-2 row">
                            <label class="col-md-2 col-form-label" for="simpleinput">대상회원</label>
                            <div class="col-md-10">
                                <input type="text" id="targetName"  class="form-control" disabled>
                                <input type="hidden" id="targetId" name="targetId" class="form-control">
                            </div>
                          </div>
                          
                          <div class="modal-footer">
                              <button type="button" class="btn btn-light" data-bs-dismiss="modal">취소</button>
                              <button type="button" id="createRoom" class="btn btn-primary" onclick="notiEnterChat();">채팅방 생성</button>
                          </div>
                      </div><!-- /.modal-content -->
                  </div><!-- /.modal-dialog -->
              </div><!-- /.modal -->
	            
	
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
	                                        <button type="button" class="btn btn-outline-info rounded-pill" style="color: #4A55A2; border: 1px solid #4A55A2;" data-bs-toggle="modal" data-bs-target="#standard-modal">채팅방 생성</button>
	                                    </h5>
	                                </div>
	                                
	                            </div>
	                        </div>
	                        <div class="card-body"> <!-- 채팅영역 -->
	                            <ul class="conversation-list chat-app-conversation chat-area" data-simplebar style="max-height: 460px; overflow-y: auto;">
	                                
	                            </ul>
	
	                            <div class="row">
	                                <div class="col">
	                                    <div class="mt-2 bg-light p-3 rounded">
	                                        <form class="needs-validation" novalidate="" name="chat-form"
	                                            id="chat-form">
	                                            <div class="row">
	                                                <div class="col mb-2 mb-sm-0">
	                                                    <input type="text" class="form-control border-0" id="message" placeholder="Enter your text" required="">
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
	<script src="${ contextPath }/resources/libs/footable/footable.all.min.js"></script>
  <script src="${ contextPath }/resources/js/pages/foo-tables.init.js"></script>
  <script src="${ contextPath }/resources/js/app.min.js"></script>
  
	<script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script> 
	<script>
	$(function(){
	  	  $.ajax({
	  		  url:"${contextPath}/room/list",
	  		  success:function(list){
	  			  console.log(list);
	  			  let alist = "";
	  			  
	  			  for(let i=0; i<list.length; i++){
	  					if(list[i].userId == "${loginUser.userId}" && list[i].status =="Y"){
	  				  	alist += '<a href="${contextPath}/room/' + list[i].roomId +'"' + ' class="btn btn-outline-info rounded-pill"' + 'style="color: #4A55A2; border: none;">' + list[i].roomName + '</a><br>'
	  				  }
	  			  }
	  			  
	  			  $("#roomlist").html(alist);
	  			  
	  		  }
	  	   
	  	  })
	  	  
	    })	
		
	$("#memberSelect").on("click","#addMember",function(){
		$("#targetName").val('');
		$("#targetId").val('');
		$("#targetName").val($(this).closest("tr").find(".memberName").text()); 
		$("#targetId").val($(this).closest("tr").find(".memberId").text()); 
	})
	
	$("#createRoom").click(function(){
		let targetId =  $("#targetId").val();
		let targetName = $("#targetName").val();
		let roomName =  $("#roomName").val();
		location.href="${contextPath}/room/create.room?targetId=" + targetId + "&userId=${loginUser.userId}&userName=${loginUser.userName}&roomName=" + roomName + "&targetName=" + targetName;
	})
	    
	function notiEnterChat(){
		//내가 초대할 계정
		notification("chatEnter",$("#targetId").val());
		//내 계정
		notification("chatEnter","${loginUser.userId}");
	}
	</script>
</body>
</html>