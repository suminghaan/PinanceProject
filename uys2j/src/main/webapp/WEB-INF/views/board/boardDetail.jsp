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
<style>
.card {
	margin-top: 10px;
}
.left-side-menu{
		margin-left:25px;
	}
#inline-username{
	color: #6c757d; 
	border-bottom: none;
	font-weight: bold;
}
</style>
<link href="${ contextPath }/resources/libs/x-editable/bootstrap-editable/css/bootstrap-editable.css" rel="stylesheet" type="text/css" />
<script src="https://code.jquery.com/jquery-3.7.1.min.js" integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo=" crossorigin="anonymous"></script>

<body>
	<div class="wapper">
		<jsp:include page="/WEB-INF/views/common/header.jsp" />
		<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />

		<div class="content-page">
			<div class="content">
				<div class="container-fluid">
				<!-- start page title -->
				<div class="row">
					<div class="col-12">
						<div class="page-title-box page-title-box-alt" style="margin-top: 20px;">
							<h4 class="page-title"style="margin-left: 20px;">게시판</h4>
							<div class="page-title-right">
								<ol class="breadcrumb m-0">
									<li class="breadcrumb-item"><a href="javascript: void(0);">게시판</a></li>
									<li class="breadcrumb-item active">게시글 상세</li>
								</ol>
							</div>
						</div>
					</div>
				</div>
				<!-- end page title -->
					<div class="card" style="border: 1px solid #4A55A2; width: 98%; margin-left: auto; margin-right: auto; border-radius: 10px;">
						<div class="card-body">
							<div class="board-space">
								<div class="detail-header">
									<div class="detail-mine" style="margin-bottom: 30px;">
										<div style="float: left;">
											<span class="btn btn-outline-secondary waves-effect"><a onclick="clip(); return false;" style="color: gray;">주소복사</a></span>
											 <a class="btn btn-outline-secondary waves-effect" href="${contextPath}/board/boardList.do?type=${board.boardNo}">목록</a>
										</div>
										<div style="text-align: right;">
											<c:if test="${loginUser.userId eq board.defaultDto.regId}">
												<a class="btn btn-outline-secondary waves-effect" href="${contextPath}/board/modifyForm.page?no=${board.postNo}">수정</a>
												<a class="btn btn-outline-danger waves-effect waves-light" href="${contextPath}/board/delete.do?no=${board.postNo}&type=${board.boardNo}">삭제</a>
											</c:if>
										</div>
									</div>
								</div>
								<c:if test="${loginUser.userId != board.defaultDto.regId}">
									<br>
								</c:if>
								<hr>
								<div class="detail-content">
									<div class="board-title">
										<span class="board-title" style="font-size: x-large; font-weight: bold; display: flex; margin-bottom: 5px;">${board.postTitle}</span>
										<c:choose>
											<c:when test="${board.boardType eq 'BA002'}">
													<span style="font-size: medium; margin-right: 10px;">익명</span>
											</c:when>
											<c:otherwise>
												<span style="font-size: medium; margin-right: 10px;">${board.userName}</span>
											</c:otherwise>
										</c:choose>
											
										<span style="font-size: medium;">조회</span> 
										<span style="font-size: medium; margin-right: 10px;">${board.postCount}</span> 
										<span style="margin-top: 3px; font-size: medium;">${board.defaultDto.regTime}</span>
									</div>
									<div class="attchment-content" style="margin-top: 5px;">
										<ul style="list-style: none; padding-left: 0px;">
											<c:forEach var="at" items="${ board.attachList }">
	                      <li><a style="font-size: medium;" href="${ contextPath }${at.filePath}/${at.filesystemName}" download="${ at.originalName }">${ at.originalName }</a></li>
	                    </c:forEach>
										</ul>
									</div>
									<hr>
									<div class="board-content" style="min-height: 300px;">
										<div class="board-style">
											<p>
												<span>${board.postContent}</span>
											</p>
										</div>
									</div>
									<hr style="margin: 0;">
									<!-- 댓글 -->
									<table id="replyArea" class="table">
										<thead>
											<tr>
												<th colspan="3"><textarea class="form-control" name="replyCotent" id="replyContent" cols="55" rows="2" style="resize: none;"></textarea></th>
												<th style="vertical-align: middle;">
												<button class="btn btn-outline-secondary waves-effect" type="button" onclick="ajaxInsertReply();">등록</button>
												</th>
											</tr>
											<tr>
												<td colspan="4"><span id="rcount" style="color: blue;"></span>개의댓글</td>
											</tr>
										</thead>
										<tbody style="text-align: center;">

											<!--<tr>
												<th>user02</th>
												<td><a href="#" id="inline-username" data-type="text" data-pk="1" data-title="Enter username">댓글입니당</a></td>
												<td>2020-04-10</td>
												<td>
													<button class="btn btn-outline-secondary waves-effect rreplyBtn">답글</button>
													<button class="btn btn-outline-secondary waves-effect">삭제</button>
												</td>
											</tr>


											<tr id="rreplyForm">
												<th colspan="3"><textarea class="form-control" name="" id="rr_content" cols="55" rows="2" style="resize: none; margin-left: 15%"></textarea></th>
												<th style="vertical-align: middle;">
													<button class="btn btn-outline-secondary waves-effect" id="writeBtn" type="button" style="margin-left: 40px;">등록</button>
													<button class="btn btn-outline-secondary waves-effect" type="button">취소</button>
												</th>
											</tr>-->

										</tbody>
									</table>

								</div>

								<script type="text/javascript">
									function clip() {

										var url = '';
										var textarea = document.createElement("textarea");
										document.body.appendChild(textarea);
										url = window.document.location.href;
										textarea.value = url;
										textarea.select();
										document.execCommand("copy");
										document.body.removeChild(textarea);
										alert("URL이 복사되었습니다.")
									}
								</script>
								<script>
								$(document).ready(function() {
						        ajaxReplyList();
						
						        $(document).on("click", ".removeReply", function() {
						            if (confirm("정말로 삭제하시겠습니까?")) {
						                $.ajax({
						                    url: "${contextPath}/board/removeReply.do",
						                    type: "get",
						                    data: "no=" + $(this).data("replyno"),
						                    success: function(result) {
						                        if (result == "SUCCESS") {
						                            ajaxReplyList();
						                        }
						                    },
						                    error: function() {
						                        console.log("삭제 실패");
						                    }
						                });
						            }
						        });
						
						        $(document).on("click", ".rreplyBtn", function() {
						            $("#rreplyForm").remove();
						            var replyForm = "<tr id='rreplyForm'>" +
						                "<th colspan='3'><textarea class='form-control' name='rreplyContent' id='rreplyContent' cols='55' rows='2' style='resize: none;'></textarea></th>" +
						                "<th style='vertical-align: middle;'>" +
						                "<input id='hiddenReply' type='hidden' value='" + $(this).data('replyno') + "'>" +
						                "<input id='parentReply' type='hidden' value='" + $(this).closest('tr').attr('id') + "'>" +
						                "<button class='btn btn-outline-secondary waves-effect' id='writeBtn' type='button'>등록</button>" +
						                "<button class='btn btn-outline-secondary waves-effect' style='margin-left: 5px;' type='button' id='cancelBtn'>취소</button>" +
						                "</th>" +
						                "</tr>";
						
						            $(this).closest("tr").after(replyForm);
						
						            $("#cancelBtn").on("click", function() {
						                $("#rreplyForm").remove();
						            });
						
						            $("#writeBtn").on("click", function() {
						                ajaxInsertReply();
						            });
						        });
						    });
						
						    function ajaxInsertReply() {
						        var msg = "";
						        if ($("#replyContent").val().trim() !== "") {
						            msg = $("#replyContent").val();
						        } else if ($("#rreplyContent").val().trim() !== "") {
						            msg = $("#rreplyContent").val();
						        }
						        $.ajax({
						            url: "${contextPath}/board/registReply.do",
						            type: "post",
						            data: {
						                replyContent: msg,
						                postNo: ${board.postNo},
						                replyUpstair: $("#hiddenReply").val()
						            },
						            success: function(result) {
						                if (result == "SUCCESS") {
						                    $("#replyContent").val("");
						                    ajaxReplyList();
						                } else if (result == "FAIL") {
						                    alert("댓글 작성 서비스 실패", "다시 입력해주세요.");
						                }
						            },
						            error: function() {
						                console.log("댓글 insert 실패");
						            }
						        });
						    }
						
						    $(document).on("click", ".modReply", function(event) {
						        event.preventDefault(); // 기본 동작 방지
						        var $this = $(this);
						        $this.editable({
						            type: 'text',
						            mode: 'inline',
						            success: function(response, newValue) {
						                if (response == "SUCCESS") {
						                    $this.text(newValue);
						                } else {
						                    console.log("수정 실패");
						                }
						            },
						            error: function() {
						                console.log("수정 실패");
						            }
						        });
						        $this.editable('toggle');  // 수정 모드 진입
						    });
						
						    $(document).on("click", ".editable-submit", function(event) {
						        event.preventDefault(); // 기본 동작 방지
						
						        var $editableContainer = $(this).closest('.editable-container');
						        var replyNo = $editableContainer.prev().data('pk');
						        var replyContent = $editableContainer.find('input[type="text"]').val();
						
						        $.ajax({
						            url: "${contextPath}/board/updateReply.do",
						            type: "post",
						            data: {
						                replyNo: replyNo,
						                replyContent: replyContent
						            },
						            success: function(result) {
						                if (result == "SUCCESS") {
						                    alert("댓글이 성공적으로 수정되었습니다.");
						                    ajaxReplyList();
						                } else if (result == "FAIL") {
						                    alert("댓글 수정 실패", "다시 시도해주세요.");
						                }
						            },
						            error: function() {
						                console.log("수정 실패");
						            }
						        });
						    });
						
						    function ajaxReplyList() {
						        $.ajax({
						            url: "${contextPath}/board/replyList.do",
						            type: "get",
						            data: "no=${board.postNo}",
						            success: function(regData) {
						                $.fn.editable.defaults.mode = 'inline';
						                $.fn.editableform.loading = "<div class='editableform-loading'><i class='ace-icon fa fa-spinner fa-spin fa-2x light-blue'></i></div>";
						                $("#rcount").text(regData.length);

						                var replies = buildReplyTree(regData);
						                var tr = buildReplyHTML(replies);

						                $("#replyArea tbody").html(tr);

						                $.each(regData, function(index, data) {
						                    $('#inline-comments' + index).editable({
						                        type: 'text',
						                        mode: 'inline',
						                        url: '${contextPath}/board/updateReply.do',
						                        params: function(params) {
						                            params.replyContent = params.value;
						                            return params;
						                        },
						                        success: function(response, newValue) {
						                            if (response == "SUCCESS") {
						                                $(this).text(newValue);
						                            }
						                        },
						                        error: function() {
						                            console.log("수정 실패");
						                        }
						                    });
						                });
						            }
						        });
						    }
						
						    function buildReplyTree(data) {
						        var map = {};
						        var roots = [];

						        // 모든 댓글을 초기화하고 map에 넣습니다.
						        data.forEach(function(reply) {
						            reply.children = [];
						            map[reply.replyNo] = reply;
						        });

						        // 각 댓글을 적절한 부모 댓글 아래에 삽입합니다.
						        data.forEach(function(reply) {
						            if (reply.replyUpstair) {
						                if (map[reply.replyUpstair]) {
						                    map[reply.replyUpstair].children.push(reply);
						                }
						            } else {
						                roots.push(reply);
						            }
						        });

						        return roots;
						    }
						
						    function buildReplyHTML(replies) {
						        var html = '';

						        function buildHTML(reply, level) {
						            if (level == undefined) level = 0;
						            var indent = '&nbsp;'.repeat(level * 4);
						            var subIcon = level > 0 ? '<i class="bx bx-subdirectory-right"></i>' : '';

						            html += "<tr id='reply" + reply.replyNo + "'>";

						            if('${board.boardType}' == 'BA002'){
						                html += "<th>" + indent + subIcon + " 익명 </th>";
						            } else {
						                html += "<th>" + indent + subIcon + reply.userName + "</th>";
						            }

						            if (reply.defaultDto.regId == '${loginUser.userId}') {
						                html += "<td><a href='#' id='inline-comments" + reply.replyNo + "' class='editable editable-click modReply' data-type='text' data-pk='" + reply.replyNo + "' data-title='Enter comments'>" + reply.replyContent + "</a></td>";
						            } else {
						                html += "<td>" + reply.replyContent + "</td>";
						            }

						            html += "<td>" + reply.defaultDto.regTime + "</td>";

						            // 대댓글(level > 0)인 경우 답글 버튼을 제외하고 hidden input 추가
						            html += "<td>";
						            if (level == 0) {
						                html += "<button class='btn btn-outline-secondary waves-effect rreplyBtn' data-replyno='" + reply.replyNo + "'>답글</button>";

						                if (reply.defaultDto.regId == '${loginUser.userId}') {
						                    html += "<button class='btn btn-outline-secondary waves-effect removeReply' style='margin-left: 5px;' data-replyno='" + reply.replyNo + "'>삭제</button>";
						                }
						            } else {
						                html += "<input type='hidden'>";
						                if (reply.defaultDto.regId == '${loginUser.userId}') {
						                    html += "<button class='btn btn-outline-secondary waves-effect removeReply' style='margin-left: 5px;' data-replyno='" + reply.replyNo + "'>삭제</button>";
						                }
						            }
						            html += "</td></tr>";
						        }

						        function buildAllReplies(replies, level) {
						            replies.forEach(function(reply) {
						                buildHTML(reply, level);
						                if (reply.children && reply.children.length > 0) {
						                    buildAllReplies(reply.children, level + 1);
						                }
						            });
						        }

						        buildAllReplies(replies, 0);

						        return html;
						    }
						
						</script>
								
							</div>
						</div>
						<!-- end card body-->
					</div>
					<!-- end card -->
				</div>
				<!-- container-fluid -->

			</div>
			<!-- content -->

		</div>

	</div>

	<jsp:include page="/WEB-INF/views/common/footer.jsp" />
<!-- Plugins js -->
<script src="${ contextPath }/resources/libs/x-editable/bootstrap-editable/js/bootstrap-editable.min.js"></script>
<script src="${ contextPath }/resources/libs/moment/min/moment.min.js"></script>

<!-- Init js-->
<script src="${ contextPath }/resources/js/pages/form-xeditable.init.js"></script>

</body>
</html>
