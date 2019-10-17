<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ include file="./includes/member_header.jsp" %>
    <div class="container h-100">
        <div class="row justify-content-center align-items-center">
            <div class="col-lg-5">
                <div class="card">
                    <div class="card-header">
                        <h3 class="card-title">회원 가입</h3>
                    </div>
                    <div class="card-body">
                        <form role="form" method="post" action="/join">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="ID" name="userid" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Password" name="userpw" type="password">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Re-Password" name="reUserpw" type="password">
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="Your Name" name="userName" type="text">
                                </div>
                                <!-- <div class="checkbox">
                                    <label>
                                        <input name="remember-me" type="checkbox">로그인 상태 유지
                                    </label>
                                </div> -->
                                <!-- Change this to a button or input when using this as a form -->
                                <%-- <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/> --%>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
                                <input type="submit" class="btn btn-lg btn-success btn-block" value="가입 하기">
                                <input type="reset" class="btn btn-lg btn-outline-secondary btn-block" value="다시 작성">
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
<script type="text/javascript">
	
		
	$(".btn-success").on("click", function(e){
		
		var userpw = $("input[name='userpw']");
		var reUserpw = $("input[name='reUserpw']");
			
		e.preventDefault();
		
		// console.log(userpw);
		// console.log(reUserpw);
		$("form-control").each(function (i, item){
			
			var obj = $(this).val();
			if(obj == null) {
				alert("모든 항목을 작성해주세요.");
				return false;
			}
			
		});
						
		if(userpw.val() != reUserpw.val()) {
			alert("비밀번호와 확인 비밀번호가 일치하지 않습니다.");
			return;
		}			
		
		alert("회원 가입이 완료되었습니다. 로그인 해주세요.");
		$("form").submit();
		
		});
	
</script>    
<%@ include file="./includes/member_footer.jsp" %>