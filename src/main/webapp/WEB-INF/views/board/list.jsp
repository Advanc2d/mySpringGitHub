<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*, org.conan.domain.BoardVO"%>
<%-- <%
	ArrayList<BoardVO> board = (ArrayList<BoardVO>)request.getAttribute("list"); 
%>  
<c:set var="list" value="<%=board %>"/> --%>

<jsp:include page="../includes/header.jsp" />

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
				<div class="panel-heading">게시글 목록
					<button id='regBtn' type="button" class="btn btn-xs btn-success pull-right">글쓰기</button>
				</div>
				<!-- /.panel-heading -->
				<div class="panel-body">
					<!-- <table width="100%"
						class="table table-striped table-bordered table-hover"
						id="dataTables-example"> -->
						<table width="100%"
						class="table table-striped table-bordered table-hover">
						<thead>
							<tr>
								<th>#번호</th>
								<th>제목</th>
								<th>작성자</th>
								<th>작성일</th>
								<th>수정일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="board" items="${list }">
								<tr class="odd gradeX">
									<td>${board.bno }</td>
									<td><a class="move" href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>
									<td>${board.writer }</td>
									<td class="center">${board.regDate }</td>
									<td class="center">${board.updateDate }</td>
								</tr>
							</c:forEach>

						</tbody>
					</table>
					<div class='row'>
						<div class="col-lg-12">
						<form id='searchForm' action='/board/list' method='get'>
							<select name='type'>
								<option value="" <c:out value="${pageMaker.cri.type==null?'selected':'' }"/>>____</option>
								<option value="T" <c:out value="${pageMaker.cri.type eq 'T'?'selected':'' }"/>>제목</option>
								<option value="C" <c:out value="${pageMaker.cri.type eq 'C'?'selected':'' }"/>>내용</option>
								<option value="W" <c:out value="${pageMaker.cri.type eq 'W'?'selected':'' }"/>>작성자</option>
								<option value="TC" <c:out value="${pageMaker.cri.type eq 'TC'?'selected':'' }"/>>제목or내용</option>
								<option value="TW" <c:out value="${pageMaker.cri.type eq 'TW'?'selected':'' }"/>>제목or작성자</option>
								<option value="TCW" <c:out value="${pageMaker.cri.type eq 'TCW'?'selected':'' }"/>>제목or내용or작성자</option>
							</select> 
							<input type='text' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'/>
							<input type='hidden' name='pageNum' value="${pageMaker.cri.pageNum }"/>
							<input type='hidden' name='amount' value="${pageMaker.cri.amount }"/>
							<button class='btn btn-info'>Search</button>
						</form>
						</div>
					</div>
					
					<div class='pull-right'>
						<ul class="pagination">
							<c:if test="${pageMaker.prev }">
								<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous</a></li>
							</c:if>
							<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
								<li class="paginate_button ${pageMaker.cri.pageNum==num?" active":""}"><a href="${num}">${num }</a></li>
							</c:forEach>
							<c:if test="${pageMaker.next }">
								<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
							</c:if>
						</ul>
					</div><!-- Pagination 끝 -->
					<form id='actionForm' action="/board/list" method='get'>
						<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
						<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
						<input type='hidden' name='type' value='${pageMaker.cri.type }'>
						<input type='hidden' name='keyword' value='${pageMaker.cri.keyword }'>
					</form>
					<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
						aria-labelledby="myModalllabel" aria-hidden="true">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal"
										aria-hidden="true">&times;</button>
									<h4 class="modal-title" id="myModalLabel">Modal title</h4>
								</div>
								<div class="modal-body">처리가 완료되었습니다.</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-default"
										data-dismiss="modal">Close</button>
									<button type="button" class="btn btn-default">Save
										Changes</button>
								</div>
							</div>
						</div>
					</div>
					<!-- /.modal fade -->

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
         var result = '<c:out value="${result}"/>';
         checkModal(result);
         /* history.replaceState({},null,null); 
         	모달이 그냥 뜰 때 처리해주기 위해서 설정해주기 위해 씀
         */
         function checkModal(result){
            if(result==='' || history.state){		// 위에 history를 확인하기 위해 추가
               return;
            }
            if(parseInt(result)>0){
               $(".modal-body").html(
               "게시글"+parseInt(result)+"번이 등록되었습니다."      
               )
            }
            $("#myModal").modal("show");
         }
      });
      
      </script>
      <script>
	      $("#regBtn").on("click",function(){
	          self.location = "/board/register";
	       });//버튼 클릭시 등록창으로 이동
      </script>
      
      <script>
       var actionForm = $("#actionForm");
	     $(".paginate_button a").on("click",function(e){
	    	e.preventDefault();
	    	/* console.log('click'); */
	    	actionForm.find("input[name='pageNum']").val($(this).attr("href"));
	    	actionForm.submit();
	     });
      </script>
      
      <script>
       $(".move").on("click",function(e){
    	  e.preventDefault();
    	  //console.log("click");
    	  actionForm.append("<input type='hidden' name='bno' value='" + $(this).attr("href") + "'>");
    	  actionForm.attr("action","/board/get");
    	  actionForm.submit();
       });
      </script>
	<script>
		var searchForm = $("#searchForm");
		$("#searchForm button").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색 종류를 선택하세요");						
				return false;
			}
			if(!searchForm.find("input[name='keyword']").val()){
				alert("키워드를 입력하세요");						
				return false;
			}
			searchForm.find("input[name='pageNum']").val("1");
			e.preventDefault();
			searchForm.submit();
		});
					</script>
<jsp:include page="../includes/footer.jsp" />

