<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
	<head>
    <meta charset="utf-8" />
    <title>로그인</title>
    <!-- JavaScript -->
		<script src="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/alertify.min.js"></script>
		
		<!-- CSS -->
		<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/alertify.min.css"/>
		<!-- Default theme -->
		<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/default.min.css"/>
		<!-- Semantic UI theme -->
		<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/semantic.min.css"/>
		<!-- Bootstrap theme -->
		<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/alertifyjs@1.14.0/build/css/themes/bootstrap.min.css"/>
    <!-- App favicon -->
    <link rel="shortcut icon" href="${contextPath}/resources/images/favicon.ico">

		<!-- App css -->
		<link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
		<link href="${contextPath}/resources/css/app.min.css" rel="stylesheet" type="text/css" id="app-stylesheet" />

		<!-- icons -->
		<link href="${contextPath}/resources/css/icons.min.css" rel="stylesheet" type="text/css" />

		<!-- Theme Config Js -->
		<script src="${contextPath}/resources/js/config.js"></script>
	</head>

	<body class=auth-fluid-pages pb-0">
		<script>
		if("${alertMsg}" != ""){// 어떤 메세지 문구가 존재할 경우
			alertify.alert("${alertTitle}", "${alertMsg}", function(){
				if("${historyBackYN}" == "Y"){
					history.back();
				}
			});
		}
		</script>
		<c:if test="${not empty cookie.rememberUserId}">
			<c:set value="checked" var="checked"/>
		</c:if>
    <div class="auth-fluid" style="background-image:url('${contextPath}/resources/images/bg-auth.jpg')">
        <!-- Auth fluid right content -->
        <div class="auth-fluid-right">
            <div class="auth-user-testimonial">
                <h3 class="mb-3 text-white">Pinance</h3>
                <p class="lead fw-normal">
                	<i class="mdi mdi-format-quote-open"></i>
                	Pinance는 "Pi"와 "Finance"가 합쳐져 탄생한 금융기업을 위한 그룹웨어 시스템입니다. Pi는 수학 상수로서 무한하고 정확한 숫자를 상징하며, 이는 금융 데이터의 복잡성과 정밀성을 반영합니다.
									Pinance는 이러한 두 요소를 결합하여 금융기업이 필요로 하는 모든 기능을 제공하는 통합 솔루션을 제안합니다. 
									<i class="mdi mdi-format-quote-close"></i>
                </p>
                <h5 class="text-white">
                    - UYS2J일동
                </h5>
            </div> <!-- end auth-user-testimonial-->
        </div>
        <!-- end Auth fluid right content -->

        <!--Auth fluid left content -->
        <div class="auth-fluid-form-box">
            <div class="align-items-center d-flex h-100">
                <div class="card-body">

                    <!-- Logo -->
                    <div class="auth-brand text-center text-lg-start">
                        <div class="auth-logo">
                            <a href="${ contextPath }" class="logo logo-dark text-center">
                                <span class="logo-lg">
                                    <img src="${ contextPath }/resources/images/dark-logo.png" alt="" height="50">
                                </span>
                            </a>
                        </div>
                    </div>

                    <!-- title-->
                    <h4 class="mt-0">로그인</h4>
                    <p class="text-muted mb-4">사번과 비밀번호를 입력해주세요.</p>

                    <!-- form -->
                    <form action="${ contextPath }/member/login.do" method="post">
                        <div class="mb-2">
                            <label for="userId" class="form-label">사번</label>
                            <input class="form-control" type="text" id="userId" name="userId" value="${cookie.rememberUserId.value}" required placeholder="사번을 입력해주세요">
                        </div>
                        <div class="mb-2">
                            <label for="password" class="form-label">비밀번호</label>
                            <div class="input-group input-group-merge">
                                <input type="password" name="userPwd" id="password" class="form-control">
                                <div class="input-group-text" data-password="false" onclick="changePwdType();">
                                    <span class="password-eye"></span>
                                </div>
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" name="rememberUserId" value="true" id="checkbox-signin" ${checked}>
                                <label class="form-check-label" for="checkbox-signin">
                                    사번 저장
                                </label>
                            </div>
                        </div>
                        <div class="d-grid text-center">
                            <button class="btn btn-primary" type="submit">로그인</button>
                        </div>
                    </form>
                    <!-- end form-->
                </div> <!-- end .card-body -->
            </div> <!-- end .align-items-center.d-flex.h-100-->
        </div>
        <!-- end auth-fluid-form-box-->
    </div>
    <!-- end auth-fluid-->
    <script>
	    function changePwdType(){
	    	var pwdType = $("#password").attr("type");
	    	if(pwdType == 'text'){
	    		$("#password").attr("type", "password");
	    	} else{
	    		$("#password").attr("type", "text");        		
	    	}
	    }
    </script>

    <!-- Vendor js -->
    <script src="${contextPath}/resources/js/vendor.min.js"></script>

    <!-- App js -->
    <script src="${contextPath}/resources/js/app.min.js"></script>
	</body>
</html> 