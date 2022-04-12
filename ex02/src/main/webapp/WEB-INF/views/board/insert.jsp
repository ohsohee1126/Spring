<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="card" style="margin-top:30px; padding:20px;">
	<form action="insert" method="post">
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label">Writer</label>
			  <input name="writer" type="text" value="red" readonly class="form-control" id="exampleFormControlInput1" placeholder="Writer">
		</div>
		<div class="mb-3">
			  <label for="exampleFormControlInput1" class="form-label">Title</label>
			  <input name="title" type="text" class="form-control" id="exampleFormControlInput1" placeholder="Title">
		</div>		
		<div class="mb-3">
			  <label for="exampleFormControlTextarea1" class="form-label">Content</label>
			  <textarea name="content" class="form-control" id="exampleFormControlTextarea1" rows="5"></textarea>
		</div>
		<div class="mb-3">
			<button type="submit" class="btn btn-primary">REGISTER</button>
			<button type="reset"  class="btn btn-secondary">RESET</button>
		</div>
	</form>
</div>
