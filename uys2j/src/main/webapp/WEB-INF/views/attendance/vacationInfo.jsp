<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>나의연차내역</title>
<!-- third party css -->
<link href="${ contextPath }/resources/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/datatables.net-select-bs5/css//select.bootstrap5.min.css" rel="stylesheet" type="text/css" />

<link href="${ contextPath }/resources/libs/spectrum-colorpicker2/spectrum.min.css" rel="stylesheet" type="text/css">
<link href="${ contextPath }/resources/libs/clockpicker/bootstrap-clockpicker.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">

<style>
.card {
	margin-top: 10px;
}

.left-side-menu{
		margin-left:25px;
	}

.myInfo {
	border: 1px solid rgb(214, 214, 214);
	text-align: center;
	width: 100%;
	height: 120px;
}

.myInfo tr td, .myInfo th {
	border: 1px solid rgb(214, 214, 214);
}

.title{
        margin-bottom: 20px; 
        font-weight: bold;
    }

.date-page{
	display: flex; 
	justify-content: space-between;
}
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/header.jsp" />
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

	<div class="content-page">
		<div class="content">

			<!-- Start Content-->
			<div class="container-fluid">
			<!-- start page title -->
			<div class="row">
				<div class="col-12">
					<div class="page-title-box page-title-box-alt" style="margin-top: 20px;">
						<h4 class="page-title"style="margin-left: 20px;">근태관리</h4>
						<div class="page-title-right">
							<ol class="breadcrumb m-0">
								<li class="breadcrumb-item"><a href="javascript: void(0);">근태관리</a></li>
								<li class="breadcrumb-item active">내 휴가정보</li>
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
								<div class="vacation-content">
									<div class="date-page">
										<div class="cal-head" style="margin-bottom: 20px;">
											<div class="input-group position-relative" id="datepicker5">
                          <i class=" ri-calendar-2-line fs-3" style="margin-right: 10px;"></i>
                          <input type="text" class="form-control datepicker" id="yearPicker" data-provide="datepicker" data-date-format="dd M, yyyy" data-date-min-view-mode="2" data-date-container="#datepicker5">
                      </div>
										</div>
										<div style="margin-top: 20px;">
											<button type="button" class="btn btn-white waves-effect" onclick="location.href='${contextPath}/edoc/edocInsert.page'">휴가신청</button>
										</div>
									</div>
									<section class="total-vacation">
										<h4 class="title">휴가생성내역</h4>
										<table class="myInfo">
											<thead style="height: 80px;">
												<tr>
													<th rowspan="2" style="width: 15%;">생성일</th>
													<th colspan="2" style="width: 30%;">생성내역</th>
													<th rowspan="2" style="width: 15%;">내용</th>
													<th rowspan="2" style="width: 40%;">비고</th>
												</tr>
												<tr>
													<th>발생</th>
													<th>합계</th>
												</tr>
											</thead>
											<tbody id="vacationInfoYear">
											<!-- 
											<c:forEach var="vo" items="${ vo }">
												<tr>
													<td id="regTime">${vo.defaultDto.regTime}</td>
													<td>${vo.vacTotal}일</td>
													<td>${vo.vacTotal}일</td>
													<td>정기 휴가</td>
													<td>연차 (${vo.vacTotal}일 x 8시간 = ${vo.vacTotal * 8}시간)</td>
												</tr>
											</c:forEach>
											 -->
											</tbody>
										</table>
									</section>
									<section class="vacation-info" style="margin-top: 80px;">
										<h4 class="title">휴가사용내역</h4>
										<table id="basic-datatable"
											class="table dt-responsive nowrap w-100">
											<thead>
												<tr>
													<th>이름</th>
													<th>휴가종류</th>
													<th>사용연차</th>
													<th>사용기간</th>
													<th>결재상태</th>
													<th>상세</th>
												</tr>
											</thead>
											<tbody>
											<c:choose>
										    <c:when test="${ empty v }">
										        <tr>
										            <td colspan="6" style="text-align: center;">조회된 게시글이 없습니다.</td>
										        </tr>
										    </c:when>
										    <c:otherwise>
													<c:forEach var="v" items="${v}">
														<tr>
															<td>${loginUser.userName}</td>
															<td>
																<c:choose>
														        <c:when test="${v.vactypeNo == 3}">
														            연차
														        </c:when>
														        <c:when test="${v.vactypeNo == 4}">
														            반차
														        </c:when>
														        <c:otherwise>
														            기타
														        </c:otherwise>
														    </c:choose>
															</td>
															<td>${v.distanceDay}</td>
															<td>${v.vacStart} ~ ${v.vacEnd}</td>
															<td>${v.vacStatus}</td>
															<td><a href="${contextPath}/edoc/edocDetail.do?no=${v.refNo}">상세</a></td>
														</tr>
													</c:forEach>
												</c:otherwise>
											</c:choose>
										</tbody>
									</table>
								</section>
							</div>
						</div>
						<!-- end card body-->
					</div>
					<!-- end card -->
				</div>
				<!-- end col-12 -->
			</div>
			<!-- end row -->
		</div>
		<!-- container-fluid -->
	</div>
	<!-- content -->
</div>
	
	<script>
	$(document).ready(function() {
	    const currentYear = new Date().getFullYear();
	    
	    $('#yearPicker').datepicker({
	        minViewMode: 2,
	        format: 'yyyy'
	    }).datepicker('setDate', new Date());

	    function fetchVacationInfo(year) {
	        $.ajax({
	            url: '${contextPath}/attendance/vacationInfo.year',
	            type: 'GET',
	            data: { userNo: "${loginUser.userNo}", vacYear: year },
	            success: function(response) {
	                const tableBody = $('#vacationInfoYear');
	                tableBody.empty();

	                if (response.length > 0) {
	                    response.forEach(function(vo) {
	                        var tr = "<tr>" +
	                            "<td>" + (vo.defaultDto && vo.defaultDto.regTime ? vo.defaultDto.regTime : 'N/A') + "</td>" +
	                            "<td>" + vo.vacTotal + '일' + "</td>" +
	                            "<td>" + vo.vacTotal + '일' + "</td>" +
	                            "<td>정기 휴가</td>" +
	                            "<td>연차 " + vo.vacTotal + '일 x 8시간 = ' + vo.vacTotal * 8 + '시간' + "</td>" +
	                        "</tr>";
	                        tableBody.append(tr);
	                    });
	                } else {
	                    var tr = "<tr><td colspan='5'>선택된 연도에 대한 휴가 정보가 없습니다.</td></tr>";
	                    tableBody.append(tr);
	                }
	            },
	            error: function() {
	                console.log("error");
	            }
	        });
	    }

	    fetchVacationInfo(currentYear);

	    $('#yearPicker').datepicker().on('changeDate', function(e) {
	        const selectedYear = e.format('yyyy');
	        fetchVacationInfo(selectedYear);
	    });
	});

	</script>


	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
	
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
  
  <!-- Plugins js-->
  <script src="${ contextPath }/resources/libs/spectrum-colorpicker2/spectrum.min.js"></script>
  <script src="${ contextPath }/resources/libs/clockpicker/bootstrap-clockpicker.min.js"></script>
  <script src="${ contextPath }/resources/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
  <script src="${ contextPath }/resources/libs/moment/min/moment.min.js"></script>
  <script src="${ contextPath }/resources/libs/bootstrap-daterangepicker/daterangepicker.js"></script>

  <!-- Init js-->
  <script src="${ contextPath }/resources/js/pages/form-pickers.init.js"></script>
</body>
</html>