<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>일정 관리</title>
    
    <!-- Plugin css -->
    <link href="${ contextPath }/resources/libs/@fullcalendar/core/main.min.css" rel="stylesheet" type="text/css" />
    <link href="${ contextPath }/resources/libs/@fullcalendar/daygrid/main.min.css" rel="stylesheet" type="text/css" />
    <link href="${ contextPath }/resources/libs/@fullcalendar/timegrid/main.min.css" rel="stylesheet" type="text/css" />
    <link href="${ contextPath }/resources/libs/@fullcalendar/list/main.min.css" rel="stylesheet" type="text/css" />
    
    <!-- App css -->
    <link href="${ contextPath }/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="${ contextPath }/resources/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet" />
    
    <!-- icons -->
    <link href="${ contextPath }/resources/css/icons.min.css" rel="stylesheet" type="text/css" />
    
    <link href="${ contextPath }/resources/libs/bootstrap-datepicker/css/bootstrap-datepicker.min.css" rel="stylesheet" type="text/css" />
    <link href="${ contextPath }/resources/libs/bootstrap-daterangepicker/daterangepicker.css" rel="stylesheet" type="text/css">
    
    <!-- Theme Config Js -->
    <script src="${ contextPath }/resources/js/config.js"></script>
    
    <script src='https://unpkg.com/@fullcalendar/core@5.10.1/main.min.js'></script>
    <script src='https://unpkg.com/@fullcalendar/daygrid@5.10.1/main.min.js'></script>
    <script src='https://unpkg.com/@fullcalendar/timegrid@5.10.1/main.min.js'></script>
    <script src='https://unpkg.com/@fullcalendar/list@5.10.1/main.min.js'></script>
    
    <style>
    .error-message {
        color: #D25565; /* 기본 색상 설정 */
        font-size: 12px;
        margin-top: 5px;
    }
</style>
    
</head>

