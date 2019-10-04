<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading"><label>게시글 작성</label></div>
			<!-- /.panel-heading -->
			<div class="panel-body">		
				<form action="/board/register" method="post">
					<div class="form-group">
						<label>Title</label><input class="form-control" name='title'/>
					</div>
					<div class="form-group">
						<label>Content</label><textarea class="form-control" rows="3" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label><input class="form-control" name='writer'/>
					</div>
					<button type="submit" class="btn btn-default">등록</button>					
					<button type="reset" class="btn btn-default">내용 지우기</button>					
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<%@include file="../includes/footer.jsp"%>