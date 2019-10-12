<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Board Modify</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				<label>Board Modify Page</label>
			</div>
			<div class="panel-body">
				<!-- /.panel-heading -->
				<form role="form" action="/board/modify" method="post">
				<div class="form-group">
					<label>No</label><input class="form-control" name="bno"
						value='<c:out value="${board.bno}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Title</label><input class="form-control" name="title"
						value='<c:out value="${board.title}"/>'>
				</div>
				<div class="form-group">
					<label>Content</label>
					<textarea class="form-control" rows="3" name="content">
						<c:out value="${board.content}"/>
					</textarea>
				</div>
				<div class="form-group">
					<label>Writer</label><input class="form-control" name="writer"
						value='<c:out value="${board.writer}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Register Date</label><input class="form-control" name='regDate'
						value='<fmt:formatDate pattern = "yyyy/MM/dd" value="${board.regDate}"/>' readonly="readonly">
				</div>
				<div class="form-group">
					<label>Update Date</label><input class="form-control" name='updateDate'
						value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.updateDate}"/>' readonly="readonly">
				</div>
				<input type="hidden" name="pageNum" value='<c:out value="${pagi.pageNum}" />'>
				<input type="hidden" name="amount" value='<c:out value="${pagi.amount}" />'>
				<input type="hidden" name="type" value='<c:out value="${pagi.type}" />'>
				<input type="hidden" name="keyword" value='<c:out value="${pagi.keyword}" />'>
				<button type="submit" data-oper='modify' class="btn btn-default">수정 하기</button>
				<button type="submit" data-oper='remove' class="btn btn-danger">삭제 하기</button>
				<button type="submit" data-oper='list' class="btn btn-info">목록 보기</button>
				<!-- /.panel-body -->
				</form>
			</div>
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- 첨부 파일 -->
<div class="bigPictureWrapper">
	<div class="bigPicture">
	
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">
				첨부 파일			
			</div>
			<div class="panel-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
				<div class="uploadResult">
					<ul>
					
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 첨부 파일 끝-->
<script type="text/javascript">
	$(document).ready(function(){
		
		var formObj = $("form");
		
		$('button').on("click", function(e){
			e.preventDefault();
			var operation = $(this).data("oper");
			// console.log(operation);
			
			if(operation === 'remove') {
				formObj.attr("action", "/board/remove");				
			} else if(operation === 'list') {
				formObj.attr("action", "/board/list").attr("method", "get");
				var pageNumVal = $("input[name='pageNum']").clone();
				var amountVal = $("input[name='amount']").clone();
				var typeVal = $("input[name='type']").clone();
				var keywordVal = $("input[name='keyword']").clone();
				formObj.empty();
				formObj.append(pageNumVal);
				formObj.append(amountVal);
				formObj.append(typeVal);
				formObj.append(keywordVal);
			} else if(operation === 'modify') {
				
				var str = "";
				
				$(".uploadResult ul li").each(function(i, obj){
					var jobj = $(obj);
					console.dir(jobj);
					
					str += "<input type='hidden' name='uploadList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
					str += "<input type='hidden' name='uploadList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
					str += "<input type='hidden' name='uploadList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
					str += "<input type='hidden' name='uploadList["+i+"].fileType' value='"+jobj.data("type")+"'>";
				});
				formObj.append(str).submit();
			}
			formObj.submit();
		});
	});
</script>
<script>
$(document).ready(function() {
	
	var	regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var	maxSize = 5242880;
	
	function checkExtension(fileName, fileSize) {
		
		if(fileSize >= maxSize) {
			alert("첨부 파일의 크기가 너무 큽니다.");
			return false;
		}
		if(regex.test(fileName)) {
			alert("해당 형식의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	$("input[type='file']").change(function(e){
			
			var formData = new FormData();
			var inputFile = $("input[name='uploadFile']");
			var files = inputFile[0].files;
			
			
			for(var i = 0; i < files.length; i++) {
				if(!checkExtension(files[i].name, files[i].size)) {
					return false;
				}
				formData.append("uploadFile", files[i]);
				
			}
			
			$.ajax({
				url: '/uploadAjaxAction',
				processData: false,
				contentType: false,
				data: formData,
				type: 'POST',
				dataType: 'json',
					success: function(result) {
						console.log(result);
						showUploadResult(result);
					}
			});
			
		});
		
	function showUploadResult(uploadResultArr) {
		
		if(!uploadResultArr || uploadResultArr.length == 0) {
			return;
		}
		
		var uploadUL = $(".uploadResult ul");
		
		var str = "";
		
		$(uploadResultArr).each(function(i, obj){
			
			// 이미지 타입일 경우
			if(obj.fileType) {
				
				var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str += "<li data-path='"+obj.uploadPath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'";
				str += "><div>";
				str += "<span> " + obj.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				
			} else {
				
				var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
				var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");
				str += "<li data-path='"+obj.uploadPath+"'";
				str += " data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>";
				str += "<span> " + obj.fileName + "</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/image/attach.jpg'>";
				str += "</div>";
				str += "</li>";
				
			}
			
		});
		
		uploadUL.append(str);
		
	}
	
	var bno = '<c:out value="${board.bno}"/>';
	
	$.getJSON("/board/getUploadList", {bno: bno}, function(arr){
		
		// console.log(arr);		
		var str = "";
		
		$(arr).each(function(i, upload){
			
			// 이미지 파일일 경우
			if(upload.fileType) {
				
				var fileCallPath = encodeURIComponent(upload.uploadPath + "/s_" + upload.uuid + "_" + upload.fileName);
				str += "<li data-path='"+upload.uploadPath+"' data-uuid='"+upload.uuid+"' data-filename='"+upload.fileName+"' data-type='"+upload.fileType+"'><div>";
				str += "<span>"+upload.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/display?fileName="+fileCallPath+"'>";
				str += "</div>";
				str += "</li>";
				
			} else {
				
				str += "<li data-path='"+upload.uploadPath+"' data-uuid='"+upload.uuid+"' data-filename='"+upload.fileName+"' data-type='"+upload.fileType+"'><div>";
				str += "<span>"+upload.fileName+"</span>";
				str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
				str += "<img src='/resources/image/attach.jpg'>";
				str += "</div>";
				str += "</li>";
				
			}			
		});
		$(".uploadResult ul").html(str);
	});
	
	$(".uploadResult").on("click", "button", function(e){
		
		if(confirm("정말 삭제 하시겠습니까?")) {
			
			var targetLi = $(this).closest("li");
			targetLi.remove();
			
		}
		
	});
	
});
</script>
<%@include file="../includes/footer.jsp"%>