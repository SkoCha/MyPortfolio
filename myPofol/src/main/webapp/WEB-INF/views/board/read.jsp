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
				<label>Board Read Page</label>
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
					<label>Wrtier</label><input class="form-control" name="wrtier"
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
</div>
<%@include file="../includes/footer.jsp"%>

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