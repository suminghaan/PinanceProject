	<%@ page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
	<!DOCTYPE html>
	<html>
	<head>
	<meta charset="UTF-8">
	<title>비품 관리</title>
	
	<style>
	.bg-success {
		background-color: #4A55A2 !important;
	}
	
	.inline-block {
		display: inline-block; /* 인라인-블록으로 설정하여 요소들을 한 줄에 정렬 */
	}
	
	.body {
		padding: 30px;
	}
	</style>
	
	</head>
	<body>
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
								<h4 class="page-title">비품관리</h4>
								<div class="page-title-right">
									<ol class="breadcrumb m-0">
										<li class="breadcrumb-item"><a href="javascript: void(0);">시설비품관리</a></li>
										<li class="breadcrumb-item active">비품관리</li>
									</ol>
								</div>
							</div>
						</div>
					</div>
					<!-- end page title -->
	
					<div class="row">
						<div class="col-12">
							<div class="card"
								style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
								<div class="card-body">
									<h4 class="header-title">비품관리</h4>
									<br>
									<p class="sub-header" style="text-align: right;">
									<c:if test="${loginUser.status eq 'A' or loginUser.status eq 'G'}">
									    <a href="${contextPath}/eq/eq_stock.page" class="btn btn-outline-info rounded-pill" style="color: #4A55A2; border: 1px solid #4A55A2;">비품 등록</a>
									</c:if>
									    <a href="${contextPath}/edoc/edocInsert.page" class="btn btn-outline-info rounded-pill" style="color: #4A55A2; border: 1px solid #4A55A2;">비품 신청</a>
									</p>

	
									<div class="mb-2">
										<div class="row row-cols-lg-auto g-2 align-items-center">
											<div class="col-12">
												<div>
													<select id="demo-foo-filter-status"
														class="form-select form-select-sm">
														<option value="">전체보기</option>
														<option value="보유">보유</option>
														<option value="소진">소진</option>
													</select>
												</div>
											</div>
	
											<div class="col-12">
												<input id="demo-foo-search" type="text" placeholder="Search"
													class="form-control form-control-sm" autocomplete="on">
											</div>
										</div>
									</div>
	
									<div class="table-responsive">
										<table id="demo-foo-filtering"
											class="table table-bordered toggle-circle mb-0"
											data-page-size="7">
											<thead>
												<tr>
													<th>비품</th>
													<th>비품명</th>
													<th>비품갯수</th>
													<th>등록일</th>
													<th>상태</th>
												</tr>
											</thead>
											<tbody id="table-body">
								                <tr id="no-data">
								                    <td colspan="5" style="text-align: center;">조회된 비품이 없습니다.</td>
								                </tr>
								             </tbody>
                                                <tfoot>
                                                <tr class="active">
                                                    <td colspan="5">
                                                        <div>
                                                            <ul class="pagination pagination-rounded justify-content-end footable-pagination mb-0"></ul>
                                                        </div>
                                                    </td>
                                                </tr>
                                             </tfoot>
										</table>
									</div>
									<!-- end .table-responsive-->
								</div>
							</div>
							<!-- end card -->
						</div>
						<!-- end col -->
					</div>
					<!-- end row -->
	
				</div>
				<!-- container -->
	
			</div>
			<!-- content -->
	
	
	
		</div>
			<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
			<!-- Footable js -->
			<script
				src="${ contextPath }/resources/libs/footable/footable.all.min.js"></script>
	
			<!-- Init js -->
			<script src="${ contextPath }/resources/js/pages/foo-tables.init.js"></script>
	
			<!-- App js -->
			<script src="${ contextPath }/resources/js/app.min.js"></script>
		</div>
		
		 <script>
		 $(document).ready(function() {
			    $.ajax({
			        url: '${contextPath}/eq/select.eq',
			        type: 'GET',
			        success: function(data) {
			            var tbody = $('#table-body');
			            tbody.empty();

			            if (data.length === 0) {
			                tbody.append('<tr id="no-data"><td colspan="5" style="text-align: center;">조회된 비품이 없습니다.</td></tr>');
			            } else {
			                data.forEach(function(e) {
			                    var statusLabel;
			                    if (e.status === 'Y') {
			                        statusLabel = '<span class="badge label-table bg-success">보유</span>';
			                    } else if (e.status === 'S') {
			                        statusLabel = '<span class="badge label-table bg-secondary text-light">소진</span>';
			                    } else {
			                        statusLabel = e.status;
			                    }
			                    
			                    var regTimeShort = e.regTime.substring(0, 10);
			                    var imgElement = '<img src="${contextPath}' + e.attach.filePath + '/' + e.attach.filesystemName + '" alt="Image" style="max-width: 100px; max-height: 100px;"/>';

			                    // eqNo를 데이터 속성으로 추가하고, 행에 onClick 이벤트 추가
			                    var row = '<tr data-eqno="' + e.eqNo + '" onclick="redirectToUpdatePage(this)">' +
			                        '<td>' + imgElement + '</td>' +
			                        '<td>' + e.eqName + '</td>' +
			                        '<td>' + e.eqCount + '</td>' +
			                        '<td>' + regTimeShort + '</td>' +
			                        '<td>' + statusLabel + '</td>' +
			                        '</tr>';
			                    tbody.append(row);
			                });
			            }
			        },
			        error: function() {
			            alert('데이터를 불러오는데 실패했습니다.');
			        }
			    });
			});

			// 행 클릭 시 호출되는 JavaScript 함수
			function redirectToUpdatePage(row) {
			    var eqNo = $(row).data('eqno');
			    var url = '${contextPath}/eq/eqUpdate.page?eqNo=' + eqNo;
			    window.location.href = url;
			}

			</script>

		
	</body>
	</html>