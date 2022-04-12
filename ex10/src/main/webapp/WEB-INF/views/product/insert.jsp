<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="page">
	<h1>상품등록</h1>
	<form name="frm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td width=100 class="title">상품이름</td>
				<td width=500><input type="text" name="title" size=50></td>
			</tr>
			<tr>
				<td width=100 class="title">상품가격</td>
				<td width=500><input type="text" name="price" size=5> 원</td>
			</tr>
			<tr>
				<td width=100 class="title">상품이미지</td>
				<td width=500>
					<input type="file" name="file" style="display:none" accept="image/*">
					<img id="image" src="https://via.placeholder.com/300x200" width=300>
				</td>
			</tr>
		</table>
		<div style="text-align:center;padding-top:20px;">
			<input type="submit" value="상품등록">
			<input type="reset" value="등록취소">
		</div>
	</form>
</div>
<script>
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
		}else if(file==""){
			alert("상품이미지를 선택하세요!");
			return;
		}
		if(!confirm("상품을 등록하실래요?")) retun;
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
