<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, org.conan.domain.BoardVO" %>
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
							게시글 조회
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/board/modify" method="post">
                            	<div class="form-group">
                            	<label>Bno</label><input class="form-control" name='bno' 
                            	value='<c:out value="${board.bno }"/>' readonly="readonly">
                            	</div>
                            	<div class="form-group">
                            		<label>Title</label>
                            		<input class="form-control" name="title" value='<c:out value="${board.title }"/>'>
                            	</div>
                            	<div class="form-group">
                            		<label>Content</label>
                            		<textarea class="form-control" rows="3" name="content"><c:out value="${board.content }"/></textarea>
                            	</div>
                            	<div class="form-group">
                            		<label>Writer</label>
                            		<input class="form-control" name="writer"  
                            	value='<c:out value="${board.writer }"/>'>
                            	</div>
                            	<div class="form-group">
                            		<label>regDate</label>
                            		<input class="form-control" name="regDate" 
                            		value='${board.regDate }' readonly="readonly">
                            	</div>
                            	<div class="form-group">
                            		<label>updateDate</label>
                            		<input class="form-control" name="regDate" 
                            		value='${board.updateDate }' readonly="readonly">
                            	</div>
                            	<!-- <div class="uploadResult">
									<ul></ul>
								</div> -->
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
                            	<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
	                        	<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
	                        	<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
	                        	<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                            	<button type="submit" data-oper='modify' class="btn btn-outline btn-info">Modify</button>
                            	<button type="submit" data-oper='remove' class="btn btn-outline btn-danger">Remove</button>
                            	<button type="submit" data-oper='list' class="btn btn-outline btn-success">List</button>
                            	</form>
                          		<%-- <button data-oper='modify' class="btn btn-outline btn-success" 
                          		onclick="location.href='/board/modify?bno=<c:out value="${board.bno}"/>'">Modify</button>
                          		<button data-oper='list' class="btn btn-default" 
                          		onclick="location.href='/board/list'">List</button> --%>
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
        <script type="text/javascript">
        	$(document).ready(function(){
        		
        		var bnoValue = '<c:out value="${board.bno}"/>';
        		
        		$.getJSON("/board/getAttachList", {bno:bnoValue}, function(arr){
        			console.log(arr);
        			var str="";
    				$(arr).each(function(i,obj){
    					console.log(obj.fileType);
    					if(!obj.fileType){
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
    						var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
    						originPath = originPath.replace(new RegExp(/\\/g),"/");
    						str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid
    						+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
    						str +="<span>" + obj.fileName+ "</span>";
    						str +="<button type='button' data-file=\'"+fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    						str += "<a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath + "'></a></div></li>";
    						
    						/* var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
    						originPath = originPath.replace(new RegExp(/\\/g),"/");
    						str +="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
    						+"<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span></li>"; */
    						/* str +="<li><img src='/display?fileName=" + fileCallPath + "'></li>"; */ 
    					}
    				});
    				
    				$(".uploadResult ul").html(str);
        		});	//end getJSON
        		
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
    				
    				if(confirm("이 파일을 삭제하시겠습니까?")){
    					var targetLi = $(this).closest("li");
    					targetLi.remove();
    				}
    				
    				$.ajax({
    					url:'/deleteFile',
    					data:{fileName:targetFile, type:type},
    					dataType:'text',
    					type:'post',
    					success:function(result){
    						/* alert(result); */
    						/* $(".uploadDiv").html(cloneObj.html()); */
    					}
    				});
    			});
    			
    			
    			var uploadResult = $(".uploadResult ul");
    			function showUploadedFile(uploadResultArr){
    				if(!uploadResultArr||uploadResultArr.length==0){return;}
    				var uploadUL = $(".uploadResult ul");
    				var str="";
    				$(uploadResultArr).each(function(i,obj){
    					console.log(obj.image);
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
    						var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
    						originPath = originPath.replace(new RegExp(/\\/g),"/");
    						str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid
    						+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
    						str +="<span>" + obj.fileName+ "</span>";
    						str +="<button type='button' data-file=\'"+fileCallPath +"\' data-type='image' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
    						str += "<a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName="+fileCallPath + "'></a></div></li>";
    						
    						/* var originPath = obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
    						originPath = originPath.replace(new RegExp(/\\/g),"/");
    						str +="<li><a href=\"javascript:showImage(\'"+originPath+"\')\"><img src='/display?fileName=" + fileCallPath + "'></a>"
    						+"<span data-file=\'" + fileCallPath + "\' data-type='image'>x</span></li>"; */
    						/* str +="<li><img src='/display?fileName=" + fileCallPath + "'></li>"; */ 
    					}
    				});
    				
    				
    				$(".uploadResult ul").html(str);
    				
    			}	//showUploadedFile 끝
    			
    			
        		var formObj = $("form[role='form']");
        		$('button').on("click", function(e){
        			e.preventDefault();
        			var operation = $(this).data("oper");
        			console.log(operation);
        			if(operation === 'remove'){
        				formObj.attr("action","/board/remove");
        			}else if(operation === 'list'){
        				//move to list
        				/* self.location="/board/list";
        				return; */
        				formObj.attr("action","/board/list").attr("method","get");
         				var pageNumTag = $("input[name='pageNum']").clone();		//임시 보관용
        				
        				var amountTag = $("input[name='amount']").clone();
        				var typeTag = $("input[name='type']").clone();
        				var keywordTag = $("input[name='keyword']").clone();
        				formObj.empty();	//제거
        				
        				formObj.append(typeTag);
        				formObj.append(keywordTag);
        				formObj.append(pageNumTag);
        				formObj.append(amountTag);		// 필요한 태그들만 추가 

        			}else if(operation==='modify'){
        				console.log("MODIFY로 들어왔음");
        				var str = "";
        				$(".uploadResult ul li").each(function(i, obj){
        					var jobj = $(obj);
        					console.log(jobj);
        					str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
            				str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
            				str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
            				str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+jobj.data("type")+"'>";
            				
            				
        				});
        				formObj.append(str);
        			}
        			formObj.submit();
        		});
        	});
        </script>
		<jsp:include page="../includes/footer.jsp"/>
    