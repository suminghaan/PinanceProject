<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<Style>
.card {
	margin-top: 10px;
}
.left-side-menu{
		margin-left:25px;
}
.fc-event, .fc-event-dot {
	background-color: #6f77c8 !important;
	border-color: #6f77c8 !important;
}
.fc-time {
	display:none;
}
.fc-holiday {
  background-color: #DF0101!important;
  font-weight: bold;
}

</Style>

<!-- third party css -->
<link href="${contextPath}/resources/libs/datatables.net-bs5/css/dataTables.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-responsive-bs5/css/responsive.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-buttons-bs5/css/buttons.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/datatables.net-select-bs5/css//select.bootstrap5.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/spectrum-colorpicker2/spectrum.min.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/libs/clockpicker/bootstrap-clockpicker.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">
<link href="${contextPath}/resources/libs/@fullcalendar/core/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/daygrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/timegrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/list/main.min.css" rel="stylesheet" type="text/css" />

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
								<li class="breadcrumb-item active">직원근태관리</li>
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
										<div class="mt-4 mt-xl-0" id="">
                      <div id="calendar" style="width:100%;"></div>
                  	</div>
									</div>
									<section class="vacation-info" style="margin-top: 80px;">
									<input type="hidden" id="selectedDepartment" name="selectedDepartment" value="${loginUser.department}">
										<div style="margin-bottom: 10px;width: 20%;">
	                    <div class="input-group position-relative" id="datepicker4">
	                    	<i class=" ri-calendar-2-line fs-3" style="margin-right: 10px;"></i>
	                      <input type="text" class="form-control" id="monthPicker" data-provide="datepicker" data-date-format="MM yyyy" data-date-min-view-mode="1" data-date-container="#datepicker4">
	                    </div>
										</div>
										<br>
										<table id="basic-datatable" class="table dt-responsive nowrap w-100">
											<thead>
												<tr>
													<th>번호</th>
													<th>기안자</th>
													<th>휴가종류</th>
													<th>사용기간</th>
													<th>결재상태</th>
												</tr>
											</thead>
											<tbody id="empVacSelect">
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
	document.addEventListener('DOMContentLoaded', function() {
		  var calendarEl = document.getElementById('calendar');
		  var userId = '${loginUser.userId}';  // 본인 userId 변수

		  var calendar = new FullCalendar.Calendar(calendarEl, {
		    plugins: ['dayGrid', 'timeGrid', 'list', 'interaction'],
		    headerToolbar: {
		      left: 'prev,next today',
		      center: 'title',
		      right: 'dayGridMonth,timeGridWeek,timeGridDay,listMonth'
		    },
		    editable: true,
		    selectable: true,
		    selectMirror: true,
		    dayMaxEvents: true,

		    events: function(fetchInfo, successCallback, failureCallback) {
		      var events = [];
		      $.ajax({
		        url: 'https://www.googleapis.com/calendar/v3/calendars/ko.south_korea.official%23holiday%40group.v.calendar.google.com/events',
		        dataType: 'json',
		        data: {
		          key: 'AIzaSyAGzgx-XZYcVmwSZ3hjoRaeXnVxN8ne9S4',
		          timeMin: fetchInfo.startStr,
		          timeMax: fetchInfo.endStr,
		          singleEvents: true,
		          orderBy: 'startTime'
		        },
		        success: function(data) {
		          $(data.items).each(function() {
		            events.push({
		              title: this.summary,
		              start: this.start.date || this.start.dateTime,
		              end: this.end.date || this.end.dateTime,
		              allDay: true,
		              className: 'fc-holiday'
		            });
		          });

		          $.ajax({
		            url: '${contextPath}/attendance/empAtt.sc',
		            type: 'GET',
		            dataType: 'json',
		            success: function(regData) {
		              $.each(regData, function(index, attendance) {
		                	if(attendance.defaultDto.regId != userId) { 
		                  var eventTitle = attendance.userName + '\n';
		                  
		                  if (attendance.isAbsent) {
		                    eventTitle += '결근';
		                    events.push({
		                      title: eventTitle,
		                      start: attendance.workDate,
		                      allDay: true
		                    });
		                  } else if (attendance.isLate || attendance.isEarlyLeave) {
		                    if (attendance.isLate) {
		                      eventTitle += '지각\n';
		                    }
		                    if (attendance.isEarlyLeave) {
		                      eventTitle += '조기퇴근\n';
		                    }
		                    events.push({
		                      title: eventTitle,
		                      start: attendance.workDate + 'T' + attendance.workIn,
		                      end: attendance.workDate + 'T' + attendance.workOut,
		                      allDay: false
		                    });
		                  }
		                }
		              });
		              successCallback(events);
		            },
		            error: function() {
		              console.log('근태스케줄 조회 실패');
		              failureCallback();
		            }
		          });
		        },
		        error: function(xhr, status, error) {
		          console.log('Error: ' + error);
		          failureCallback(error);
		        }
		      });
		    }
		  });

		  calendar.render();
		});


	$(document).ready(function() {
	    const currentMonth = new Date().getMonth() + 1; 
	    const formattedCurrentMonth = ("0" + currentMonth).slice(-2); 

	    $('#monthPicker').datepicker({
	        minViewMode: 1, 
	        format: 'mm yyyy',
	        language: 'ko',
	        autoclose: true
	    }).datepicker('setDate', new Date());

	    function fetchVacationInfo(month) {
	    	var userId = '${loginUser.userId}'; 
	        $.ajax({
	            url: '${contextPath}/attendance/empVac.sc',
	            type: 'GET',
	            data: { vacMonth: month, userId: userId },
	            success: function(response) { 
	                const tableBody = $('#empVacSelect');
	                tableBody.empty();

	                if (response.length > 0) {
	                    response.forEach(function(v) {
	                        // 로그인한 사용자를 제외
	                        if (v.defaultDto.regId !== userId) {
	                            var tr = "<tr>" +
	                                "<td>" + v.vacNo + "</td>" +
	                                "<td>" + v.userName + "</td>";
	                                
	                            if (v.vactypeNo == 3) {
	                                tr += "<td> 연차 </td>";
	                            } else if (v.vactypeNo == 4) {
	                                tr += "<td> 반차 </td>";
	                            } else {
	                                tr += "<td> 기타 </td>";
	                            }
	                            
	                            tr += "<td>" + v.vacStart + " ~ " + v.vacEnd + "</td>" + 
	                                     "<td>" + v.vacStatus + "</td></tr>";
	                            
	                            tableBody.append(tr);
	                        }
	                    });
	                } else {
	                    var tr = "<tr><td colspan='5' style='text-align:center;'>선택된 월에 대한 휴가 정보가 없습니다.</td></tr>";
	                    tableBody.append(tr);
	                }
	            },
	            error: function() {
	                console.log("휴가 정보 조회 실패");
	            }
	        });
	    }
	    fetchVacationInfo(formattedCurrentMonth);

	    $('#monthPicker').datepicker().on('changeDate', function(e) {
	        const selectedMonth = e.format('mm');
	        fetchVacationInfo(selectedMonth);
	    });
	});


  </script>
	
