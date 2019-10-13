/**
 * Sko's JavaScript Module
 */

function showImage(fileCallPath){
		
		$(".bigPictureWrapper").css("display", "flex").show();		
		$(".bigPicture").html("<img src='/display?fileName=" + encodeURI(fileCallPath)+"'>").animate({width: '100%', height: '100%'}, 1000);
		
	}

$(document).ready(function(){

	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880;
	var cloneObj = $(".uploadDiv").clone();
	
	function checkExtension(fileName, fileSize) {
		
		if(fileSize >= maxSize) {
			alert("파일 사이즈 초과");
			return false;
		}
		
		if(regex.test(fileName)) {
			alert("해당 종류의 파일은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}	
	
	
	$("#uploadBtn").on("click", function(e){
	
		var formData = new FormData();
		
		var inputFile = $("input[name='uploadFile']");
		
		var files = inputFile[0].files;
		
		console.log(files);
		
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
					
					showUploadedFile(result);
					
					$(".uploadDiv").html(cloneObj.html());
				}
		});
		
		var uploadResult = $(".uploadResult ul");
		
		function showUploadedFile(uploadResultArr) {
			
			var str = "";
			
			$(uploadResultArr).each(function(i, obj) {
				
				if(!obj.image){
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);
					str += "<li><a href='/download?fileName="+ fileCallPath +"'><img src='/resources/image/attach.jpg'>" + obj.fileName + "</a></li>";
				} else {
					// str += "<li>" + obj.fileName + "</li>";
					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
					originPath = originPath.replace(new RegExp(/\\/g), "/"); 
					str += "<li><a href=\"javascript:showImage(\'" + originPath +"\')\"><img src='/display?fileName="+ fileCallPath + "'></a></li>";
				}
				
			});
			
			uploadResult.append(str);
		}
		
	});
	
});