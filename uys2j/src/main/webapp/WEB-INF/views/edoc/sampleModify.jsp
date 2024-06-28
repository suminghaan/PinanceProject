<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="en" data-layout-mode="detached" data-sidebar-user="true" data-topbar-color="dark">
<head>
<meta charset="UTF-8">
<title>샘플양식 작성</title>
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
                            <li class="breadcrumb-item"><a href="javascript: void(0);">결재양식수정</a></li>
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
	   	 					<h4 class="header-title" style="font-size:1.5rem">샘플양식 작성</h4><br>
	   	 					
	   	 					<form id="frm" action="${contextPath}/sample/update.sample" method="post" enctype="multipart/form-data">
	   	 						<input type="hidden" name="defaultDto.regId" value="${loginUser.userId}">
	   	 						<input type="hidden" name="sampleNo" value="${sample.sampleNo}"/>
	   	 						<table class="table">
	   	 							<tr>
	   	 								<td>양식유형</td>   	 								
	   	 								<td >
	   	 									<select id="sampleCategory"  name="sampleCode" class="form-select" style="width:45%; display:inline;" >
	                        <option value="0" selected>선택</option>
	                        <c:forEach var="category" items="${codeList}">
	                        	<c:choose>
	                        		<c:when test="${category.codeList eq sample.sampleCode}">
	                        			<option value="${category.codeList}" selected>${category.codeList}</option>
	                        		</c:when>
	                        		<c:otherwise>
	                        			<option value="${category.codeList}">${category.codeList}</option>
	                        		</c:otherwise>
	                        	</c:choose>
	                        	
	                        </c:forEach>	                        
	                        <option value="추가">추가</option>
                    		</select>
                    		
	   	 									<input type="text" id="sampleList"  name="addSampleCode" class="form-control" style="width:45%; display:none;">
	   	 									
	                        
                    	</td>   	 								
	   	 								<td>사용여부</td>   	 								
	   	 								<td>
	   	 									<select name="status" class="form-select">
	                        <option value="Y" ${sample.status == 'Y' ? 'selected' : ''}>사용</option>
	                        <option value="W" ${sample.status == 'W' ? 'selected' : ''}>대기</option>
                    		</select>
	   	 								</td>   	 								
	   	 							</tr>
	   	 							<tr>
	   	 								<td>양식명</td>
	   	 								<td>
	   	 									<input type="text" name="sampleTitle" class="form-control" id="inlineFormInput" required value="${sample.sampleTitle}">
	   	 								</td>
	   	 								<td>양식설명</td>
	   	 								<td>
	   	 									<input type="text" name="sampleDesc" class="form-control" id="inlineFormInput" value="${sample.sampleDesc}">
	   	 								</td>
	   	 							</tr>
	   	 							<!-- 샘플입력시는 보존연한, 보안등급 입력안함 -->
	   	 						</table>
	   	 						<br>
	   	 						
	   	 						
	   	 						<br><br>
	   	 						
	   	 						<textarea name="sampleContent" id="editorTxt" row="20" cols="20" style="width:100%;">${sample.sampleContent}</textarea>
	   	 						<br><br>
	   	 						<div class="mb-2 row">
                      <label class="col-md-2 col-form-label" for="example-fileinput">첨부 파일</label>
                      
	                      <div class="col-md-10">
                         <input name="uploadFiles" type="file" class="form-control" id="example-fileinput" multiple>
	                      </div>
                      
		                  	<c:forEach var="at" items="${sample.attachList}">
		                  		<div>
			                      <a href="${contextPath}${at.filePath}/${at.filesystemName}" download="${at.originalName}">${at.originalName}</a>
			                      <c:if test="${at.fileNo != 0 }">
			                      	<span class="origin_del" data-fileno="${ at.fileNo }" style="cursor:pointer;">x</span><br>
			                      </c:if>
		                      </div>
		                    </c:forEach>
	                    
                  </div>
	   	 						<br><br>
	   	 						
	   	 						<div style="text-align: right">
	   	 								<button style="margin-right: 20px" class="btn btn-primary" onclick="return submitPost();">수정하기</button>
		   	 							<button class="btn btn-secondary" onclick="history.back();">취소</button>		   	 								   	 					
	   	 						</div>
	   	 					</form>
	   	 					<!-- ---------------------------------------- -->
	   	 					
	   	 				</div> <!-- card-body end -->
	   	 			</div> <!-- card end -->
	   	 		</div> <!-- col end -->
	   	 	</div> <!-- row end -->
	   	 
	   	 </div>
	   	</div>
	  </div>
	  
	  
       <script>
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
       });
       
       $("#sampleCategory").on("change",function(){
    	   if($("#sampleCategory").val() == "추가"){
    		   $('#sampleList').css('display', 'inline');
    	   }else{
    		   $('#sampleList').css('display', 'none');
    	   }
       })
       
       
       function submitPost() {
    	   oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
    	   let content = document.getElementById("editorTxt").value
    	   let code = document.getElementById("sampleCategory").value
    	   
    	   if(content == '<p>&nbsp;</p>') {
    	     alert("내용을 입력해주세요.")
    	     oEditors.getById["editorTxt"].exec("FOCUS")
    	     return false;
    	   } else {
    		   if(code == 0){
    			   alert("양식유형을 선택해주세요.")
    			   document.getElementById("sampleCategory").focus()
    			   return false;
    		   }else{
	    	     $("#frm").submit();
    		   }
    	   }
    	 }
       
    	 
       $(document).ready(function(){
     		$(".origin_del").on("click", function(){
     			let inputEl = document.createElement("input"); 
     			inputEl.type = "hidden";
     			inputEl.name = "delFileNo";
     			inputEl.value= $(this).data("fileno");
     			
     			document.getElementById("frm").append(inputEl);
     			
     			$(this).parent().remove();
     			
     		})
     	})
       
       
       
     </script>
	  
	
		
  </div><!-- wrapper end -->
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
</body>
</html>