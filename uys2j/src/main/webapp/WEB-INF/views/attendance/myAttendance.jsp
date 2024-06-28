<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>나의근태현황</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<!-- Plugin CSS -->
<link href="${contextPath}/resources/libs/@fullcalendar/core/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/daygrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/timegrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/@fullcalendar/list/main.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/libs/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">

<!-- App CSS -->
<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<link href="${contextPath}/resources/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet" />
<link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css" />

<!-- Theme Config JS -->
<script src="${contextPath}/resources/js/config.js"></script>

<!-- FullCalendar JS -->
<script src='https://unpkg.com/@fullcalendar/core@5.10.1/main.min.js'></script>
<script src='https://unpkg.com/@fullcalendar/daygrid@5.10.1/main.min.js'></script>
<script src='https://unpkg.com/@fullcalendar/timegrid@5.10.1/main.min.js'></script>
<script src='https://unpkg.com/@fullcalendar/list@5.10.1/main.min.js'></script>

<style>
.card { margin-top: 10px; } 
.left-side-menu{
	margin-left:25px;
}
.box-group {
    display: grid; 
    grid-template-columns: repeat(3, 1fr);
    gap: 18px; 
    margin-bottom: 50px;
}
.box-title {
    margin-bottom: 15px; 
    line-height: 20px;
}
.box {
    border: 1px solid #d9d9d9; 
    min-height: 116px; 
    display: flex; 
    flex-wrap: wrap; 
    align-items: center;
}
.attendance {
    list-style: none; 
    display: flex; 
    padding-left: 0rem; 
    width: 100%; 
    margin-top: 16px;
}
.attendance-list {
    flex: 1 1 0; 
    justify-content: space-around; 
    position: relative; 
    display: flex; 
    flex-direction: column; 
    text-align: center;
}
.subtitle-count {
    margin-top: 20px;
}
.vacBtn {
    position: relative; 
    display: inline-flex; 
    align-items: center; 
    justify-content: center;
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
									<h4 class="page-title"style="margin-left: 20px;">근태관리</h4>
									<div class="page-title-right">
										<ol class="breadcrumb m-0">
											<li class="breadcrumb-item"><a href="javascript: void(0);">근태관리</a></li>
											<li class="breadcrumb-item active">내 근태</li>
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
                                <section class="info-year">
                                    <h3 style="margin-bottom: 30px;">올해 근무현황</h3>
                                    <div class="box-group">
                                        <div>
                                            <div class="box-title">
                                                <i class="ri-article-line fa-lg" style="margin-right: 5px;"></i>
                                                <span style="font-size: 15px; font-weight: bold;">나의 근태현황</span>
                                            </div>
                                            
                                            <div class="box">
                                                <ul class="attendance">
                                                    <li class="attendance-list">
                                                        <div class="subtitle">
                                                            <span>지각</span>
                                                        </div>
                                                        <div class="subtitle-count">
                                                            <span>${lateCount}</span> 회
                                                        </div>
                                                    </li>
                                                    <li class="attendance-list">
                                                        <div class="subtitle">
                                                            <span>조기퇴근</span>
                                                        </div>
                                                        <div class="subtitle-count">
                                                            <span>${earlyLeaveCount}</span> 회
                                                        </div>
                                                    </li>
                                                    <li class="attendance-list">
                                                        <div class="subtitle">
                                                            <span>결근</span>
                                                        </div>
                                                        <div class="subtitle-count">
                                                            <span>${absentCount}</span> 회
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="box-title">
                                                <i class="bx bxs-calendar fa-lg" style="margin-right: 5px;"></i>
                                                <span style="font-size: 15px; font-weight: bold;">나의 휴가현황</span>
                                            </div>
                                            <div class="box" style="text-align: center;">
                                                <div class="subtitle" style="min-width: 45%;">
                                                    <div style="min-width: 70px;">잔여휴가</div>
                                                    <div class="subtitle-count" style="min-width: 70px;">
                                                        <span>${vo.vacLeft}</span> <span>일</span>
                                                    </div>
                                                </div>
                                                <div>
                                                    <div style="display: inline-block; margin-right: 20px;">
                                                        <a href="${contextPath}/attendance/vacationInfo.page?no=${loginUser.userNo}"> <span>휴가현황</span></a>
                                                    </div>
                                                    <a href="${contextPath}/edoc/edocInsert.page" class="btn btn-white waves-effect vacBtn">
                                                        <span>휴가신청</span>
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <div>
                                            <div class="box-title">
                                                <i class="bx bxs-time-five fa-lg" style="margin-right: 5px;"></i>
                                                <span style="font-size: 15px; font-weight: bold;">나의 근무시간</span>
                                            </div>
                                            <div class="box" style="text-align: center;">
                                                <ul class="attendance">
                                                    <li class="attendance-list">
                                                        <div class="subtitle">
                                                            <span>근무일수</span>
                                                        </div>
                                                        <div class="subtitle-count">
                                                            <span>${workDays}</span> 일
                                                        </div>
                                                    </li>
                                                    <li class="attendance-list">
                                                        <div class="subtitle">
                                                            <span>총근무시간</span>
                                                        </div>
                                                        <div class="subtitle-count">
                                                            <span>${workHours}</span> 시간
                                                        </div>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </section>
                                <div class="col-lg-9">
                                    <div class="mt-4 mt-xl-0" id="">
                                        <div id="calendar" style="width:133%;"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

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
                    url: "${contextPath}/attendance/selectAtt.sc",
                    type: "GET",
                    dataType: 'json',
                    data: {
                        regId: "${loginUser.userId}"
                    },
                    success: function(regData) {
                        $.each(regData, function(index, attendance) {
                            var eventTitle = '';

                            if (attendance.isAbsent) {
                                eventTitle = '결근';
                                events.push({
                                    title: eventTitle,
                                    start: attendance.workDate,
                                    allDay: true
                                });
                            } else {
                                if (attendance.workIn) {
                                    eventTitle += '출근시간: ' + attendance.workIn + '\n';
                                }
                                if (attendance.workOut) {
                                    eventTitle += '퇴근시간: ' + attendance.workOut + '\n';
                                }
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
                        });

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
                                successCallback(events);
                            },
                            error: function(xhr, status, error) {
                                console.log('Error: ' + error);
                                failureCallback(error);
                            }
                        });
                    },
                    error: function() {
                        console.log("근태스케줄 조회 실패");
                        failureCallback();
                    }
                });
            }
        });

        calendar.render();
    });

  </script>

        <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        
        <!-- Plugin JS -->
        <script src="${contextPath}/resources/libs/moment/min/moment.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/core/main.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/bootstrap/main.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/daygrid/main.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/timegrid/main.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/list/main.min.js"></script>
        <script src="${contextPath}/resources/libs/@fullcalendar/interaction/main.min.js"></script>
        
        <!-- Additional Libraries -->
        <script src="${contextPath}/resources/libs/spectrum-colorpicker2/spectrum.min.js"></script>
        <script src="${contextPath}/resources/libs/clockpicker/bootstrap-clockpicker.min.js"></script>
        <script src="${contextPath}/resources/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
        <script src="${contextPath}/resources/libs/bootstrap-daterangepicker/daterangepicker.js"></script>
    </div>
</body>
</html>
