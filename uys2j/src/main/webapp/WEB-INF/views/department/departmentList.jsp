<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<!-- Treeview css -->
  <link href="${ contextPath }/resources/libs/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<style>
	 #profileImg{
	    width:56px;
	    height:56px;
	    /* border:1px solid lightgray;
	    border-radius: 50%; */
	} 
	.dlist{
		height:250px;
		display: flex;
	    justify-content: center;
	    align-items: center;
	}
	.col-sm-9{
		margin-bottom: -3px;
	}
	.smallfont{font-size:0.8em;}
	.nocheck{display:block;}
	.usable{color:green;}
	.unusable{color:red;}
</style>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	<div class="content-page">
	  <div class="content">
	
	      <!-- Start Content-->
	      <div class="container-fluid">
	          
	          <!-- start page title -->
	          <div class="row">
	              <div class="col-12">
	                  <div class="page-title-box page-title-box-alt">
	                      <h4 class="page-title">조직도</h4>
	                      <div class="page-title-right">
	                          <ol class="breadcrumb m-0">
	                              <li class="breadcrumb-item"><a href="javascript: void(0);">PiNANCE</a></li>
	                              <li class="breadcrumb-item"><a href="javascript: void(0);">조직도</a></li>
	                          </ol>
	                      </div>
	                  </div>
	              </div>
	          </div>     
	          <!-- end page title -->
	          <div class="row">
	              <div class="col-xl-4">
	                  <div class="card">
	                  <div class="card-body">
	                      <h4 class="header-title mb-3">조직도</h4>
	                      <div class="d-flex mb-3">
	                      	<c:if test="${ loginUser.status == 'A' || loginUser.status == 'G' }">
	                          <button type="button" class="btn btn-secondary waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#create-modal">+</button>
	                          <button type="button" class="btn btn-danger waves-effect waves-light ms-1" data-bs-toggle="modal" data-bs-target="#delete-modal" onclick="$('#delDeptVal').val(''); $('#deptCodeResult').text('');">-</button>
	                      	</c:if>
	                          <form  class="search-bar ms-5">
	                              <div class="position-relative">
	                                  <input type="text" id="searchKey" class="form-control keyword"  placeholder="검색">
	                                  <span class="mdi mdi-magnify" onclick="search();"></span>
	                              </div>
	                          </form>
	                      </div>
	                      <div id="dragTree">
	                          
	                      </div>
	                  </div>
	                  </div> <!-- end card -->
	              </div> <!-- end col-->
	              <script>
				    var nodeId;
				    var dept_st_value = null;
						function search(){
							$('#dragTree').jstree(true).search($("#searchKey").val());
						}
				    // 부서 리스트를 가져오고 jstree를 초기화하는 함수
				    function initDeptTree() {
				        $.ajax({
				            url: "${contextPath}/department/deptList.do",
				            type: "get",
				            dataType: 'JSON',
				            success: function(data) {
				                var deptlist = new Array();
				                $.each(data, function(idx, item) {
				                    deptlist[idx] = {
				                        id: item.deptValue, //사원id
				                        parent: item.deptUpstair, //부서id
				                        parentName: item.upstairName, // 상위부서명
				                        childrenName: item.childName, // 하위부서명
				                        text: item.commonName, //사원명
				                        status: item.status, // 멤버상태
				                        regTime: item.defaultDto.regTime, // 생성일자
				                        state: { opened: item.deptValue == 'KB001' }
				                    	
				                    };
				                });
								
				                $('#dragTree').jstree('destroy');
				                var plugins = ['types', 'sort', 'search'];
				                if('${loginUser.status}' == 'A' || '${loginUser.status}' == 'G') {
				                    plugins.push('dnd');
				                }
				                $('#dragTree').jstree({
				                    'plugins': plugins,
				                    'core': {
				                        'data': deptlist,
				                        'check_callback': function (operation, node, node_parent, node_position, more) {
											window.v_node = node;
											window.v_node_parent = node_parent;
											window.dup = false;

											if ( operation === 'move_node') {
												deptlist.forEach(function(item, index) {
													if (window.v_node_parent.id == item.parent && window.v_node.text == item.text){
														window.dup = true;
														return false;
													}
												});
												return !(window.dup);
											} else {
												return false;
											}
										}
				                    },
				                    'types': {
				                        'default': {
				                            'icon': 'fa-solid fa-book-open-reader'
				                        }
				                    },
				                    'search' :{
				                    	 "show_only_matches" : true,
				                    	 "show_only_matches_children" : true,
				                    }
				                 
				                }).bind("select_node.jstree", function(e, data) {
									$('#dept_name').text(data.node.text);
									$('#dept_id').text(data.node.id);
									$('#dept_st').val(data.node.parent);
									$('#dept_regTime').text(data.node.original.regTime);
									if(data.node.parent != '#'){
										$('.heidept').text(data.node.original.parentName);
									}else{
										$('.heidept').text("미지정");
									}
									$('.lowdept').text(data.node.original.childrenName == null ? "미지정" : data.node.original.childrenName);
									
                                   	if(data.node.original.status == "Y" || data.node.original.status == "A" || data.node.original.status == "G"){
										$('.deptStatus').text("재직");                     		
									}else if(data.node.original.status == "H"){
										$('.deptStatus').text("휴직");
									}else if(data.node.original.status == "B"){
										$('.deptStatus').text("병가");
									}else{
										$('.deptStatus').text("");
									}
									
				                    var upstair = data.node.parent;
				                    memberList();
				                }).bind("move_node.jstree", function(event, data) {
				                    // 서버에 업데이트 요청 보내기
				                    $.ajax({
				                        url: "${contextPath}/department/update.do",
				                        type: "post",
				                        data: { nodeId: data.node.id,
				                        		parentId: data.node.parent },
				                        success: function(response) {
											console.log(response);
				                        	if(response == 1){
				                        		
				                        	} else{
				                        		alert("코드가 중복되어 이동 실패")
				                        	}
				                        	
				                        	console.log("response : " + response);
				                            console.log("Node updated successfully" + response);
				                        },error: function(){
				                        	console.log("업데이트 실패");
				                        }
				                    });
				                });
				                 $('#searchKey').on('input', function () {
				                    var v = $(this).val();
				                    $('#dragTree').jstree(true).search(v);
				                  });
				                
				            }
				        });
				    }
				    $(document).ready(function() {
				        initDeptTree(); // 초기화 함수 호출
				    });
				</script>
	              
	              <div class="col-xl-8">
	                  <div class="card">
	                      <div class="card-body">
	                          <h4 class="header-title mb-4">조회</h4>
	                          <div class="d-flex justify-content-end">
	                          	<c:if test="${ loginUser.status == 'A' || loginUser.status == 'G' }">
	                          	
	                              <a href="${ contextPath }/member/signup.page" class="btn btn-outline-secondary waves-effect waves-light">
	                                  <span class="btn-label"><i class="fas fa-plus"></i></span>신규 부서원 생성
	                              </a>
	                              <button type="button" class="btn btn-outline-secondary waves-effect waves-light ms-2" data-bs-toggle="modal" data-bs-target="#emptyDept-modal">
	                                  <span class="btn-label"><i class="mdi mdi-account-question"></i></span>부서 미지정 멤버
	                                  <c:if test="${not empty count}">
		                                  <span	class="badge bg-danger rounded-circle noti-icon-badge">${ count }</span>
	                                  </c:if>
	                              </button>
                              	</c:if>
	                          </div>
	                          <ul class="nav nav-tabs nav-bordered">
	                              <li class="nav-item">
	                                  <a href="#home-b1" data-bs-toggle="tab" aria-expanded="true" class="nav-link active">
	                                      <span class="d-inline-block d-sm-none"><i class="mdi mdi-home-variant"></i></span>
	                                      <span class="d-none d-sm-inline-block">상세조회</span>
	                                  </a>
	                              </li>
	                              <li class="nav-item">
	                                  <a href="#profile-b1" data-bs-toggle="tab" aria-expanded="false" class="nav-link">
	                                      <span class="d-inline-block d-sm-none"><i class="mdi mdi-account"></i></span>
	                                      <span class="d-none d-sm-inline-block">부서원 목록</span>
	                                  </a>
	                              </li>
	                          </ul>
	                          
	                          <div class="tab-content" style="margin: 1%;">
                               	  <input id="dept_st" type="hidden">
	                              <div class="tab-pane show active" id="home-b1">
	                                  <dl class="row mb-0 dlist" style="margin-top: -20px;">
	                                      <dt class="col-sm-3">부서명/이름</dt>
	                                      <dd id="dept_name" class="col-sm-9"></dd>
							
	                                      <dt class="col-sm-3">코드/사번</dt>
	                                      <dd id="dept_id" class="col-sm-9"></dd>
	
	                                      <dt class="col-sm-3">생성일/입사일</dt>
	                                      <dd id="dept_regTime" class="col-sm-9"></dd>
	
	                                      <dt class="col-sm-3">상위 부서</dt>
	                                      <dd class="col-sm-9">
	                                          <div class="heidept"></div>
	                                      </dd>
	
	                                      <dt class="col-sm-3">하위 부서</dt>
	                                      <dd class="col-sm-9">
	                                          <div class="lowdept"></div>
	                                      </dd>
	                                      
	                                      <dt class="col-sm-3">재직현황</dt>
	                                      <dd class="col-sm-9">
	                                          <div class="deptStatus"></div>
	                                      </dd>
	                                     
	                                  </dl>
	                              </div>
                              
	                              <div class="tab-pane" id="profile-b1">
	                                  <div class="align-items-start meml"></div>
	                              </div>
	                              
	                              <script>
		                          	function memberList(){
		                          		var dept_st_value;
		                          		if ($("#dept_st").val() == '#') {
	                          				return;
		                          		}else if ($("#dept_st").val().charAt(2) == '0') {
		                                    dept_st_value = $("#dept_id").text();  
		                                } else {
		                                    dept_st_value = $("#dept_st").val(); // 클릭할 때마다 dept_st 값 가져오기
		                                }
		                              	$.ajax({
		                              		url: "${contextPath}/department/memberList.do",
		         				            type: "post",
		         				           data: { dept: dept_st_value },
		         				            dataType: 'JSON',
		         				            success: function(result) {
		         				            	console.log(result);
		         				            	let answer = ""; // 초기화
		         				               if (result.length == 0) {
		         				            	  answer = '<div class="d-flex">'
		         				            		 	 + '</div>'
		         				            	   // answer = ""; // 비어있을 때 값을 초기화
		         								} else {
			         				            	for(let i = 0; i < result.length; i++){
			         				            		if('${loginUser.status}' == 'A' || '${loginUser.status}' == 'G') {
			         				            			answer += '<a href="${contextPath}/member/mypage.page?userId=' + result[i].userId +'">'
			         				            		}else{
			         				            			answer += '<div>'
			         				            		}
			         				            		answer += '<div class="d-flex">'
			         				            			+ '<div class="avatar-md me-3">'
			         				            			+ '<img id="profileImg" src="${contextPath}' + (result[i].profilePath ? result[i].profilePath : '/resources/images/defaultProfile.png') + '">' 
				                                          	+ '</div>'
				                                          	+ '<div class="flex-1">'
				                                          	+ '<h5 class="my-1 text-dark">' + result[i].rank + '</h5>'
				                                          	+ '<p class="text-muted mb-0">'
				                                          	+ '<i class="mdi mdi-account me-1"></i>' + result[i].userName + '</p>'
				                                          	+ '</div>'
				                                          	+ '</div>'
			                                          	if('${loginUser.status}' == 'A' || '${loginUser.status}' == 'G') {
			                                          		answer += '</a><br><br>'
			         				            		}else{
			         				            			answer += '</div><br><br>'
			         				            		}
			         				            	}
		         								}
			                                    $(".meml").html(answer);
		         				            }
		                              	})
		                              }
	                              
	                              </script>
	                          </div>
	                      </div>
	                  </div> <!-- end card -->
	              </div> <!-- end col -->
	              </div>
	          </div>
	          <!-- end row -->
	      </div> <!-- container -->
	
	  </div> <!-- content -->
	
	  <div id="create-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
	      <div class="modal-dialog">
	          <div class="modal-content">
	          
	          	<form action="${contextPath}/department/insert.do" id="addForm" method="post">
	              <div class="modal-header">
	                  <h4 class="modal-title">조직도 추가</h4>
	                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	              </div>
	              <div class="modal-body p-4">
	                  <div class="row">
	                      <div class="col-md-12">
	                          <div class="mb-3">
	                              <label for="commonName" class="form-label">조직명</label>
	                              <input type="text" class="form-control" name="commonName" id="commonName" required placeholder="이름">
	                          </div>
	                      </div>
	                  </div>
	                  <div class="row">
	                      <div class="col-md-12">
	                          <div class="mb-3">
	                              <label for="deptVal" class="form-label">조직 코드</label>
	                              <input type="text" class="form-control" name="deptValue" id="deptVal" required placeholder="코드( ex.KB001 )" maxlength="5">
	                          </div>
	                      </div>
	                  </div>
	                  <div class="row">
	                      <div class="col-md-12">
	                          <div class="mb-3">
	                              <label for="upDeptVal" class="form-label">상위 조직 코드</label>
	                              <input type="text" class="form-control" name="deptUpstair" id="upDeptVal" required placeholder="지점은 # / 부서는 지점코드" maxlength="5">
	                          </div>
	                      </div>
	                  </div>
	              </div>
	              <div class="modal-footer">
	                  <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal" >취소</button>
	                  <button type="submit" id="addDept" class="btn btn-primary waves-effect waves-light" disabled>생성</button>
	              </div>
	              </form>
	              <script>
	              	document.getElementById('addForm').addEventListener('submit', function(event) {
	                  const input = document.getElementById('upDeptVal');
	                  const value = input.value;
	                  const regExp = /^[A-Z]{2}\d{3}$|^#$/;
				
	                  if (!regExp.test(value)) {
	                      event.preventDefault(); // 폼 제출을 막음
	                      alert('상위조직 코드에 지점은 #, 부서는 코드(ex.KB001)를 입력하세요.');
	                  }
	              	});
	              $("#deptVal").on("keyup", function(){
						let regExp = /^[A-Z]{2}\d{3}$/;
		          		if(regExp.test($(this).val())){
		          			$.ajax({
		          				url:"${contextPath}/department/codeCheck.do",
		          				type:"get",
		          				async:false,
		          				data:"checkCode=" + $(this).val(),
		          				success:function(data){
		          					console.log(data);
		          					if(data == "YYYYY"){
		    							$("#addDept").attr("disabled", false);
		    						}else if(data == "NNNNN"){
		    							$("#addDept").attr("disabled", true);
		    						}
		          				}
		          			})
		          		}
		            })
	              
	              	
	              
	              </script>
	              
	          </div>
	      </div>
	  </div>
	  
	  <!-- 부서없는멤버 모달 -->
	    <div id="emptyDept-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" style="display: none;">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">부서 미지정 멤버</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body p-4">
                    <div class="row">
                        <c:forEach var="member" items="${empMemlist}">
                        	<a href="${contextPath}/member/mypage.page?userId=${member.userId}">
	                        	<div class="d-flex" style="margin-bottom: 5%;">
	                        		<img id="profileImg" src="${ contextPath }/<c:out value='${member.profilePath}' default='resources/images/defaultProfile.png'/>">
		                            <div style="margin-left: 5%;">
			                            <h5 class="my-1 text-dark">${member.position}</h5>
			                            <p class="text-muted mb-0"><i class="mdi mdi-account me-1"></i>${member.userName}</p>
		                            </div>
	                            </div>
                            </a>
                        </c:forEach>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
	  <!-- 부서없는멤버 모달 end -->
	  
	  <!-- delDept modal -->

		<div id="delete-modal" class="modal fade" tabindex="-1" role="dialog"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
					<form action="${contextPath}/department/delete.do" method="get">
					<div class="modal-header">
							<h4 class="modal-title">조직도 삭제</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-4">
						<div class="row">
							<div class="col-md-12">
								<div class="mb-3">
									<label for="delDeptVal" class="form-label">조직 코드</label>
									<input type="text" class="form-control" name="deptValue" id="delDeptVal" required placeholder="삭제 시킬 조직 코드" maxlength="5">
									<div id="deptCodeResult" class="nocheck smallfont"></div>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal" id="delDeptCancel">취소</button>
							<button type="submit" id="delDept" class="btn btn-danger waves-effect waves-light" disabled>삭제</button>
						</div>
					</div>
					</form>
					 <script>
					 	
						$(document).ready(function(){
							
						    let checkDeptCode = null;
						    
						    $("#delDeptVal").on("keyup", function(){
						        let regExp2 = /^[A-Z]{2}\d{3}$/;
						        let inputVal = $(this).val();
						
						        if(regExp2.test(inputVal)){
						            $.ajax({
					                	url: "${contextPath}/department/delcodeCheck.do",
						                type: "get",
						                async: false,
						                data: { checkCode: inputVal },
						                success: function(data){
						                    if(data == "YYYYY"){
						                        checkDeptCode = $("#delDept").attr("disabled", false);
						                    } else if(data == "NNNNN"){
						                        checkDeptCode = $("#delDept").attr("disabled", true);
						                    }
						                    if(regExp2.test(inputVal) && data == "YYYYY"){
						                        checkPrint("#deptCodeResult", "nocheck unusable", "usable", "삭제 가능한 코드입니다.");
						                    } else {
						                        checkPrint("#deptCodeResult", "nocheck usable", "unusable", "일치하는 코드가 없습니다.");
						                    }
						                }
						            });
						        } else {
						            checkPrint("#deptCodeResult", "nocheck usable", "unusable", "일치하는 코드가 없습니다.");
						        }
						    });
						});
						function checkPrint(selector, rmClassNm, addClassNm, msg){
			      	    	$(selector).removeClass(rmClassNm)
			      									 .addClass(addClassNm)
			      									 .text(msg);
			      	    	return addClassNm == "usable" ? true : false;
			      	    };

						</script>
				</div>
			</div>
		</div>
		<!-- /.modal -->
</div>


	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
	<!-- Tree view js -->
	<script src="${ contextPath }/resources/libs/jstree/jstree.min.js"></script>
	<script src="${ contextPath }/resources/js/pages/treeview.init.js"></script>
</body>
</html>