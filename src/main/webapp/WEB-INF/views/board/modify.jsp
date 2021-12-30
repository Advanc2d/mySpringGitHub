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
        </div>
        <!-- /#page-wrapper -->
        <script type="text/javascript">
        	$(document).ready(function(){
        		var formObj = $("form");
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

        			}
        			formObj.submit();
        		});
        	});
        </script>
		<jsp:include page="../includes/footer.jsp"/>
    