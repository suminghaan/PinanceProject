<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주쓰는 결재선</title>
<!-- Treeview css -->
<link href="${ contextPath }/resources/libs/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<style>
.box{
	border: 1px solid lightgray; 
	margin-top: auto;
	padding-top : 10px;
	padding-bottom: 10px;

}

.boxborder{
	border: 1px solid lightgray;
	width: 350px;
}
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
                        <h4 class="page-title">결재선</h4>
                        <div class="page-title-right">
                            <ol class="breadcrumb m-0">
                                <li class="breadcrumb-item"><a href="javascript: void(0);">전자결재</a></li>
                                <li class="breadcrumb-item"><a href="javascript: void(0);">결재선</a></li>
                            </ol>
                        </div>
                    </div>
                </div>
            </div>     
            <!-- end page title --> 

						<!-- start detail content -->
            <div class="row">
                <div class="col-12">               
                    <div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
                        <div class="card-body">
                            <h3 class="header-title">자주쓰는 결재선</h3>
                            <p class="sub-header">
                                내가 등록한 자주쓰는 결재선 목록
                            </p>

                            <div class="table-responsive">
                                <table class="table mb-0">
                                    <thead class="table-light">
                                        <tr>
                                            <th>#</th>
                                            <th>결재선 명</th>
                                            <th>결재선</th>
                                            <th>등록일</th>
                                            <th>관리</th>
                                        </tr>
                                    </thead>
                                    <tbody>                                   	
                                    	<c:forEach var="sa" items="${list}" varStatus="no">
                                    		<input type="hidden" name="saNo" value="${sa.saNo}">
														            <tr>
														                <th scope="row">${no.index + 1}</th>
														                <td>${sa.saTitle}</td>
														                <td>
														                    ${sa.saUserId}
														                </td>
														                <td>${sa.regTime}</td>
														                <td>
														                		<!--  --> 
														                    <a href="${contextPath}/edoc/myApprovalDelete.do?saNo=${sa.saNo}" onclick="return confirm('${sa.saTitle} 결재선을 삭제하시겠습니까?')">삭제</a>
														                </td>
														            </tr>
                                      </c:forEach>                                      
                                    </tbody>
                                </table>
                            </div> <!-- end card body-->
												</div> <!-- end card -->
									</div> 
							</div>
							
							<div class="col-12">					
								<div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
		              <div class="card-body">
			              <br>
			              <h3 class="header-title">결재선 추가</h3>
			              <p class="sub-header">
			                자주쓰는 결재선 추가하기
			              </p>
			              
	              		<form id="approval" method="post" action="${contextPath}/edoc/insertMyApproval.do"> 
			              	<!-- 조직도 포함 전체 박스 -->
				              <div class="box" >       
					              <h4 class="header-title mb-3 ms-5">조직도</h4>
					              
			                	
                           <div class="position-relative">
                               <input type="text" id="searchKey" class="form-control keyword"  placeholder="검색" onclick="search();">                               
                           </div>
                        				                
				
												<!-- 결재선 선택 박스 -->
				               	<div class="col-12 d-flex" style="justify-content: space-between; align-items: stretch;">
				               		<!-- 조직도 트리 -->
				               		<div class="boxborder ms-5">
						                <div id="checkTree">
						                    
						                </div>					                
													</div>
													<!-- 조직도 트리 end -->

													<!-- 결재 버튼 -->
					                <div style="margin: auto;">
					                    <button type="button" class="btn btn-outline-purple waves-effect waves-light" id="approvalLlineBtn">결재</button>					                    
					                </div>
					                <!-- 결재 버튼 end -->

													<!-- 선택된 결재자 div -->
					                <div class="boxborder me-5">
				                    <div id="approvalName">
				                        결재선 명 : <input type="text" name="saTitle">
				                    </div>
					
					                  <div id="approvalLine">
			                        <table  class="apLine">
		                            <tr>
	                                <th>순서</th>
	                                <th>부서</th>
	                                <th>결재자</th>
		                            </tr>
		                            <tr>
	                                <td id="apRank" name="apRank"></td>
	                                <td id="apDept" name="apDept"></td>
	                                <td id="apName" name="apName"></td>
		                            </tr>
			                        </table>
				                    </div>
				                    
					                  <br>
					                  												  
					               </div>
					               <!-- 선택된 결재자 div end-->
						                
					              </div><!-- 결재선 선택 박스 end -->
					            </div><!-- 조직도 포함 전체 박스 -->
			            	
			            	
			              <div style="margin: auto;display:flex;justify-content: center;padding-top: 10px;">
			                  <button type="submit" class="btn btn-primary rounded-pill waves-effect waves-light">등록</button>
			                  <button type="reset" class="btn btn-danger rounded-pill waves-effect waves-light" id="resetBtn">취소</button>
			                  <br>
			              </div>
			              
			            </form>
	             </div>
	             
	             
	             
						
						
						
	             </div>
             </div>
					</div>   <!-- end detail content -->                
        </div> <!-- container -->
		 </div> <!-- content -->
	</div>
	
	<script>
    var nodeId;
    var dept_st_value = null;
    
    $(document).ready(function(){
    	initDeptTree(); // 초기화 함수 호출
    })

    function search(){
			$('#checkTree').jstree(true).search($("#searchKey").val());
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
                        regTime: item.defaultDto.regTime, // 생성일자
                        state: { opened: item.deptValue == 'KB001' }
                    	
                    };
                });
                console.log(deptlist);

                $('#checkTree').jstree('destroy');
                $('#checkTree').jstree({
                    'plugins': ['types', 'sort', 'search', 'checkbox'],
                    'core': {
                        'data': deptlist,
                        'check_callback': true
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
                })               
            }
        });
    }
    
    $('#searchKey').on('input', function () {
        var v = $(this).val();
        $('#checkTree').jstree(true).search(v);
      });
    
 		// 결재 버튼 클릭 시 결재자 목록 생성
    $('#approvalLlineBtn').on('click', function() {
        var selectedNodes = $('#checkTree').jstree("get_checked", true);
        
        //console.log(selectedNodes);
        
        var rowNum = 1;

        var memberResultHtml = selectedNodes
            .filter(function(node) {
                return node.children.length == 0;
            })
            .map(function(node) {
            	if(rowNum < 7){
                return '<tr>'
												 + '<input type="hidden" name="saRank" value="' + rowNum + '">'
												 + '<td>' + (rowNum++) + '</td>'
						   					 + '<td>' + node.original.parentName + '</td>'
						   					 + '<input type="hidden" name="saUserId" value="' + node.id + '">'
						   					 + '<td>' + node.text + '</td>'
						   					 + '</tr>';
            	}else{
            		alert('결재자는 6명을 초과할 수 없습니다.');
            	}
            	
            }).join('');
        //console.log(memberResultHtml);

        $('.apLine tbody').html(memberResultHtml);
        
    });
 
 		
 		// reset버튼
    $('#resetBtn').on('click', function() {
        // 결재자 목록 초기화
        $('.apLine tbody').html('<tr><td id="apRank" name="apRank"></td><td id="apDept" name="apDept"></td><td id="apName" name="apName"></td></tr>');
        
        // 추가로 초기화할 요소
        // 입력 필드 초기화
        $('input[name="saTitle"]').val('');
    });
    
    
    $(document).ready(function() {
        initDeptTree(); // 초기화 함수 호출
        
     
     
    });
    
                                        
    /* 수정버튼 클릭시 아래 목록에 나오게..
   	function editApproval(saNo){
   		$.ajax({
   			url : '${contextPath}/edoc/approvalDetail.do',
   			type : 'get',
   			data : {saNo: saNo},
   			dataType: 'json',
   			success: function(data){
   				
   				// saUserList를 쉼표로 구분된 문자열에서 배열로 변환
   				var saUserArray = data.saUserList.split(',');
   			
   				$('input[name="modalSaTitle"]').val(data.saTitle);
   				
   				// 결재자 목록 필드 채우기
          var memberResultHtml = saUserArray.map(function(userId, index) {
			        return '<tr>'
			             + '<input type="hidden" name="saRank" value="' + data.saRank[index] + '">'
			             + '<td>' + (index + 1) + '</td>'
			             + '<td>' + '부서명' + '</td>'  // 부서명은 필요 시 서버에서 추가로 가져와야 함
			             + '<input type="hidden" name="saUserId" value="' + userId.trim() + '">'
			             + '<td>' + userId.trim() + '</td>'
			             + '</tr>';
			    }).join('');
   				
          $('.apLine tbody').html(memberResultHtml);
   			},
   			error: function(xhr, status, error){
   				alert('결재선 정보를 불러오는 중 오류가 발생했습니다.');
   			}
   		});
   	}
    */
    
</script>

                

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
<!-- Tree view js -->
<script src="${ contextPath }/resources/libs/jstree/jstree.min.js"></script>
<script src="${ contextPath }/resources/js/pages/treeview.init.js"></script>
</div>
</body>
</html>