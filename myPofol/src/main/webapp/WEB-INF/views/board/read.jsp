<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">		
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-10">
		<div class="card">
			<div class="card-header">
				<label><h3>Board Read</h3></label>
			</div>
			<div class="card-body">
				<!-- /.panel-heading -->

				<div class="form-group">
					<label>No</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer}"/>' readonly="readonly">
				</div>
				<sec:authentication property="principal" var="pinfo"/>
					<sec:authorize access="isAuthenticated()">
						<c:if test="${pinfo.username eq board.writer}">
							<button data-oper='modify' class="btn btn-outline-dark">게시글 수정</button>
						</c:if>
					</sec:authorize>
				<button data-oper='list' class="btn btn-dark">목록 보기</button>
				<form id="operForm" action="/board/modify" method="get">
					<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}" />'>
					<input type="hidden" id="pageNum" name="pageNum" value='<c:out value="${pagi.pageNum}" />'>
					<input type="hidden" id="amount" name="amount" value='<c:out value="${pagi.amount}" />'>
					<input type="hidden" id="type" name="type" value='<c:out value="${pagi.type}" />'>
					<input type="hidden" id="keyword" name="keyword" value='<c:out value="${pagi.keyword}" />'>
				</form>
				<!-- /.panel-body -->
			</div>
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
	<div class="col-lg-2">
	</div>		
</div>
<!-- 첨부 파일 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	
	</div>
</div>
<div class="row">
<div class="col-lg-10">
	<div class="card">
		<div class="card-header">
			첨부 파일			
		</div>
		<div class="card-body">
			<div class="uploadResult">
				<ul>
				
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- 첨부 파일 끝-->
	<!-- Reply List Start -->
	<div class="col-lg-10">
		<div class="card">
			<div class="card-header">
				<div class="d-flex justify-content-between">
				<div>
					<i class="fas fa-comment-dots"></i><label>댓글 목록</label>
				</div>
				<sec:authorize access="isAuthenticated()">
					<button id="addReplyBtn" type="button" class="btn btn-secondary btn-sm">댓글 달기</button>
				</sec:authorize>
				</div>
			</div>
			<div id="replyBody" class="card-body">
				<ul class="chat">
				<!-- 
					<li class="left clearfix" data-rno='12'>
						<div class="header">
							<strong class="primary-font">user00</strong>
							<small class="pull-right text-muted">2019-10-07 22:29</small>
						</div>
						<p>댓글창 테스트</p>						
					</li>
				 -->
				</ul>			
			</div>
			
			<!-- 댓글 페이징 처리 -->
			<div class="card-footer">
				
			</div>			
		</div>
	</div>
</div>
 <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">댓글 작성란</h4>
                <button type="button" class="close" data-dismiss="modal"
										aria-label="Close"><span aria-hidden="true">&times;</span></button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                	<label>내용</label>
                	<input class="form-control" name="reply" value="reply">
                </div>
                <div class="form-group">
                	<label>작성자</label>
                	<input class="form-control" name="writer" value="writer">
                </div>
                <div class="form-group">
                	<label>날짜</label>
                	<input class="form-control" name="regDate" value="regDate">
                </div>
            </div>
            <div class="modal-footer">
                <button id="modalRegisterBtn" type="button" class="btn btn-primary" >등록</button>
                <button id="modalModifyBtn" type="button" class="btn btn-warning" >수정</button>
                <button id="modalRemoveBtn" type="button" class="btn btn-danger" >삭제</button>
                <button id="modalCloseBtn" type="button" class="btn btn-outline-dark" >닫기</button>
            </div>            
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->


