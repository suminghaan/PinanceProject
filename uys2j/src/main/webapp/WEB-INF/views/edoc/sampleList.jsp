<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>양식함</title>
<link href="${ contextPath }/resources/libs/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<style>
.bg-success {
	background-color: #4A55A2 !important;
}
.btn-colorCustom{
	background-color: #4A55A2 !important;
	border-color:#4A55A2 !important;
}
.sampleList:hover{
	cursor: pointer;
	background-color: lightgray;
}

</style>
</head>
<body>
 	<!-- Begin page -->
  <div id="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
		<input type="hidden" value="${loginUser.userId}" id="userId">
		
            <div class="content-page">
                <div class="content">

                    <!-- Start Content-->
                    <div class="container-fluid">
                    	<!-- start page title -->
					            <div class="row">
					                <div class="col-12">
					                    <div class="page-title-box page-title-box-alt">
					                        <h4 class="page-title">결재양식</h4>
					                        <div class="page-title-right">
					                            <ol class="breadcrumb m-0">
					                                <li class="breadcrumb-item"><a href="javascript: void(0);">전자결재</a></li>
					                                <li class="breadcrumb-item"><a href="javascript: void(0);">결재양식</a></li>
					                            </ol>
					                        </div>
					                    </div>
					                </div>
					            </div>     
					            <!-- end page title --> 
                        <div id="standard-modal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="standard-modalLabel" aria-hidden="true">
	                           <div class="modal-dialog">
	                               <div class="modal-content">
	                                   <div class="modal-header">
	                                       <h4 class="modal-title" id="standard-modalLabel">전자결재 양식</h4>
	                                       <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                                   </div>
	                                   <div class="modal-body">
                                       <div id="dragTree">
											                    <!-- jstree출력구역 -->
											                    
											                            <ul>
											                            	<c:forEach var="category" items="${codeList}">
											                                <li data-jstree='{"opened":false}' id="${category.codeList}">${category.codeList}
											                                    <ul>
											                                    	<c:forEach var="title" items="${list}">
											                                    	  <c:if test="${title.sampleCode eq category.codeList }">
											                                        	<li data-jstree='{"type":"file"}' id="${title.sampleNo}">${title.sampleTitle}</li>
											                                        </c:if>
											                                      </c:forEach>
											                                    </ul>
											                                </li>
											                                </c:forEach>
											                            </ul>
											                        
											                </div>
	                                   </div>
	                                   <div class="modal-footer">
	                                       <button type="button" class="btn btn-light" data-bs-dismiss="modal">Close</button>
	                                       <!-- <button type="button" class="btn btn-primary" onclick="aaa();">Save changes</button> -->
	                                   </div>
	                               </div><!-- /.modal-content -->
	                           </div><!-- /.modal-dialog -->
	                       </div><!-- /.modal -->

                        <div class="row" >
                            <div class="col-12">
                                <div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
                                    <div class="card-body">
                                        <h4 class="header-title" style="font-size:2rem">양식함</h4>
                                        <p class="sub-header">
                                            <a href="${contextPath}/sample/sampleInsert.page" class="btn btn-sm btn-primary rounded-pill waves-effect waves-light">샘플양식 추가</a>
                                            <button type="button" class="btn btn-sm btn-primary rounded-pill waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#standard-modal">분류설정</button>                                           
                                        </p>
    
                                        <div class="mb-2">
                                            <div class="row row-cols-lg-auto g-2 align-items-center">
                                                <div class="col-12">
                                                    <div>
                                                        <select id="demo-foo-filter-status" class="form-select form-select-sm">
                                                            <option value="">Show all</option>
                                                            <option value="사용">사용</option>
                                                            <option value="대기">대기</option>
                                                        </select>
                                                    </div>
                                                </div>

                                                <div class="col-12">
                                                    <input id="demo-foo-search" type="text" placeholder="Search" class="form-control form-control-sm" autocomplete="on">
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="table-responsive">
                                            <table id="demo-foo-filtering" class="table table-bordered toggle-circle mb-0" data-page-size="7">
                                                <thead>
                                                <tr>
                                                    <th data-toggle="true">문서번호</th>
                                                    <th>양식명</th>
                                                    <th data-hide="phone">작성자</th>
                                                    <th data-hide="phone, tablet">등록일</th>
                                                    <th data-hide="phone, tablet">상태</th>
                                                    <th data-hide="phone, tablet">관리</th>
                                                </tr>
                                                </thead>
                                                <tbody>
                                                	<c:forEach var="sample" items="${list}">
                                                		<tr >
                                                			<td class="sampleNo">${sample.sampleNo}</td>
                                                			<td class="sampleList">${sample.sampleTitle}</td>
                                                			<td class="sampleList">${sample.userName}</td>
                                                			<td class="sampleList">${sample.defaultDto.modTime}</td>
                                                			<td>
                                                				<span class="badge label-table bg-${sample.status eq 'Y' ? 'success' : 'secondary'}">
                                                					${sample.status eq 'Y' ? '사용' : '대기'}
                                                				</span>
                                                			</td>
                                                			<td>
					                                                <a href="${contextPath}/sample/modify.page?sampleNo=${sample.sampleNo}">수정</a> | 
					                                                <a href="${contextPath}/sample/delete.sample?sampleNo=${sample.sampleNo}" onclick="return confirm('${sample.sampleTitle} 샘플양식을 삭제하시겠습니까?\n 첨부파일이 있을 경우 첨부파일이 삭제됩니다.')">삭제</a>
					                                            </td>
                                                		</tr>
                                                	</c:forEach>
                                                </tbody>
                                                <tfoot>
                                                <tr class="active">
                                                    <td colspan="6">
                                                        <div>
                                                            <ul class="pagination pagination-rounded justify-content-end footable-pagination mb-0"></ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                                </tfoot>
                                            </table>
                                        </div> <!-- end .table-responsive-->
                                    </div>
                                </div> <!-- end card -->
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->
                    </div><!--container-fluid-->
                </div><!--content-->
            </div><!--content-page-->		
  </div> <!-- wrapper end -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
          <!-- Vendor js -->
        <%-- <script src="${ contextPath }/resources/js/vendor.min.js"></script> --%>
				<!-- Tree view js -->
	      <script src="${contextPath}/resources/libs/jstree/jstree.min.js"></script>
	
	      <%-- <script src="${contextPath}/resources/js/pages/treeview.init.js"></script> --%>
        <!-- Footable js -->
        <script src="${ contextPath }/resources/libs/footable/footable.all.min.js"></script>

        <!-- Init js -->
        <script src="${ contextPath }/resources/js/pages/foo-tables.init.js"></script>

        <!-- App js -->
        <script src="${ contextPath }/resources/js/app.min.js"></script>
        