<jsp:include page="/WEB-INF/views/common/footer.jsp" />

<!-- Datatables init -->
<script src="${contextPath}/resources/js/pages/datatables.init.js"></script>

<script src="${contextPath}/resources/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script src="${contextPath}/resources/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
<script src="${contextPath}/resources/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
<script src="${contextPath}/resources/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
<script src="${contextPath}/resources/libs/jquery-datatables-checkboxes/js/dataTables.checkboxes.min.js"></script>
<!-- third party js ends -->

<script src="${contextPath}/resources/js/pages/product-list.init.js"></script>

<!-- Plugins js-->
<script src="${contextPath}/resources/libs/spectrum-colorpicker2/spectrum.min.js"></script>
<script src="${contextPath}/resources/libs/clockpicker/bootstrap-clockpicker.min.js"></script>
<script src="${contextPath}/resources/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
<script src="${contextPath}/resources/libs/moment/min/moment.min.js"></script>
<script src="${contextPath}/resources/libs/bootstrap-daterangepicker/daterangepicker.js"></script>

<!-- Init js-->
<script src="${contextPath}/resources/js/pages/form-pickers.init.js"></script>

<script src="${contextPath}/resources/libs/moment/min/moment.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/core/main.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/bootstrap/main.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/daygrid/main.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/timegrid/main.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/list/main.min.js"></script>
<script src="${contextPath}/resources/libs/@fullcalendar/interaction/main.min.js"></script>
  
</body>
</html>
