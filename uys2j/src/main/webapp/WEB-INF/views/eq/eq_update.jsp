<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비품 수정</title>
<style>
    .error {
        color: red;
        font-size: small;
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
                                        <li class="breadcrumb-item active">비품수정</li>
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
                                    <h4 class="header-title">비품 수정</h4>
                                    <p class="sub-header">수정하시려는 비품의 정보를 입력해주세요.</p>

                                    <div class="row">
                                        <div class="col-12">
                                            <div class="p-2">
                                                <form class="form-horizontal" method="post" role="form" id="eqUpdate" action="${contextPath}/eq/update.eq" enctype="multipart/form-data" onsubmit="return validateForm()">
                                                    <input type="hidden" name="eqNo" value="${eqdto.eqNo}">
                                                    <input type="hidden" name="delFileNo" value="${eqdto.attach.fileNo}">
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="example-fileinput">비품사진</label>
                                                        <div class="col-md-10">
                                                            <input type="file" class="form-control" id="example-fileinput" name="uploadFiles">
                                                            <span style="margin-left: 7%; font-size: small;">현재 업로드된 파일 : ${eqdto.attach.originalName}</span><br>
                                                            <span id="uploadFiles-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqname">비품명</label>
                                                        <div class="col-md-10">
                                                            <input type="text" id="eqname" class="form-control" name="eqName" placeholder="비품명" value="${eqdto.eqName}">
                                                            <span id="eqname-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqcategory">비품카테고리</label>
                                                        <div class="col-md-10">
                                                            <input type="text" id="eqcategory" name="eqCategory" class="form-control" placeholder="비품카테고리" value="${eqdto.eqCategory}">
                                                            <span id="eqcategory-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqcount">비품갯수</label>
                                                        <div class="col-md-10">
                                                            <input type="number" id="eqcount" name="eqCount" class="form-control" value="${eqdto.eqCount}">
                                                            <span id="eqcount-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqprice">비품가격</label>
                                                        <div class="col-md-10">
                                                            <input type="number" id="eqprice" name="eqPrice" class="form-control" value="${eqdto.eqPrice}">
                                                            <span id="eqprice-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqbuyplace">구입처</label>
                                                        <div class="col-md-10">
                                                            <input type="text" id="eqbuyplace" name="eqBuyplace" class="form-control" placeholder="구입처" value="${eqdto.eqBuyplace}">
                                                            <span id="eqbuyplace-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div class="mb-2 row">
                                                        <label class="col-md-2 col-form-label" for="eqreason">구입사유</label>
                                                        <div class="col-md-10">
                                                            <textarea id="eqreason" name="eqReason" class="form-control" placeholder="구입사유" style="min-height: 250px;">${eqdto.eqReason}</textarea>
                                                            <span id="eqreason-error" class="error"></span>
                                                        </div>
                                                    </div>
                                                    <div style="text-align: right;">
                                                        <button type="submit" class="btn btn-primary" style="background-color: #4A55A2; color: #ffffff;">수정</button>
                                                        <button type="button" class="btn btn-primary" onclick="eqDelete(${eqdto.eqNo});" style="background-color: #4A55A2; color: #ffffff;">삭제</button>
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
    
    <script>
        function eqDelete(eqNo) {
           location.href = "${contextPath}/eq/delete.eq?eqNo=" + eqNo;
        }

        function validateForm() {
            let isValid = true;

            const fields = [
                { id: 'eqname', errorId: 'eqname-error', message: '비품명을 입력해주세요.' },
                { id: 'eqcategory', errorId: 'eqcategory-error', message: '비품카테고리를 입력해주세요.' },
                { id: 'eqcount', errorId: 'eqcount-error', message: '비품갯수를 입력해주세요.' },
                { id: 'eqprice', errorId: 'eqprice-error', message: '비품가격을 입력해주세요.' },
                { id: 'eqbuyplace', errorId: 'eqbuyplace-error', message: '구입처를 입력해주세요.' },
                { id: 'eqreason', errorId: 'eqreason-error', message: '구입사유를 입력해주세요.' }
            ];

            fields.forEach(field => {
                const element = document.getElementById(field.id);
                const errorElement = document.getElementById(field.errorId);
                if (!element.value.trim()) {
                    isValid = false;
                    errorElement.textContent = field.message;
                } else {
                    errorElement.textContent = '';
                }
            });

            return isValid;
        }

        document.getElementById('eqUpdate').addEventListener('input', function (event) {
            const field = event.target;
            const errorElement = document.getElementById(`${field.id}-error`);
            if (field.value.trim()) {
                errorElement.textContent = '';
            } else {
                const fields = {
                    'eqname': '비품명을 입력해주세요.',
                    'eqcategory': '비품카테고리를 입력해주세요.',
                    'eqcount': '비품갯수를 입력해주세요.',
                    'eqprice': '비품가격을 입력해주세요.',
                    'eqbuyplace': '구입처를 입력해주세요.',
                    'eqreason': '구입사유를 입력해주세요.'
                };
                errorElement.textContent = fields[field.id];
            }
        });
    </script>

</body>
</html>
