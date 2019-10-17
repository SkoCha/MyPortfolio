<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ include file="./includes/member_header.jsp" %>

<div class="container h-100">
	<div class="row justify-content-center align-items-center">
		<div class="col-lg-4">
			<div class="card">
				<div class="card-header">
					<h3 class="panel-title">Login</h3>
				</div>
				<div class="card-body">
					<form role="form" method="post" action="/login">
						<fieldset>
							<div class="form-group">
								<input class="form-control" placeholder="ID" name="username"
									type="text" autofocus>
							</div>
							<div class="form-group">
								<input class="form-control" placeholder="Password"
									name="password" type="password" value="">
							</div>
							<div class="checkbox">
								<label> <input name="remember-me" type="checkbox">
								로그인 상태 유지
								</label>
							</div>
							<!-- Change this to a button or input when using this as a form -->
							<input type="hidden" name="${_csrf.parameterName}"
								value="${_csrf.token}" /> <a href="index.jsp"
								class="btn btn-lg btn-success btn-block">로그인</a> <a href="/join"
								class="btn btn-lg btn-warning btn-block">회원가입</a>
						</fieldset>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
	$(".btn-success").on("click", function(e){
		
		e.preventDefault();
		$("form").submit();
	});
</script>    
<%@ include file="./includes/member_footer.jsp" %>