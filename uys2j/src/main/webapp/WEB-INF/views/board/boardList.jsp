<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 목록</title>
<!-- third party css -->
<link href="${ contextPath }/resources/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-select-bs5/css//select.bootstrap5.min.css" rel="stylesheet" type="text/css" />
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
<div class="wapper">
</div>
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
									<li class="breadcrumb-item active">게시글 목록</li>
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
                            <div class="board-content">
                           		 <c:forEach var="bn" items="${ bList }">
	                           	 		 <c:if test="${bn.boardNo eq param.type}">
		                                <h3 style="margin-bottom: 30px;">${ bn.boardName }</h3>
		                            	</c:if>
		                            </c:forEach>
		                                    <div class="board-write" style="text-align: right; margin-bottom: 20px;">
		                                    	<c:forEach var="bn" items="${ bList }">
																				    <c:if test="${bn.boardNo eq param.type}">
																				        <!-- 관리자(R)와 일반 사용자를 구분하여 글쓰기 버튼 표시 -->
																				        <c:choose>
																				            <c:when test="${bn.defaultRole eq 'R'}">
																				                <c:if test="${loginUser.status eq 'A' || loginUser.status eq 'G'}">
																				                    <a href="${ contextPath }/board/registForm.page?boardNo=${bn.boardNo}" class="btn btn-white waves-effect">글쓰기</a>
																				                </c:if>
																				            </c:when>
																				            <c:otherwise>
																				                <a href="${ contextPath }/board/registForm.page?boardNo=${bn.boardNo}" class="btn btn-white waves-effect">글쓰기</a>
																				            </c:otherwise>
																				        </c:choose>
																				    </c:if>
																				</c:forEach>
		                                    </div>
		                                    <div class="boardList">
		                                        <table id="basic-datatable" class="table dt-responsive nowrap w-100">
		                                            <thead>
		                                                <tr>
		                                                    <th>게시글번호</th>
		                                                    <th>제목</th>
		                                                    <th>작성자</th>
		                                                    <th>작성일</th>
		                                                    <th>조회수</th>
		                                                </tr>
		                                            </thead>
		                                            <tbody>
		                                           		<c:choose>
																								    <c:when test="${ empty list }">
																								        <tr>
																								            <td colspan="5" style="text-align: center;">조회된 게시글이 없습니다.</td>
																								        </tr>
																								    </c:when>
																								    <c:otherwise>
																								        <c:forEach var="b" items="${ list }">
																								            <tr onclick="location.href='${contextPath}/board/${loginUser.userId == b.defaultDto.regId ? 'boardDetail.do' : 'increase.do'}?no=${b.postNo}';" style="cursor: pointer;">
																								                <td>${ b.postNo }</td>
																								                <td>${ b.postTitle }</td>
																								                <c:choose>
																								                    <c:when test="${b.boardType eq 'BA002'}">
																								                        <td><span style="font-size: medium; margin-right: 10px;">익명</span></td>
																								                    </c:when>
																								                    <c:otherwise>
																								                        <td><span style="font-size: medium; margin-right: 10px;">${b.userName}</span></td>
																								                    </c:otherwise>
																								                </c:choose>
																								                <td>${ b.defaultDto.regTime }</td>
																								                <td>${ b.postCount }</td>
																								            </tr>
																								        </c:forEach>
																								    </c:otherwise>
																								</c:choose>
		                                            </tbody>
		                                        </table>
		                                    </div>
	                            </div>
	                        </div> <!-- end card body-->
	                    </div> <!-- end card -->
	                </div><!-- end col-12 -->
	            </div> <!-- end row -->
	        </div> <!-- container-fluid -->
	    </div> <!-- content -->
	</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>

<!-- third party js -->
<script src="${ contextPath }/resources/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-buttons/js/dataTables.buttons.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-buttons-bs5/js/buttons.bootstrap5.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-buttons/js/buttons.html5.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-buttons/js/buttons.flash.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-buttons/js/buttons.print.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-keytable/js/dataTables.keyTable.min.js"></script>
<script src="${ contextPath }/resources/libs/datatables.net-select/js/dataTables.select.min.js"></script>
<script src="${ contextPath }/resources/libs/pdfmake/build/pdfmake.min.js"></script>
<script src="${ contextPath }/resources/libs/pdfmake/build/vfs_fonts.js"></script>
<!-- third party js ends -->

<!-- Datatables init -->
<script src="${ contextPath }/resources/js/pages/datatables.init.js"></script>
</body>
</html>