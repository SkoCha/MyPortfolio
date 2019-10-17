<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../includes/header.jsp" %>
<style type="text/css">
	html,
	body {
	  height: 100%;
	}
	
	#page-content {
	  flex: 1 0 auto;
	}
	
	#sticky-footer {
	  flex-shrink: none;
	}
	
	footer {

    position:absolute;

    bottom:0;

    width:100%;

}
</style>
<div class="d-flex flex-column">
  <div id="page-content">
    <div class="container text-center">
      <div class="row justify-content-center">
        <div class="col-md-7">
          <h1 class="font-weight-light mt-4 text-black">잘못된 요청으로 인한 페이지</h1>
          	<p class="lead text-black-50">요청하신 주소에 대한 페이지가 존재 하지 않습니다. </p>
        </div>
      </div>
    </div>
  </div>
</div> 
<%@ include file="../includes/footer.jsp" %>
