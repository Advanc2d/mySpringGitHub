<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="/resources/vendor/jquery/jquery.min.js"></script>
<script>
function showImage(fileCallPath){		// 섬네일 이미지 확대해서 보여주고 다시 클릭 시 숨기기
	$(".bigPictureWrapper").css("display","flex").show();
	$(".bigPicture").html("<img src='/display?fileName="+encodeURI(fileCallPath)+"''>").animate({width:'100%', height:'100%'}, 1000);
	
	$(".bigPictureWrapper").on("click",function(e){
		$(".bigPicture").animate({width:'0%',height:'0%'},1000);
		setTimeout(function(){
			$('.bigPictureWrapper').hide();
		},1000);
	});	//bigPictureWrapperclick
}
</script>
<style>
.uploadResult{
	width:100%;
	background-color:#ddd;
}

.uploadResult ul{
	display:flex;
	flex-flow:row;
	justify-content:center;
	align-items:center;
}

.uploadResult ul li{
	list-style:none;
	padding:10px;
}
.uploadResult ul li img{
	width:20px;
}

.uploadResult ul li span{
	color: white;
}

.bigPictureWrapper{
	position:absolute;
	display:none;
	justify-content:center;
	align-items:center;
	top:0%;
	width:100%;
	height:100%;
	background-color:gray;
	z-index:100;
	background:rgba(255, 255, 255, 0.5);
}

.bigPicture{
	position:relative;
	display:flex;
	justify-content:center;
	align-items:center;
}

.bigPicture img{
	width:400px;
}
</style>
</head>
<body>
	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>
	<div class="uploadResult">
		<ul></ul>
	</div>
	<button id="uploadBtn">Upload</button>
	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>
	<script>
		$(document).ready(function(){
			var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
			// 확장자를 위한 변수 설정
			var maxSize = 5242880;
			
			function checkExtension(fileName, fileSize){
				if(fileSize>=maxSize){	// fileSize 변수가 최대 파일 크기보다 크면 경고 창 출력 후 돌아가기
					alert("파일 크기 초과");
					return false;
				}
				if(regex.test(fileName)){		// fileName을 내부함수 test를 통해 확장자가 맞으면
					alert("해당 종류의 파일은 업로드 할 수 없음");		// 파일 업로드 불가 메세지 출력
					return false;
				}
				return true;			// 아닐 시에는 다음 문장들 실행
			}
			var cloneObj=$(".uploadDiv").clone();
			$("#uploadBtn").on("click", function(e){		//ID가 uploadBtn인 걸 클릭시에
				
				var formData = new FormData();				//가상 form을 만들어		
				var inputFile = $("input[name='uploadFile']");	//input name에 해당하는 것들을 파일들(multiple) 담아서
				var files = inputFile[0].files;		// 배열로 저장 inputFile[i]인 이유는 input을 여러개 담았을 시 배열로 저장됨
				console.log(files);
				
				for(var i =0;i<files.length;i++){
					if(!checkExtension(files[i].name, files[i].size)){
						return false;
					}
					formData.append("uploadFile",files[i]);
				}
				console.log("files.length : " + files.length);
				
				$.ajax({
					url:'/uploadAjaxAction',
					processData:false,	//전달할 데이터를 query string을 만들지 말 것
					contentType:false,
					data:formData, // 전달할 데이터
					type:'POST',
					dataType:'json',
					success: function(result){
						/* alert('Uploaded'); */
						
						console.log(result);
						showUploadedFile(result);
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			});
			
			$(".uploadResult").on("click","span",function(e){
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				console.log(targetFile);
				$.ajax({
					url:'/deleteFile',
					data:{fileName:targetFile, type:type},
					dataType:'text',
					type:'post',
					success:function(result){
						alert(result);
					}
				});
			});
			
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr){
				var str="";
				$(uploadResultArr).each(function(i,obj){
					if(!obj.image){
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
						
						str +="<li><div>"
						str +="<span>" + obj.fileName+ "</span>";
						str +="<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/images/attach.png'></div></li>";
						
						/* str +="<li><div><a href='/download?fileName="+fileCallPath+"'><img src='/resources/images/attach.png'>" + obj.fileName + "</a>"
						+"<span data-file=\'" + fileCallPath + "\' data-type='file'>x</span></div></li>"; */
						
						/* str +="<li><img src='resources/images/attach.png'>" + obj.fileName + "</li>"; */	
					}else{
						/* str +="<li>" + obj.fileName + "</li>"; */
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
						
						str +="<li><div>"
							str +="<span>" + obj.fileName+ "</span>";
							str +="<button type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
							str += "<img src='/display?fileName="+fileCallPath + "'></div></li>";
						
						/* var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
						originPath = originPath.replace(new RegExp(/\\/g),"/");
						str +="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
						+"<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span></li>"; */
						/* str +="<li><img src='/display?fileName=" + fileCallPath + "'></li>"; */ 
					}
				}); 
				uploadResult.append(str);
			}	//showUploadedFile 끝
			
			
			
		});
	</script>
</body>
</html>