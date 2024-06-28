<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 등록</title>
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
								<h4 class="page-title">시설관리</h4>
								<div class="page-title-right">
									<ol class="breadcrumb m-0">
										<li class="breadcrumb-item"><a
											href="javascript: void(0);">시설시설관리</a></li>
										<li class="breadcrumb-item active">시설등록</li>
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
									<h4 class="header-title">시설 등록</h4>
									<p class="sub-header">등록하시려는 시설의 정보를 입력해주세요.</p>

									<div class="row">
										<div class="col-12">
											<div class="p-2">
												<form class="form-horizontal" role="form" id="facInsert" action="${ contextPath }/fac/insert.fac" method="post" enctype="multipart/form-data">
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label"
															for="example-fileinput">시설사진</label>
														<div class="col-md-10">
															<input type="file" class="form-control"
																id="example-fileinput" name="uploadFiles">
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="facname">시설명</label>
														<div class="col-md-10">
															<input type="text" id="facname" class="form-control" name="facName"
																placeholder="시설명">
														</div>
													</div>
													<div class="mb-2 row">
														<label class="col-md-2 col-form-label" for="faccategory">시설카테고리</label>
														<div class="col-md-10">
															<input type="text" id="faccategory" name="facCategory"
																class="form-control" placeholder="시설카테고리">
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