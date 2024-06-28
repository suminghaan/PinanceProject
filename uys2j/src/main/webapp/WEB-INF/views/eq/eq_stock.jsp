<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품 등록</title>
<style>
    .error-message {
        color: red;
        font-size: 0.9em;
        display: none;
    }
</style>
<script>
    function validateForm() {
        var isValid = true;
        var requiredFields = ["eqname", "eqcategory", "eqcount", "eqprice", "eqbuyplace", "eqreason"];
        requiredFields.forEach(function(field) {
            var inputElement = document.getElementById(field);
            var errorElement = document.getElementById(field + "-error");
            if (!inputElement.value.trim()) {
                errorElement.style.display = 'block';
                isValid = false;
            } else {
                errorElement.style.display = 'none';
            }
        });
        return isValid;
    }
</script>
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
										<li class="breadcrumb-item"><a
											href="javascript: void(0);">시설비품관리</a></li>
										<li class="breadcrumb-item active">비품등록</li>
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
									<h4 class="header-title">비품 등록</h4>
									<p class="sub-header">등록하시려는 비품의 정보를 입력해주세요.</p>

									<div class="row">
										<div class="col-12">
											<div class="p-2">
												<form class="form-horizontal" role="form" id="eqInsert" action="${ contextPath }/eq/insert.eq" method="post" enctype="multipart/form-data" onsubmit="return validateForm()">
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label"
															for="example-fileinput">비품사진</label>
														<div class="col-md-10">
															<input type="file" class="form-control"
																id="example-fileinput" name="uploadFiles">
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqname">비품명</label>
														<div class="col-md-10">
															<input type="text" id="eqname" class="form-control" name="eqName"
																placeholder="비품명">
                                                            <span id="eqname-error" class="error-message">비품명을 입력해주세요.</span>
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqcategory">비품카테고리</label>
														<div class="col-md-10">
															<input type="text" id="eqcategory" name="eqCategory"
																class="form-control" placeholder="비품카테고리">
                                                            <span id="eqcategory-error" class="error-message">비품카테고리를 입력해주세요.</span>
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqcount">비품갯수</label>
														<div class="col-md-10">
															<input type="number" id="eqcount" name="eqCount"
																class="form-control">
                                                            <span id="eqcount-error" class="error-message">갯수를 입력해주세요.</span>
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqprice">비품가격</label>
														<div class="col-md-10">
															<input type="number" id="eqprice" name="eqPrice"
																class="form-control">
                                                            <span id="eqprice-error" class="error-message">가격을 입력해주세요.</span>
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqbuyplace">구입처</label>
														<div class="col-md-10">
															<input type="text" id="eqbuyplace" name="eqBuyplace"
																class="form-control" placeholder="구입처">
                                                            <span id="eqbuyplace-error" class="error-message">구입처를 입력해주세요.</span>
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="eqreason">구입사유</label>
														<div class="col-md-10">
															<textarea id="eqreason" name="eqReason"
																class="form-control" placeholder="구입사유"
																style="min-height: 250px;"></textarea>
                                                            <span id="eqreason-error" class="error-message">구입사유를 입력해주세요.</span>
														</div>
													</div>
													<div style="text-align: right;">
														<button type="submit" class="btn btn-primary"
															style="background-color: #4A55A2; color: #ffffff;">등록</button>
													</div>

												</form>
											</div>
										</div>

									</div>
									<!-- end row -->
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

			<jsp:include page="/WEB-INF/views/common/footer.jsp" />


			<!-- App js -->
			<script src="${ contextPath }/resources/js/app.min.js"></script>

		</div>
	</div>

</body>
</html>
