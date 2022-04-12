<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="card" style="margin-top:30px; padding:20px;">
	<form name="frm">
		<input type="hidden" name="page" value="${page}">
		<input type="hidden" value="${vo.bno}" name="bno">
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label">Writer</label>
			  <input value="${vo.writer}" name="writer" type="text" readonly class="form-control" id="exampleFormControlInput1" placeholder="Writer">
		</div>
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label">Title</label>
			  <input value="${vo.title}"name="title" type="text" class="form-control" id="exampleFormControlInput1" placeholder="Title">
		</div>		
		<div class="mb-3">
			  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
			  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="5">${vo.content}</textarea>
		</div>
		<div class="mb-3">
			<button type="submit" class="btn btn-warning">MODIFY</button>
			<button type="reset"  class="btn btn-secondary">RESET</button>
			<button type="submit" class="btn btn-danger">DELETE</button>
			<button type="submit" class="btn btn-success">GO LIST</button>
		</div>
	</form>
</div>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
	});
	
	$(".btn-success").on("click", function(){
		frm.method="get";
		frm.action="list";
		frm.submit();
	});
	
	$(".btn-danger").on("click", function(){
		if(!confirm("게시물을 삭제하실래요?")) return;
		frm.method="post";
		frm.action="delete";
		frm.submit();
	});
	
	$(".btn-warning").on("click", function(){
		if(!confirm("게시물을 수정하실래요?")) return;
		frm.method="post";
		frm.action="update";
		frm.submit();
	});
</script>

<script>

</script>
