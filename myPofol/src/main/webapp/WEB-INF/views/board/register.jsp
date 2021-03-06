<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
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
			<div class="card-header"><label><h2>게시글 작성</h2></a></label></div>
			<!-- /.panel-heading -->
			<div class="card-body">		
				<form role="form" action="/board/register" method="post">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					<div class="form-group">
						<label>Title</label><input class="form-control" name='title'/>
					</div>
					<div class="form-group">
						<label>Content</label><textarea class="form-control" rows="3" name="content"></textarea>
					</div>
					<div class="form-group">
						<label>Writer</label><input class="form-control" name='writer'
						value='<sec:authentication property="principal.username"/>' readonly="readonly"/>
					</div>
					<button type="submit" class="btn btn-secondary">등록</button>					
					<button type="reset" class="btn btn-outline-dark">내용 지우기</button>					
				</form>
			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
	<div class="col-lg-2">
	</div>
</div>
<div class="row">
	<div class="col-lg-1"></div>
	<div class="col-lg-10">
		<div class="card">
			<div class="card-header">
				파일 업로드			
			</div>
			<div class="card-body">
				<div class="form-group uploadDiv">
					<input type="file" name="uploadFile" multiple>
				</div>
				<div class="card-footer">
					<div class="uploadResult">
						<ul>
						
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="col-lg-1"></div>
</div>
<script>

$(document).ready(function(e){
	
	var formObj = $("form[role='form']");
	
	$("button[type='submit']").on("click", function(e){
		e.preventDefault();		
		console.log("submit clicked");		
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
	});	
	
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
	
	var csrfHeaderName = "${_csrf.headerName}";
	var csrfTokenValue = "${_csrf.token}";
	
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
				beforeSend: function(xhr) {
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
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
	
	$(".uploadResult").on("click", "button", function(e){
		
		// console.log("삭제할 첨부파일");
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		
		var targetLi = $(this).closest("li");
		
		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			beforeSend: function(xhr) {
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			dataType: 'text',
			type: 'POST',
			success: function(result) {
				alert(result);
				targetLi.remove();
			}
			
		});
		
	});
	
	
});

</script>
<%@include file="../includes/footer.jsp"%>