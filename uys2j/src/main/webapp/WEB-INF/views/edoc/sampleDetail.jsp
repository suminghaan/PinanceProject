<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>샘플양식 상세화면</title>
<script type="text/javascript" src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>
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
	   	 	<!-- start page title -->
        <div class="row">
            <div class="col-12">
                <div class="page-title-box page-title-box-alt">
                    <h4 class="page-title">결재양식</h4>
                    <div class="page-title-right">
                        <ol class="breadcrumb m-0">
                            <li class="breadcrumb-item"><a href="javascript: void(0);">전자결재</a></li>
                            <li class="breadcrumb-item"><a href="javascript: void(0);">결재양식</a></li>
                            <li class="breadcrumb-item"><a href="javascript: void(0);">결재양식조회</a></li>
                        </ol>
                    </div>
                </div>
            </div>
        </div>     
        <!-- end page title -->
	   	 	<!-- 컨텐츠  -->
	   	 	<div class="row" >
	   	 		<div class="col-12">
	   	 			<div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
	   	 				<div class="card-body">
	   	 					
	   	 					<!-- 컨텐츠 영역-------------------------------- -->
	   	 					<h4 class="header-title" style="font-size:1.5rem">샘플양식 상세조회</h4><br>
	   	 					
	   	 					<form id="frm" action="${contextPath}/sample/modify.page" method="post">
	   	 						<input type="hidden" name="sampleNo"  value="${sample.sampleNo}"/>
	   	 						<table class="table">
	   	 							<tr>
	   	 								<td>양식유형</td>   	 								
	   	 								<td >
	   	 									<input type="text" class="form-control" disabled id="inlineFormInput" value="${sample.sampleCode}">
                    	</td>   	 								
	   	 								<td>사용여부</td>   	 								
	   	 								<td>
	   	 									<input type="text" class="form-control" disabled id="inlineFormInput" value="${sample.status eq 'Y' ? '사용' : '대기'}">
	   	 								</td>   	 								
	   	 							</tr>
	   	 							<tr>
	   	 								<td>양식명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" disabled id="inlineFormInput" value="${sample.sampleTitle}">
	   	 								</td>
	   	 								<td>양식설명</td>
	   	 								<td>
	   	 									<input type="text" class="form-control" disabled id="inlineFormInput" value="${sample.sampleDesc}">
	   	 								</td>
	   	 							</tr>
	   	 							
	   	 						</table>
	   	 						<br>
	   	 						<!-- 결재선 자리  ------------------------- -->
	   	 						
				        <!-- 결재선 자리  ------------------------- -->
				        
				        
	   	 						
	   	 						<div class="mb-2 row">
                      <label class="col-md-2 col-form-label" for="simpleinput" style="padding-left: 30px">제목</label>
                      <div class="col-md-10">
                          <input type="text" id="simpleinput" class="form-control" value="${sample.sampleTitle}">
                      </div>
                  </div>
	   	 						
	   	 						
	   	 						
	   	 						<div id="edocDocument" style="min-height:400px; border:1px solid lightgray; padding:10px; border-radius: var(--bs-border-radius);">${sample.sampleContent}</div>  
	   	 						<br><br>
	   	 						<div class="mb-2 row">
                      <label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일</label>
                      <c:if test="${empty sample.attachList}"><label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일이 없습니다.</label></c:if>
	                  	<c:forEach var="at" items="${sample.attachList}">
	                      <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originalName}">${at.originalName}</a><br>
	                    </c:forEach>
                  </div>
                  <br><br>
	   	 						<div style="text-align: right">
		   	 						<a style="margin-right: 20px" class="btn btn-primary" href="${contextPath}/sample/modify.page?sampleNo=${sample.sampleNo}" >수정하기</a>
		   	 						<button type="button" style="margin-right: 20px" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#warning-alert-modal">삭제하기</button>
		   	 						<a class="btn btn-secondary" href="${contextPath}/sample/sampleList.page">뒤로가기</a>
	   	 						</div>
	   	 					</form>
	   	 					<!-- ---------------------------------------- -->
	   	 					<div id="warning-alert-modal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
						      <div class="modal-dialog modal-sm">
			              <div class="modal-content">
	                     <div class="modal-body p-4">
                           <div class="text-center">
                              <i class="bx bxs-no-entry h1 text-danger"></i>
                              <h4 class="mt-2">삭제</h4>
                              <p class="mt-3">${sample.sampleTitle} 문서를 삭제하겠습니까?</p>
                              <button type="submit" class="btn btn-danger my-2" data-bs-dismiss="modal" onclick="location.href='${contextPath}/sample/delete.sample?sampleNo=${sample.sampleNo}'">삭제</button>
                              <button type="reset" class="btn btn-secondary" onclick="javascript:history.go(-1);">뒤로가기</button>
                            </div>
	                      </div>
			              </div><!-- /.modal-content -->
						      </div><!-- /.modal-dialog -->
								</div><!-- /.modal -->
	   	 					<!-- ------------------------------------------ -->
	   	 				</div> <!-- card-body end -->
	   	 			</div> <!-- card end -->
	   	 		</div> <!-- col end -->
	   	 	</div> <!-- row end -->
	   	 
	   	 </div>
	   	</div>
	  </div>
		
  </div> <!-- wrapper end -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>