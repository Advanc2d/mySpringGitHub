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
							게시글 조회
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                       
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
                            	value='<c:out value="${board.writer }"/>' readonly="readonly" >
                            	</div>
                            	<div class="form-group">
                            		<div class="uploadResult">
									<ul></ul>
								</div>
									<div class="bigPictureWrapper">
									<div class="bigPicture"></div>
								</div>
                            	</div>
                            	
                            	<!-- <button type="submit" class="btn btn-default">Submit</button>
                            	<button type="reset" class="btn btn-danger">Reset</button> -->
                          		<button data-oper='modify' class="btn btn-outline btn-warning">Modify</button>
                          		<button data-oper='list' class="btn btn-outline btn-success">List</button>
                          		
                          		<form id="operForm" action="/board/modify" method="get">
	                        		<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno }"/>'>
	                        		<input type="hidden" name="pageNum" value='<c:out value="${cri.pageNum }"/>'>
	                        		<input type="hidden" name="amount" value='<c:out value="${cri.amount }"/>'>
	                        		<input type="hidden" name="type" value='<c:out value="${cri.type }"/>'>
	                        		<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }"/>'>
                          		</form>
                          		
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                        <div class="panel panel-default">
                        	<div class="panel-heading"><i class="fa fa-comments fa-fw"></i>Reply<button id='addReplyBtn' type="button" class="btn btn-xs btn-primary pull-right">New Reply</button></div>
                        	<div class="panel-body">
                        		
                        		<ul class="chat">
                        			<!-- <li class="left clearfix" data-rno="12">
                        				<div>
                        					<div class="header">
                        						<strong class="primary-font">user00</strong>
                        						<small class="pull-right text-muted">2021-05-13 13:13</small>
                        					</div>
                        					<p> Good job</p>
                        				</div>
                        			</li> -->
                        		</ul>
                        	</div>
                        	<div class="panel-footer"></div>
                        </div>
                        <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalllabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">REPLY MODAL</h4>
								</div>
								<div class="modal-body">
									<div class="form-group">
										<label>Reply</label><input class="form-control" name="reply" value="New Reply!!!!">
									</div>
									<div class="form-group">
										<label>Replyer</label><input class="form-control" name="replyer" value="New Replyer!!!!">
									</div>
									<div class="form-group">
										<label>ReplyDate</label><input class="form-control" name="replyDate" value="New ReplyDate!!!!">
									</div>
									
									<!-- replyer, replyDate를 위한 div 배치 -->
								</div>
								<div class="modal-footer">
									<button id ='modalModBtn' type="button" class="btn btn-warning">Modify</button>
									<button id ='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
									<button id ='modalRegisterBtn' type="button" class="btn btn-success">Register</button>
									<button id ='modalCloseBtn' type="button" class="btn btn-info">Close</button>
								</div>
							</div>
						</div>
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
                
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        
       
        
      
		
		<script>
		
		</script>
		<!--   <script>
	        function displayTime(timeValue){
				var today = new Date();
				var gap = today.getTime()-timeValue;
				var dateObj = new Date(timeValue);
				var str = "";
				if(gap<(1000*60*60*24)){
					var hh = dateObj.getHours();
					var mi = dateObj.getMinutes();
					var ss = dateObj.getSeconds();
					return [(hh>9?'':'0') +hh, ':',(mi>9?'':'0')+mi,':',(ss>9?'':'0')+ss].join('');
				}else{
					var yy = dateObj.getFullYear();
					var mm = dateObj.getMonth()+1;
					var dd= dateObj.getDate();
					return [yy, '/',(mm>9?'':'0')+mm,'/',(dd>9?'':'0')+dd].join('');
				}
			} //displayTime 함수 끝
		</script> -->
		<script src="/resources/js/reply.js"></script>
		 <script type="text/javascript">
        	$(document).ready(function(){
        		var bnoValue = '<c:out value="${board.bno}"/>';
        		
        		$.getJSON("/board/getAttachList", {bno:bnoValue}, function(arr){
        			console.log(arr);
        			showUploadedFile(arr);
        		});	//end getJSON
        		
        		var uploadResult = $(".uploadResult ul");
    			function showUploadedFile(uploadResultArr){
    				if(!uploadResultArr||uploadResultArr.length==0){return;}
    				var uploadUL = $(".uploadResult ul");
    				var str="";
    				$(uploadResultArr).each(function(i,obj){
    					console.log(obj.fileType);
    					if(!obj.fileType){
    						var fileCallPath = encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName);
    						
    						str +="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid
    						+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
    						str +="<span>" + obj.fileName+ "</span>";
    						str +="<br>";
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
    						str +="<br>";
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
        		
        		var replyUL=$(".chat");
        		showList(1);
        		function showList(page){
        			replyService.getList(
            				{bno: bnoValue, page:page||1},
            				function(replyCnt,list){
            					console.log("replyCnt : " + replyCnt);
            					console.log("list : " + list);
            					if(page ==0){
            						pageNum = Math.ceil(replyCnt/10.0);
            						showList(pageNum);
            						return;
            					}
            					var str="";
            					if(list == null || list.length ==0){
            						replyUL.html("");
            						return
            					}
            					for(var i=0,len = list.length||0;i<len;i++){
            						var replyTime = replyService.displayTime(list[i].replyDate);
            						str += "<li class='left clearfix' data-rno='" + list[i].rno + "'>";
                    				str += "<div><div class='header;><strong class='primary-font'>" + list[i].replyer + "</strong>";
                					str += "<small class='pull-right text-muted'>" + replyTime + "</small></div>";
                					str += "<p>"+list[i].reply +"</p></div></li>";
            					}
            					replyUL.html(str);
            					showReplyPage(replyCnt);
            				});		//function call
            				
        		}	// showList
        			var modal=$(".modal");
        			var modalInputReply = modal.find("input[name='reply']");
        			var modalInputReplyer = modal.find("input[name='replyer']");
        			var modalInputReplyDate = modal.find("input[name='replyDate']");
        			
        			var modalModBtn = $("#modalModBtn");
        			var modalRemoveBtn = $("#modalRemoveBtn");
        			var modalRegisterBtn = $("#modalRegisterBtn");
        			var modalCloseBtn = $("#modalCloseBtn");
        			
        			$(".chat").on("click","li",function(e){
        				var rno = $(this).data("rno");
        				console.log(rno);
        				replyService.get(rno, function(reply){
        					modalInputReply.val(reply.reply);
        					modalInputReplyer.val(reply.replyer);
        					modalInputReplyDate.val(replyService.displayTime(reply.replyDate)).attr("readonly","readonly");
        					modal.data("rno", reply.rno);
        					modalInputReplyDate.closest("div").show();
        					modal.find("button[id!='modalCloseBtn']").hide();
        					modalModBtn.show();
        					modalRemoveBtn.show();
        					$(".modal").modal("show");
        				});
        			});
        			
        			$("#addReplyBtn").on("click", function(e){
        				modal.find("input").val("");
        				modalInputReplyDate.closest("div").hide();
        				modal.find("button[id !='modalCloseBtn']").hide();
        				modalRegisterBtn.show();
        				$(".modal").modal("show");
        			});

        			modalRegisterBtn.on("click", function(e){
        				var reply ={
        					reply:modalInputReply.val(),
        					replyer:modalInputReplyer.val(),
        					bno:bnoValue
        				};
        				
        				replyService.add(reply, function(result){
        					alert(result);			// 댓글 등록이 정상임을 팝업으로 알림
        					
        					modal.find("input").val("");		// 댓글 등록이 정상적으로 이뤄지면, 내용을 지움
        					modal.modal("hide");	// 모달창 닫음
        					showList(0);
        				});	
        			});
        			
        			modalModBtn.on("click", function(e){
        				var reply ={
        					rno:modal.data("rno"),
        					reply:modalInputReply.val()
        				};
        				
        				replyService.update(reply, function(result){
        					alert(result);			// 댓글 등록이 정상임을 팝업으로 알림
        					modal.modal("hide");	// 모달창 닫음
        					showList(pageNum);
        				});	
        			});
        			
        			modalRemoveBtn.on("click", function(e){
        				var rno = modal.data("rno");
        				
        				replyService.remove(rno, function(result){
        					alert(result);			// 댓글 등록이 정상임을 팝업으로 알림
        					modal.modal("hide");	// 모달창 닫음
        					showList(pageNum);
        				});	
        			});
        			
        			modalCloseBtn.on("click", function(e){
        				modal.modal("hide");	// 모달창 닫음
        			});
        		
        			var pageNum=1;
        			var replyPageFooter=$(".panel-footer");
        			
        			function showReplyPage(replyCnt){
        				console.log("ShowReplyCount: " + replyCnt);
        				var endNum = Math.ceil(pageNum/10.0)*10;
        				var startNum = endNum-9;
        				var prev = startNum != 1;
        				var next = false;
        				if(endNum * 10>=replyCnt){endNum = Math.ceil(replyCnt/10.0);}
        				if(endNum * 10 < replyCnt){
        					next = true;
        				}
        				var str = "<ul class='pagination pull-right'>";
        				
        				if(prev){
        					str += "<li class='page-item'><a class='page-link' href='" + (startNum -1) + "'>Previous</a></li>";
        				}
        				for(var i =startNum;i<=endNum;i++){
        					var active = pageNum == i?"active":"";
        					str += "<li class='page-item " + active + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>";
        				}
        				if(next){
        					str += "<li class='page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
        				}
        				str += "</ul></div>";
        				console.log(str);
        				replyPageFooter.html(str);
        			}	// showReplyPage
        			
        			replyPageFooter.on("click","li a", function(e){
        				e.preventDefault();
        				console.log("page click");
        				var targetPageNum = $(this).attr("href");
        				console.log("targetPageNum : " + targetPageNum);
        				pageNum = targetPageNum;
        				showList(pageNum);
        			});
        		
        		
/*         		replyService.add({
        			reply:"JS TEST", replyer:"js tester", bno:bnoValue}, function(result){
        				alert("RESULT : " + result);
        			}
        		);
        		
        		replyService.getList(
        				{bno: bnoValue, page:1},
        				function(list){
        					for(var i=0, len = list.length||0; i < len; i++){
        						console.log(list[i]);
        					}
        			});
        		replyService.remove(19 , function(count){
        			console.log(count);
        			if(count ==="success"){
        				alert("REMOVED");
        				}
        			}, function(err){
        				alert('error occurred..');
        			
        		});
        		
        		replyService.update({ rno:4, bno:bnoValue, reply:"modified reply....."},function(result){
        			alert("수정 완료");        		
        		});
        		
        		replyService.get(4, function(data){
        			console.log(data);
        		}); */
        		

        		var operForm = $("#operForm");
        		$('button[data-oper="modify"]').on("click",function(e){
        			operForm.attr("action","/board/modify").submit();
        		});
        		
        		$('button[data-oper="list"]').on("click",function(e){
        			operForm.find("#bno").remove();
        			operForm.attr("action","/board/list");
        			operForm.submit();
        		});
        		
        		
        	});
        </script>
		<jsp:include page="../includes/footer.jsp"/>
    