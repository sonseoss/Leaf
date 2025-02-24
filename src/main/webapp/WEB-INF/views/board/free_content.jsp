<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!-- 글 내용 줄 개행 처리를 위해 추가 -->
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% pageContext.setAttribute("newLineChar", "\n"); %>


<html>
<head>

   <meta charset="UTF-8">

   <title>RunWith</title>
   
   <!-- jQuery -->
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
   
   <!-- 합쳐지고 최소화된 최신 자바스크립트 -->
   <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
   
   <!-- 합쳐지고 최소화된 최신 CSS -->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
   
   <!-- 개인 디자인 추가, ?after를 붙이면 기존에 동일한 이름의 파일을 인식하는것이 아닌 새로운 파일을 인식하게 된다. -->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainstyle.css">
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mainpage-style.css">
   
   <!-- 여기다가 나만의 새로운 css 만들기 -->
   <style>

 	.boardReplyWrap {
 		position:relative;
 		overflow:hidden;
 		width:100%;
 		min-height: 40px;
 		max-height: 900px;
 		float: none;
 		text-align:center;
 		line-height: 40px;
 		border-bottom:1px solid #D8D8D8; 
 		padding: 10px 0px;
 		
 	}
    
    #btn-boardReply-Modify {
    	background-color:transparent; 
    	border: none;
    }
    
    #btn-boardReply-Delete {
    	background-color:transparent; 
    	border: none;
    }
    
    .container{
	width:1200px;
	margin: 0 auto;
	}
 
   </style>
   
</head>
<body>