<script>
    document.querySelectorAll('.sampleList').forEach(function(e) {
        e.addEventListener('click', function() {
        		let no = $(this).closest("tr").find(".sampleNo").text();
            location.href = "${contextPath}/sample/sampleDetail.page?no=" + no;
        });
    });
    
    //위에 주석한 스크립트 dragTree에 파일에 칠드런요소 가지지못하게 수정함
    $(document).ready(function(){
    	$("#dragTree").jstree({
    		core:{check_callback:!0,themes:{responsive:!1}}
    	 ,types:{default:{icon:"fa fa-folder text-warning","max_depth": 1}
    	 				,file:{icon:"fa fa-file text-primary","max_children": 0}}
    	 ,plugins:["types","dnd"]
    	})
    });
    
    
    
    $('#dragTree').on('move_node.jstree', function(e, data) {
    	
    	console.log(userId);
    	console.log(data);
    	if(data.node.parent == "#" && data.node.type == "file"){
    		console.log(data.node.parent);
    		alert("최상위 루트에 놓을 수 없습니다.");
    		$('#dragTree').jstree('move_node', data.node, data.old_parent, data.old_position, function() {
            console.log('이전 위치로 이동됨.');
        });
    	}else if(data.node.parent == data.old_parent && data.node.type == "file"){
    		data.instance.refresh_node(data.node);
    	}else{
    		//ajax실행 
 				$.ajax({
 					url:"${contextPath}/sample/update.list",
 					type:"post",
 					data:{
 						sampleNo : data.node.id , 
 						sampleCode : data.node.parent,
 						"defaultDto.regId" : $("#userId").val()
 					},
 					success:function(result){
 						if(result>0){
 							alert("성공적으로 경로 변경되었습니다."); 							
 						}
 					},
 					error : function(){
 						console.log("리스트업데이트 ajax실패");
 					}
 				})
   		
    	}
    });
    
</script>
	
</body>
</html>