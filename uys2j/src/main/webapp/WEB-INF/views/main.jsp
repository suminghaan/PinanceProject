<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>mainPage</title>
<!-- Plugin css -->
<link href="${ contextPath }/resources/libs/@fullcalendar/core/main.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/@fullcalendar/daygrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/@fullcalendar/timegrid/main.min.css" rel="stylesheet" type="text/css" />
<link href="${ contextPath }/resources/libs/@fullcalendar/list/main.min.css" rel="stylesheet" type="text/css" />

<style>
	.fc-scroller {
		overflow: visible !important;
	}
	.fc-view-container {
		height: 500px;
	}
	.fc-view.fc-dayGridMonth-view.fc-dayGrid-view {
		height: 500px;
	}
	.fc-view.fc-dayGridMonth-view.fc-dayGrid-view > table {
		 height: 460px;
	 }
    .topContent, .attendanceChart{
        display: flex;
    }
    .leftContent{
        width: 50%;
        margin-left: 30px;
        margin-top: 30px;
        margin-bottom: 30px;
    }
    .rightContent{
        margin-left: 30px;
        margin-top: 70px;
        width: 50%;
    }
    #calendar{
        width: 100%;
        height: 500px;
    }
    .attendanceChart{
        margin-top: 15px;
        display: flow;
        width: 40%; 
        padding-left: 20px;
    }
    .card-body1{
        width: 100%;
    }
    .noticeTi, .newsTi{
        width: 95%;
        height: 80px;
    }
    .fc-header-toolbar{
    	font-size: 	7px;
    }
    .fc-header-toolbar h2{
    	font-size: 	30px;
    }
    .newsTi, .notiTi{
    	font-size: 20px;
	    display: flex;
        margin-left: 20px;
    	margin-top: 10px;
	    overflow: hidden;
		width: 100%;
	    height: 30px;
	    flex-wrap: wrap; 
    }
	.carousel-inner{
		display: flex;
	    flex-direction: column;
	    justify-content: center;
	}
	.carousel-inner .carousel-item {
	    transition: transform 0.1s ease; /* 전환 속도를 0.3초로 변경합니다. */
	}
	.notiTi a, .newsTi a, .schedule a{
		text-decoration: none;
		color: black;
	}
	
	.bg-success{
		background-color: #4A55A2 !important;
	}
