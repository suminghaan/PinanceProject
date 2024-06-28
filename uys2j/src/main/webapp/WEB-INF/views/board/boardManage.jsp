<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- third party css -->
<link href="${contextPath}/resources/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-select-bs5/css//select.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<!-- third party css end -->

<!-- App css -->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet" />

<style>
   .card {
       margin-top: 10px;
   }
   .left-side-menu {
       margin-left: 25px;
   }
</style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    <jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

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
												<li class="breadcrumb-item active">게시판 관리</li>
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
                                <div class="board-make" style="text-align: right;">
                                    <a href="${contextPath}/board/boardCreate.page" class="btn btn-light mb-2"><i class="mdi mdi-plus-circle me-1"></i>게시판 만들기</a>
                                </div>
                                <div class="table-responsive">
                                    <table id="basic-datatable" class="table dt-responsive nowrap w-100" id="products-datatable">
                                        <thead class="table-light">
                                            <tr>
                                                <th>종류</th>
                                                <th>유형</th>
                                                <th>게시판이름</th>
                                                <th>관리자</th>
                                                <th>게시글수</th>
                                                <th>만든날짜</th>
                                                <th style="width: 75px;">관리</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="bn" items="${boardList}">
                                                <tr>
                                                    <td>${bn.boardType eq 'BG' ? '그룹게시판' : '전체게시판' }</td>
                                                    <td>${bn.boardType eq 'BA002' ? '익명' : '일반' }</td>
                                                    <td>${bn.boardName}</td>
                                                    <td>${bn.userName}</td>
                                                    <td>${bn.postCount}</td>
                                                    <td>${bn.defaultDto.regTime}</td>
                                                    <td>
                                                        <ul class="list-inline mb-0">
                                                            <li class="list-inline-item">
                                                                <a href="${contextPath}/board/modifyBoard.page?no=${bn.boardNo}" class="action-icon"><i class="mdi mdi-square-edit-outline"></i></a>
                                                            </li>
                                                            <li class="list-inline-item">
                                                                <a href="javascript:void(0);" class="action-icon delete-btn" data-boardno="${bn.boardNo}"><i class="mdi mdi-delete"></i></a>
                                                            </li>
                                                        </ul>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <script>
                                $(document).ready(function() {
                                    $(document).on("click", ".delete-btn", function() {
                                        if (confirm("정말로 삭제하시겠습니까?")) {
                                            const boardRow = $(this).closest("tr");

                                            $.ajax({
                                                url: "${contextPath}/board/removeBoard.do",
                                                type: "get",
                                                data: { no: $(this).data("boardno") },
                                                success: function(result) {
                                                    if (result == "SUCCESS") {
                                                        boardRow.remove();
                                                    }
                                                },
                                                error: function() {
                                                    console.log("게시판 삭제 실패");
                                                }
                                            });
                                        }
                                    });
                                });
                                </script>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- end row -->
            </div>
            <!-- container -->
        </div>
        <!-- content -->
    </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />

    <script src="${contextPath}/resources/js/pages/datatables.init.js"></script>

		<script src="${contextPath}/resources/libs/datatables.net/js/jquery.dataTables.min.js"></script>
		<script src="${contextPath}/resources/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
		<script src="${contextPath}/resources/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
		<script src="${contextPath}/resources/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
		<script src="${contextPath}/resources/libs/jquery-datatables-checkboxes/js/dataTables.checkboxes.min.js"></script>
		<!-- third party js ends -->
		
		<script src="${contextPath}/resources/js/pages/product-list.init.js"></script>
</body>
</html>