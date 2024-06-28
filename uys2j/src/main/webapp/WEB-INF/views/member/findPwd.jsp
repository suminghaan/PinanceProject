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
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div class="container" style="margin-top:100px;">
	  <div class="row justify-content-center">
	      <div class="col-md-8 col-lg-6 col-xl-4">
	          <div class="card">
	
	              <div class="card-body p-4">
	                  
	                  <div class="text-center w-75 m-auto">
	                      <div class="auth-logo">
	                          <a href="${contextPath}" class="logo logo-dark text-center">
	                              <span class="logo-lg">
	                                  <img src="${ contextPath }/resources/images/dark-logo.png" alt="" height="22">
	                              </span>
	                          </a>
	      
	                          <a href="${contextPath}" class="logo logo-light text-center">
	                              <span class="logo-lg">
	                                  <img src="${ contextPath }/resources/images/white-logo.png" alt="" height="22">
	                              </span>
	                          </a>
	                      </div>
	                      <p class="text-muted mb-4 mt-3"></p>
	                  </div>
	
	                  <form action="${contextPath}/member/findPwd.do" method="post">
                      <div class="mb-3">
                        <label for="password" class="form-label">현재 비밀번호</label>
                        <div class="input-group input-group-merge">
			                    <input type="password" id="password" class="form-control" name="userPwd" placeholder="비밀번호를 적어주세요">
				
			                    <div class="input-group-text" data-password="false" onclick="changePwdType();">
							            	<span class="password-eye"></span>
									        </div>
										    </div>
                      </div>
	                      
	                      <div class="mb-3">
                          <label for="changePwd" class="form-label">변경할 비밀번호</label>
                          <div class="input-group input-group-merge">
			                    <input type="password" id="changePwd" class="form-control" name="updatePwd" placeholder="비밀번호를 적어주세요">
				
			                    <div class="input-group-text" data-password="false" onclick="changeCurPwdType();">
							            	<span class="password-eye"></span>
									        </div>
										    	</div>
	                      </div>
	
	                      <div class="d-grid text-center">
	                          <button class="btn btn-primary" type="submit"> 비밀번호 변경 </button>
	                      </div>
	
	                  </form>
	
	              </div> <!-- end card-body -->
	          </div>
	          <!-- end card -->
	
	          <div class="row mt-3">
	              <div class="col-12 text-center">
	                  <p class="text-muted"><a href="${ contextPath }/member/login.page" class="text-primary fw-medium ms-1">로그인</a>으로 돌아가기</p>
	              </div> <!-- end col -->
	          </div>
	          <!-- end row -->
	
	      </div> <!-- end col -->
	  </div>
	  <!-- end row -->
	</div>
	<!-- end container -->
</div>
<script>
	function changePwdType(){
	   	var pwdType = $("#password").attr("type");
	   	if(pwdType == 'text'){
	   		$("#password").attr("type", "password");
	   	} else{
	   		$("#password").attr("type", "text");        		
	   	}
	}
	
	function changeCurPwdType(){
	   	var pwdType = $("#changePwd").attr("type");
	   	if(pwdType == 'text'){
	   		$("#changePwd").attr("type", "password");
	   	} else{
	   		$("#changePwd").attr("type", "text");        		
	   	}
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>