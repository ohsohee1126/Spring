<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	input[type=text]{margin-bottom:10px;}
</style>    
<div id="page">
	<h1>회원정보</h1>
	<form name="frm" method="post"  enctype="multipart/form-data">
		<table>
			<tr>
				<td class="title" width=100>아이디</td>
				<td width=500>
					<input type="text" name="uid" value="${vo.uid}" readonly>
				</td>
			</tr>
			<tr>
				<td class="title" width=100>비밀번호</td>
				<td width=500><input type="password" name="upass" value="${vo.upass}"></td>
			</tr>
			<tr>
				<td class="title" width=100>이름</td>
				<td width=500><input type="text" name="uname" value="${vo.uname}"></td>
			</tr>
			<tr>
				<td class="title" width=100>주소</td>
				<td width=500>
					<input type="text" name="zipcode" size=5 value="${vo.zipcode}">
					<button type="button" id="search">주소검색</button><br>
					<input type="text" name="address1" value="${vo.address1}" size=50><br>
					<input type="text" name="address2" value="${vo.address2}" size=30>
				</td>
			</tr>
			<tr>
				<td class="title" width=100>사진</td>
				<td>
					<input type="file" name="file" style="display:none;">
					<img src="/display?fileName=${vo.image}" id="image" width=150>
					<input type="hidden" name="image" value="${vo.image}">
				</td>
			</tr>
		</table>
		<div style="text-align:center;margin-top:10px;">
			<button type="submit">정보수정</button>
			<button type="reset">수정취소</button>
		</div>
	</form>
</div>

<script>
	$("#search").on("click", function(){
		new daum.Postcode({
			oncomplete: function(data){
				console.log(data);
				$(frm.address1).val(data.address);
				$(frm.zipcode).val(data.zonecode);
				$(frm.address1).focus();
			}
		}).open();	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		
		var upass=$(frm.upass).val();
		var uname=$(frm.uname).val();
		var file=$(frm.file).val();
		
		if(upass==""){
			alert("비밀번호를 입력하세요!");
			$(frm.upass).focus();
			return;
		}else if(uname=="") {
			alert("이름을 입력하세요!");
			$(frm.uname).focus();
			return;
		}else{
			if(!confirm("회원정보를 수정 하실래요?")) return;
			frm.submit();
		}
	});
	
	$(frm.file).on("change", function(e){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
	
	$("#image").on("click", function(){
		$(frm.file).click();
	})
</script>