<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://cdn.ckeditor.com/4.16.2/standard/ckeditor.js"></script>

<div id="page">
	<h1>상품수정</h1>
	<form name="frm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td width=100 class="title">상품번호</td>
				<td width=500><input value="${vo.code}" readonly type="text" name="code" size=5></td>
			</tr>
			<tr>
				<td width=100 class="title">상품이름</td>
				<td width=500><input value="${vo.title}" type="text" name="title" size=50></td>
			</tr>
			<tr>
				<td width=100 class="title">상품가격</td>
				<td width=500><input value="${vo.price}" type="text" name="price" size=5> 원</td>
			</tr>
			<tr>
				<td width=100 class="title">상품이미지</td>
				<td width=500>
					<input type="file" name="file" style="display:none" accept="image/*">
					<img id="image" src="/display?fileName=${vo.image}" width=300>
					<input type="hidden" name="image" value="${vo.image}">
				</td>
			</tr>
		</table>
		<div style="margin-top:20px;">
			<textarea id="editor" rows="100" cols="80" name="content">${vo.content}</textarea>
		</div>
		<div style="text-align:center;padding-top:20px;">
			<input type="submit" value="상품수정">
			<input type="reset" value="수정취소">
			<input type="button" value="목록이동" id="btnList">
		</div>
	</form>
</div>
<script>
	//ckEditor출력
	var ckeditor_config = {
		 resize_enable : false, //editor 사이즈를 변경하지 못한다. 
		 enterMode : CKEDITOR.ENTER_BR, 
		 shiftEnterMode : CKEDITOR.ENTER_P, 
		 filebrowserUploadUrl : "/ckupload", 
		 height: 300
	 };
 	CKEDITOR.replace('editor', ckeditor_config)
 
	//목록이동 버튼을 클릭한 경우
	$("#btnList").on("click", function(){
		var page="${param.page}";
		var keyword="${param.keyword}";
		location.href="list?page=" + page + "&keyword=" + keyword;
	});
	
	//Submit 버튼을 클릭한 경우
	$(frm).on("submit", function(e){
		e.preventDefault();
		var title=$(frm.title).val();
		var file=$(frm.file).val();
		var price=$(frm.price).val();
		
		if(title==""){
			alert("상품이름을 입력하세요!");
			$(frm.title).focus();
			return;
		}else if(price == "" || price.replace(/[0-9]/g,'')){
			alert("상품가격을 숫자로 입력하세요!");
			$(frm.price).focus();
			return;
		}
		if(!confirm("상품을 수정하실래요?")) retun;
		frm.submit();
	});
	
	//이미지 미리보기
	$("#image").on("click", function(){
		$(frm.file).click();
	});
	
	$(frm.file).on("change", function(e){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
</script>
