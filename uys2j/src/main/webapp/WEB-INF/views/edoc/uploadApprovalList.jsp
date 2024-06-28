<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>결재 상신함</title>
<style>
.bg-success{
	background-color: #4A55A2 !important;
}

.btn-primary{
	background-color: #4A55A2 !important;
	border-color:#4A55A2 !important;
}

</style>
</head>
<body>

<div id="wrapper">
   <jsp:include page="/WEB-INF/views/common/header.jsp"/>
   <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>




<div class="content-page">
  <div class="content">

      <!-- Start Content-->
      <div class="container-fluid">
          
          <!-- start page title -->
          <div class="row">
              <div class="col-12">
                  <div class="page-title-box page-title-box-alt">
                      <h4 class="page-title">결재상신함</h4>
                      <div class="page-title-right">
                          <ol class="breadcrumb m-0">
                              <li class="breadcrumb-item"><a href="javascript: void(0);">전자결재</a></li>
                              <li class="breadcrumb-item"><a href="javascript: void(0);">결재상신함</a></li>
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
                          <h4 class="header-title" style="font-size:2rem">결재상신함</h4>
                          <p class="sub-header">
                           내가 올린 결재 목록
                          </p>

                          <div class="mb-2">
                              <div class="row row-cols-lg-auto g-2 align-items-center">
                                  <div class="col-12">
                                      <div>
                                          <select id="demo-foo-filter-status" class="form-select form-select-sm">
                                              <option value="">전체조회</option>
                                              <option value="결재중">결재중</option>
                                              <option value="미결재">미결재</option>
                                          </select>
                                      </div>
                                  </div>

                                  <div class="col-12">
                                      <input id="demo-foo-search" type="text" placeholder="Search" class="form-control form-control-sm" autocomplete="on">
                                  </div>
                                  
                                  <div class="col-12 text-end">
                                  	<a href="${contextPath}/edoc/edocInsert.page" class="btn btn-sm btn-primary rounded-pill waves-effect waves-light">결재기안</a>
                                  </div>
                              </div>
                          </div>
                          
                          <div class="table-responsive">
                              <table id="demo-foo-filtering" class="table table-bordered toggle-circle mb-0" data-page-size="10">
                                  <thead>
                                  <tr>
                                      <th data-toggle="true">문서번호</th>
                                      <th>제목</th>
                                      <th data-hide="phone">문서종류</th>
                                      <th data-hide="phone, tablet">기안일</th>
                                      <th data-hide="phone, tablet">결재상태</th>
                                  </tr>
                                  </thead>
                                  <tbody>
                                  	<c:forEach var="edoc" items="${list}">
		                                  <tr onclick="location.href='${contextPath}/edoc/edocDetail.do?no=${edoc.docNo}';">
		                                      <td>${edoc.docNo}</td>
		                                      <td>${edoc.docTitle}</td>
		                                      <td>${edoc.sampleDto.sampleTitle}</td>
		                                      <td>${edoc.defaultDto.regTime}</td>
		                                      <td>
		                                      	<c:choose>
		                                
		                                      		<c:when test="${ edoc.status eq 'W' }">
		                                      			<span class="badge label-table bg-success">결재중</span>
		                                      		</c:when>
		                                      		<c:otherwise>
		                                      			<span class="badge label-table bg-secondary text-light">미결재</span>
		                                      		</c:otherwise>
		                                      	</c:choose>                                 	
		                                      </td>
		                                  </tr>		                                  
		                                 </c:forEach>
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
                          </div> <!-- end .table-responsive-->
                      </div>
                  </div> <!-- end card -->
              </div> <!-- end col -->
          </div>
          <!-- end row -->  
          
      </div> <!-- container -->

  </div> <!-- content -->
</div>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</div>
<!-- Vendor js -->
<%-- <script src="${ contextPath }/resources/js/vendor.min.js"></script> --%>
<!-- Tree view js -->
<script src="${contextPath}/resources/libs/jstree/jstree.min.js"></script>

<script src="${contextPath}/resources/js/pages/treeview.init.js"></script>
<!-- Footable js -->
<script src="${ contextPath }/resources/libs/footable/footable.all.min.js"></script>

<!-- Init js -->
<script src="${ contextPath }/resources/js/pages/foo-tables.init.js"></script>

<!-- App js -->
<script src="${ contextPath }/resources/js/app.min.js"></script>
	
</body>
</html>