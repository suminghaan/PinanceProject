<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 생성</title>

<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!-- Treeview css -->
<link href="${contextPath}/resources/libs/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />

<style>
    .card { margin-top: 10px;}
    .authority{
        display: flex; 
        width: 100%; 
        height: 50px; 
        align-items: center; 
        justify-content: center;
    } 
    .plusBtn{
        background-color: transparent; 
        border: 0;
    }
    .checklist{
       display: flex; 
       border-bottom: 1px solid rgb(234, 234, 234); 
       justify-content: center; 
       align-items: center; 
       height: 50px;
    }
    .chekcTreeForm{
        border: 1px solid rgb(214, 214, 214); 
        width: 489px; 
        overflow: overlay; 
        height: 358px;
    } 
    .checklistForm{
        border: 1px solid rgb(214, 214, 214); 
        width: 250px; 
        height: 100%; 
        margin-left: 10px;
    }
    .left-side-menu{
        margin-left:25px;
    }
    .memberResult {
        height: 300px; /* Adjust the height as needed */
        overflow-y: auto;
    }
    .result {
        max-height: 300px; /* Adjust the max-height as needed */
        overflow-y: auto;
    }
    .name-container, .role-container {
		    flex: 1;
		    display: flex;
		    justify-content: center;
		    align-items: center;
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
								<h4 class="page-title"style="margin-left: 20px;">게시판</h4>
								<div class="page-title-right">
									<ol class="breadcrumb m-0">
										<li class="breadcrumb-item"><a href="javascript: void(0);">게시판</a></li>
										<li class="breadcrumb-item active">게시판 수정</li>
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
                            <div class="create-space">
                                <h3>게시판 수정</h3>
                                <br>
                                <form id="boardForm" method="post" action="${contextPath}/board/modifyBoard.do?no=${b.boardNo}">
                                <input type="hidden" name="boardNo" value="${b.boardNo}"/>
                                <input type="hidden" id="selectedMembers" name="selectedMembers" />
                                <input type="hidden" name="boardType" id="boardType" value="${b.boardType}">
																<input type="hidden" name="defaultRoleHidden" id="defaultRoleHidden" value="">
                                <div>
                                    <h4>이름</h4>
                                    <input class="form-control" type="text" name="boardName" value="${b.boardName}" placeholder="게시판이름을입력하세요" style="width: 30%;" required>
                                </div>
                                <br>
                                <div style="font-size: medium;">
                                    <h4>게시판 종류</h4>
                                    <label>전체게시판</label> <input type="radio" name="bType" value="전체게시판" style="margin-right: 30px; margin-left: 10px;" ${b.boardType.startsWith('BA') ? 'checked' : ''}> 
                                    <label>그룹게시판</label> <input type="radio" name="bType" value="그룹게시판" style="margin-left: 10px;" ${b.boardType == 'BG' ? 'checked' : ''}>
                                </div>
                                <br>
                                <div style="font-size: medium;">
                                    <h4>익명 설정</h4>
                                    <label>익명게시판으로 사용</label> <input type="checkbox" name="bCategory" ${b.boardType == 'BA002' ? 'checked' : ''} style="margin-left: 10px;" ${b.boardType == 'BG' ? 'disabled' : ''}> 
                                </div>
                                    
                                <!-- 그룹게시판 선택시 익명게시판 사용못하게 script구문 -->
                               <script>
                               $(document).ready(function() {
                            	    const defaultRoleFromBackend = "${b.defaultRole}";
                            	    let defaultRole = defaultRoleFromBackend == "W" ? "읽기/쓰기" : "읽기";
                            	    const loggedInUserId = "${loginUser.userId}"; // 로그인한 사용자의 ID
                            	    const loggedInUserName = "${loginUser.userName}"; // 로그인한 사용자의 이름
                            	    let selectedMembers = [];

                            	    try {
                            	        selectedMembers = JSON.parse('${selectedMembersJson}') || [];
                            	        console.log("Selected Members: ", selectedMembers);
                            	    } catch (e) {
                            	        selectedMembers = [];
                            	    }

                            	    function updateWriteButtonVisibility() {
                            	        if (defaultRole === "읽기/쓰기") {
                            	            $('.write-button').show();
                            	        } else {
                            	            $('.write-button').hide();
                            	        }
                            	    }

                            	    function updateRoleDisplays() {
                            	        $('.memberResult .authority').each(function() {
                            	            var memberName = $(this).data('member-name');
                            	            if (memberName !== loggedInUserName) { // 로그인한 사용자는 고정
                            	                $(this).find('.role-display').text(defaultRole);
                            	            } else {
                            	                $(this).find('.role-display').text("읽기/쓰기");
                            	            }
                            	        });
                            	    }

                            	    $('#defaultRole').change(function() {
                            	        defaultRole = $(this).val();
                            	        updateRoleDisplays();
                            	        updateWriteButtonVisibility();
                            	    });

                            	    $('#defaultRole').val(defaultRole);
                            	    updateWriteButtonVisibility();

                            	    function initDeptTree() {
                            	        $.ajax({
                            	            url: "${contextPath}/board/deptList.do",
                            	            type: "get",
                            	            dataType: 'json',
                            	            success: function(data) {
                            	                var deptlist = data.map(function(item) {
                            	                    return {
                            	                        id: item.deptValue,
                            	                        parent: item.deptUpstair,
                            	                        text: item.commonName,
                            	                        state: { opened: item.deptValue == 'KB001' }
                            	                    };
                            	                });

                            	                $('#checkTree').jstree('destroy').empty();
                            	                $('#checkTree').jstree({
                            	                    'plugins': ['types', 'sort', 'search', 'checkbox'],
                            	                    'core': {
                            	                        'data': deptlist,
                            	                        'check_callback': true
                            	                    },
                            	                    'types': {
                            	                        'default': {
                            	                            'icon': 'fa fa-user'
                            	                        }
                            	                    }
                            	                });

                            	                $('#checkTree').on('loaded.jstree', function() {
                            	                    // 선택된 멤버 체크하기
                            	                    let allNodes = $('#checkTree').jstree(true).get_json('#', { 'flat': true });
                            	                    
                            	                    selectedMembers.forEach(function(member) {
                            	                        let node = allNodes.find(n => n.text == member);
                            	                        if (node) {
                            	                            $('#checkTree').jstree('check_node', node.id);
                            	                        }
                            	                    });
                            	                    // 작성자 고정 선택
                            	                    var adminNode = $('#checkTree').jstree(true).get_node(loggedInUserId);
                            	                    if (adminNode) {
                            	                        $('#checkTree').jstree('check_node', adminNode.id);
                            	                    }
                            	                    updateSelectedMembers();
                            	                });

                            	                $('#checkTree').on('changed.jstree', function(e, data) {
                            	                    updateSelectedMembers();
                            	                });
                            	            },
                            	            error: function(jqXHR, textStatus, errorThrown) {
                            	                console.log("AJAX Error: ", textStatus, errorThrown);
                            	            }
                            	        });
                            	    }

                            	    function updateSelectedMembers() {
                            	        var selectedNodes = $('#checkTree').jstree("get_checked", true);
                            	        console.log("Selected nodes: ", selectedNodes);

                            	        var resultHtml = selectedNodes
                            	            .filter(function(node) {
                            	                return node.children.length === 0;
                            	            })
                            	            .map(function(node) {
                            	                return '<div>' + node.text + '</div>';
                            	            }).join('');

                            	        $('#result').html(resultHtml);

                            	        var memberResultHtml = '<div class="authority" style="margin-left: -2.6%;" data-member-name="' + loggedInUserName + '">' +
                            	            '<span class="member-name" style="margin-right: 7%;">' + loggedInUserName + '</span>' +
                            	            '<div style="margin-left: 30%;">' +
                            	            '<span class="role-display">읽기/쓰기</span>' +
                            	            '</div>' +
                            	            '</div>';

                            	        memberResultHtml += selectedNodes
                            	            .filter(function(node) {
                            	                return node.children.length === 0 && node.id !== loggedInUserId;
                            	            })
                            	            .map(function(node) {
                            	                return '<div class="authority" data-member-name="' + node.text + '">' +
                            	                    '<div class="name-container" style="margin-left:50px;"><span class="member-name">' + node.text + '</span></div>' +
                            	                    '<div class="role-container"><span class="role-display" style="margin-right:250px;">' + defaultRole + '</span></div>' +
                            	                    '</div>';
                            	            }).join('');

                            	        $('.memberResult').html(memberResultHtml);

                            	        // Update employee count in both locations
                            	        var count = selectedNodes.filter(node => node.children.length === 0).length;
                            	        $('#empCount').text(count + '명');
                            	        $('.modal #empCount').text(count + '명');
                            	    }

                            	    function selectAllMembers() {
                            	        $('#checkTree').jstree("open_all"); // 모든 노드를 열기
                            	        $('#checkTree').jstree("check_all"); // 모든 노드를 체크

                            	        updateSelectedMembers(); // 선택된 멤버 업데이트
                            	    }

                            	    function clearSelectedMembers() {
                            	        $('#checkTree').jstree("uncheck_all"); // 모든 노드의 체크 해제
                            	        $('#checkTree').jstree('check_node', loggedInUserId); // 작성자 고정 선택
                            	        updateSelectedMembers(); // 선택된 멤버 업데이트
                            	    }

                            	    $('#addMembersButton').on('click', function() {
                            	        updateSelectedMembers();
                            	        $('#bs-example-modal-lg').modal('hide');
                            	    });

                            	    $('#clearBtn').on('click', function() {
                            	        clearSelectedMembers();
                            	    });

                            	    $('#defaultRole').change(function() {
                            	        defaultRole = $(this).val();
                            	        updateRoleDisplays();
                            	    });

                            	    $('#defaultRole').val(defaultRole);

                            	    initDeptTree();

                            	    $('.memberSearch').on('input', function() {
                            	        var searchString = $(this).val();
                            	        $('#checkTree').jstree('search', searchString);
                            	    });

                            	    $('input[name="bType"]').change(function() {
                            	        if ($(this).val() === '그룹게시판') {
                            	            $('input[name="bCategory"]').prop('disabled', true);
                            	            clearSelectedMembers();
                            	        } else if ($(this).val() === '전체게시판') {
                            	            $('input[name="bCategory"]').prop('disabled', false);
                            	            selectAllMembers();
                            	        } else {
                            	            clearSelectedMembers();
                            	        }
                            	        // 게시판 종류 변경 시 작성자 고정 선택
                            	        $('#checkTree').jstree('check_node', loggedInUserId);
                            	        updateSelectedMembers();
                            	    });

                            	    $('#boardForm').submit(function(event) {
											                event.preventDefault();
											
											                let boardType = '';
											                const bType = $('input[name="bType"]:checked').val();
											                const bCategory = $('input[name="bCategory"]').is(':checked');
											
											                if (!bType) {
											                    alert('게시판 종류를 선택해야 합니다.');
											                    return false;
											                }
											
											                if (bType === '전체게시판') {
											                    boardType = bCategory ? 'BA002' : 'BA001';
											                    selectAllMembers();
											                } else if (bType === '그룹게시판') {
											                    boardType = 'BG';
											                }
											
											                $('#boardType').val(boardType);

                            	        let selectedMembers = [loggedInUserName]; // 고정된 작성자 추가
                            	        selectedMembers = selectedMembers.concat($('#checkTree').jstree("get_checked", true)
                            	            .filter(node => node.children.length === 0 && node.id !== loggedInUserId)
                            	            .map(node => node.text));

                            	        $('#selectedMembers').val(JSON.stringify(selectedMembers)); // hidden input에 JSON 문자열로 설정

                            	        // 폼 제출 전에 defaultRole 필드를 적절하게 설정
                            	        let finalDefaultRole = defaultRole === '읽기/쓰기' ? 'W' : 'R'; // Updated here
                            	        $('#defaultRoleHidden').val(finalDefaultRole);

                            	        this.submit();
                            	    });

                            	    // 초기화
                            	    initDeptTree();

                            	    // 초기 멤버 역할 디스플레이 업데이트
                            	    updateRoleDisplays();
                            	});

                            	</script>
                                <br>
                                <div class="user-list-info">
                                    <div style="font-size: medium; margin-bottom: 10px;">
                                        <h4>사용자 및 권한</h4>
                                        <span id="empCount" style="margin-right: 20px;">0명</span>

                                        <!-- Center modal content -->
                                        <div class="modal fade" id="bs-example-modal-lg"
                                            tabindex="-1" role="dialog"
                                            aria-labelledby="myLargeModalLabel" aria-hidden="true">
                                            <div class="modal-dialog modal-lg">
                                                <div class="modal-content">
                                                    <div class="modal-header">
                                                        <h4 class="modal-title" id="myCenterModalLabel">사용자
                                                            추가하기</h4>
                                                        <button type="button" class="btn-close"
                                                            data-bs-dismiss="modal" aria-label="Close"></button>
                                                    </div>
                                                    <div class="modal-body">
                                                        <div style="display: flex;">
                                                            <div>
                                                                <div class="search" style="width: 489px; margin-bottom: 10px;">
                                                                    <input type="search" class="form-control form-control-sm memberSearch" name="" id="" placeholder="부서명 검색">
                                                                </div>
                                                                <div class="chekcTreeForm">
                                                                    <div id="checkTree">
                                                                    </div>
                                                                </div>
                                                            </div>
                                                            <div>
                                                                <div class="checklistForm">
                                                                    <div class="checklist">
                                                                        <div>
                                                                            <span class="count" id="empCount">0</span>명선택
                                                                            <button type="button" class="btn btn-outline-secondary waves-effect" id="clearBtn" style="margin-left: 20px;">모두해제</button>
                                                                        </div>
                                                                    </div>
                                                                    <div id='result' class="result">
                                                                    <!-- checked 된 직원 들어가는 div -->
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </div>

                                                    <div class="modal-footer">
                                                        <button type="button" class="btn btn-secondary waves-effect" data-bs-dismiss="modal">취소</button>
                                                        <button type="button" class="btn btn-info waves-effect waves-light" id="addMembersButton">확인</button>
                                                    </div>
                                                </div>
                                                <!-- /.modal-content -->
                                            </div>
                                            <!-- /.modal-dialog -->
                                        </div>
                                        <!-- /.modal -->

                                        <button class="plusBtn" type="button" data-bs-toggle="modal"
                                            data-bs-target="#bs-example-modal-lg">
                                            <i class="fe-plus-square"></i>
                                        </button>
                                        <span>멤버추가</span>
                                    </div>
                                    <div>
                                        <div class="authority" style="border: 1px solid lightgray;">
                                            <span>이름</span>
                                            <div style="margin-left: 30%;">
                                                <span>기본권한</span> 
                                                <select name="defaultRole" id="defaultRole" style="width: 100px; margin-left: 20px;">
                                                    <option value="읽기/쓰기">읽기/쓰기</option>
                                                    <option value="읽기">읽기</option>
                                                </select>
                                            </div>
                                        </div>
                                        <div class="memberResult" style="border: 1px solid lightgray; font-size:medium; height: 373px;">
                                            <!-- 추가된 멤버가 이곳에 표시됨 -->
                                        </div>
                                    </div>
                                    <div align="center" style="margin-top: 30px;">
                                        <button type="submit" class="btn btn-outline-secondary waves-effect">등록하기</button>
                                        <a href="${contextPath}/board/boardManage.do" class="btn btn-outline-secondary waves-effect">취소하기</a>
                                    </div>
                                </div>
                                </form>
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

    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
    
<script src="${contextPath}/resources/libs/jstree/jstree.min.js"></script>
<script src="${contextPath}/resources/js/pages/treeview.init.js"></script>
</body>
</html>