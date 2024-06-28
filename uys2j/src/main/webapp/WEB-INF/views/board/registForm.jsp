<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 등록페이지</title>
<script type="text/javascript" src="${contextPath}/resources/smarteditor/js/HuskyEZCreator.js" charset="UTF-8"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<style>
	.card{
		margin-top:10px;
	}
	.left-side-menu{
		margin-left:25px;
	}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>

	<div class="content-page">
	    <div class="content">
	        <div class="container-fluid">
	         <!-- start page title -->
						<div class="row">
							<div class="col-12">
								<div class="page-title-box page-title-box-alt" style="margin-top: 20px;">
									<h4 class="page-title"style="margin-left: 20px;">게시판</h4>
									<div class="page-title-right">
										<ol class="breadcrumb m-0">
											<li class="breadcrumb-item"><a href="javascript: void(0);">게시판</a></li>
											<li class="breadcrumb-item active">게시글 작성</li>
										</ol>
									</div>
								</div>
							</div>
						</div>
						<!-- end page title -->
	            <div class="row">
	                <div class="col-12">
	                    <div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
	                        <div class="card-body">
	                            <section class="board-insert">
	                                <div class="container">
	                                    <form id="frm" action="${contextPath}/board/regist.do" method="post" style="margin-top: 50px;" enctype="multipart/form-data">
	                                       <input type="hidden" name="boardNo" value="${board.boardNo}" />
	                                       <input type="hidden" name="defaultDto.regId" value="${loginUser.userId}"/>
	                                        <table class="table" style="font-size: large;">
	                                            <tr>
	                                                <th><label for="title">제목</label></th>
	                                                <td><input type="text" id="title" class="form-control" name="postTitle" required></td>
	                                            </tr>
	                                            <tr>
	                                                <th colspan="2">
	                                                    <div class="mb-2 row">
	                                                        <label class="col-md-2 col-form-label" for="example-fileinput">첨부파일</label>
	                                                        <div class="col-md-10">
	                                                            <input type="file" class="form-control" id="example-fileinput" name="uploadFiles" style="margin-left:6.5%; width:93.5%;" multiple>
	                                                        </div>
	                                                    </div>
	                                                </th>
	                                            </tr>
	                                            <tr>
	                                                <th colspan="2"><textarea name="postContent" id="editorTxt" style="width:100%;"></textarea></th>
	                                            </tr>
	                                        </table>
	                                        <br>
	                                        <div align="center">
	                                        		<button type="button" style="margin-right: 2px" class="btn btn-primary" onclick="submitPost();">등록하기</button>
															   	 						<a class="btn btn-outline-secondary waves-effect" href="${contextPath}/board/boardList.do?type=${board.boardNo}">취소하기</a>
	                                        </div>
	                                    </form>
	                                </div>           
	                            </section>
	                        </div> <!-- end card body-->
	                    </div> <!-- end card -->
	                </div> <!-- end col-12 -->
	            </div> <!-- end row -->
	        </div> <!-- container-fluid -->
	    </div> <!-- content -->
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
	   
	   function submitPost() {
		   oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
		   let content = document.getElementById("editorTxt").value
		   let title = document.getElementById("title").value
		   
		   if(title == '') {
		        alert("제목을 입력해주세요.");
		        document.getElementById("title").focus();
		        return;
		    }
	
		   if(content == '<p>&nbsp;</p>' || content == '') {
		     alert("내용을 입력해주세요.")
		     oEditors.getById["editorTxt"].exec("FOCUS")
		     return
		   } else {
		     console.log(content)
		     $("#frm").submit();
		   }
		 }
		 
   </script>

	<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