</style>
</head>
<body>
 	<!-- Begin page -->
	<div id="wrapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	
	<!-- ============================================================== -->
	<!-- Start Page Content here -->
	<!-- ============================================================== -->
	
		<div class="content-page">
			<div class="card" style=" width: 100%; margin-top: 30px; min-height: 1000px;">
		
		    <div class="topContent">
		        <div class="leftContent">
		            <!-- 일정파트 -->
						<div class="card-body" style="display: flex; height: 600px;">
							<div style="border: 1px solid #98a6ad; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
								<div id="wrapper" class="schedule">
                                	
									    <div id="calendar"></div>
									
                              	</div>
	                              	
                              	
							</div>
							<!-- 근태관리 -->

							<div class="attendanceChart">
								<div class="card" style="border: 1px solid #98a6ad; width: 100%;height: 260px; margin-left: auto; margin-right: auto; border-radius: 10px; margin-top: -15px;">
									<div class="card-body1">
										<h4 align="center">나의 근무일수</h4>
										<h5 class="mb-3" align="center">${att.workInCount}일 / ${att.weekdayCount}일</h5>
										<div class="mt-4 chartjs-chart">
											<canvas id="attDonut-chart" style="margin-top: -35px;" height="200" data-colors="#526dee,#e3eaef"></canvas>
										</div>
									</div>
								</div>
								
								<script>
									$(document).ready(function(){
										var ctx = document.getElementById('attDonut-chart').getContext('2d');
								        var chart = new Chart(ctx, {
								            // 만들기 원하는 차트의 유형
								            type: 'doughnut',
								            // 데이터 집합을 위한 데이터
								            data: {
								                labels: ['근무일', '월근무일'],
								                datasets: [{
								                    label: 'My First dataset',
								                    backgroundColor: ['#7880D1', 'rgb(227, 228, 230)'],
								                    data: [${att.workInCount}, ${att.weekdayCount}]
								                }]
								            },
								            options: {
								                cutoutPercentage: 60 // 중앙의 공간 비율 (0~100 사이의 값)
								            }
								        }); 
									})
								</script>
								<!-- end card -->

								<div class="card" style="border: 1px solid #98a6ad; width: 100%;height: 260px; margin-left: auto; margin-right: auto; border-radius: 10px; margin-top: 30px;">
									<div class="card-body1">
										<h4 align="center">나의 연차현황</h4>
										<h5 class="mb-3" align="center">남은연차 ${vacation.vacLeft}일 / 총연차 ${vacation.vacTotal}일</h5>
										<div class="mt-4 chartjs-chart">
											<canvas id="vacaDonut-chart" style="margin-top: -35px;" height="200" data-colors="#526dee,#e3eaef"></canvas>
										</div>

									</div>
									<!-- end card-body-->
								</div>
								<!-- end card-->
							</div>
						</div>
						
						<script>
							$(document).ready(function(){
								var ctx = document.getElementById('vacaDonut-chart').getContext('2d');
						        var chart = new Chart(ctx, {
						            // 만들기 원하는 차트의 유형
						            type: 'doughnut',
						            // 데이터 집합을 위한 데이터
						            data: {
						                labels: ['연차', '사용'],
						                datasets: [{
						                    label: 'My First dataset',
						                    backgroundColor: ['#4A55A2', 'rgb(227, 228, 230)'],
						                    data: [${vacation.vacLeft}, ${vacation.vac}]
						                }]
						            },
						            options: {
						                cutoutPercentage: 60 // 중앙의 공간 비율 (0~100 사이의 값)
						            }
						        }); 
							})
						</script>

						<div> <!-- 결재 목록 -->
		                <div class="card-body" style="border: 1px solid #98a6ad;height: 350px;margin-left: 20px;margin-right: 25px;border-radius: 10px;">
		                    <table class="table mb-0" style="width: 100%;">
		                    	<thead>
			                        <tr>
			                            <th>문서번호</th>
			                            <th>제목</th>
			                            <th>기안자</th>
			                            <th>기안일</th>
			                            <th>구분</th>
			                        </tr>
		                        </thead>
		                        <tbody>
		                        	
		                        </tbody>
		                        <c:forEach var="edo" items="${ edolist }">
			                        <tr onclick="location.href='${ contextPath }/edoc/uploadApprovalList.page'" style="cursor:pointer;">
			                            <td>${ edo.docNo }</td>
			                            <td>${ edo.docTitle }</td>
			                            <td>${ edo.sampleDto.sampleTitle }</td>
			                            <td>${ edo.defaultDto.regTime }</td>
			                            <td>
				                            <c:choose>
	                                     		<c:when test="${ edo.status eq 'W' }">
	                                     			<span class="badge label-table bg-success">결재중</span>
	                                     		</c:when>
	                                     		<c:otherwise>
	                                     			<span class="badge label-table bg-secondary text-light">미결재</span>
	                                     		</c:otherwise>
	                                     	</c:choose>  
                                     	</td>
			                        </tr>
		                        </c:forEach>
		                    </table>
		                </div>
		            </div> <!-- 결재 목록 end -->
		            <div class="d-flex">
		                <div class="card" style="width: 325px;min-height: 175px;margin-top: 15px;margin-left: 20px;background:#ffffff;border: 1px solid #98a6ad;">
		                    <div style="margin-left: 20px;">
		                    <h3 style="color: black; padding-top: 10px;">오늘의 생일자 <i class="ri-cake-2-line"></i></h3>
		                    <h4 id="todayBirth" style="color: black;"></h4>
		                    <hr style="width: 324px;margin-left: -20px;">
		                    <c:forEach var="birthm" items="${ memlist }">
		                    <p style="color: black; font-size: medium;">${ birthm.birth } ${ birthm.userName }</p>
		                    </c:forEach>

		                    </div> 
		                </div>
		                 <!-- 생일 end -->
		                
		                <!-- 오늘생일 -->
		                 <script>
					        var birthtoday = new Date();
					        var birthyear = birthtoday.getFullYear();
					        var birthmonth = birthtoday.getMonth() + 1;
					        var birthday = birthtoday.getDate();
					        if (birthmonth < 10) {
					        	birthmonth = '0' + birthmonth;
					        }
					        if (birthday < 10) {
					        	birthday = '0' + birthday;
					        }
					        document.getElementById('todayBirth').innerText = birthyear + '.' + birthmonth + '.' + birthday;
					    </script>
		                
		                <!-- BEGIN WEATHER WIDGET -->
		                <div class="card" style="width: 45%;height: 175px;margin-top: 15px;margin-left: 25px;background:#ffffff;border: 1px solid #98a6ad;">
		                    <div class="card-body">
		                        <div class="row">
		                            <div class="col-md-7" style="width: 100%;">
		                                <div class="row align-items-center">
		                                    <div class="col-6 text-center">
		                                        <h1 class="display-4 wicon"></h1>
		                                    </div>
		                                    <div class="col-6">
		                                        <div class="weather-text" style="color:black;">
		                                            <h2 class="weather-text T1H" style="color:black;"><b></b></h2>
		                                            <p class="SKY"></p>
		                                            <p class="WSD"></p>
		                                        </div>
		                                    </div>
		                                </div><!-- End row -->
		                            </div>
		                        </div><!-- end row -->
		                    </div>
		                </div><!-- cardbox -->
							<script>
								let date = new Date();
								let year = date.getFullYear();
								let month = ("0" + (date.getMonth() + 1)).slice(-2); // 월을 2자리 문자열로 만듭니다.
								let day = ("0" + date.getDate()).slice(-2); // 일을 2자리 문자열로 만듭니다.
								let hours = ("0" + (date.getHours() - 1)).slice(-2);
								let minutes = "00";
								let today = year + month + day;
								let time = hours + minutes;
								let wtkey = "i92%2FVs3SXjSPBWL2iRyVrQ%2Flueak5Wo57p0AJOeml6xjQUAiMtxHWnk5o2v%2FdcRUqyzOzq4BwhqkoKGoulZvNg%3D%3D";
								$.ajax({
									url : 'https://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getUltraSrtFcst?serviceKey=' + wtkey + '&pageNo=1&numOfRows=1000&dataType=JSON&base_date='+today+'&base_time='+time+'&nx=58&ny=125',
									success : function(result) {
										let T1H = result.response.body.items.item[24].fcstValue;
										let WSD = result.response.body.items.item[54].fcstValue;
										let REH = result.response.body.items.item[30].fcstValue;
										let SKY = result.response.body.items.item[18].fcstValue;
										let PTY = result.response.body.items.item[6].fcstValue;
										$(".T1H").text(T1H + "°");
										$(".WSD").text("풍속 " + WSD + "m/s 　습도 " + REH + "%");
										if(PTY == 0){
											if(SKY == 1){
												$(".SKY").text("맑음");
												$(".wicon").html('<i class="wi wi-day-sunny text-black"></i>');
											}else if(SKY == 3){
												$(".SKY").text("구름많음");
												$(".wicon").html('<i class="wi wi-cloud weather-text"></i>');
											}else if(SKY == 4){
												$(".SKY").text("흐림");
												$(".wicon").html('<i class="wi wi-cloudy weather-text"></i>');
											}else{
												$(".SKY").text("구름조금");
												$(".wicon").html('<i class="wi wi-day-cloudy weather-text"></i>');
											}
										}else{
											if(PTY == 1 || PTY == 5){
												$(".SKY").text("비");
												$(".wicon").html('<i class="wi wi-rain weather-text"></i>');
											}else if(PTY == 2 || PTY == 6){
												$(".SKY").text("비/눈");
												$(".wicon").html('<i class="wi wi-rain-mix weather-text"></i>');
											}else if(PTY == 3 || PTY == 7){
												$(".SKY").text("눈");
												$(".wicon").html('<i class="wi wi-snow-wind weather-text"></i>');
											}else{
												$(".SKY").text("소나기");
												$(".wicon").html('<i class="wi wi-day-showers weather-text"></i>');
											}
										}
									}
								})
							</script> 
							<!-- END Weather WIDGET 1 -->
		            </div>
		        </div>
				
		        <div class="rightContent">
		        <div style="border: 1px solid #98a6ad;width: 98%;margin-left: -13px;margin-right: 30px;border-radius: 10px;margin-top: -15px;">
		            <div class="noticeTi">
		            	<!--------------------------- 공지사항 ------------------------->
	               		<div style="margin-left: 20px;margin-top: 20px;">공지사항</div>
		                <div class="noti" style="height: 80px; display: flex;">
		                	<div class="notiTi">
		                		<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
									<div class="carousel-inner notiContent">
									</div>
								</div>
							</div>
						</div>
						<script>
						$.ajax({
							url:"${contextPath}/main/notice.do",
							success : function(data) {
								for (let i = 0; i < data.length; i++) {
									let notiLink = data[i].postNo;
								    let notiTitle = data[i].postTitle;
								    let notiRow = '<a href="${contextPath}/board/boardDetail.do?no='+ notiLink +'">' 
					    							+ notiTitle + '</a><br>';
									let carouselItem = $('<div class="carousel-item" data-bs-interval="10000"></div>');
									if (i == 0) {
					                    carouselItem.addClass('active');
					                }
					                carouselItem.append(notiRow);
					                $('.notiContent').append(carouselItem);
								}
							}
						})
						</script>
		                <!-------------------------------- 공지사항 end ----------------------------->
		            </div>
		            	<!---------------------- 뉴스 start --------------->
		            	<div style="margin-left: 20px;">오늘의 금융 뉴스</div>
						<div class="news" style="height: 65px; display: flex; justify-content: center;">
							<div class="newsTi">
								<div id="carouselExampleFade" class="carousel slide carousel-fade" data-bs-ride="carousel">
									<div class="carousel-inner newsContent">
									</div>
								</div>
							</div>
						</div>
						</div>
						<script>
						$.ajax({
							url:"${contextPath}/main/news.do",
							success : function(result) {
								for (let i = 0; i < result.items.length; i++) {
								    let newsItem = result.items[i];
								    let newsLink = newsItem.link;
								    let newsTitle = newsItem.title;
								    let newsRow = '<a href="'+ newsLink +'" target="_blank">' 
								    			+ newsTitle + '</a><br>';
								    let carouselItem = $('<div class="carousel-item" data-bs-interval="10000"></div>');
					                if (i == 0) {
					                    carouselItem.addClass('active');
					                }
					                carouselItem.append(newsRow);
					                $('.newsContent').append(carouselItem);
								}
							}
						})
						</script>
						<!-------------------------------- 뉴스 end ----------------------------->
						
						<!--------------------------------- 금리 start ------------------------------->
						<div class="card" style="width: 100%;"> <!-- 금리 그래프 -->
		                    <div class="card-body" style="border: 1px solid #98a6ad; height: 350px; margin-left: -13px;margin-right: 30px;border-radius: 10px; margin-top: 15px;">
		                        <h4 class="header-title" style="margin-bottom: -30px; font-weight: bold;">기준금리</h4>
		                        <!-- <div id="website-stats1" style="height: 200px;" class="flot-chart mt-5" data-colors="#526dee,#18c984"></div> -->
		                        <div id="IR">
		                        	<canvas id="IR-chart" width="690" height="300" style="margin-top: 5%;"></canvas>
		                        </div>
		                    </div>
		                </div>
		                
						 <script>
							$(document).ready(function(){
								$.ajax({
									url:"${contextPath}/main/IR.do",
									success : function(result) {
										var ctx = document.getElementById('IR-chart').getContext('2d');
										var labelsList = new Array();
						                var dataList = new Array();
						                $.each(result.StatisticSearch.row, function(idx, item) {
						                    labelsList.push(item.TIME);
						                    dataList.push(parseFloat(item.DATA_VALUE));
						                });
								        var chart = new Chart(ctx, {
								            type: 'line',
								            data: {
								            	labels: labelsList,
								                datasets: [{
								                    label: '금리(%)',
								                    backgroundColor: ['#7880D1'],
								                    data: dataList
								                }]
								            },
								            options: {scales: {
								            		yAxes: [{ticks: {
								                            beginAtZero: true,
								                            max: 10
								                        } }] },
								                elements: {
								                    line: {tension: 0}// 각진 라인을 얻기 위해 tension을 0으로 설정
								                } }
								        }); 
									}
								})
							})
						</script>
		                <!--------------------------------- 금리 end ------------------------------>
						
						<!----------------------------- 환율 그래프 ---------------------------------->						
		                <div class="card" style="width: 100%;"> 
		                    <div class="card-body" style="border: 1px solid #98a6ad; height: 350px; margin-left: -13px;margin-right: 30px;border-radius: 10px;">
		                        <h4 class="header-title" style="margin-bottom: -30px; font-weight: bold;">환율</h4>
		                        <!-- <div id="flotRealTime" style="height: 200px;" data-colors="#526dee" class="flot-chart mt-5"></div> -->
		                        <div id="IR">
		                        	<canvas id="EXC-chart" width="690" height="300" style="margin-top: 5%;"></canvas>
		                        </div>
		                    </div>
		                </div>
		                <script>
							$(document).ready(function(){
								$.ajax({
									url:"${contextPath}/main/exchange.do",
									dataType:"json",
									success : function(result) {
										console.log(result);
										var ctx = document.getElementById('EXC-chart');
										var labelsList = new Array();
										var dataDollar = new Array();
							            var dataEuro = new Array();
							            var dataYuan = new Array();
							            var dataYen = new Array();
							        	
							            
							            for (let i = 0; i < result.dollar.StatisticSearch.row.length; i++) {
							            	labelsList.push(result.dollar.StatisticSearch.row[i].TIME);
							                dataDollar.push(result.dollar.StatisticSearch.row[i].DATA_VALUE);
							                dataEuro.push(result.euro.StatisticSearch.row[i].DATA_VALUE);
							                dataYuan.push(result.yen.StatisticSearch.row[i].DATA_VALUE);
							                dataYen.push(result.yuan.StatisticSearch.row[i].DATA_VALUE);
							            }
							         	// 데이터의 최대값을 계산
							            var maxDataValue = Math.max(...dataDollar);
							            // 기본 최대값 설정
							            var maxValue = 2000;

							            // 최대값이 1500을 넘으면 최대값을 3000으로 설정
							            if (maxDataValue > 1500) {
							                maxValue = 3000;
							            }
							            
								        var chart = new Chart(ctx, {
								            type: 'line',
								            data: {
								            	labels: labelsList,
								                datasets: [{
								                    label: '미국달러(1달러)',
								                    backgroundColor: 'rgba(0, 0, 0, 0)', 
								                    borderColor: 'rgb(67, 100, 247)',
								                    data: dataDollar
								                }, {
							                        label: '유로(1유로)',
							                        backgroundColor: 'rgba(0, 0, 0, 0)', 
								                    borderColor: 'rgb(255, 99, 132)',
							                        data: dataEuro
							                    }, {
							                        label: '위안(1위안)',
							                        backgroundColor: 'rgba(0, 0, 0, 0)', 
								                    borderColor: 'rgb(54, 162, 235)',
							                        data: dataYuan
							                    }, {
							                        label: '일본엔(100엔)',
							                        backgroundColor: 'rgba(0, 0, 0, 0)', 
								                    borderColor: 'rgb(255, 206, 86)',
							                        data: dataYen
							                    }]
								            },
								            options: {scales: {
								            		yAxes: [{ticks: {
								                            beginAtZero: true,
								                            max: maxValue
								                        } }] },
								                elements: {
								                    line: {tension: 0}
								                } }
								        }); 
									},
						           error: function(xhr, status, error) {
						               console.log("Error: 환율 ajax 실패");
						           }
								})
							})
						</script>
		                <!----------------------------- 환율 그래프 end ---------------------------------->
		                
						<div class="card-body" style="border: 1px solid #98a6ad; height: 175px; margin-left: -13px; margin-right: 30px; margin-top: -10px; border-radius: 10px;">
							<div class="d-flex align-items-start">
								<div class="avatar-md me-3">
									<div class="avatar-title bg-light rounded-circle">
										<img src="${ contextPath }/resources/images/dark-logo.png" alt="logo" class="avatar-sm rounded-circle">
									</div>
								</div>
								<div class="flex-1">
									<h4 class="my-1">
										<a href="javascript:void(0);" class="text-dark">PiNANCE.</a>
									</h4>
									<p class="text-muted text-truncate mb-0">
										<i class="ri-map-pin-line align-bottom me-1"></i> Seoul, Korea
									</p>
								</div>
							</div>
							<hr>
                            <div class="col-xl-3 col-lg-4 col-sm-6">
							    <a href="https://www.kbstar.com/" class="text-decoration-none" style="color: #98a6ad;" target="_blank">
							        <i class="fe-airplay"></i> PiNANCE HOME
							    </a>
							</div>
						</div>
					</div>
		    </div>
		</div>
	
   	<!-- ============================================================== -->
	<!-- End Page content -->
	<!-- ============================================================== -->
		
	</div>
	
		<jsp:include page="/WEB-INF/views/common/footer.jsp" />

		<!-- plugin js -->
		<script src="${ contextPath }/resources/libs/moment/min/moment.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/core/main.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/bootstrap/main.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/interaction/main.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/daygrid/main.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/timegrid/main.min.js"></script>
		<script src="${ contextPath }/resources/libs/@fullcalendar/list/main.min.js"></script>

		<script>
			$.ajax({
				url: '${contextPath}/schedule/select.sc',
				type: 'GET',
				success: function(res){
					var list = res;
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
						}
					});
					var calendar = new FullCalendar.Calendar(calendarEl, {
						plugins: [ 'dayGrid', 'timeGrid', 'list', 'interaction' ],
						initialView: 'dayGridMonth',
						events: events,
						eventTimeFormat: {
							hour: '2-digit',
							minute: '2-digit',
							hour12: false
						},
						eventClick: function(info) {
							window.location.href = '${contextPath}/schedule/schedule.page';
						}
					});
					calendar.render();
				}
			});
		</script>

</body>
</html>