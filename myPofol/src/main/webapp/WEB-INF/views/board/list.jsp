<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-1"></div>
	<div class="col-lg-10">
		<div class="card">
			<div class="card-header">
				<div class="d-flex justify-content-between">
					<h2>Board</h2>
					<button id='regBtn' type="button" class="btn btn-dark btn-sm">글 작성</button>
				</div>
			</div>
			<!-- /.panel-heading -->
			<div class="card-body">
				<table class="table table-striped table-bordered table-hover">
					<thead class="thead-dark">
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
							<td><c:out value="${board.bno}"></c:out></td>
							<%-- <td><a class='move' href='/board/read?bno=<c:out value="${board.bno}"/>'><c:out value="${board.title}"></c:out></a></td> --%>
							<td><a class='move'
								href='/board/read?bno=${board.bno}&pageNum=${pagination.pagi.pageNum}&amount=${pagination.pagi.amount}
											&type=${pagination.pagi.type}
											&keyword=${pagination.pagi.keyword}'>
									<c:out value="${board.title}"/>&nbsp;<span class="badge badge-dark"><c:out value="${board.replyCnt}"/></span>
							</a></td>
							<td><c:out value="${board.writer}"></c:out></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${board.regDate}" /></td>
							<td><fmt:formatDate pattern="yyyy-MM-dd"
									value="${board.updateDate}" /></td>
						</tr>
					</c:forEach>
				</table>
				</div>
				<div class="card-footer">
				<!-- Searching bar -->
					<form id="searchForm" action="/board/list" method="get">
						<div class="form-row">
							<div class="form-group col-md-2">
								<select class="form-control" name='type'>
									<option value=""
										<c:out value="${pagination.pagi.type == null ? 'selected' : '' }" />>---</option>
									<option value="T"
										<c:out value="${pagination.pagi.type eq 'T' ? 'selected' : '' }" />>제목

									
									<option value="C"
										<c:out value="${pagination.pagi.type eq 'C' ? 'selected' : '' }" />>내용</option>
									<option value="W"
										<c:out value="${pagination.pagi.type eq 'W' ? 'selected' : '' }" />>작성자</option>
									<option value="TC"
										<c:out value="${pagination.pagi.type eq 'TC' ? 'selected' : '' }" />>제목
										+ 내용</option>
									<option value="TW"
										<c:out value="${pagination.pagi.type eq 'TW' ? 'selected' : '' }" />>제목
										+ 작성자</option>
									<option value="TWC"
										<c:out value="${pagination.pagi.type eq 'TWC' ? 'selected' : '' }" />>제목
										+ 내용 + 작성자</option>
								</select>
								</div>
							<div class="form-group col-md-4 input-group">
									<input class="form-control" type="text" name="keyword"
										value='<c:out value="${pagination.pagi.keyword}" />'> <input
										type="hidden" name="pageNum"
										value='<c:out value="${pagination.pagi.pageNum}" />'> <input
										type="hidden" name="amount"
										value='<c:out value="${pagination.pagi.amount}" />'>
									<div class="input-group-append">	 
										<span>
										<button class="btn btn-outline-secondary">검색</button>
									</span>
									</div>
							</div>
						
						</div>
					</form>

				<!-- Paging처리 -->
				<div class="col-lg-12">
						<ul class="pagination justify-content-center">
							<c:if test="${pagination.prev}">
								<li class="paginate_button previous"><a class="page-link"
									href="/board/list?pageNum=${pagination.startPage - 1}
							 				&amount=${pagination.pagi.amount}
											&type=${pagination.pagi.type}
											&keyword=${pagination.pagi.keyword}">이전</a>
								</li>
							</c:if>
							<c:forEach var="num" begin="${pagination.startPage}"
								end="${pagination.endPage}">
								<li
									class="page-item ${pagination.pagi.pageNum == num ? "active":""} ">
									<a class="page-link"
									href="/board/list?pageNum=${num}
									&amount=${pagination.pagi.amount}
									&type=${pagination.pagi.type}
									&keyword=${pagination.pagi.keyword}">${num}</a>
								</li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li class="paginate_button next"><a class="page-link"
									href="/board/list?pageNum=${pagination.endPage + 1}
									&amount=${pagination.pagi.amount}
									&type=${pagination.pagi.type}
									&keyword=${pagination.pagi.keyword}">다음</a></li>
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
								<h4 class="modal-title" id="myModalLabel">알림</h4>
									<button type="button" class="close" data-dismiss="modal"
										aria-label="Close"><span aria-hidden="true">&times;</span></button>
							</div>
							<div class="modal-body"><p>처리가 완료 되었습니다.</p></div>
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
<div class="col-lg-1"></div>

<script type="text/javascript">
	$(document).ready(
			function() {

				var result = '<c:out value="${result}"/>';

				checkModal(result);

				history.replaceState({}, null, null);

				function checkModal(result) {
					if (result === '' || history.state) {
						return;
					}
					if (parseInt(result) > 0) {
						$(".modal-body").html(
								"게시글 " + parseInt(result) + " 번이 등록되었습니다.");
					}
					$("#myModal").modal("show");
				}

				$("#regBtn").on("click", function() {
					self.location = "/board/register";
				});

				/* var actionForm = $("#actionForm");
				
				$(".paginate_button a").on("click", function(e){
					e.preventDefault();
					console.log('click');
					actionForm.find("input[name='pageNum']").val($(this).attr("href"));
					actionForm.submit();
				}); */

				var searchForm = $("#searchForm");
				$("#searchForm button").on("click", function(e) {
					if (!searchForm.find("option:selected").val()) {
						alert("검색 방식을 선택하세요.");
						return false;
					}
					if (!searchForm.find("input[name='keyword']").val()) {
						alert("키워드를 입력하세요.");
						return false;
					}
					searchForm.find("input[name='pageNum']").val("1");
					e.preventDefault();
					searchForm.submit();
				});

			});
</script>

<%@include file="../includes/footer.jsp"%>