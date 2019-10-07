<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Read</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<label>Article</label>
			</div>
			<div class="panel-body">
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
					<textarea class="form-control" rows="3" name="content"
						value='<c:out value="${board.content}"/>'></textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer}"/>' readonly="readonly">
				</div>
				<button data-oper='modify' class="btn btn-default">게시글 수정</button>
				<button data-oper='list' class="btn btn-info">목록 보기</button>
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
	
	<!-- Reply List Start -->
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<i class="fas fa-comment-dots"></i>
				<label>댓글 목록</label>
				<button id='addReplyBtn' type="button"
					class="btn btn-primary btn-xs pull-right">댓글 달기</button>
			</div>
			<div class="panel-body">
				<ul class="chat">
					<li class="left clearfix" data-rno='12'>
						<div class="header">
							<strong class="primary-font">user00</strong>
							<small class="pull-right text-muted">2019-10-07 22:29</small>
						</div>
						<p>댓글창 테스트</p>
					</li>
				</ul>			
			</div>
			<div class="panel-footer">
				페이징 처리
			</div>			
		</div>
	</div>
</div>
 <!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                <h4 class="modal-title" id="myModalLabel">댓글 작성란</h4>
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
                <button id="modalCloseBtn" type="button" class="btn btn-default" >닫기</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript" src="/resources/js/reply.js"></script>
<script type="text/javascript">
$(document).ready(function (){
var bnoValue = '<c:out value="${board.bno}"/>';
var replyUL = $(".chat");

	showList(1);
	
	function showList(page) {
		replyService.getList({bno: bnoValue, page: page || 1}, function(list){
		
			var str = "";
			if(list == null || list.length ==0) {
				replyUL.html("");
				return;
			}
			for(var i=0, len = list.length || 0; i<len; i++) {
				str += "<li class='left clearfix' data-rno ='"+ list[i].rno +"'>";
				str += "	<div><div class='header'><strong class='primary-font'>" + list[i].writer + "</strong>";
				str += "		<small class = 'pull-right text-muted'>" + replyService.displayTime(list[i].regDate) + "</small></div>";
				str += "		<p>" + list[i].reply + "</p></div></li>";
			}
			
			replyUL.html(str);
		});
		
	}	
	
	/* Modal의 <input> 요소들 */
	var modal = $(".modal");
	var modalInputReply = modal.find("input[name='reply']");
	var modalInputWriter = modal.find("input[name='writer']");
	var modalInputRegDate = modal.find("input[name='regDate']");
	/* Modal의 <button> 요소들 */
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalModifyBtn = $("#modalModifyBtn");
	
	$("#addReplyBtn").on("click", function(e){
		modal.find("input").val("");
		modalInputRegDate.closest("div").hide();
		modal.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();
		
		$(".modal").modal("show");
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
				showList(1);
			});
		});
	
	$(".chat").on("click", "li", function(e){
		
		var rno = $(this).data("rno");
		replyService.get(rno, function(reply){
			modalInputReply.val(reply.reply);
			modalInputWriter.val(reply.writer);
			modalInputRegDate.val(replyService.displayTime(reply.regDate)).attr("readonly", "readonly");
			modal.data("rno", reply.rno);
			
			modal.find("button[id != 'modalCloseBtn']").hide();
			modalModifyBtn.show();
			modalRemoveBtn.show();
			
			$(".modal").modal("show");
		});
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