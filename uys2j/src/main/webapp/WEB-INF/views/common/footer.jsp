<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!-- Vendor js -->
	<script src="${ contextPath }/resources/js/vendor.min.js"></script>

	<!-- init js -->
	<%-- <script src="${ contextPath }/resources/js/pages/flot.init.js"></script> --%>

  <!-- Chart JS -->
  <script src="${ contextPath }/resources/libs/chart.js/Chart.bundle.min.js"></script>
    
  <!-- Init js -->
  <script src="${ contextPath }/resources/js/pages/chartjs.init.js"></script>
    
  <!-- flot-charts js -->
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.time.js"></script>
  <script src="${ contextPath }/resources/libs/jquery.flot.tooltip/js/jquery.flot.tooltip.min.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.resize.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.pie.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.selection.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.stack.js"></script>
  <script src="${ contextPath }/resources/libs/flot-orderbars/js/jquery.flot.orderBars.js"></script>
  <script src="${ contextPath }/resources/libs/flot-charts/jquery.flot.crosshair.js"></script>

	<!-- Apex js-->
	<script src="${ contextPath }/resources/libs/apexcharts/apexcharts.min.js"></script>
	
	<!-- Plugins js-->
	<script src="${ contextPath }/resources/libs/admin-resources/jquery.vectormap/jquery-jvectormap-1.2.2.min.js"></script>
	<script src="${ contextPath }/resources/libs/admin-resources/jquery.vectormap/maps/jquery-jvectormap-world-mill-en.js"></script>
	
	<!-- App js -->
	<%-- <script src="${ contextPath }/resources/js/app.min.js"></script> --%>


 


</body>
</html>