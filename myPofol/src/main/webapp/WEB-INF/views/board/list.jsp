<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
			<div class="panel-heading">Board List Page
				<button id='regBtn' type="button" class="btn btn-primary btn-xs pull-right">글 작성</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th><bold>No</bold></th>
							<th>Subject</th>
							<th>Name</th>
							<th>Date</th>
							<th>Update Date</th>
						</tr>
					</thead>
					<c:forEach items="${list}" var="board">
						<tr>
							<td>
								<c:out value="${board.bno}"></c:out>
							</td>
							<%-- <td><a class='move' href='/board/read?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"></c:out></a></td> --%>
							<td>
								<a class='move' href='/board/read?bno=${board.bno}&pageNum=${pagination.pagi.pageNum}&amount=${pagination.pagi.amount}'>
									<c:out value="${board.title}"></c:out>
								</a>
							</td>
							<td>
								<c:out value="${board.writer}"></c:out>
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${board.regDate}" />
							</td>
							<td>
								<fmt:formatDate pattern="yyyy-MM-dd" value="${board.updateDate}" />
							</td>
						</tr>
					</c:forEach>
				</table>
				
				<!-- Paging처리 -->				
				<div class="pull-right">
					<ul class="pagination">
						 <c:if test="${pagination.prev}">
						 	<li class="paginate_button previous">
						 		<a href="/board/list?pageNum=${pagination.startPage - 1}">이전</a>
						 	</li>
						 </c:if>
						 <c:forEach var="num" begin="${pagination.startPage}" end="${pagination.endPage}">
							<li class="pagination_button ${pagination.pagi.pageNum == num ? "active":""} ">
								<a href="/board/list?pageNum=${num}&amount=${pagination.pagi.amount}">${num}</a>
							</li>						 
						 </c:forEach>
						 <c:if test="${pagination.next}">
						 	<li class="paginate_button next">
						 		<a href="/board/list?pageNum=${pagination.endPage + 1}">다음</a>
						 	</li>
						 </c:if>
					</ul>
				</div>
				<%-- <form id="actionForm" action="/board/list" method="get">
					<input type="hidden" name="pageNum" value="${pagination.pagi.pageNum}">
					<input type="hidden" name="amount" value="${pagination.pagi.amount}">
				</form> --%>
				<!-- Paging처리 끝-->
				
				<!-- modal창 처리 -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
					aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal"
									aria-hidden="true">&times;</button>
								<h4 class="modal-title" id="myModalLabel">알림</h4>
							</div>
							<div class="modal-body">
								처리가 완료 되었습니다.
							</div>
							<div class="modal-footer">
								<button type="button" class="btn btn-primary"
									data-dismiss="modal">닫기</button>
							</div>
						</div>
						<!-- /.modal-content -->
					</div>
					<!-- /.modal-dialog -->
				</div>
				<!-- /. modal -->
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>

<script type="text/javascript">
	$(document).ready(function(){
		
		var result = '<c:out value="${result}"/>';
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			if(result === '' || history.state) {
				return;
			}
			if(parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + parseInt(result) + " 번이 등록되었습니다.");
			}
			$("#myModal").modal("show");
		}
		
		$("#regBtn").on("click", function(){
			self.location = "/board/register";
		});
		
		/* var actionForm = $("#actionForm");
		
		$(".paginate_button a").on("click", function(e){
			e.preventDefault();
			console.log('click');
			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		}); */		
		
		
	});
</script>

<%@include file="../includes/footer.jsp"%>