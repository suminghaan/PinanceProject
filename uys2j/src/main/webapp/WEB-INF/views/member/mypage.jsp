<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 페이지</title>
<style>
    .mytable{
        font-size: 16px;   
    }
    .mytable tr{
        height: 56px !important; /* 셀의 높이 설정 */
    }
    #profileImg{
        width:250px;
        height:245px;
        border:1px solid lightgray;
        border-radius: 50%;
    }
    .ri-lock-fill {
		font-size: 10px; /* 아이콘의 크기를 조절할 수 있는 속성 */
	}
    .addDelete{
        display: flex;
        justify-content: space-around;
        padding-top : 15px;
        /* height: 45px; */
    }
    .edadd{
        width: 80%; 
        height: 80%; 
        font-size: 16px;
        margin-top: 5px;
        margin-left: 10px;
    }
    .attchdown{
        display: flex;
        height: 55px;
        justify-content: space-between;
    }
</style>
</head>
<body>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
<!-- ============================================================== -->
 <!-- Start Page Content here -->
 <!-- ============================================================== -->

 <div class="content-page">
     
     <div class="wrap">
         <div class="card" style="margin-top: 30px;">
             <form id="modifyMemForm" action="${ contextPath }/member/modify.do" method="post" enctype="multipart/form-data">
                 <div class="LeftMyContent d-flex" style="margin: 2%;">
                     <div class="myContent1" style="margin-left: 8%;">
                         <table class="table table-bordered mb-0 mytable">
                             <thead>
                             		<div class="d-flex">
                                 <h2>${ loginUser.status == 'A' ? '사원정보관리' : loginUser.status == 'G' ? '사원정보관리' : '내정보관리' }</h2>
                                 <button type="button" id="changePwdBtn" class="btn btn-warning btn-bordered waves-effect waves-light m-auto" style="width: 120px; height: 38px;" onclick="location.href='${contextPath}/member/findPwd.page'">비밀번호 변경</button>
                             		</div>
                             </thead>
                             <tbody>
                                 <tr>
                                     <th style="width: 155px">사번 <i class="ri-lock-fill"></i></th>
                                     <td>
                                     	 <input type="hidden" id="originUser" value="${loginUser.userId }">
                                     	 <input type="text" id="userId" name="userId" value="${ empty member.userId ? loginUser.userId : member.userId }" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }>
	                                     <c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }">
	                                     		<button type="button" class="btn btn-info waves-effect waves-light" onclick="ajaxMemberSearch();">검색</button>
	                                     </c:if> 
	                                   </td>
                                 </tr>
                                 
                                 <tr>
                                     <th>이름</th>
                                     <td>
                                     	<input type="text" id="userName" name="userName" value="${ empty member.userId ? loginUser.userName : member.userName }">
                                     	<input type="hidden" id="hiddenStatus" name="status" value="${ empty member.userId ? loginUser.status : member.status}">
                                     	<select id="memStatus" name="status" style="height: 30px;width: 120px;" ${ loginUser.status == 'G' ? '' : 'disabled' }>
																		    <c:choose>
																			    <c:when test="${ loginUser.status eq 'G' }">
																			    	<script>
																			    		$("#memStatus").attr("name", "status");
																			    		$("#hiddenStatus").attr("name", "memStatus");
																			    	</script>
																			    	<option value="Y" ${ empty member.userId ? (loginUser.status == 'Y' ? 'selected' : '') : (member.status == 'Y' ? 'selected' : '') }>일반 사원</option>
																			    	<option value="A" ${ empty member.userId ? (loginUser.status == 'A' ? 'selected' : '') : (member.status == 'A' ? 'selected' : '') }>관리자</option>
																				    <option value="G" ${ empty member.userId ? (loginUser.status == 'G' ? 'selected' : '') : (member.status == 'G' ? 'selected' : '') }>최고 관리자</option>
																			    </c:when>
																			    <c:otherwise>
																			    	<script>
																			    		$("#memStatus").attr("name", "memStatus");
																			    		$("#hiddenStatus").attr("name", "status");
																			    	</script>
																			    	
																				    <option value="Y" ${ member.status == 'G' || member.status == 'A' || member.status == 'Y' ? 'selected' : '' }>재직</option>
																			    </c:otherwise>
																		    </c:choose>
																			    <option value="B" ${ member.status == 'B' ? 'selected' : '' }>병가</option>
																			    <option value="H" ${ member.status == 'H' ? 'selected' : '' }>휴직</option>
																			    <option value="N" ${ member.status == 'N' ? 'selected' : '' }>퇴사</option>
																			</select>

                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>부서 <i class="ri-lock-fill"></i></th>
                                     <td>
	                                     <label for="branchOffice">지점</label>
	                                     <select style="height: 30px;width: 150px;" name="branchOffice" id="branchOffice" onchange="changeData();" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'disabled' }>
			                                   <option selected></option>
	                                     </select>
	                                     <label class="ms-3" for="department">부서</label>
	                                     <select style="height: 30px;width: 150px;" name="department" id="department" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'disabled' }>
			                                   <option selected></option>
	                                     </select>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>직급 <i class="ri-lock-fill"></i></th>
                                     <td>
                                     	<select style="height: 30px;width: 150px;" name="rank" id="rank" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'disabled' }>
			                                	<option selected></option>
	                                    </select>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>직책 <i class="ri-lock-fill"></i></th>
                                     <td>
	                                     <select style="height: 30px;width: 150px;" name="position" id="position" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'disabled' }>
			                                   <option selected></option>
	                                     </select>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>이메일</th>
                                     <td><input type="email" id="email" name="email" value="${ empty member.userId ? loginUser.email : member.email }" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }></td> 
                                 </tr>
                                 <tr>
                                     <th>휴대전화</th>
                                     <td><input type="text" id="phone" name="phone" value="${ empty member.userId ? loginUser.phone : member.phone }"></td> 
                                 </tr>
                                 <tr>
                                     <th>입사일 <i class="ri-lock-fill"></i></th>
                                     <td><input type="date" id="regTime" name="defaultDto.regTime" value="${ empty member.userId ? loginUser.defaultDto.regTime : member.defaultDto.regTime }" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }></td> 
                                 </tr>
                                 <tr>
                                     <th>생년월일 <i class="ri-lock-fill"></i></th>
                                     <td>
                                         <input type="date" id="birth" name="birth" value="${ empty member.userId ? loginUser.birth : member.birth }" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>우편번호</th>
                                     <td>
                                         <input type="text" id="postcode" name="post" size="10px" value="${ empty member.userId ? loginUser.post : member.post }"> <button type="button" class="btn btn-info waves-effect waves-light" onclick="post_code();">주소 검색</button>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>주소</th>
                                     <td><input type="text" id="roadAddress" name="address" size="50px" value="${ empty member.userId ? loginUser.address : member.address }"></td> 
                                 </tr>
                                 <tr>
                                     <th>상세주소</th>
                                     <td><input type="text" id="addressDetail" name="addressDetail" size="50px" value="${ empty member.userId ? loginUser.addressDetail : member.addressDetail }"></td> 
                                 </tr>
                                 <tr>
                                     <th>급여계좌 <i class="ri-lock-fill"></i></th>
                                     <td>
                                     	<input type="text" id="accountName" name="accountName" value="${ empty member.userId ? loginUser.accountName : member.accountName }" size="10%" placeholder="은행명"${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }>&nbsp;&nbsp;
                                     	<input type="text" id="accountNo" name="accountNo" value="${ empty member.userId ? loginUser.accountNo : member.accountNo }" size="20%" placeholder="계좌번호"${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }>
                                     </td> 
                                 </tr>
                                 <tr>
                                     <th>고용보험가입일 <i class="ri-lock-fill"></i></th>
                                     <td><input type="date" id="employDate" name="employDate" value="${ empty member.userId ? loginUser.employDate : member.employDate }" ${ loginUser.status == 'A' ? '' : loginUser.status == 'G' ? '' : 'readonly' }></td> 
                                 </tr>
                                 <tr>
                                     <th>기타정보</th>
                                     <td><textarea name="direction" id="direction" cols="50" rows="5" style="resize: none;">${ empty member.userId ? loginUser.direction : member.direction }</textarea></td> 
                                 </tr>
                                 <tr>
                                     <th>서명</th>
                                     <td style="display: flex; justify-content: space-between; align-items: center; padding-right: 10%;">
	                                    	<button type="button" id="signBtn" class="btn btn-info waves-effect waves-light" data-bs-toggle="modal" data-bs-target="#sign-modal">서명그리기</button>
	                                     <div id="signCheck">
	                                     	<c:if test="${not empty signCount}">
	                                     		서명있음
	                                     	</c:if>
	                                     </div>
                                     </td>
                                 </tr>
                             </tbody>
                             
                         </table>
                     </div>
                     <div class="myContent2" style="margin-left: 2%;">
                         <table class="table table-bordered mb-0 mytable" style="width: 280px;">
                             <thead style="height: 15px;">
                                 <div style="display: flex; justify-content: flex-end; width: 280px; margin-top: 5px; margin-bottom: -5px;">
                                     <button class="btn btn-primary btn-bordered waves-effect waves-light" style="width: 80px;" type="button" onclick="modifyMem();">저장</button>
                                     <c:if test="${ loginUser.status eq 'A' or loginUser.status eq 'G' }">
	                                     <button class="btn btn-danger btn-bordered waves-effect waves-light ms-1" style="width: 80px;" type="button" onclick="checkDelete();">삭제</button>
                                     </c:if>
                                 </div>
                             </thead>
                             <tr>
                                 <td colspan="3" style="height: 336px">
                                     <div class="profile_img">
                                         <img id="profileImg" src="${ contextPath }<c:out value='${empty member.userId ? loginUser.profilePath : member.profilePath}' default='/resources/images/defaultProfile.png'/>" onclick="$('#profileImgFile').click();">
                                         <input type="file" class="file" name="profileImgFile" id="profileImgFile" style="display:none;" accept="image/*" onchange="changeImg(this);">
                                     </div>
                                     <div class="addDelete" >
                                         <button type="button" class="btn btn-outline-primary rounded-pill waves-effect waves-light" onclick="$('#profileImgFile').click();"><i class="ri-add-line"></i></button>
                                         <button type="button" class="btn btn-outline-secondary rounded-pill waves-effect" onclick="changeDefault();"><i class="ri-close-line"></i></button>
                                     </div>
                                 </td>
                             </tr>
                         </table>
                         
                     </div>
                     
                 </div>
                 
             </form>
         </div>
		
			
    </div>
 </div>

 <!-- ============================================================== -->
 <!-- End Page content -->
 <!-- ============================================================== -->
 	
 	<!------------------------- sign 모달 ----------------------------->
 	<div id="sign-modal" class="modal fade" tabindex="-1" role="dialog"
			aria-hidden="true" style="display: none;">
			<div class="modal-dialog">
				<div class="modal-content">
				
					<form action="${contextPath}/member/insertSign.do" method="post" enctype="multipart/form-data">
					<div class="modal-header">
							<h4 class="modal-title">서명 그리기</h4>
							<button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					</div>
					<div class="modal-body p-4">
						<div style="display: flex;width: 100%;height: 300px;justify-content: center;align-items: center;">
							<canvas id="canvas" style="border:1px solid black;width: 400px;height: 250px;"></canvas>
						</div>
						<input type="hidden" name="imageData" id="imageData">
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal" id="cancelSign">취소</button>
							<button type="submit" id="saveSign" class="btn btn-primary waves-effect waves-light">등록</button>
						</div>
					</div>
					</form>

					<script>
						function checkDelete(){
							alertify.confirm('회원 삭제', '정말 삭제 하시겠습니까?', function(){ alertify.success('삭제'); deleteMember(); }
			                , function(){ alertify.error('취소')});
						}
						function modifyMem(){
							$("#modifyMemForm").submit();
						}
						
				    (function(obj){
				        obj.init();
				    })
				    ((function(){
				        var canvas = document.getElementById("canvas");
				        var ctx = canvas.getContext("2d");
				        var drawable = false;
				        document.getElementById("cancelSign").addEventListener("click", clearCanvas); // 취소버튼 시 초기화

				        function canvasResize(){
				            canvas.width = 400; // 고정 너비
				            canvas.height = 250; // 고정 높이
				        }

				        function clearCanvas() {
				            ctx.clearRect(0, 0, canvas.width, canvas.height); // 그려진 모든 것을 지움
				        }

				        function getPosition(e) {
				            var rect = canvas.getBoundingClientRect();
				            return {
				                X: e.clientX - rect.left,
				                Y: e.clientY - rect.top
				            };
				        }

				        function draw(e){
				            var pos = getPosition(e);
				            switch(e.type){
				                case "mousedown":
				                    drawable = true;
				                    ctx.beginPath();
				                    ctx.moveTo(pos.X, pos.Y);
				                    break;
				                case "mousemove":
				                    if(drawable){
				                        ctx.lineTo(pos.X, pos.Y);
				                        ctx.stroke();
				                    }
				                    break;
				                case "mouseup":
				                case "mouseout":
				                    if (drawable) {
				                        drawable = false;
				                        ctx.closePath();
				                    }
				                    break;
				            }
				        }
				        return {
				            init: function(){
				                $(window).on("resize", canvasResize);
				                $('#sign-modal').one('shown.bs.modal', function() {
				                    canvasResize();
				                });
				                canvasResize();
				                canvas.addEventListener("mousedown", draw);
				                canvas.addEventListener("mousemove", draw);
				                canvas.addEventListener("mouseup", draw);
				                canvas.addEventListener("mouseout", draw);
				            }
				        };
				    })());
				    
				    document.getElementById('saveSign').addEventListener('click', function(event) {
				        var canvas = document.getElementById('canvas');
				        var dataURL = canvas.toDataURL('image/png');
				        document.getElementById('imageData').value = dataURL;
				    });
				    
				    function changeDefault(){
				    	$("#profileImg").attr("src", "${contextPath}/resources/images/defaultProfile.png");
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
	
				</div>
			</div>
		</div>
		<!------------------------------------- sign 모달 end ------------------------------------>
 
 	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
 	<script>
 		function userCheck() {
 			if($("#userId").val() == $("#originUser").val()) {
 				// 로그인 유저가 맞으면 버튼 활성화
 				 $("#signBtn").prop("disabled", false);
 				 $("#changePwdBtn").prop("disabled", false);
 			}else{
 				// 로그인 유저가 안맞으면 버튼 비활성화
 				 $("#signBtn").prop("disabled", true);
 				 $("#changePwdBtn").prop("disabled", true);
 			}
 		}
 		function ajaxMemberSearch(){
 			$.ajax({
				url:"${contextPath}/member/otherId.do",
				type:"get",
				data:"userId=" + $("#userId").val(),
				success:function(result){
					console.log(result);
					if(result != null){
						dataSet(result);
						userCheck();
					}else{
						alertify.alert('회원 검색', '검색된 회원이 없습니다!', function(){ alertify.success('Ok'); });
					}
									
				},error:function(){
					console.log("아이디 검색 ajax 통신 실패");
				}
			})// ajax end			
 		}
		function deleteMember(){
				location.href="${contextPath}/member/delete.do?userId=" + $("#userId").val();
		}
		function dataSet(result){
			console.log(result);
			
			$("#hiddenStatus").val(result.status);
			if('${loginUser.status}' == 'A' && result.status == 'A'){
				result.status = 'Y';
			}
			
			$("#memStatus").val(result.status).prop("selected",true);				
			$("#userId").val(result.userId);
			$("#userName").val(result.userName);
			searchMember(result.branchOffice
								 , result.department
								 , result.rank
								 , result.position);
			$("#email").val(result.email);
			$("#phone").val(result.phone);
			$("#regTime").val(result.defaultDto.regTime);
			$("#birth").val(result.birth);
			$("#post").val(result.post);
			$("#address").val(result.address);
			$("#addressDetail").val(result.addressDetail);
			$("#accountName").val(result.accountName);
			$("#accountNo").val(result.accountNo);
			$("#employDate").val(result.employDate);
			$("#direction").val(result.direction);
			if(result.profilePath == null){
				$("#profileImg").attr("src", "${contextPath}/resources/images/defaultProfile.png");				
			} else {
				$("#profileImg").attr("src", "${contextPath}" + result.profilePath);								
			}
			if(result.signCount != 0){
				$("#signCheck").text("서명있음");
			}else{
				$("#signCheck").text("");
			}
		}
	const phoneAutoHyphen = (target) => {
	 target.value = target.value
	  .replace(/[^0-9]/g, '')
	  .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
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
  
  function changeProfile(){
		$("#profileImgFile").attr("name", "uploadFile");
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
  
  function ajaxChangeData(keyword){
		console.log(keyword);
	  $.ajax({
			url:"${contextPath}/member/common.data",
			type:"get",
			data:"keyword=" + keyword,
			async: false,
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
						$("#department").html(data);
					} else if(origin == 'CP'){
						$("#position").html(data);
					} else if(origin == 'CR'){
						$("#rank").html(data);
					}
					
				}
				
			},error:function(){
				console.log("아이디 검색 ajax 통신 실패");
			}
		})// ajax end
		
  }
  
  function resetOption(){
	  let data = '<option value="" selected>가발령</option>';
	  $("#department").html(data);
	  $("#position").html(data);
	  $("#rank").html(data);
  }
  
	$(document).ready(function(){
		ajaxChangeData('KB');
		let branchOffice = '${ empty member.userId ? loginUser.branchOffice : member.branchOffice }';
		if(branchOffice == ''){
			branchOffice = "가발령";
		}
		let department = '${ empty member.userId ? loginUser.department : member.department }';
		if(department == ''){
			department = "가발령";
		}
		let rank = '${ empty member.userId ? loginUser.rank : member.rank }';
		if(rank == ''){
			rank = "가발령";
		}
		let position = '${ empty member.userId ? loginUser.position : member.position }';
		if(position == ''){
			position = "가발령";
		}
		console.log($("#branchOffice").val(branchOffice));
		$('#branchOffice option:contains('+ branchOffice +')').attr('selected', true);
		changeData();
		$('#department option:contains('+ department +')').attr('selected', true);
		$('#rank option:contains('+ rank +')').attr('selected', true);
		$('#position option:contains('+ position +')').attr('selected', true);
		
		userCheck();
	})
	
	function searchMember(branchOffice, department, rank, position){
		ajaxChangeData('KB');
		if(branchOffice == ''){
			branchOffice = "가발령";
		}
		if(department == ''){
			department = "가발령";
		}
		if(rank == ''){
			rank = "가발령";
		}
		if(position == ''){
			position = "가발령";
		}
		$('#branchOffice option:contains('+ branchOffice +')').attr('selected', true);
		changeData();
		$('#department option:contains('+ department +')').attr('selected', true);
		$('#rank option:contains('+ rank +')').attr('selected', true);
		$('#position option:contains('+ position +')').attr('selected', true);
	}
 	</script>
 	
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>