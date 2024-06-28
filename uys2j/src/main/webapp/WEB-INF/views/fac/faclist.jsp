<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>시설 관리</title>

<script src="//ej2.syncfusion.com/javascript/demos/schedule/block-events/datasource.js" type="text/javascript"></script>
<script src="${ contextPath }/resources/faccalendar/js/ej2.min.js"></script>
<link href="${ contextPath }/resources/faccalendar/css/material.css" rel="stylesheet">

<!-- <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet"> -->

<style>
    body {
        touch-action: none;
    }

    .e-schedule .e-vertical-view .e-resource-cells {
        height: 58px;
    }

    .e-schedule .e-timeline-view .e-resource-left-td, .e-schedule .e-timeline-month-view .e-resource-left-td {
        width: 170px;
    }

    .e-schedule .e-resource-cells.e-child-node .employee-category,
    .e-schedule .e-resource-cells.e-child-node .employee-name {
        padding: 5px;
    }

    .e-schedule .employee-image {
        width: 45px;
        height: 40px;
        float: left;
        border-radius: 50%;
        margin-right: 10px;
    }

    .e-schedule .employee-name {
        font-size: 13px;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
    }

    .e-schedule .employee-designation {
        font-size: 10px;
        text-overflow: ellipsis;
        white-space: nowrap;
        overflow: hidden;
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
                                <h4 class="page-title" style="font-size: 17.6px;">시설관리</h4>
                                <div class="page-title-right">
                                    <ol class="breadcrumb m-0">
                                        <li class="breadcrumb-item" style="font-size: 13.44px;"><a href="javascript: void(0);">시설비품관리</a></li>
                                        <li class="breadcrumb-item active" style="font-size: 13.44px;">시설예약</li>
                                    </ol>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- end page title -->

                    <div class="stackblitz-container material3">
                        <div class="col-lg-12 control-section">
                            <div id="Schedule" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;"></div>
                        </div>
                        <script id="resource-template" type="text/x-template">
                            <div class="template-wrap">
                                \${getFacList(data)}
                            </div>
                        </script>
                    </div>

                    <div class="row">
                        <div class="col-12 pt-4">
                            <div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
                                <div class="card-body">
                                    <label for="validationCustomUsername" style="font-size: 20px;">나의 예약 현황</label>
                                    <p class="choice_date">
                                        <label for="dateInput" style="font-size: 15px; margin-top: 15px">날짜 선택 : </label>
                                        <input type="date" id="dateInput" style="font-size: 15px;">
                                        <button onclick="searchByDate()" class="btn btn-sm btn-primary" style="background-color: #4A55A2; color: #ffffff;">조회</button>
                                    </p>
                                    <div class="table-responsive">
                                        <table class="table table-centered mb-0" id="inline-editable">
                                            <thead>
                                                <tr>
                                                    <th>#</th>
                                                    <th>예약제목</th>
                                                    <th>예약내용</th>
                                                    <th>시설명</th>
                                                    <th>예약시작시간</th>
                                                    <th>예약종료시간</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                                <!-- end .table-responsive-->
                            </div>
                            <!-- end card-body -->
                        </div>
                        <!-- end card -->
                    </div>
                    <!-- end col -->
                </div>
                <input type="hidden" id="testsss" value="1">
                <!-- end row -->

                <script>
                    ej.base.enableRipple(true);

                    window.getFacList = function(value) {
                        return '<div class="employee-category" onclick="detail(' + value.resourceData["Id"] + ')">'
                            + '<img class="employee-image" src="${contextPath}/' + value.resourceData["Src"] + '" />'
                            + '<div class="employee-name">' + value.resourceData["Text"] + '</div>';
                    }

                    function getFac() {
                        $.ajax({
                            url: '${contextPath}/fac/select.fac',
                            type: 'GET',
                            success: function(fac) {
                            	let userId = '${loginUser.userId}';

                                window.data = fac.sclist.map(item => ({
                                    "Id": item.scNo,
                                    "Subject": item.scName,
                                    "StartTime": item.scStart,
                                    "EndTime": item.scEnd,
                                    "IsAllDay": false,
                                    "IsBlock": userId == item.regId ? false : true,
                                    "EmployeeId": parseInt(item.facName),
                                    "Description":item.scContent
                                }));
                                console.log(window.data);

                                var buttonClickActions = function (e) {
                                    var eventDetails;
                                    var currentAction;
                                    if (e.target.innerText === 'DELETE') {
                                        eventDetails = scheduleObj.activeEventData.event;
                                        if (eventDetails.RecurrenceRule) {
                                            currentAction = 'DeleteOccurrence';
                                        }
                                        scheduleObj.deleteEvent(eventDetails, currentAction);

                                        $.ajax({
                                            url: '${contextPath}/fac/delete.fl',
                                            type: 'POST',
                                            data: {
                                                scNo: eventDetails.Id
                                            },
                                            success: function(response) {
                                                console.log("Delete response from server: ", response);
                                                scheduleObj.deleteEvent(eventDetails, currentAction);
                                                location.reload();
                                            },
                                            error: function(error) {
                                                console.error("Error deleting event", error);
                                            }
                                        });
                                    } else  if (e.target.innerText === 'SAVE') {
                                        console.log('insert 로직');
                                        console.log("window.data[window.data.length-1] = ", window.data[window.data.length-1]);
                                        let obj = window.data[window.data.length-1];
                                        console.log(obj);

                                        for (var i=0 ; i<window.data.length ; i++) {
                                            if (window.data[i].RecurrenceID === null) { //insert 찾는 로직
                                                obj.Id = 0;
                                                break;
                                            }
                                            if (window.data[i].RecurrenceRule === null) { //update 찾는 로직
                                                obj = window.data[i];
                                                break;
                                            }

                                        }
                                        $.ajax({
                                            url: '${contextPath}/fac/insert.fl',
                                            type: 'POST',
                                            data: {
                                                scNo : obj.Id,
                                                scName: obj.Subject,
                                                scStart: obj.StartTime,
                                                scEnd: obj.EndTime,
                                                scContent: obj.Description,
                                                facName: obj.EmployeeId
                                            },
                                            success: function(response) {
                                                console.log("Response from server: ", response);
                                                location.reload();
                                            },
                                            error: function(error) {
                                                console.error("Error: ", error);
                                            }
                                        });
                                    }
                                    scheduleObj.closeQuickInfoPopup();
                                };

                                var dataSource = fac.faclist.map(item => ({
                                    Text: item.facName,
                                    Id: item.facNo,
                                    Color: '#4A55A2',
                                    Description: item.facCategory,
                                    Src: item.attach.filePath + '/' + item.attach.filesystemName
                                }));

                                var scheduleObj = new ej.schedule.Schedule({
                                    width: '100%',
                                    height: '650px',
                                    selectedDate: new Date(),
                                    currentView: 'TimelineDay',
                                    views: [{ option: 'TimelineDay' }],
                                    resourceHeaderTemplate: '#resource-template',
                                    group: {
                                        enableCompactView: false,
                                        resources: ['Employee']
                                    },
                                    resources: [{
                                        field: 'EmployeeId',
                                        title: '시설',
                                        name: 'Employee',
                                        allowMultiple: true,
                                        dataSource: dataSource, // 여기에서 동적으로 설정된 데이터 소스 사용
                                        textField: 'Text'
                                    }],
                                    eventSettings: {
                                        dataSource: window.data,
                                        fields: {
                                            subject: { title: '제목', name: 'Subject' },
                                            startTime: { title: "시작시간", name: "StartTime" },
                                            endTime: { title: "종료시간", name: "EndTime" },
                                            description: { title: '설명', name: 'Description' }
                                        }
                                    },
                                    popupOpen: function (args) {
                                        var data = args.data;
                                        if (args.type === 'QuickInfo' || args.type === 'Editor' || args.type === 'RecurrenceAlert' || args.type === 'DeleteAlert') {
                                            var target = (args.type === 'RecurrenceAlert' ||
                                                args.type === 'DeleteAlert') ? args.element[0] : args.target;
                                            if (!ej.base.isNullOrUndefined(target) && target.classList.contains('e-work-cells')) {
                                                if ((target.classList.contains('e-read-only-cells')) || (!scheduleObj.isSlotAvailable(data))) {
                                                    args.cancel = true;
                                                }
                                            }
                                            else if (!ej.base.isNullOrUndefined(target) && target.classList.contains('e-appointment')) {
                                                args.cancel = false;
                                            }

                                            var deleteBtn = args.element.querySelector('.e-quick-dialog-delete');
                                            if (deleteBtn) {
                                                new ej.buttons.Button({ content: 'Delete', cssClass: 'e-flat' }, deleteBtn);
                                                deleteBtn.onclick = function (e) { buttonClickActions(e); };
                                            }

                                            var updateBtn = args.element.querySelector('.e-event-save');
                                            if (updateBtn) {
                                                new ej.buttons.Button({ content: 'SAVE', cssClass: 'e-flat' }, updateBtn);
                                                updateBtn.onclick = function (e) { buttonClickActions(e); };
                                            }
                                        }

                                    }
                                });
                                scheduleObj.appendTo('#Schedule');

                                setTimeout(function() {
                                    $('.e-location-container').css('display', 'none');
                                    $('.e-all-day-time-zone-row').css('display', 'none');
                                    $('#Schedule_recurrence_editor').css('display', 'none');
                                }, 1000);
                            },
                            error: function(error) {
                                console.error("Error fetching data", error);
                            }
                        });
                        
                    }

                    $(document).ready(function() {
                        getFac();
                    });

                    function detail(no) {
                        location.href = "${contextPath}/fac/facUpdate.page?facNo=" + no;
                    }


                    function searchByDate() {
                        let selectedDate = document.getElementById('dateInput').value;
                        if (!selectedDate) {
                            alert('날짜를 선택해 주세요.');
                            return;
                        }

                        $.ajax({
                            url: '${contextPath}/fac/selectReservationsByDate.fac',
                            type: 'GET',
                            data: { date: selectedDate },
                            success: function(reservations) {
                                let tableBody = $("#inline-editable tbody");
                                tableBody.empty(); // 기존 행을 지웁니다
                                let row = "";
                               for(let i = 0; i < reservations.length; i++){
                            	   	   row += '<tr>'
                            	   		   + '<td>'+ (i + 1) +'</td>'
                                           + '<td>' + reservations[i].scName + '</td>'
                                           + '<td>' + reservations[i].scContent + '</td>'
                                           + '<td>' + reservations[i].facName + '</td>'	
                                           + '<td>' + reservations[i].scStart + '</td>'
                                           + '<td>' + reservations[i].scEnd + '</td>'
                                       + '</tr>'
                               }
                                
                               $("#inline-editable tbody").html(row);
                               
                            },
                            error: function(error) {
                                console.error("예약 조회 중 오류 발생", error);
                            }
                        });
                    }


                </script>

            </div>
            <!-- content -->

            <jsp:include page="/WEB-INF/views/common/footer.jsp" />

            <script src="${ contextPath }/resources/libs/datatables.net/js/jquery.dataTables.min.js"></script>
            <script src="${ contextPath }/resources/libs/datatables.net-bs5/js/dataTables.bootstrap5.min.js"></script>
            <script src="${ contextPath }/resources/libs/datatables.net-responsive/js/dataTables.responsive.min.js"></script>
            <script src="${ contextPath }/resources/libs/datatables.net-responsive-bs5/js/responsive.bootstrap5.min.js"></script>
            <script src="${ contextPath }/resources/libs/jquery-datatables-checkboxes/js/dataTables.checkboxes.min.js"></script>
            <!-- third party js ends -->

            <script src="${ contextPath }/resources/js/pages/product-list.init.js"></script>

            <!-- App js -->
            <script src="${ contextPath }/resources/js/app.min.js"></script>

        </div>
    </div>

</body>
</html>