<%@ include file="../include/header.jsp" %>



	<div class="mainbox">

		<section>
			<div class="container">
				<div class="row">
					<!-- 메인화면 공지사항 상단 -->
					<a href="#" class="list-group-item active notice-list-top"
						style="margin-top: 20px;"> <span class="main-notice-title">자유게시판</span>
					</a>

					<div class="container my-1">
						<form action="<c:url value='/board/boardDelete'/>" method="post"
							name="boardDeleteForm">
							<div class="row" style="margin-bottom: 50px;">
								<div class="free_content">
									<div class="free_content_up" style="margin-left: 30px;">
										<div class="free_title_up" scope="col"
											style="width: 100%; margin-top: 10px;">
											<input type="hidden" id="hidden-boardNo" name="boardNo"
												value="${board.boardNo}">
											<h4 style="display: inline-block;">${board.boardTitle}</h4>

											<c:if
												test="${board.boardWriter eq user.userID || user.commonCODE == 'ADM002'}">
												<a type="submit" id="btn-board-delete" class="btn mb-2"
													style="display: inline-block; float: right; margin-right: 50px;">삭제</a>

											</c:if>
										</div>

										<div class="free_title_down" style="margin-top: 30px;">
											<div class="free_writer" style="display: inline-block;">

												<c:choose>

													<c:when test="${boardWriterNumbers.userNo != ''}">
														<img
															src="<c:url value='/user/userProfileGet?userNO=${boardWriterNumbers.userNo}'/>"
															width="40px" height="40px"
															style="border-radius: 30px; margin-left: 10px; margin-right: -5px;">
													</c:when>

													<c:when test="${boardWriterNumbers.companyNo != ''}">
														<img
															src="<c:url value='/company/companyLogoGet?companyNO=${boardWriterNumbers.companyNo}'/>"
															width="40px" height="40px"
															style="border-radius: 30px; margin-left: 10px; margin-right: -5px;">
													</c:when>

												</c:choose>


												<span
													style="display: inline-block; font-size: 14px; font-weight: bold; font-family: sans-serif; margin-left: 15px;">&nbsp;
													${board.boardWriter} &nbsp;</span>
												<c:if test="${board.boardWriter eq user.userID }">
													<span
														style="background: lightgray; font-size: 13px; color: #202020; padding: 5px; margin-left: 10px;">내가
														작성한 글</span>
												</c:if>
												<c:if test="${board.boardWriter eq company.companyID }">
													<span
														style="background: lightgray; font-size: 13px; color: #202020; padding: 5px; margin-left: 10px;">내가
														작성한 글</span>
												</c:if>
											</div>
											<div
												style="display: inline-block; float: right; margin-top: 10px; margin-right: 40px; color: gray;">
												<div style="margin-left: 50px;">
													<span style="color: black; font-style: bold;">조회수</span>
													${board.boardViews }
												</div>
												<div
													style="float: right; margin-top: 10px; margin-right: 40px; color: gray;">
													<fmt:formatDate value="${board.boardDate}"
														pattern="yyyy-MM-dd HH:mm" />
												</div>

											</div>
										</div>
									</div>
								</div>
								<br>
								<hr>

								<div class="free_content_down"
									style="min-height: 300px; margin-top: 50px; margin-left: 30px; font-size: 15px; margin-bottom: 30px;">

									${fn:replace(board.boardContent, newLineChar, '<br/>')}</div>
							</div>
						
						</form>
					</div>
				</div>
				<!-- 댓글 입력 부분 -->
				<div style="background-color: #bbd0e7; height: 120px;">
					<div
						style="text-align: left; margin: 10px 10px 10px 10px; padding-top: 10px;">회원만
						댓글 작성이 가능합니다.</div>
					<div>
						<div>
							<input type="hidden" id="boardNo" name="boardNo"
								value="${board.boardNo}">

							<c:if test="${user != null}">
								<input type="hidden" id="boardReplyWriter"
									name="boardReplyWriter" value="${user.userID}">
							</c:if>

							<c:if test="${company != null}">
								<input type="hidden" id="boardReplyWriter"
									name="boardReplyWriter" value="${company.companyID}">
							</c:if>

							<c:if test="${user != null || company != null}">
								<textarea id="boardReplyContent" type="text"
									class="form-control col-md-8 col-sm-10"
									placeholder="댓글을 입력하세요." name="boardReplyContent"
									maxlength="2048"
									style="float: left; width: 85%; margin-left: 30px; resize: none;"></textarea>
							</c:if>

							<c:if test="${user == null && company == null}">
								<textarea id="boardReplyContent" type="text"
									class="form-control col-md-8 col-sm-10"
									placeholder="로그인 한 후 댓글을 입력하세요." name="boardReplyContent"
									maxlength="2048"
									style="float: left; width: 85%; margin-left: 30px; resize: none;"
									readonly="readonly"></textarea>
							</c:if>

						</div>
						<div
							style="margin-bottom: 10px; float: right; margin-right: 40px; width: 5%;">
							<input type="button" id="btn-boardreply-write" class="btn"
								value="댓글입력" style="height: 54px;">
						</div>
					</div>
				</div>

				<!-- 댓글 보여지는 부분 -->
				<div class="boardreply-List"
					style="text-align: center; font-size: 12px;">
					<div>
						<div style="background-color: #bbd0e7;">
							<div
								style="text-align: left; margin-left: 10px; padding-top: 10px;">
								전체댓글
								<p id="p-reply-count" style="color: red; display: inline-block;"></p>
							</div>
						</div>
					</div>

					<!-- 댓글 보기 모드 (여기에 댓글 반복이 들어감) -->
					<div id="boardReplyList"
						style="background: #FAFAFA; padding: 5px 15px 5px 15px;">

						<!-- ------------------------댓글이 반복됨---------------------------- -->
						<!-- ------------------------댓글이 반복됨---------------------------- -->
						<!-- ------------------------댓글이 반복됨---------------------------- -->
						<!-- ------------------------댓글이 반복됨---------------------------- -->
						<!-- ------------------------댓글이 반복됨---------------------------- -->

					</div>
					<button class="form-control" id="moreList">댓글 더보기</button>
				</div>

				<div class="text-center">


					<br>
					<div style="margin-top: 20px;">

						<button type="submit" class=" mb-2 pull-left">신고하기</button>
						<c:if
							test="${board.boardWriter eq user.userID || board.boardWriter eq company.companyID || user.commonCODE == 'ADM002'}">
							<button type="button" id="btn-board-modify"
								class="btn btn-info mb-2 pull-right"
								onclick="location.href='<c:url value="/board/boardModify?boardNo=${board.boardNo}"/>'"
								style="margin-left: 10px;">수정하기</button>
						</c:if>
						<button type="button" id="btn-board-list"
							class="btn btn-primary mb-2 pull-right"
							onclick="location.href='free_list'">목록</button>
					</div>
					<!-- 날짜${boardReply.boardReplyDate} -->

				</div>

			</div>
		</section>


		<!-- 댓글 수정/삭제 모달 -->
		<div class="modal fade" id="replyModal" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="btn btn-default pull-right"
							data-dismiss="modal">닫기</button>
						<h4 class="modal-title">댓글 수정</h4>
					</div>
					<div class="modal-body">
						<!-- 수정폼 id값을 확인하세요-->
						<input type="hidden" id="hidden-modal-replyno" name="">
						<div class="reply-content">
							<textarea class="form-control" rows="4" id="modalReply"
								placeholder="내용입력" style="resize: none;">${boardContent.boardContent }</textarea>
							<div class="reply-group">
								<button class="right btn btn-info" id="modalModBtn"
									style="margin-top: 10px;">수정하기</button>
								<button class="right btn btn-info" id="modalDelBtn">삭제하기</button>
							</div>
						</div>
						<!-- 수정폼 끝. -->
					</div>
				</div>
			</div>
		</div>
		<!-- 댓글 수정 모달 끝. -->



		<%@ include file="../include/footer.jsp"%>
	</div>



