<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, org.conan.domain.BoardVO" %>
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
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-6 -->
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
        <script src="/resources/js/reply.js"></script>
        <script type="text/javascript">
        	$(document).ready(function(){
        		
        		var bnoValue = '<c:out value="${board.bno}"/>';
        		
        		replyService.add({
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
        		});
        		
        		console.log(replyService);
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
    