<body>
   <div id="wrapper">
      <jsp:include page="/WEB-INF/views/common/header.jsp"/>
      <jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
   
      <div class="content-page">
          <div class="content">
              <div class="container-fluid">
                  <div class="row">
                      <div class="col-12">
                          <div class="page-title-box page-title-box-alt">
                              <h4 class="page-title">일정관리</h4>
                              <div class="page-title-right">
                                  <ol class="breadcrumb m-0">
                                      <li class="breadcrumb-item"><a href="javascript: void(0);">일정관리</a></li>    
                                      <li class="breadcrumb-item active">일정관리</li>
                                  </ol>
                              </div>
                          </div>
                      </div>
                  </div>     
                  <div class="row">
                      <div class="col-12">
                          <div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
                              <div class="card-body">
                                  <div class="row">
                                      <div class="col-lg-3">
                                          <div class="d-grid">
                                              <button class="btn btn-lg font-16 btn-primary" style="background-color: #4A55A2; height : 55px;" id="" onclick='$(".error-message").remove(); resetModalFields(); new bootstrap.Modal(document.getElementById("event-modal"),{}).toggle(); insert();'><i class="mdi mdi-plus-circle-outline"></i> 일정 추가</button>
                                          </div>
                                          <br><br>
                                          <div id="external-events">
                                              <div class="cal-category" style="height: 700px; border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
                                              <br><br><br><br><br>
                                              <p class="text-muted" style="text-align: center;">카테고리별 일정</p>
                                              <select id="category-select" aria-label="Default select example" class="mt-3 form-select" style="width: 60%; margin: 0 auto;">
												    <option>-</option>
												    <option value="출장">출장</option>
												    <option value="회의">회의</option>
												    <option value="개인">개인</option>
												</select>

                                              
                                              <br><br>
                                              <p class="text-muted" style="text-align: center;">등록자별 일정</p>
                                              <div style="border: 1px solid #ffffff; width: 60%; margin-left: auto; margin-right: auto; border-radius: 10px; text-align: center;">
												    <div>
												        <div class="form-check" style="display: inline-block;">
												            <input type="checkbox" id="company-schedule-checkbox" class="form-check-input" checked="">
												            <label title="" for="company-schedule-checkbox" class="form-check-label"> 회사 일정</label>
												        </div>
												    </div>
												    <div>
												        <div class="form-check" style="display: inline-block;">
												            <input type="checkbox" id="personal-schedule-checkbox" class="form-check-input" checked="">
												            <label title="" for="personal-schedule-checkbox" class="form-check-label"> 개인 일정</label>
												        </div>
												    </div>
												</div>
                                              <br><br><br><br><br><br><br><br><br><br><br><br>                  
                                              </div>
                                          </div>
                                      </div>
                                      <div class="col-lg-9">
                                          <div class="mt-4 mt-xl-0" id="">
                                              <div id="calendar" style="display:none;"></div>
                                          </div>
                                      </div>
                                  </div>
                              </div>
                          </div>
                          <div class="modal fade" id="event-modal" tabindex="-1">
                              <div class="modal-dialog">
                                  <div class="modal-content">
                                      <div class="modal-header py-3 px-4 border-bottom-0 d-block">
                                          <button type="button" class="btn-close float-end" data-bs-dismiss="modal" aria-label="Close"></button>
                                          <h5 class="modal-title" id="modal-title">일정</h5>
                                      </div>
                                      <div class="modal-body px-4 pb-4 pt-0">
								    <form method="post" class="needs-validation" name="event-form" id="modal_form" onsubmit="return myvalidation();">
								        <div class="row">
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="simpleinput"></label>
								                <div class="col-md-10">
								                    <input type="hidden" id="sc-no" name="scNo" class="form-control" value="0">
								                </div>
								            </div>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="event-title">일정명</label>
								                <div class="col-md-10">
								                    <input type="text" id="event-title" name="scName" class="form-control" placeholder="일정 제목을 입력해주세요">
								                </div>
								            </div>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="start">시작일</label>
								                <div class="col-md-10">
								                    <input class="form-control" type="datetime-local" name="scStart" id="start">
								                </div>
								            </div>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="end">종료일</label>
								                <div class="col-md-10">
								                    <input class="form-control" type="datetime-local" name="scEnd" id="end">
								                </div>
								            </div>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="sc-category">카테고리</label>
								                <div class="col-md-10">
								                    <select class="form-select" name="scCategory" id="sc-category">
								                        <option value="">선택하세요</option>
								                        <option value="개인">개인</option>
								                        <option value="회의">회의</option>
								                        <option value="출장">출장</option>
								                    </select>
								                </div>
								            </div>
								            <c:if test="${loginUser.status eq 'A' or loginUser.status eq 'G'}">
											    <div class="mb-2 row">
											        <label class="col-md-2 col-form-label" for="sc-share">공유여부</label>
											        <div class="col-md-10">
											            <select class="form-select" name="scShare" id="sc-share">
											                <option value="N">미공유</option>
											                <option value="Y">공유</option>
											            </select>
											        </div>
											    </div>
											</c:if>
											<c:if test="${loginUser.status ne 'A' and loginUser.status ne 'G'}">
											    <select class="form-select" name="scShare" id="sc-share" style="display:none;">
											        <option value="N" selected>미공유</option>
											    </select>
											</c:if>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="sc-color">색상</label>
								                <div class="col-md-10">
								                    <select class="form-select" name="scColor" id="sc-color">
								                        <option value="#D25565" style="color: #D25565;">빨간색</option>
								                        <option value="#9775fa" style="color: #9775fa;">보라색</option>
								                        <option value="#ffa94d" style="color: #ffa94d;">주황색</option>
								                        <option value="#74c0fc" style="color: #74c0fc;">파란색</option>
								                        <option value="#f06595" style="color: #f06595;">핑크색</option>
								                        <option value="#63e6be" style="color: #63e6be;">연두색</option>
								                        <option value="#a9e34b" style="color: #a9e34b;">초록색</option>
								                        <option value="#4d638c" style="color: #4d638c;">남색</option>
								                        <option value="#495057" style="color: #495057;">검정색</option>
								                    </select>
								                </div>
								            </div>
								            <div class="mb-2 row">
								                <label class="col-md-2 col-form-label" for="event-content">일정내용</label>
								                <div class="col-md-10">
								                    <textarea class="form-control" id="event-content" rows="3" name="scContent"></textarea>
								                </div>
								            </div>
								        </div>
								        <div class="row mt-2">
								            <div class="col-6">
								                <button type="button" class="btn btn-danger" id="btn-delete-event" onclick="deleteForm();">삭제</button>
								            </div>
								            <div class="col-6 text-end">
								                <button type="button" class="btn btn-light me-1" data-bs-dismiss="modal">닫기</button>
								                <button type="submit" class="btn btn-success" id="savebtn">저장</button>
								            </div>
								        </div>
								    </form>
								</div>

                                         <script>
	                                         function myvalidation() {
	                                             let isValid = true;
	                                             const form = document.getElementById('modal_form');
	                                             const fields = form.querySelectorAll('input:not([type="hidden"]), select, textarea');
	
	                                             // 모든 필드가 입력되었는지 확인
	                                             fields.forEach(field => {
	                                                 const errorMessage = field.nextElementSibling;
	                                                 if (field.value.trim() === '') {
	                                                     isValid = false;
	                                                     if (!errorMessage || !errorMessage.classList.contains('error-message')) {
	                                                         const error = document.createElement('div');
	                                                         error.classList.add('error-message');
	                                                         error.innerText = '필수입력사항입니다. 입력해주세요.';
	                                                         error.style.color = 'red'; // 색상을 빨간색으로 설정
	                                                         field.parentNode.appendChild(error);
	                                                     }
	                                                 } else {
	                                                     if (errorMessage && errorMessage.classList.contains('error-message')) {
	                                                         errorMessage.remove();
	                                                     }
	                                                 }
	                                             });
	                                             // 시작일과 종료일 확인
	                                             const startDate = document.getElementById('start').value;
	                                             const endDate = document.getElementById('end').value;
	
	                                             if (startDate && endDate && startDate > endDate) {
	                                                 isValid = false;
	                                                 const endField = document.getElementById('end');
	                                                 const errorMessage = endField.nextElementSibling;
	                                                 if (!errorMessage || !errorMessage.classList.contains('error-message')) {
	                                                     const error = document.createElement('div');
	                                                     error.classList.add('error-message');
	                                                     error.innerText = '종료일이 시작일보다 빠릅니다.';
	                                                     error.style.color = 'red'; // 색상을 빨간색으로 설정
	                                                     endField.parentNode.appendChild(error);
	                                                 }
	                                             }

	                                             return isValid;
	                                         }
	
	                                         function resetModalFields() {
	                                             const form = document.getElementById('modal_form');
	                                             const fields = form.querySelectorAll('input, select, textarea');
	                                             fields.forEach(field => {
	                                                 field.value = '';
	                                                 const errorMessage = field.nextElementSibling;
	                                                 if (errorMessage && errorMessage.classList.contains('error-message')) {
	                                                     errorMessage.remove();
	                                                 }
	                                             });
	                                             // "공유여부" 필드를 "미공유"로 설정
	                                             document.getElementById('sc-share').value = 'N';
	                                         }
                                         
                                             function insert(){
                                              $("#savebtn").show();
                                           	  $("#btn-delete-event").hide();
                                           	  $("#sc-no").attr("name", '');
                                           	  $("#modal_form").attr("action","");
                                           	  $("#modal_form").attr("action", "${contextPath}/schedule/insert.sc");
                                             }
                                             function update(regId){
                                            	 console.log("regID:"+regId);
                                           	  $("#sc-no").attr("name", 'scNo');
                                           	  $("#modal_form").attr("action",'');
                                           	  $("#modal_form").attr("action","${contextPath}/schedule/update.sc");
                                           	  if(regId == '${loginUser.userId}'){
                                           		$("#btn-delete-event").show();
                                           		$("#savebtn").show();
                                           	  }else{
                                           		$("#btn-delete-event").hide();
                                           		$("#savebtn").hide();  
                                           	  }
                                             }
                                             function deleteForm(){
                                           	  $("#modal_form").attr("action",'');
                                           	  $("#sc-no").attr("name", 'scNo');
                                           	  $("#modal_form").attr("action","${contextPath}/schedule/delete.sc");
                                           	  $("#modal_form").submit();
                                             }                     
                                         </script>
                                      </div>
                                  </div>
                              </div>
                          </div>
                      </div>
                  </div>
              </div>
          </div>
      </div>
      </div>

    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
    
    <!-- plugin js -->
    <script src="${ contextPath }/resources/libs/moment/min/moment.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/core/main.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/bootstrap/main.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/daygrid/main.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/timegrid/main.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/list/main.min.js"></script>
    <script src="${ contextPath }/resources/libs/@fullcalendar/interaction/main.min.js"></script>
    
    <!-- Calendar init -->
    <script src="${ contextPath }/resources/js/pages/calendar.init.js"></script>
    
    <!-- App js -->
    <script src="${ contextPath }/resources/js/app.min.js"></script>
    
    <script src="${ contextPath }/resources/libs/spectrum-colorpicker2/spectrum.min.js"></script>
    <script src="${ contextPath }/resources/libs/clockpicker/bootstrap-clockpicker.min.js"></script>
    <script src="${ contextPath }/resources/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
    <script src="${ contextPath }/resources/libs/bootstrap-datepicker/js/bootstrap-datepicker.min.js"></script>
    <script src="${ contextPath }/resources/libs/bootstrap-daterangepicker/daterangepicker.js"></script>

    <script>
    $.ajax({
        url: '${ contextPath }/schedule/select.sc',
        type: 'GET',
        success: function(res){
            var list = res;
            console.log(list);
            
            var calendarEl = document.getElementById('calendar');
            calendarEl.innerHTML = '';
            calendarEl.style.display='block';
            
            var events = list.map(function(item) {
                return {
                    title: item.scName,
                    start: item.scStartDate + 'T' + item.scStartTime,
                    end: item.scEndDate + 'T' + item.scEndTime,
                    color: item.scColor,
                    sccontent: item.scContent,
                    sccategory: item.scCategory,
                    scshare: item.scShare,
                    scstartdate: item.scStartDate,
                    scstarttime: item.scStartTime,
                    scenddate: item.scEndDate,
                    scendtime: item.scEndTime,
                    sctitle: item.scName,
                    sccolor: item.scColor,
                    scno: item.scNo,
                    regId: item.regId
                }
            });
            
            var calendar = new FullCalendar.Calendar(calendarEl, {
                plugins: [ 'dayGrid', 'timeGrid', 'list', 'interaction' ],
                initialView: 'dayGridMonth',
                events: events,
                eventsTimeFormat: {
                    hour: '2-digit',
                    minute: '2-digit',
                    hour12: false
                },
                dateClick: function(e) {
                	// resetModalFields();
                	// new bootstrap.Modal(document.getElementById("event-modal"),{}).toggle();
                },
                eventClick: function(e) {
                	update(e.event._def.extendedProps.regId);
                    resetModalFields();
                    console.log(e.event._def.extendedProps);
                    $('#event-title').val(e.event._def.extendedProps.sctitle);
                    $('#start').val(e.event._def.extendedProps.scstartdate+'T'+e.event._def.extendedProps.scstarttime);
                    $('#end').val(e.event._def.extendedProps.scenddate+'T'+e.event._def.extendedProps.scendtime);
                    $('#sc-category').val(e.event._def.extendedProps.sccategory);
                    $('#sc-share').val(e.event._def.extendedProps.scshare);
                    $('#sc-color').val(e.event._def.extendedProps.sccolor);
                    $('#sc-no').val(e.event._def.extendedProps.scno);
                    $('#event-content').val(e.event._def.extendedProps.sccontent);
                	new bootstrap.Modal(document.getElementById("event-modal"),{}).toggle();
                },
                titleFormat : function(date) { // title 설정
             	return date.date.year +"년 "+(date.date.month +1)+"월"; 
             	}
            });
            
            calendar.render();
            
        },
    });
    
    document.getElementById('category-select').addEventListener('change', function() {
        filterSchedules();
    });

    document.getElementById('company-schedule-checkbox').addEventListener('change', filterSchedules);
    document.getElementById('personal-schedule-checkbox').addEventListener('change', filterSchedules);


    function fetchSchedulesByCategory(category) {
        $.ajax({
            url: '${contextPath}/schedule/selectFiltered.sc',
            type: 'GET',
            data: { category: category },
            success: function(res) {
                renderCalendar(res);
            },
        });
    }

    function fetchAllSchedules() {
        $.ajax({
            url: '${ contextPath }/schedule/select.sc',
            type: 'GET',
            success: function(res) {
                renderCalendar(res);
            },
        });
    }

    function renderCalendar(list) {
        var calendarEl = document.getElementById('calendar');
        calendarEl.innerHTML = '';
        calendarEl.style.display = 'block';

        var events = list.map(function(item) {
            return {
                title: item.scName,
                start: item.scStartDate + 'T' + item.scStartTime,
                end: item.scEndDate + 'T' + item.scEndTime,
                color: item.scColor,
                sccontent: item.scContent,
                sccategory: item.scCategory,
                scshare: item.scShare,
                scstartdate: item.scStartDate,
                scstarttime: item.scStartTime,
                scenddate: item.scEndDate,
                scendtime: item.scEndTime,
                sctitle: item.scName,
                sccolor: item.scColor,
                scno: item.scNo
            };
        });

        var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: ['dayGrid', 'timeGrid', 'list', 'interaction'],
            initialView: 'dayGridMonth',
            events: events,
            eventTimeFormat: {
                hour: '2-digit',
                minute: '2-digit',
                hour12: false
            },
            dateClick: function(e) {
                resetModalFields();
                new bootstrap.Modal(document.getElementById("event-modal"), {}).toggle();
            },
            eventClick: function(e) {
                update();
                resetModalFields();
                console.log(e.event._def.extendedProps);
                $('#event-title').val(e.event._def.extendedProps.sctitle);
                $('#start').val(e.event._def.extendedProps.scstartdate + 'T' + e.event._def.extendedProps.scstarttime);
                $('#end').val(e.event._def.extendedProps.scenddate + 'T' + e.event._def.extendedProps.scendtime);
                $('#sc-category').val(e.event._def.extendedProps.sccategory);
                $('#sc-share').val(e.event._def.extendedProps.scshare);
                $('#sc-color').val(e.event._def.extendedProps.sccolor);
                $('#sc-no').val(e.event._def.extendedProps.scno);
                $('#event-content').val(e.event._def.extendedProps.sccontent);
                new bootstrap.Modal(document.getElementById("event-modal"), {}).toggle();
            },
            titleFormat: function(date) { // title 설정
                return date.date.year + "년 " + (date.date.month + 1) + "월";
            }
        });

        calendar.render();
    }
    
    document.getElementById('company-schedule-checkbox').addEventListener('change', filterSchedules);
    document.getElementById('personal-schedule-checkbox').addEventListener('change', filterSchedules);

    function filterSchedules() {
        var selectedCategory = document.getElementById('category-select').value;
        var showCompany = document.getElementById('company-schedule-checkbox').checked;
        var showPersonal = document.getElementById('personal-schedule-checkbox').checked;

        if (!showCompany && !showPersonal) {
            renderCalendar([]); // 두 체크박스가 모두 체크되지 않았을 경우 빈 배열을 넘김
            return;
        }

        $.ajax({
            url: '${contextPath}/schedule/selectFiltered.sc',
            type: 'GET',
            data: {
                category: selectedCategory,
                showCompany: showCompany,
                showPersonal: showPersonal
            },
            success: function(res) {
                renderCalendar(res);
            },
            error: function(err) {
                console.error("Error fetching filtered schedules", err);
            }
        });
    }


    </script>
</body>
</html>
