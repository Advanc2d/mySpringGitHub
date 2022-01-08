<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, org.conan.domain.BoardVO" %>
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
        <jsp:include page="../includes/header.jsp"/>
        <div id="page-wrapper">
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
                        <div class="panel-heading">
                            DataTables Advanced Tables
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <form role="form" action="/board/register" method="post">
                            	<div class="form-group">
                            		<label>Title</label>
                            		<input class="form-control" name="title">
                            	</div>
                            	<div class="form-group">
                            		<label>Content</label>
                            		<textarea class="form-control" rows="3" name="content"></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>Writer</label>
                            		<input class="form-control" name="writer">
                            	</div>
                            	<div class="form-group">
                            		<label>File Upload</label>
                            		<div class="form-group uploadDiv">
                            		<input type="file" class="form-control" name="uploadFile" multiple>
                            		</div>
                            	</div>
                            	<div class="uploadResult">
									<ul></ul>
								</div>
								<div class="bigPictureWrapper">
									<div class="bigPicture"></div>
								</div>
                            	<button type="submit" class="btn btn-default">Submit</button>
                            	<button type="reset" class="btn btn-danger">Reset</button>
                            </form>
                            
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
        <!-- /#page-wrapper -->

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
			
			/* $("#uploadBtn").on("click", function(e){		//ID가 uploadBtn인 걸 클릭시에 */
				$("input[type='file']").change(function(e){
				
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
						/* $(".uploadDiv").html(cloneObj.html()); */
					}
				});
			});
			
			$(".uploadResult"). on("click","button",function(e){					
				var targetFile = $(this).data("file");
				var type = $(this).data("type");
				var targetLi = $(this).closest("li");
				console.log(targetFile);
				console.log(targetLi);
				
				$.ajax({
					url:'/deleteFile',
					data:{fileName:targetFile, type:type},
					dataType:'text',
					type:'post',
					success:function(result){
						/* alert(result); */
						/* targetFile.remove(); */
						
						targetLi.remove();
						/* $(".uploadDiv").html(cloneObj.html()); */
					}
				});
			});
			
			/* $(".uploadResult").on("click","span",function(e){
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
						$(".uploadDiv").html(cloneObj.html());
					}
				});
			}); */
			
			var uploadResult = $(".uploadResult ul");
			function showUploadedFile(uploadResultArr){
				if(!uploadResultArr||uploadResultArr.length==0){return;}
				var uploadUL = $(".uploadResult ul");
				var str="";
				$(uploadResultArr).each(function(i,obj){
					if(!obj.image){
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
						
						str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid
						+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
						str +="<span>" + obj.fileName+ "</span>";
						str +="<button type='button' data-file=\'"+fileCallPath +"\' data-type='file' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
						str += "<img src='/resources/images/attach.png'></div></li>";
						
						/* str +="<li><div><a href='/download?fileName="+fileCallPath+"'><img src='/resources/images/attach.png'>" + obj.fileName + "</a>"
						+"<span data-file=\'" + fileCallPath + "\' data-type='file'>x</span></div></li>"; */
						
						/* str +="<li><img src='resources/images/attach.png'>" + obj.fileName + "</li>"; */	
					}else{
						/* str +="<li>" + obj.fileName + "</li>"; */
						var fileCallPath = encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
						
						str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid
						+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
						str +="<span>" + obj.fileName+ "</span>";
						str +="<button type='button' data-file=\'"+fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
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
			
			
			var formObj = $("form[role='form']");
        	$("button[type='submit']").on("click", function (e){
    			e.preventDefault();
    			console.log("submit clicked");
    			var str="";
    			$(".uploadResult ul li").each(function(i,obj){
    				var jobj = $(obj);
    				console.dir(jobj);
    				str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
    				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
    				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
    				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
    				
    				});	
    				formObj.append(str);
    				formObj.submit(); 
    			}); // submit button event
			
		});
	</script>
		<jsp:include page="../includes/footer.jsp"/>
    