<script type="text/javascript" src="/resources/commons/reply.js"></script>
<script type="text/javascript">
$(document).ready(function (){	
	
	var bnoValue = '<c:out value="${board.bno}"/>';
	var replyUL = $(".chat");

	showList(1);
	
	function showList(page) {
		replyService.getList({bno: bnoValue, page: page || 1}, function(replyCnt, list){
		
			if(page == -1) {
				pageNum = Math.ceil(replyCnt / 10.0);
				showList(pageNum);
				return;
			}
			
			var str = "";
			if(list == null || list.length ==0) {
				return;
			}
			
			for(var i=0, len = list.length || 0; i<len; i++) {
				str +="<div class='card-body border-bottom-secondary' data-rno='"+list[i].rno+"'>";
		        str +="  <div><div class='header'><strong class='primary-font'>["
		     	   +list[i].rno+"] "+list[i].writer+"</strong>"; 
		        str +="    <small class='float-right text-muted'>"
		            +replyService.displayTime(list[i].regDate)+"</small></div>";
		        str +="    <p>"+list[i].reply+"</p></div></div>";
			}
			
			replyUL.html(str);
			showReplyPage(replyCnt);
		});
		
	}	
	
	/* Modal의 <input> 요소들 */
	var modal = $("#myModal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputWriter = modal.find("input[name='writer']");
	var modalInputRegDate = modal.find("input[name='regDate']");
	/* Modal의 <button> 요소들 */
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalModifyBtn = $("#modalModifyBtn");
	var modalCloseBtn = $("#modalCloseBtn");
	
	var writer = null;
	
	<sec:authorize access="isAuthenticated()">
		writer = '<sec:authentication property="principal.username"/>';
	</sec:authorize>
		
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
	$(document).ajaxSend(function(e, xhr, options){
		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
	});
	
	/*/board/read페이지에서 해당 게시물의 댓글 달기 버튼을 눌렀을 때 실행하는 JQuery 이벤트 */
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modal.find("input[name='writer']").val(writer);
		modalInputRegDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		modal.modal("show");
	});
	
	
	modalRegisterBtn.on("click", function(e){
			
			var reply = {
					reply : modalInputReply.val(),
					writer : modalInputWriter.val(),
					bno : bnoValue
			};
			
			replyService.add(reply, function(result){
				
				alert(result);
				
				modal.find("input").val("");
				modal.modal("hide");
				showList(-1);
			});
		});
	
	/* 댓글을 클릭하였을 때 모달창을 띄우고 해당 댓글의 필드들을 폼 내용으로 출력하고 수정버튼과 삭제버튼 표시 */
	$(".chat").on("click", ".card-body", function(e){
		
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputWriter.val(reply.writer);
			modalInputRegDate.val(replyService.displayTime(reply.regDate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModifyBtn.show();
			modalRemoveBtn.show();
			
			modal.modal("show");
		});
	});
	
	/* 댓글의 모달창의 수정 버튼을 클릭하였을때 폼의 내용대로 댓글 수정, 모달 창을 숨기고 댓글 리스트 갱신 */
	modalModifyBtn.on("click", function(e) {
		
		var originWriter = modalInputWriter.val();
		var reply = { rno : modal.data("rno"), reply : modalInputReply.val(), writer : originWriter};
		
		if(!writer) {
			alert("로그인 후에 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		if(writer != originWrtier) {
			alert("본인 작성한 댓글만 수정 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.update(reply, function(result){
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
			
		});
		
	});
	
	/* 댓글의 모달창의 삭제 버튼을 클릭하였을때 해당 댓글 번호의 필드 삭제, 모달 창을 숨기고 댓글 리스트 갱신 */
	modalRemoveBtn.on("click", function(e) {
		
		var rno = modal.data("rno");
		
		if(!writer) {
			alert("로그인 후에 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		var originWriter = modalInputWriter.val();
		
		if(writer != originWrtier) {
			alert("본인 작성한 댓글만 삭제가 가능합니다.");
			modal.modal("hide");
			return;
		}
		
		replyService.remove(rno, originWrtier, function(result) {
			
			alert(result);
			modal.modal("hide");
			showList(pageNum);
			
		});
		
	});
	
	modalCloseBtn.on("click", function(){
		
		modal.modal("hide");
		
	});
	
	var pageNum = 1;
	var replyPageFooter = $(".card-footer");
	
	function showReplyPage(replyCnt) {
		
		var endNum = Math.ceil(pageNum / 10.0) * 10;
		var startNum = endNum - 9;
		var prev = startNum != 1;
		var next = false;
		
		if(endNum * 10 >= replyCnt) {
			endNum = Math.ceil(replyCnt / 10.0);
		}
		
		if(endNum * 10 < replyCnt) {
			next = true;
		}
		
		var str = "<ul class='pagination float-right'>";
		
		if(prev) {
			str += "<li class='page-item'><a class='page-link' href='" + (startNum - 1) + "'>이전</a></li>";
		}
		
		for(var i = startNum; i <= endNum; i++){
			var active = pageNum == i ? "active" : "";
			str += "<li class='page-item " + active + " '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
		}
		
		if(next) {
			str += "<li class='page-item'><a class='page-link' href='"+ (endNum + 1) +"'>다음</a></li>";
		}
		
		str += "</ul>";
		replyPageFooter.html(str);
	}
	
	replyPageFooter.on("click", "li a", function(e){
		
		e.preventDefault();
		var targetPageNum = $(this).attr("href");
		pageNum = targetPageNum;
		
		showList(pageNum);
		
	});
	
});
</script>
<script type="text/javascript">
$(document).ready(function(){
	
	var operForm = $("#operForm");
	
	$("button[data-oper='modify']").on("click", function(e){
		
		operForm.attr("action", "/board/modify").submit();
		
	});
	
	$("button[data-oper='list']").on("click", function(e){
		
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	 
	});		
	
});
</script>
<script>
$(document).ready(function() {
	
	var bno = '<c:out value="${board.bno}"/>';
	
	$.getJSON("/board/getUploadList", {bno: bno}, function(arr){
		
		console.log(arr);		
		var str = "";
		
		$(arr).each(function(i, upload){
			
			// 이미지 파일일 경우
			if(upload.fileType) {
				
				var fileCallPath = encodeURIComponent(upload.uploadPath + "/s_" + upload.uuid + "_" + upload.fileName);
				str += "<li data-path='"+upload.uploadPath+"' data-uuid='"+upload.uuid+"' data-filename='"+upload.fileName+"' data-type='"+upload.fileType+"'><div>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				
			} else {
				
				str += "<li data-path='"+upload.uploadPath+"' data-uuid='"+upload.uuid+"' data-filename='"+upload.fileName+"' data-type='"+upload.fileType+"'><div>";
				str += "<span>"+upload.fileName+"</span><br>";
				str += "<img src='/resources/image/attach.jpg'>";
				str += "</div>";
				str += "</li>";
				
			}			
		});
		$(".uploadResult ul").html(str);
	});
	
	$(".uploadResult").on("click", "li", function(e){
		
		// console.log("이미지 보기");
		var liObj = $(this);
		var path = encodeURIComponent(liObj.data("path") + "/" + liObj.data("uuid") + "_" + liObj.data("filename"));
		
		// 이미지 타입일 경우
		if(liObj.data("type")) {
			showImage(path.replace(new RegExp(/\\/g), "/"));
		} else {
			// 이미지 타입이 아닐 경우 다운로드
			self.location = "/download?fileName=" + path;
		}
		
	});
	
	// 첨부 파일 이미지 클릭 시 원본 크기로 애니메이션 지정
	function showImage(fileCallPath) {
		
		// alert(fileCallPath);
		
		$(".bigPictureWrapper").css("display", "flex").show();
		$(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>").animate({width: '100%', height: '100%'}, 1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		}, 1000);				
		
	}
	
});
</script>
<%@include file="../includes/footer.jsp"%>