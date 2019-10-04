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
				<button data-oper='modify' class="btn btn-default" onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">게시글 수정</button>
				<button data-oper='list' class="btn btn-info" onclick="location.href='/board/list/">목록 보기</button>
				<!-- /.panel-body -->
			</div>
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<%@include file="../includes/footer.jsp"%>