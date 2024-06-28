<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입</title>
<style>
	.smallfont{font-size:0.8em;}
	.nocheck{display:block;}
	.usable{color:green;}
	.unusable{color:red;}
</style>
</head>
<body>
<div id="wrapper">
	<jsp:include page="/WEB-INF/views/common/header.jsp"/>
	<div id="signup_form" class="account-pages mt-5 mb-5">
            <div class="container">
                <div class="row pt-5 justify-content-center">
                    <div class="col-md-8 col-lg-6 col-xl-4">
                        <div class="card">

                            <div class="card-body p-4">
                                
                                <div class="text-center w-75 h-50 m-auto">
                                    <div class="auth-logo">
                                        <a href="index.html" class="logo logo-dark text-center">
                                            <span class="logo-lg">
                                                <img src="${ contextPath }/resources/images/dark-logo.png" alt="" height="32">
                                            </span>
                                        </a>
                                    </div>
                                    <p class="text-muted mb-4 mt-3">계정이 없나요? 자신만의 계정을 만드세요.</p>
                                </div>

                                <form action="${ contextPath }/member/signup.do" method="post" enctype="multipart/form-data">
                                		<input type="hidden" name="defaultDto.regId" value="${ loginUser.userId }">
                                		<input type="hidden" name="defaultDto.modId" value="${ loginUser.userId }">
                                		<div class="mb-2">
                                        <label for="fullname" class="form-label">프로필 사진</label>
                                        <div class="profile_img d-flex justify-content-center" style="height: 284px">
		                                    	<img class="img-fluid rounded-circle" style="height: 284px" id="profileImg" src="${contextPath}/resources/images/defaultProfile.png" onclick="$('#profileImgFile').click();">
		                                      <input type="file" class="file" name="profileImgFile" id="profileImgFile" style="display:none;" accept="image/*" onchange="changeImg(this);">
		                                    </div>
                                    </div>
                                    
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">사번</label>
                                        <div class="d-flex">
	                                        <input class="form-control" type="text" id="userId" name="userId" value="${userId}" readonly>
                                        </div>
                                        <div id="idCheck_result" class="nocheck smallfont"></div>
                                    </div>
	
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">성함</label>
                                        <input class="form-control" type="text" name="userName" id="fullname" placeholder="이름을 적어주세요" required>
                                    </div>
                                    <div class="mb-2">
                                        <label for="emailaddress" class="form-label">이메일 주소</label>
                                    </div>
                                    <div class="mb-2 d-flex">
                                        <input class="form-control" type="email" id="email" name="email" required placeholder="이메일주소를 입력해주세요">
                                    </div>
                                    <div class="mb-2">
                                        <label for="password" class="form-label">비밀번호</label>
                                        <div class="input-group input-group-merge">
                                            <input type="password" id="password" class="form-control" name="userPwd" placeholder="비밀번호를 적어주세요">

                                            <div class="input-group-text" data-password="false" onclick="changePwdType();">
                                                <span class="password-eye"></span>
                                            </div>
                                        </div>
                                        <div id="pwdCheck_result" class="nocheck smallfont"></div>
                                    </div>
                                    <div class="mb-2">
                                        <label for="checkPwd" class="form-label">비밀번호 확인</label>
                                        <div class="input-group input-group-merge">
                                            <input type="password" id="checkPwd" class="form-control" placeholder="비밀번호를 적어주세요">

                                            <div class="input-group-text" data-password="false" onclick="changeCheckPwdType();">
                                                <span class="password-eye"></span>
                                            </div>
                                        </div>
                                        <div id="pwdEqualCheck_result" class="nocheck smallfont"></div>
                                    </div>
                                    <div class="mb-2">
                                        <label for="phone" class="form-label">전화번호</label>
                                        <input class="form-control" type="text" id="phone" name="phone" placeholder="-제외 하고 입력해주세요" oninput="phoneAutoHyphen(this)" maxlength="13" required>
                                    </div>
                                    <div class="mb-2">
                                        <label for="branchOffice" class="form-label">지점</label>
                                        <select class="form-select" name="branchOffice" id="branchOffice" aria-label="Floating label select example" onchange="changeData();">
	                                     	</select>
                                    </div>
                                    <div class="mb-2">
                                        <label for="department" class="form-label">부서</label>
                                       	<select class="form-select" name="department" id="department" aria-label="Floating label select example">
                                       	<option value="">가발령</option>
                                     		</select>
                                    </div>
                                    <div class="mb-2">
                                        <label for="rank" class="form-label">직급</label>
                                        <select class="form-select" name="rank" id="rank" aria-label="Floating label select example">
                                        <option value="">가발령</option>
	                                    	</select>
                                    </div>
                                    <div class="mb-2">
                                        <label for="position" class="form-label">직책</label>
                                        <select class="form-select" name="position" id="position" aria-label="Floating label select example">
                                        <option value="">가발령</option>
	                                     	</select>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">생년월일</label>
                                        <input class="form-control" type="date" name="birth" id="example-date" required>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">우편번호</label>
                                        <div class="d-flex">
	                                        <input class="form-control" type="text" id="postcode" name="post" required>
	                                        <button type="button" class="btn btn-soft-secondary waves-effect col-4 ms-3" onclick="post_code();">우편번호검색</button>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">주소</label>
                                        <input class="form-control" type="text" id="roadAddress" name="address">
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">상세 주소</label>
                                        <input class="form-control" type="text" id="address_detail" name="addressDetail" required>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">고용보험 가입일</label>
                                        <input class="form-control" type="date" name="employDate" id="example-date" required>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">통장</label>
                                        <div class="d-flex">
	                                        <input class="form-control" style="width:100px;" type="text" id="accountName" name="accountName" placeholder="은행명" required>
	                                        <input class="form-control ms-1" style="width:300px;" type="text" id="accountNo" name="accountNo" placeholder="계좌번호" required>
                                        </div>
                                    </div>
                                    <div class="mb-2">
                                        <label for="fullname" class="form-label">자기소개</label>
                                        <textarea class="form-control" id="direction" name="direction"></textarea>
                                    </div>
                                    
                                    <div class="d-grid text-center">
                                        <button type="submit" class="btn btn-primary"> 회원 가입 </button>
                                    </div>

                                </form>

                            </div> <!-- end card-body -->
                        </div>
                        <!-- end card -->

                        <div class="row mt-3">
                            <div class="col-12 text-center">
                                <p class="text-muted">이미 회원가입이 되어있다면? <a href="${ contextPath }/member/login.page" class="text-primary fw--medium ms-1">로그인</a></p>
                            </div> <!-- end col -->
                        </div>
                        <!-- end row -->

                    </div> <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </div>
        <!-- end page -->