</body>
</html>


<script language="javaScript">
	
	const msg = '${msg}';
	if(msg !== '') {
		alert(msg);
	}
	
	//목록 이동 버튼
	$(function() {
		$('#btn-board-list').click(function() {
			location.href='<c:url value="/board/boardList"/>';
		});
	});
	
	//삭제 버튼 처리
	$(function(){
	 	$('#btn-board-delete').click(function() {
	 		if(confirm('정말 삭제하시겠습니까?')) {
				document.boardDeleteForm.submit();
			}
	 	});
	});
	
	
	//댓글 등록
	$(document).ready(function () {
	
		$('#btn-boardreply-write').click(function(){
			
			const boardNo = $('#hidden-boardNo').val(); //컨트롤러에서 넘어온 글 번호
			const boardReplyContent = $('#boardReplyContent').val(); //댓글 내용
			
			console.log(boardReplyContent);
			
			const boardReplyWriter = $('#boardReplyWriter').val();//작성자
			
			if($('#boardReplyContent').val() == '') {
				alert('내용을 입력하세요 !');
				return;
			}
			
			$.ajax({
				type: 'post',
				url: '<c:url value="/boardreply/boardReplyWrite" />',
				contentType: 'application/json',
				data: JSON.stringify(
					{
						"boardReplyWriter": boardReplyWriter,
						"boardReplyContent": boardReplyContent,
						"boardNo": boardNo
					}		
				),
				
				dataType: 'text',
				
				success: function(result) {
					console.log('통신 성공' + result);
					//alert('댓글 등록이 완료되었습니다.');
					$('#boardReplyContent').val('');
					boardReplyList(1,true);
				},
				
				error: function() {
					alert('error: 댓글 등록이 실패하였습니다. 관리자에게 문의해주세요!');
				}
			
				
			}); //end ajax
		}); //댓글 등록 이벤트 끝
	
		
		//더보기 버튼 처리(클릭 시 전역 변수 page에 +1 한 값을 전달)
		$('#moreList').click(function() {
			//왜 false를 주었죠?, 더보기잖아요. 누적해야 하지 않을까요?
			//1페이지의 댓글 내용 밑에다가 2페이지를 줘야지, 1페이지를 없애고 2페이지를 보여주자 는 게 아니니까요.
			boardReplyList(++page, false);
		});
		
		
		//연속클릭 방지
		var timer; 
		$("#btn-boardreply-write").click(function () {
		    if(alert("댓글을 등록하였습니다.")){
		        if(timer){
		            clearTimeout(timer);
		        }
		        timer = setTimeout(function(){
		            //수행될 프로세스를 입력하는 곳
		        },200); //2초 동안 재 수행되는 것을 방지
		    }
		});
	
	
		//댓글 목록 조회
		let page = 1; //페이지 번호
		let strAdd = ''; //화면에 넣을 태그를 문자열 형태로 추가할 변수
		
		boardReplyList(1, true); //상세보기 화면에 처음 진입 시 댓글 리스트 불러오기
		
		
		//목록 불러오기
		function boardReplyList(pageNum, reset) {
		
			const boardNo = '${board.boardNo}';
			strAdd = '';
			
			$.getJSON(
				"<c:url value='/boardreply/boardReplyList/'/>" + boardNo + '/' + pageNum,
				function(result){
					
					let boardReplyTotal = result.boardReplyTotal; //총 댓글 수
					let boardReplyList = result.boardReplyList; //댓글 리스트
					
					//댓글수 빨간글씨
					$('#p-reply-count').text(boardReplyTotal);
					
					if(reset === true) {
						strAdd = '';
						page = 1;
					}
					
					//페이지번호 * 데이터 수보다 전체 댓글 개수가 작으면 더보기 버튼을 없애자.
					console.log('현재 페이지: ' + page);
					if(boardReplyTotal <= page * 5) {
						$('#moreList').css('display', 'none');
					} else {
						$('#moreList').css('display', 'block');
					}
					
					if(boardReplyList.length <= 0) {
						return; //함수 종료
					}
					
					for(let i=0; i<boardReplyList.length; i++) {
						
						
						var timestamp = boardReplyList[i].boardReplyDate;
						
						var date = new Date(timestamp).toISOString().replace("T", " ").replace(/\..*/, '').slice(0,16);
						var replyWriter = boardReplyList[i].boardReplyWriter;
						var replyReader = '';
						
						var memberNo = '';

						if(boardReplyList[i].userNo != '') {
							memberNo = boardReplyList[i].userNo;
							
							if(${user != null}) {
								replyReader = '${user.userID}';
							} else if(${company != null}) {
								replyReader = '${company.companyID}';
							}
							
							if(replyWriter == replyReader) {
								strAdd += 
									`<div class='boardReplyWrap'>
										<div><span><img src="<c:url value='/user/userProfileGet?userNO=' />` + memberNo + `" width="30px" style="margin: 5px; float:left; border-radius:50px; width:30px; height:30px; margin: 5px;"><span>
										</div>
				                        <div id='boardReply-Writer' style="text-align: left; float:left; width:10%; font-weight:bold; ">&nbsp;`+ boardReplyList[i].boardReplyWriter +`
				                        </div>
				                        <div id='boardReply-Content' style="width:65%; word-break:break-all; text-align: left; float:left;">` + boardReplyList[i].boardReplyContent +`
				                        </div>
				                        <div style="float:right; width:13%;">`+ date +`
				                        </div>
			                            <div style="float:right; width:5%;">
			                            	<a id="btn-board-reply-delete` + i + `" class="glyphicon glyphicon-remove replyDelete" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `"></a>
			                            	<a id="btn-board-reply-update` + i + `" class="glyphicon glyphicon-ok replyModify" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `" aria-hidden="true"></a>
			                            </div>
			                        </div>`;
							} //user.commonCODE == 'ADM002'
							else if (replyWriter != replyReader) {
								strAdd += 
									`<div class='boardReplyWrap' > 
										<div><span><img src="<c:url value='/user/userProfileGet?userNO=' />` + memberNo + `" width="30px" style="float:left; border-radius:50px; width:30px; height:30px; margin: 5px;"><span>
				                        </div>
										<div id='boardReply-Writer' style="text-align: left; float:left; width:10%; font-weight:bold; ">&nbsp;`+ boardReplyList[i].boardReplyWriter +`
				                        </div>
				                        <div id='boardReply-Content' style="width:65%; word-break:break-all; text-align: left; float:left;">` + boardReplyList[i].boardReplyContent +`
				                        </div>
				                        <div style="float:right; width:13%;">`+ date +`
				                        </div>
			                            <c:if test="${user.commonCODE == 'ADM002'}">
				                            <div style="float:right; width:5%;">
				                        		<a id="btn-board-reply-delete` + i + `" class="glyphicon glyphicon-remove replyDelete" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `"></a>
			                            		<a id="btn-board-reply-update` + i + `" class="glyphicon glyphicon-ok replyModify" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `" aria-hidden="true"></a>
					                        </div>
			                            </c:if>
			                        </div>`;
							} 
						} else {
							memberNo = boardReplyList[i].companyNo;
							
							if(${user != null}) {
								replyReader = '${user.userID}';
							} else if(${company != null}) {
								replyReader = '${company.companyID}';
							}
							
							if(replyWriter == replyReader) {
								strAdd += 
									`<div class='boardReplyWrap'>
										<div><span><img src="<c:url value='/company/companyLogoGet?companyNO=' />` + memberNo + `" width="30px" style="float:left; border-radius:50px; width:30px; height:30px; margin: 5px;"><span>
										</div>
				                        <div id='boardReply-Writer' style="text-align: left; float:left; width:10%; font-weight:bold; ">&nbsp;`+ boardReplyList[i].boardReplyWriter +`
				                        </div>
				                        <div id='boardReply-Content' style="width:65%; word-break:break-all; text-align: left; float:left;">` + boardReplyList[i].boardReplyContent +`
				                        </div>
				                        <div style="float:right; width:13%;">`+ date +`
				                        </div>
			                            <div style="float:right; width:5%;">
			                            	<a id="btn-board-reply-delete` + i + `" class="glyphicon glyphicon-remove replyDelete" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `"></a>
			                            	<a id="btn-board-reply-update` + i + `" class="glyphicon glyphicon-ok replyModify" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `" aria-hidden="true"></a>
			                            </div>
			                        </div>`;
							} 
							else {
								strAdd += 
									`<div class='boardReplyWrap'> 
										<div><span><img src="<c:url value='/company/companyLogoGet?companyNO=' />` + memberNo + `" width="30px" style="float:left; border-radius:50px; width:30px; height:30px; margin: 5px;"><span>
				                        </div>
										<div id='boardReply-Writer' style="text-align: left; float:left; width:10%; font-weight:bold; ">&nbsp;`+ boardReplyList[i].boardReplyWriter +`
				                        </div>
				                        <div id='boardReply-Content' style="width:65%; word-break:break-all; text-align: left; float:left;">` + boardReplyList[i].boardReplyContent +`
				                        </div>
				                        <div style="float:right; width:13%;">`+ date +`
				                        </div>
			                            <c:if test="${user.commonCODE == 'ADM002'}">
				                            <div style="float:right; width:5%;">
				                        		<a id="btn-board-reply-delete` + i + `" class="glyphicon glyphicon-remove replyDelete" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `"></a>
			                            		<a id="btn-board-reply-update` + i + `" class="glyphicon glyphicon-ok replyModify" aria-hidden="true" data-value="` + boardReplyList[i].boardReplyNo + `" aria-hidden="true"></a>
			                            	</div>
			                            </c:if>
			                        </div>`;
							}
						}
						
						
					
						
						$('#boardReplyList').html(strAdd);	

					}	

				}
			); //end getJSON
			
		}//end boardReplyList()
		
		
		//댓글 수정/삭제 버튼 처리
		$('#boardReplyList').on('click', 'a', function(e) {
			e.preventDefault();
			const target = e.target.getAttribute('data-value');
			if($(this).hasClass('replyModify')) {
				//수정 버튼을 눌렀으므로 수정 모달 형식으로 꾸며주겠다.
				$('.modal-title').html('댓글 수정');
				$('#hidden-modal-replyno').val(target);
				$('#modalReply').css('display', 'inline');
				$('#modalModBtn').css('display', 'inline'); //수정버튼 보이기
				$('#modalDelBtn').css('display', 'none'); 
				$('#replyModal').modal('show');
			} else if($(this).hasClass('replyDelete')) { //('replyDelete')
				//삭제 버튼을 눌렀으므로 삭제 모달 형식으로 변경
				$('.modal-title').html('댓글을 삭제하시겠습니까?');
				$('#modalReply').css('display', 'none');
				$('#modalModBtn').css('display', 'none');
				$('#modalDelBtn').css('display', 'inline'); //삭제버튼 보이기
				$('#hidden-modal-replyno').val(target);
				$('#replyModal').modal('show');
			}
		}); //수정 or 삭제 버튼 클릭 이벤트 처리 끝.

		
		//댓글 수정   (https://rsorry.tistory.com/m/282참고)
		$('#modalModBtn').click(function () {
			const boardReplyNO = $('#hidden-modal-replyno').val();
			const modalReply = $('#modalReply').val();
			
			console.log(boardReplyNO);
			console.log(modalReply);
			
			$.ajax({
				type: 'POST',
				url: '<c:url value="/boardreply/boardReplyUpdate"/>',
				dataType:'text',
				data: {
					'boardReplyNo': boardReplyNO,
					'boardReplyContent': modalReply
				},
				success: function(result) {
					if(result === 'UpdateSuccess') {
						alert('댓글이 수정되었습니다.');
						$('#modalReply').val('');
						$('#replyModal').modal('hide');
						location.reload();
					} else {
						alert('댓글이 수정되지 못했습니다.');
						return false;
					}
				}, error: function() {
					alert('error: 수정에 실패했습니다. 관리자에게 문의하세요!');
				}
			});//ajax 끝.
		});//댓글 수정 끝.
		
		
		//삭제 함수
		$('#modalDelBtn').click(function () {
			const boardReplyNO = $('#hidden-modal-replyno').val();
			$.ajax({
				type: 'POST',
				url: '<c:url value="/boardreply/boardReplyDelete"/>',
				dataType: 'text',
				data: {
					'boardReplyNO': boardReplyNO
				},
				success: function (result) {
					if(result === 'DeleteSuccess') {
						$('#replyModal').modal('hide');
						location.reload();
					} else {
						alert('댓글이 삭제되지 못했습니다.');
						return false;
					}
				},
				error: function () {
					alert('error: 댓글 삭제에 실패하였습니다. 관리자에게 문의하세요!');
				}
			}); //삭제 비동기 통신 끝.
		}); //삭제 이벤트 끝.
		
		
		
		
	});//end jquery (댓글등록 끝)
	

</script>