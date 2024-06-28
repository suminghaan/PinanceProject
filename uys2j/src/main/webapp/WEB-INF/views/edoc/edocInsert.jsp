<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>전자결재 작성하기</title>
<script type="text/javascript" src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<!-- Treeview css -->
<link href="${ contextPath }/resources/libs/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
<style>
.stamp{
      height: 80px !important;
  }
</style>

</head>
<body>
 	<!-- Begin page -->
  <div id="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
		
		<div class="content-page">
		  <div class="content">
			 <!-- Start Content-->
	   	 <div class="container-fluid">
	   	 	<!-- 컨텐츠  -->
	   	 	<div class="row" style="margin-top:50px">
	   	 		<div class="col-12">
	   	 			<div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
	   	 				<div class="card-body">
	   	 					
	   	 					<!-- 컨텐츠 영역-------------------------------- -->
	   	 					<h4 class="header-title" style="font-size:1.5rem">전자결재 기안작성</h4><br>
	   	 					
	   	 					<form id="edocInsert" action="${contextPath}/edoc/insertEdoc.do" method="post" enctype="multipart/form-data">
	   	 						<input type="hidden" id="vacType" name="vacType" >
	   	 						<input type="hidden" id="vacDay" name="vacDay" >
	   	 						<table class="table">
	   	 							<tr>
	   	 								<td>양식유형</td>   	 								
	   	 								<td>
	   	 									<select id="sampleCategory"  class="form-select" style="width:45%; display:inline;" onclick="ajaxSampleList();">
	                        <option value="0" selected>선택</option>
	                        <c:forEach var="category" items="${sampleCode}">
	                        	<option>${category.codeList}</option>
													</c:forEach>
                    		</select>
	   	 									<select id="sampleList"  name="docCode" class="form-select" style="width:45%; display:inline;" onchange="ajaxSampleDetail();">
	                        <option value="0" selected>선택</option>	                        
                    		</select>
                    	</td>   	 								
	   	 								<td>사용여부</td>   	 								
	   	 								<td>
	   	 									<select id="sampleStatus" name="status" class="form-select" disabled>
	                        <option value="1" selected>사용</option>
	                        <option value="2">미사용</option>
                    		</select>
	   	 								</td>   	 								
	   	 							</tr>
	   	 							<tr>
	   	 								<td>양식명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" id="sampleTitle" readonly placeholder="양식명">
	   	 								</td>
	   	 								<td>양식설명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" id="sampleDesc" readonly placeholder="양식설명">
	   	 								</td>
	   	 							</tr>
	   	 							<tr>
	   	 								<td>비밀등급</td>
	   	 								<td>
	   	 									<select name="secCode" class="form-select" required>
	                        <option value="0" selected>선택</option>
	                        <option value="S">S등급</option>
	                        <option value="A">A등급</option>
                    		</select>
	   	 								</td>
	   	 								<td>보존연한</td>
	   	 								<td>
	   	 									<select name="preservePeriod" class="form-select" required>
	                        <option value="0" selected>선택</option>
	                        <option value="5">5년</option>
	                        <option value="3">3년</option>
	                        <option value="1">1년</option>
                    		</select>
	   	 								</td>
	   	 							</tr>
	   	 						</table>
	   	 						<br>
	   	 						<!-- 결재선 자리  ------------------------- -->
	   	 						<table class="table  table-bordered table-sm mb-0">
				            <colgroup>
				                <col style="width: 12.09%;">
				                <col style="width: 87.91%;">
				            </colgroup>
				            <tbody>
				                <tr>
				                    <th scope="row" class="sign">
				                        <div style="height: 162px; display: table-cell; width: 116px; vertical-align: middle; text-align: center; position: relative;">결재
					                        <div class="col-xl-3 col-lg-4 col-sm-6" style="position:absolute; right: 0px; top:0px;">
					                        	<i class="fe-plus-circle" style="font-size: 20px;" id="approvalModal" data-bs-toggle="modal" data-bs-target="#bs-example-modal-lg"></i> 
					                        </div>
				                        </div>
				                    </th>
				                    <td>
				                    		<span>자주쓰는 결재선</span>
				                    		
				                    		<select id="myApproval"  name="myApproval" class="form-select" style="width:45%; display:inline;">
					                        <option value="0" selected>선택</option>
					                        <c:forEach var="approval" items="${saAp}">
					                        	<option value="${approval.saNo}">${approval.saTitle}</option>
																	</c:forEach>
				                    		</select>			                    		
				                    		<button type="button" class="btn btn-outline-secondary rounded-pill waves-effect" onclick="ajaxMyApproval();">선택한 결재선 사용</button>
				                        <table id="approvalTable" style="width: 100%; table-layout: fixed;">
				                            <colgroup>
				                                <col>
				                                <col>
				                                <col>
				                                <col>
				                                <col>
				                                <col>
				                            </colgroup>
				                            <tbody>
				                                <tr>
				                                    <td class="team name">직급</td>
				                                </tr>
				                                <tr>
				                                    <td class="stamp">
				                                        <img src="" alt="결재사인">
				                                        <p class="date">결재완료일</p>
				                                    </td>				                                    
				                                </tr>
				                                <tr>
				                                    <td>직원명</td>				                                    
				                                </tr>
				                            </tbody>
				                        </table>
				            </tbody>
				        </table>
				        <table class="table  table-bordered table-sm mb-0">
				            <colgroup>
				                <col style="width: 12.09%;">
				                <col style="width: 87.91%;">
				            </colgroup>
				            <tbody>
				                <tr>
				                    <th scope="row">
				                        <div class="choice" style="min-height: 45px; height: 44px; display: table-cell; width: 116px; vertical-align: middle; text-align: center;">참조</div>
				                    </th>
				                    <td id="approvalReftd">
				                        <span class="refer-list" user_no="" node_id="" type="">
				                            "참조자"
				                            <span class="icon file_delete js-approval-line-delete" style="display: none;"></span>
				                        </span>
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				        
				        <!-- 결재선 선택 모달 내용 -->
								<div class="modal fade" id="bs-example-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
								    <div class="modal-dialog modal-lg">
								        <div class="modal-content">
								            <div class="modal-header">
								                <h4 class="modal-title" id="myLargeModalLabel">결재선 선택</h4>
								                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
								            </div>
								            <div class="modal-body">							                
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
				
																	<!-- 결재,참조 버튼 -->
									                <div style="margin: auto;">
									                    <button type="button" class="btn btn-outline-purple waves-effect waves-light" id="modalApprovalLlineBtn">결재</button> <br>	<br>				                    
									                		<button type="button" class="btn btn-outline-purple waves-effect waves-light" id="modalRefLlineBtn">참조</button>					                    											                
									                </div>
									                <!-- 결재,참조 버튼 end -->
				
																	<!-- 선택된 결재자 div -->
									                <div class="boxborder me-5">										                    											
									                  <div id="modalApprovalLine">
									                  	<h4>결재선</h4>
							                        <table  class="apLine">
							                        	<thead>
							                            <tr>
						                                <th>순서</th>
						                                <th>부서</th>
						                                <th>결재자</th>
							                            </tr>
						                            </thead>
						                            <tbody >
							                            <tr>
						                                <td id="modalApRank" name="modalApRank"></td>
						                                <td id="modalApDept" name="modalApDept"></td>
						                                <td id="modalApName" name="modalApName"></td>
							                            </tr>
						                            </tbody>
							                        </table>
							                        <br><br>
							                        <h4>참조</h4>
							                        <table class="refLine">
							                        	<thead>
																					<tr>
																						<th>참조자 명</th>
																					</tr>
																				</thead>
																				<tbody>
																				</tbody>									                        
							                        </table>
								                    </div>										                    
									                  <br>											                  												  
									               </div>
									               <!-- 선택된 결재자 div end-->												                
									              </div><!-- 결재선 선택 박스 end -->
									            </div><!-- 조직도 포함 전체 박스 -->

							              	<div class="modal-footer">
								                <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal" id="resetBtn">취소</button>
								                <button type="button" class="btn btn-info waves-effect waves-light" data-bs-dismiss="modal" id="apRefBtn">결재선 적용</button>
								            	</div>						              
									            
								            </div>
								        </div><!-- /.modal-content -->
								   </div><!-- /.modal-dialog -->
								</div><!-- /.modal -->
				        <!-- 결재선 자리  ------------------------- -->
				        
				        
   	 						<br><br><br><br>
   	 						<div class="mb-2 row">
                     <label class="col-md-2 col-form-label" for="simpleinput" style="padding-left: 30px">제목</label>
                     <div class="col-md-10">
                         <input type="text" id="simpleinput" class="form-control" name="docTitle" placeholder="제목 작성" required>
                     </div>
                 </div>
	   	 						
   	 						<br><br>
	   	 						
   	 						<textarea name="docContent" id="editorTxt" row="20" cols="20" style="width:100%; min-height:500px;"></textarea>
   	 						<br><br>
   	 						
   	 						<div class="mb-2 row">
                     <label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일</label>
                     <div class="col-md-10">
                         <input name="uploadFile" type="file" class="form-control" id="example-fileinput">
                     </div>
                 </div>
                 <br><br>
   	 						<div style="text-align: right">
	   	 						<button type="button" style="margin-right: 20px" class="btn btn-primary" onclick="submitEdoc();" disabled id="submitEdocBtn">등록하기</button>
	   	 						<button type="button" style="margin-right: 20px" class="btn btn-primary" onclick="edocTempSave();">임시저장</button>
	   	 						<input type="hidden" value="N" name="tempSave" id="tempSave">
	   	 						<button type="reset" class="btn btn-secondary" onclick="javascript:history.go(-1);">취소</button>
   	 						</div>
	   	 					</form>
	   	 					<!--------------------------------------------->
	   	 					<button style="display: none;" id="alertTitle" type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#warning-alert-modal">Warning Alert</button>
	   	 					
	   	 					<!-- Warning Alert Modal -->
                <div id="warning-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-body p-4">
                                <div class="text-center">
                                    <i class="bx bxs-no-entry h1 text-warning"></i>
                                    <h4 class="mt-2">제목을 입력해주세요.</h4>
                                    <p class="mt-3"></p>
                                    <button type="button" class="btn btn-warning my-2" data-bs-dismiss="modal" onclick="focusTitle();">Continue</button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
	   	 					
	   	 					<button style="display: none;" id="alertContent" type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#warning-alert-modal2">Warning Alert</button>
	   	 					
	   	 					<!-- Warning Alert Modal -->
                <div id="warning-alert-modal2" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-body p-4">
                                <div class="text-center">
                                    <i class="bx bxs-no-entry h1 text-warning"></i>
                                    <h4 class="mt-2">내용을 입력해주세요.</h4>
                                    <p class="mt-3"></p>
                                    <button type="button" class="btn btn-warning my-2" data-bs-dismiss="modal" onclick="focusContent();">Continue</button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
	   	 					
	   	 					<button style="display: none;" id="alertCategory" type="button" class="btn btn-warning" data-bs-toggle="modal" data-bs-target="#warning-alert-modal3">Warning Alert</button>
	   	 					
	   	 					<!-- Warning Alert Modal -->
                <div id="warning-alert-modal3" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
                    <div class="modal-dialog modal-sm">
                        <div class="modal-content">
                            <div class="modal-body p-4">
                                <div class="text-center">
                                    <i class="bx bxs-no-entry h1 text-warning"></i>
                                    <h4 class="mt-2">양식유형을 선택해주세요.</h4>
                                    <p class="mt-3"></p>
                                    <button type="button" class="btn btn-warning my-2" data-bs-dismiss="modal" onclick="focusCategory();">Continue</button>
                                </div>
                            </div>
                        </div><!-- /.modal-content -->
                    </div><!-- /.modal-dialog -->
                </div><!-- /.modal -->
	   	 					
	   	 					<!-- ---------------------------------------- -->
	   	 				</div> <!-- -body end -->
	   	 			</div> <!-- card end -->
	   	 		</div> <!-- col end -->
	   	 	</div> <!-- row end -->
	   	 
	   	 </div>
	   	</div>
	  </div>
	  
	  
      <script>
      //-----texteditor-----
      let oEditors = [];
      let sEditor;
      let smartEditor;

      $(document).ready(function() {
   	   console.log("Naver SmartEditor");
        smartEditor = nhn.husky.EZCreator.createInIFrame({
          oAppRef: oEditors,
          elPlaceHolder: "editorTxt",
          sSkinURI: "${contextPath}/resources/smarteditor/SmartEditor2Skin.html",
          fCreator: "createSEditor2"
        });
        
        initDeptTree(); // 초기화 함수 호출
      });
    	//-----texteditor-----
    	
    	// 샘플구분 선택시 구분에 해당하는 샘플 조회용 ajax
    	function ajaxSampleList(){
    		$.ajax({
    			url:"${contextPath}/edoc/sampleList.do",
    			type:"post",
    			data: {
    				sampleCategory:$("#sampleCategory").val()
    			},
    			success:function(resData){
    				//console.log(resData);
    				let sample = "<option value='0' selected>선택</option>";
    				for(let i = 0; i < resData.length; i++){
    					sample += "<option value='" + resData[i].sampleNo + "'>" + resData[i].sampleTitle + "</option>";
    				}
    									  
    				$("#sampleList").html(sample);
    			},
    			error: function(){
    				console.log("샘플양식목록 조회 ajax통신 실패");
    			}
    				
    		})
    	}
    	
    	// 샘플양식 내용 조회용 ajax
    	function ajaxSampleDetail(){
    		$.ajax({
    			url:"${contextPath}/edoc/sampleDetail.do",
    			type:"post",
    			data:{
    				sample:$("#sampleList").val()
    			},
    			success:function(resData){
    				
    				console.log(resData);
    				console.log(resData.status);
    				if(resData.status == 'Y'){
    					$("#sampleStatus").val('1');
    				}else{
    					$("#sampleStatus").val('2');
    				}
    				
    				$("#sampleTitle").val(resData.sampleTitle);
    				$("#sampleDesc").val(resData.sampleDesc);
    				
    				// editor 내용 삭제
    				oEditors.getById["editorTxt"].exec("SET_IR", [""]);
    				// editor html 추가
    			  oEditors.getById["editorTxt"].exec("PASTE_HTML", [resData.sampleContent]);
    			},
    			error:function(){
    				console.log("샘플양식 내용 조회 ajax 통신 실패");
    			}
    		})
    	}    	
    	
    	// 자주쓰는 결재선 ajax
    	function ajaxMyApproval(){
    		$.ajax({
    			url : "${contextPath}/edoc/ajaxSelectMyApproval.do",
    			type : "post",
    			data : {
    				saNo:$('#myApproval').val() 				
    			},
    			success:function(resData){
    				console.log(resData);
    				
    				let html='<tr>';
    				for(let i = 0; i < resData.edocUser.length; i++){
    					html += '<td class="team name">' + resData.edocUser[i].rank + '</td>'
    							 + '<input type="hidden" name="aprvlRank" value="' + i + '">'
						 			 + '<input type="hidden" name="aprvluserCr" value="' + resData.edocUser[i].rank + '">'
						 			 + '<input type="hidden" name="aprvluserId" value="' + resData.edocUser[i].userId + '">'
    				}
            html += '</tr>'
            		 +  '<tr>';
            for(let i = 0; i < resData.edocUser.length; i++){
            	html += '<td class="stamp">'
            			 + '</td>';
            }
            html += '</tr>'
			       		 +  '<tr>';
			      for(let i = 0; i < resData.edocUser.length; i++){
			    	  html += '<td>'
			    	  		 + '<input type="hidden" name="aprvluserName" value="' + resData.edocUser[i].userName + '">'
			    	  		 +  resData.edocUser[i].userName
			    	  		 +  '</td>';
			      }
            html += '</tr>';
            
            $("#approvalTable tbody").html(html);
            $("#submitEdocBtn").prop("disabled", false);
    			},
    			error:function(){
    				console.log("자주쓰는 결재선 ajax통신 실패");
    			}
    		})
    	}
    	
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
                    console.log(data);
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
     $('#modalApprovalLlineBtn').on('click', function() {
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
    	
     // 참조 버튼 클릭 시 참조자 목록 생성
     $("#modalRefLlineBtn").on('click', function(){
         var selectedNodes = $('#checkTree').jstree("get_checked", true);
         var rowNum = 1;
         
         var memberResultHtml = selectedNodes
         												.filter(function(node){
         													return node.children.length == 0;
         												})
         												.map(function(node){
         													return '<tr>'
         																	+ '<input type="hidden" name="saUserId" value="' + node.id + '">'
         								                  + '<td>'
         								                  + node.text
         								                  + '</td>'
         								                  + '</tr>'
         												}).join('');
         
         $('.refLine tbody').html(memberResultHtml);
     });
     
  	 // reset버튼
     $('#resetBtn').on('click', function() {
         // 결재자 목록 초기화
         $('.apLine tbody').html('<tr><td id="apRank" name="apRank"></td><td id="apDept" name="apDept"></td><td id="apName" name="apName"></td></tr>');
         $('.refLine tbody').html('');
     });
  	 
  	 
  	 // 결재자 등록버튼
  	 $('#apRefBtn').on('click', function(){
  		var apUser = []; // 결재자 정보를 담을 배열

 	    // 결재자 목록을 순회하면서 정보 추출
 	    $('.apLine tbody tr').each(function() {
        var userId = $(this).find('input[name="saUserId"]').val(); // 사용자 ID 추출
        var userInfo = $(this).find('td:eq(2)').text().split('/'); // 사용자 정보를 "/"로 나누어 배열로 저장
        var userName = userInfo[0].trim(); // 이름 추출 후 공백 제거
        var userRank = userInfo.length > 1 ? userInfo[1].trim() : ''; // 순위 추출 후 공백 제거

        // 추출된 정보를 객체로 저장하여 배열에 추가
        var user = {
            id: userId,
            name: userName,
            rank: userRank
        };
        apUser.push(user); // 배열에 추가
    	});
 
 	   	var aphtml='<tr>';
			for(let i = 0; i < apUser.length; i++){
						aphtml += '<td class="team name">' + apUser[i].rank + '</td>'
									 + '<input type="hidden" name="aprvlRank" value="' + i + '">'
									 + '<input type="hidden" name="aprvluserCr" value="' + apUser[i].rank + '">'
									 + '<input type="hidden" name="aprvluserId" value="' + apUser[i].id + '">'
					}
			aphtml += '</tr>'
					 +  '<tr>';
			for(let i = 0; i < apUser.length; i++){
						aphtml += '<td class="stamp">'
								 + '</td>';
					}
			aphtml += '</tr>'
					 	 +  '<tr>';
			for(let i = 0; i < apUser.length; i++){
					  aphtml += '<td>'
					  		 + '<input type="hidden" name="aprvluserName" value="' + apUser[i].name + '">'
					   	   + apUser[i].name
					   	   + '</td>';
					}
			aphtml += '</tr>';
	
			$("#approvalTable tbody").html(aphtml);

			// 참조자
 	    var refUsers = []; // 참조자 정보를 담을 배열
 	    
 	    $('.refLine tbody tr').each(function(){
 	    	var refUserId = $(this).find('input[name="saUserId"]').val();
 	    	var userName = $(this).find('td').text();
 	    	
 	    	var refUser = {
 	    			id : refUserId,
 	    			name : userName
 	    	};
 	    	refUsers.push(refUser);	    	
 	    });
 	    
 	   var refhtml='<span>';
		 for(let i = 0; i < refUsers.length; i++){
			 		refhtml += '<input type="hidden" name="refUserId" value="' + refUsers[i].id + '">'
			 						+ '<input type="hidden" name="refUserName" value="' + refUsers[i].name + '">'
				          + refUsers[i].name
									+ ', '
						}
				refhtml += '</span>';
		
				$("#approvalReftd").html(refhtml); 
				$("#submitEdocBtn").prop("disabled", false);
				
  	 })
			
  	 function notificationEdoc(){
	 		notification("insertEdoc", "${loginUser.userId}");
			// 결재자 알람 보내기 위해 사용
		  	var apUser = []; // 결재자 정보를 담을 배열
	
	    // 결재자 목록을 순회하면서 정보 추출
	    $('.apLine tbody tr').each(function() {
	      var userId = $(this).find('input[name="saUserId"]').val(); // 사용자 ID 추출
	      var userInfo = $(this).find('td:eq(2)').text().split('/'); // 사용자 정보를 "/"로 나누어 배열로 저장
	      var userName = userInfo[0].trim(); // 이름 추출 후 공백 제거
	      var userRank = userInfo.length > 1 ? userInfo[1].trim() : ''; // 순위 추출 후 공백 제거
	
	      // 추출된 정보를 객체로 저장하여 배열에 추가
	      var user = {
	          id: userId,
	          name: userName,
	          rank: userRank
	      };
	      apUser.push(user); // 배열에 추가
	  		});
		  	if(apUser.length > 0){
		  		console.log(apUser);
		  		notification("enterEdoc", apUser[0].id);
		  	}
			// 참조자 알람 보내기 위해 사용
	    var refUsers = []; // 참조자 정보를 담을 배열
	    
	    $('.refLine tbody tr').each(function(){
	    	var refUserId = $(this).find('input[name="saUserId"]').val();
	    	var userName = $(this).find('td').text();
	    	
	    	var refUser = {
	    			id : refUserId,
	    			name : userName
	    	};
	    	refUsers.push(refUser);	    	
	    });
		 	if(refUsers.length > 0){
			 	console.log(refUsers);
			 for(let i = 0; i < refUsers.length; i++){
				 notification("refEdoc", refUsers[i].id);
			 }
		 	}
  	 }
  	 
      // 기안등록
     function submitEdoc() {
    	 notificationEdoc();
    	 // editor 내용 올리기
   	   oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
   	   let content = document.getElementById("editorTxt").value
   	   let docTitle = document.getElementById("simpleinput").value
   	   //휴가신청서인 경우 넘겨줄 값들 정리
   	   if($("#sampleList").val() == '1'){
			   var str = content.split('id="startDay"')[1];
				 var startIdx = str.indexOf('>')+1;
				 var endIdx = str.indexOf('</');
				 var vacDay = str.substring(startIdx, endIdx).trim().replace(/&nbsp;/g, ' ');
				 $("#vacDay").val(vacDay);
				 
				 var str2 = content.split('id="vacationType"')[1];
				 var startIdx2 = str2.indexOf('>')+1;
				 var endIdx2 = str2.indexOf('</');
				 var vacType = str2.substring(startIdx2, endIdx2).trim().replace(/&nbsp;/g, ' ');
				 $("#vacType").val(vacType);
				 
   	   }
    	  
   	   if(content == '<p>&nbsp;</p>' || content == '') {
   	     document.getElementById("alertContent").click();
   	     return 
   	   }else if(docTitle == ''){
   			 document.getElementById("alertTitle").click();
  	     return
   	   }else if($("#sampleList").val() == '0'){
		  	 document.getElementById("alertCategory").click();
			   return
   	   }else {
   	     $("#edocInsert").submit();
   	   }
   	 }
   	   
      
    	//임시저장
      function edocTempSave(){
   	   oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", []);
   	   
   	   let content = document.getElementById("editorTxt").value
   	   let docTitle = document.getElementById("simpleinput").value

   		 if(content == '') {
  	     document.getElementById("alertContent").click();
  	     return 
  	   }else if(docTitle == ''){
  			 document.getElementById("alertTitle").click();
 	     	 return
  	   }else if($("#sampleList").val() == '0'){
		  	 document.getElementById("alertCategory").click();
			   return
  	   }else {
   			$("#tempSave").val("Y");
    	  $("#edocInsert").submit();
    	  alert('결재선은 저장되지 않습니다.');
   	   }
      }
   	   
      function focusContent(){
   	   oEditors.getById["editorTxt"].exec("FOCUS")
      }
      function focusTitle(){
   	   document.getElementById("simpleinput").focus()
      }   	   
      function focusCategory(){
   	   document.getElementById("sampleList").focus()
      }
   	  
      
    </script>
	  
	
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
  </div>

<!-- Tree view js -->
<script src="${ contextPath }/resources/libs/jstree/jstree.min.js"></script>
<script src="${ contextPath }/resources/js/pages/treeview.init.js"></script>
	
</body>
</html>