</div>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
	const phoneAutoHyphen = (target) => {
	 target.value = target.value
	  .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
	}
	
	let pwdResult = false;
	let pwdEqualResult = false;
	let nameResult = false;

  $(document).ready(function(){
	  	ajaxChangeData('KB');
    	
    	$("#signup_form input[name=userPwd]").on("keyup", function(){ // pwd check
    		let regExp = /^[a-z\d!@#$%^&*]{8,15}$/;
    		
    		if($(this).val().trim().length == 0){
    			pwdResult = checkPrint("#pwdCheck_result", "usable unusable", "nocheck", "");
    		}else{
    			if(regExp.test($(this).val())){
    				pwdResult = checkPrint("#pwdCheck_result", "nocheck unusable", "usable", "사용가능한 비밀번호입니다.");
    			}else{
    				pwdResult = checkPrint("#pwdCheck_result", "nocheck usable", "unusable", "영문자, 숫자, 특수문자로 8~15자로 작성해주세요.");
    			}
    		}
    		validate();
    	})// pwd check end
    	
    	$("#signup_form input[id=checkPwd]").on("keyup", function(){
    		if($(this).val().trim().length == 0){
    			pwdEqualResult = checkPrint("#pwdEqualCheck_result", "usable unusable", "nocheck", "");
    		}else{
    			if($(this).val() == $("#signup_form input[name=userPwd]").val()){
    				pwdEqualResult = checkPrint("#pwdEqualCheck_result", "nocheck unusable", "usable", "비밀번호가 일치합니다.");
    			}else{
    				pwdEqualResult = checkPrint("#pwdEqualCheck_result", "nocheck usable", "unusable", "비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
    			}
    		}
    		
    		validate();
    	})// pwd equal check end
    	
    	$("#signup_form input[name=userName]").on("keyup", function(){ // name check start
    		
    		let regExp=/^[가-힣]{2,5}$/;
    		
    		if($(this).val().trim().length == 0){
    			nameResult = checkPrint("#nameCheck_result", "usable unusable", "nocheck", "");
    		}else{
    			if(regExp.test($(this).val())){
    				nameResult = checkPrint("#nameCheck_result", "nocheck unusable", "usable", "사용가능한 이름입니다.");
    			}else{
    				nameResult = checkPrint("#nameCheck_result", "nocheck usable", "unusable", "한글로 2~5자로 작성해주세요.");
    			}
    		}
    		validate();
    	})// name check end
    	
  })
	function checkPrint(selector, rmClassNm, addClassNm, msg){
    	$(selector).removeClass(rmClassNm)
								 .addClass(addClassNm)
								 .text(msg);
    	return addClassNm == "usable" ? true : false;
  }
	
	function validate(){
	   	console.log(pwdResult, pwdEqualResult, nameResult);
	   	if(pwdResult && pwdEqualResult && nameResult){
	   		$("#signup_form :submit").removeAttr("disabled");
	   	}else{
	   		$("#signup_form :submit").attr("disabled", true);
	   	}
   }
	
	function changePwdType(){
	   	var pwdType = $("#password").attr("type");
	   	if(pwdType == 'text'){
	   		$("#password").attr("type", "password");
	   	} else{
	   		$("#password").attr("type", "text");        		
	   	}
   }
	
	function changeCheckPwdType(){
	   	var pwdType = $("#checkPwd").attr("type");
	   	if(pwdType == 'text'){
	   		$("#checkPwd").attr("type", "password");
	   	} else{
	   		$("#checkPwd").attr("type", "text");        		
	   	}
   }
	
  //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
  function post_code() {
      new daum.Postcode({
          oncomplete: function(data) {
              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

              // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
              // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
              var roadAddr = data.roadAddress; // 도로명 주소 변수
              var extraRoadAddr = ''; // 참고 항목 변수

              // 법정동명이 있을 경우 추가한다. (법정리는 제외)
              // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
              if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                  extraRoadAddr += data.bname;
              }
              // 건물명이 있고, 공동주택일 경우 추가한다.
              if(data.buildingName !== '' && data.apartment === 'Y'){
                 extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
              }
              // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
              if(extraRoadAddr !== ''){
                  extraRoadAddr = ' (' + extraRoadAddr + ')';
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('postcode').value = data.zonecode;
              document.getElementById("roadAddress").value = roadAddr;
          }
      }).open();
  }
  function changeData(){
	  changeBranchData();
	  changeDepartmentData();
	  changeRankData();
  }
  
  function changeBranchData(){
	  if($("#branchOffice").val() != ''){
		  console.log($("#branchOffice").val());
		  let branch = $("#branchOffice").val();
		  let keyword = "DP" + branch.charAt(branch.length - 1);
			ajaxChangeData(keyword);
	  } else {
		  resetOption();
	  }
  }
  
  function changeDepartmentData(){
	  if($("#branchOffice").val() != ''){
		  console.log($("#branchOffice").val());
		  let branch = $("#branchOffice").val();
		  let keyword = "CR" + branch.charAt(branch.length - 1);
			ajaxChangeData(keyword);
	  } else {
		  resetOption();
	  }
  }
  
  function changeRankData(){
	  if($("#branchOffice").val() != ''){
		  console.log($("#branchOffice").val());
		  let branch = $("#branchOffice").val();
		  let keyword = "CP" + branch.charAt(branch.length - 1);
			ajaxChangeData(keyword);
	  } else {
		  resetOption();
	  }
  }
  
  function resetOption(){
	  let data = '<option value="">가발령</option>';
	  $("#department").html(data);
	  $("#position").html(data);
	  $("#rank").html(data);
  }
  
  function ajaxChangeData(keyword){
		console.log(keyword);
	  $.ajax({
			url:"${contextPath}/member/common.data",
			type:"get",
			data:"keyword=" + keyword,
			success:function(result){
				console.log(result);
				
				if(result != null){
					let data = '<option value="" selected>가발령</option>';
					let dataOption = "";
					let origin = result[0].value[0] + result[0].value[1];
					console.log(origin);
					for(let i = 0; i < result.length; i ++){
						data += '<option value="' + result[i].value + '">'+ result[i].name +'</option>'
					}
					
					if(origin == 'KB'){
						$("#branchOffice").html(data);
					} else if(origin == 'DP'){
						$("#department").empty();
						$("#department").html(data);
					} else if(origin == 'CP'){
						$("#position").empty();
						$("#position").html(data);
					} else if(origin == 'CR'){
						$("#rank").empty();
						$("#rank").html(data);
					}
					
				}
				
			},error:function(){
				console.log("아이디 검색 ajax 통신 실패");
			}
		})// ajax end
  }
  
  function changeImg(input){
  	if (input.files && input.files[0]) {
  	    var reader = new FileReader();
  	    reader.onload = function(e) {
  	      document.getElementById('profileImg').src = e.target.result;
  	    };
  	    reader.readAsDataURL(input.files[0]);
  	  } else {
  	    document.getElementById('profileImg').src = "${contextPath}/resources/images/defaultProfile.png";
  	  }
  }
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>