<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>전자결재 상세화면</title>
<script type="text/javascript" src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
<style>
.stamp{
      height: 80px !important;
  }

.sign{
	height : 70px !important;
	width : 70px !important;
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
	   	 					<h4 class="header-title" style="font-size:1.5rem">전자결재 상세조회</h4><br>
	   	 					
	   	 					<!-- <form id="edoc" action="${contextPath}/edoc/modifyEdoc.do" method="post">  -->
	   	 						<input type="hidden" name="DocumentNo" value="${edoc.docNo}" id="DocumentNo"/>
	   	 						<table class="table">
	   	 							<tr>
	   	 								<td>양식유형</td>   	 								
	   	 								<td >
	   	 									<input type="text" id="sampleCategory" class="form-control" style="width:45%; display:inline;" disabled value="${edoc.sampleDto.sampleCode}">
	   	 									<input type="text" id="sampleList"  class="form-control" style="width:45%; display:inline;" disabled value="${edoc.sampleDto.sampleTitle}">
                    	</td>   	 								
	   	 								<td>사용여부</td>   	 								
	   	 								<td>
	   	 									<input type="text" id="sampleStatus" class="form-control" disabled value="${edoc.status == 'Y' ? '사용' : '미사용'}">
	   	 								</td>   	 								
	   	 							</tr>
	   	 							<tr>
	   	 								<td>양식명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" disabled id="sampleTitle" value="${edoc.sampleDto.sampleTitle}">
	   	 								</td>
	   	 								<td>양식설명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" disabled id="sampleDesc" value="${edoc.sampleDto.sampleDesc}">
	   	 								</td>
	   	 							</tr>
	   	 							<tr>
	   	 								<td>비밀등급</td>
	   	 								<td>
	   	 									<input type="text" id="secCode" class="form-control" disabled value="${edoc.secCode}">
	   	 								</td>
	   	 								<td>보존연한</td>
	   	 								<td>
	   	 									<input type="text" id="preservePeriod" class="form-control" disabled value="${edoc.preservePeriod}">
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
				                        <div style="height: 162px; display: table-cell; width: 116px; vertical-align: middle; text-align: center;">결재</div>
				                    </th>
				                    <td>
				                        <table style="width: 100%; table-layout: fixed;">
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
				                                	<c:forEach var="ea" items="${ edocEa }">
				                                    <td class="team name">${ ea.aprvluserCr }</td>
				                                	</c:forEach>

				                                </tr>
				                                <tr id="stamptr">
				                                	<c:forEach var="ea" items="${ edocEa }">
				                                    <td class="stamp" id="stamptd${ea.aprvlRank}">
				                                    <c:if test="${ ea.aprvluserId eq loginUser.userId }">
				                                    	<c:if test="${ ea.status eq 'W' and edoc.tempSave eq 'N'}">
			                                    			<button type="button" class="btn btn-outline-purple rounded-pill waves-effect waves-light" onclick="ajaxApBtn();">승인</button>
			                                    			<button type="button" class="btn btn-outline-danger rounded-pill waves-effect waves-light" onclick="ajaxRejBtn();">반려</button>	                                    		
				                                    	</c:if>
				                                    </c:if>
				                                    
				                                    <c:if test="${ea.status eq 'A'}">
				                                    	<c:choose>
				                                    		<c:when test="${ea.aprvluserId eq ea.attachDto.defaultDto.regId}">
																					      	<img class="sign" src="${contextPath}${ea.attachDto.filePath}/${ea.attachDto.filesystemName}" alt="결재완료사인">
																					      </c:when>
																					      <c:otherwise>
																					      	<img class="sign" src="${contextPath}/resources/images/approval.png" alt="결재완료사인">
																					      </c:otherwise>																						        																							
				                                    	</c:choose>																			    	    
																						</c:if>
				                                    <c:if test="${ ea.status eq 'R' }">
				                                    	<img class="sign" src="${contextPath}/resources/images/reject.png" alt="결재반려사인">
				                                    	<p class="date"></p>
				                                    </c:if>
				                                        
				                                    </td>		
				                                	</c:forEach>	                                                                    
				                                </tr>
				                                <tr>
				                                	<c:forEach var="ea" items="${ edocEa }">
				                                		<td class="name gt-position-relative">${ ea.aprvluserName }</td>		
				                                	</c:forEach>			                                    
				                                </tr>
				                            </tbody>
				                        </table>
				                    </td>
				                </tr>
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
				                    <td id="approvalFourthLine">
				                    	<c:forEach var="ref" items="${ edocRef }">
				                        <span class="refer-list">
				                            ${ ref.refUserName }, 
				                            <!-- <span class="icon file_delete js-approval-line-delete" style="display: none;"></span> -->
				                        </span>
				                        <!-- 			                        
				                        <span class="bt_left">
				                            <button type="button" class="small-button" onclick="">확인</button>
				                        </span>
				                         -->
				                    	</c:forEach>
				                    </td>
				                </tr>
				            </tbody>
				        </table>
				        <!-- 결재선 자리  ------------------------- -->
				        
				        
	   	 						<br><br><br><br>
	   	 						<div class="mb-2 row">
                      <label class="col-md-2 col-form-label" for="simpleinput" style="padding-left: 30px">제목</label>
                      <div class="col-md-10">
                          <input type="text" id="simpleinput" class="form-control" value="${edoc.docTitle}" readonly>
                      </div>
                  </div>
	   	 						
	   	 						
	   	 						<div style="border:1px solid lightgray; padding:10px; border-radius: var(--bs-border-radius);" id="edocDocument">${edoc.docContent}</div>  

	   	 						<br><br>
	   	 						<div class="mb-2 row">
                      <label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일</label>
                      <c:if test="${empty edoc.attachList}">
                      	<label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일이 없습니다.</label>
                      </c:if>
	                  	<c:forEach var="at" items="${edoc.attachList}">
	                      <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originalName}">${at.originalName}</a><br>
	                    </c:forEach>
                  
                  </div>
                  <br><br>
	   	 						<div style="text-align: right">
   	 								<c:if test="${edoc.status eq 'Y' and edoc.defaultDto.regId eq loginUser.userId}">
	   	 								<button type="button" style="margin-right: 20px" class="btn btn-primary" onclick="modifyEdoc(${edoc.docNo});">수정하기</button>	   	 						
	   	 								<button type="button" style="margin-right: 20px" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#warning-alert-modal">삭제하기</button>
	   	 							</c:if>
	   	 							<button type="reset" class="btn btn-secondary" onclick="javascript:history.go(-1);">뒤로가기</button>
   	 								<button type="button" class="btn btn-secondary" onclick="list();">상신목록</button>

	   	 							
	   	 						
	   	 							<!-- 삭제 Alert Modal -->
	   	 							<form id="deleteModal" method="post">
											<div id="warning-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
									      <div class="modal-dialog modal-sm">
						              <div class="modal-content">
				                     <div class="modal-body p-4">
		                            <div class="text-center">
		                               <i class="bx bxs-no-entry h1 text-danger"></i>
		                               <h4 class="mt-2">삭제</h4>
		                               <p class="mt-3">상신한 문서를 삭제하겠습니까?</p>
		                               <button type="submit" class="btn btn-danger my-2" data-bs-dismiss="modal" onclick="deleteEdoc();">삭제</button>
		                               <input type="hidden" name="docNo" value="${edoc.docNo}">
		                               <button type="reset" class="btn btn-secondary" onclick="javascript:history.go(-1);">뒤로가기</button>
		                             </div>
				                      </div>
						              </div><!-- /.modal-content -->
									      </div><!-- /.modal-dialog -->
											</div><!-- /.modal -->
										</form>
	   	 						</div>
	   	 					<!--</form>-->
	   	 					
	   	 						
									
	   	 					<!-- ---------------------------------------- -->
	   	 					
	   	 				</div> <!-- card-body end -->
	   	 			</div> <!-- card end -->
	   	 		</div> <!-- col end -->
	   	 	</div> <!-- row end -->
	   	 
	   	 </div>
	   	</div>
	  </div>
	  
	  <script>
	  function insertTempSaveEdoc(no){
		  location.href = "${contextPath}/edoc/insertTempSaveEdoc.do";
	  }
	  
	  function modifyEdoc(no){
		  location.href = "${contextPath}/edoc/edocModify.page?no=" + no;
		  alert('수정하기 페이지로 이동 시 결재선을 다시 지정해야합니다.');
	  }
	  
	  function deleteEdoc(no){
		  $("#deleteModal").attr("action","${contextPath}/edoc/edocDelete.do");		  	  
	  }
	  
	  function list(){
		  location.href = "${contextPath}/edoc/uploadApprovalList.page";
	  }
	  
	  // 결재버튼 클릭 ajax
		  function ajaxApBtn(){
			  $.ajax({
				  url : "${contextPath}/edoc/ajaxUpdateApBtn.do",
				  type : "post",
				  data : {
					  docNo:$("#DocumentNo").val()
				  },
				  success : function(resData){
					  console.log(resData);
					  if(resData.success){
						  var data = resData.data;
						  
						  let html;
						  if (data.filePath != null) {
							  html = '<img class="sign" src="${contextPath}' + data.filePath + '/' + data.filesystemName + '" alt="결재완료사인">';
						  } else {
							  html = '<img class="sign" src="${contextPath}/resources/images/approval.png" alt="결재완료사인">';						      
						  }
						            
              $("#stamptd" + data.aprank).html(html);
              if(data.aprank == "${edocEa.size() - 1}"){ //마지막 결재가 되었는지
            	  console.log("결재 완료");
            	  notification("endEdoc", "${edoc.defaultDto.regId}");
              }else{
            	  let aprankCount = 0;
            	  let edocEa;
	              <c:forEach var="ea" items="${ edocEa }">
	          			if(data.aprank + 1 == aprankCount + 1){
	          				edocEa = "${ea.aprvluserId}";
	          			}
	              	aprankCount++;
	              </c:forEach>
            	  console.log("현재 결재 완료 : ", edocEa);
	              notification("enterEdoc", edocEa);
              }
					  }else{
						  alert(resData.message);
					  }
				  },
				  error : function(){
					  console.log("결재버튼 클릭 ajax 통신 실패");
				  }
			  })
		  }
	  
	  
	  // 반려버튼 클릭 ajax 
	  function ajaxRejBtn(){
		  $.ajax({
			  url : "${contextPath}/edoc/ajaxUpdateRejBtn.do",
			  type : "post",
			  data : {
				  docNo:$("#DocumentNo").val()
			  },
			  success : function(resData){
				  var data = resData.data;
				  console.log(data);
				  let html = '<img class="sign" src="${contextPath}/resources/images/reject.png" alt="반려">';

				  $("#stamptd" + data.aprvlRank).html(html);
				  //알람 등록
			  	notification("rejEdoc", "${edoc.defaultDto.regId}");
			  },
			  error : function(){
				  console.log("반려버튼 클릭 ajax 통신 실패");
			  }
		  })
	  }
	  
	  </script>
		
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
  </div>
	
</body>
</html>