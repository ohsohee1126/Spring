<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="page">
	<h1>상품 수정</h1>
	<form name="frm" method="post" enctype="multipart/form-data">
		<table>
			<tr>
				<td class="title" width=100>상품번호</td>
				<td width=700>
					<input value="${vo.code}" readonly type="text" name="code" size=5>
				</td>
			</tr>
			<tr>
				<td class="title" width=100>상품이름</td>
				<td width=700><input value="${vo.title}" type="text" name="title" size=80></td>
			</tr>
			<tr>
				<td class="title" width=100>상품가격</td>
				<td width=700><input value="${vo.price}" type="text" name="price" size=8> 원</td>
			</tr>
			<tr>
				<td class="title" width=100>상품이미지</td>
				<td width=700>
					<img id="image" src="/display?fileName=${vo.image}" width=300/>
					<input type="file" name="file" accept="image/*" style="display:none;">
					<input type="hidden" value="${vo.image}" name="image"/>
				</td>
			</tr>
			<tr>
				<td class="title" width=100>상품설명</td>
				<td width=700>
					<textarea rows="10" cols="80" name="content">${vo.content}</textarea>
				</td>
			</tr>
		</table>
		<div style="text-align:center;margin-top:20px;">
			<input type="submit" value="상품수정">
			<input type="reset" value="수정취소">
			<input type="button" onClick="location.href='list?page=${param.page}'" value="목록이동">
		</div>
	</form>
</div>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var title=$(frm.title).val();
		var price=$(frm.price).val();

		if(title==""){
			alert("상품명을 입력하세요!");
			$(frm.title).focus();
			return;
		}else if(price=="" || price.replace(/[0-9]/g,'')){
			alert("가격을 숫자로 입력하세요!");
			$(frm.price).focus();
			return;
		}
		
		if(!confirm("상품을 수정하실래요?")) return;
		frm.submit();
	});

	$("#image").on("click", function(){
		$(frm.file).click();	
	});
	
	//이미지 미리보기
	$(frm.file).on("change", function(){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
</script>