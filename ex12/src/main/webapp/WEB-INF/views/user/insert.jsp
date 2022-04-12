<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<div id="page">
	<h1>회원가입</h1>
	<form name="frm" method="post" action="insert" enctype="multipart/form-data">
		<table>
			<tr>
				<td class="title" width=100>아이디</td>
				<td width=500>
					<input type="text" name="uid">
					<button type="button" id="check">아이디중복체크</button>
				</td>
			</tr>
			<tr>
				<td class="title" width=100>비밀번호</td>
				<td width=500><input type="password" name="upass"></td>
			</tr>
			<tr>
				<td class="title" width=100>이름</td>
				<td width=500><input type="text" name="uname"></td>
			</tr>
			<tr>
				<td class="title" width=100>사진</td>
				<td>
					<input type="file" name="file" style="display:none;">
					<img src="https://via.placeholder.com/150x150" id="image" width=150>
				</td>
			</tr>
		</table>
		<div style="text-align:center;margin-top:10px;">
			<button type="submit">회원가입</button>
			<button type="reset">가입취소</button>
		</div>
	</form>
</div>

<script>
	var check=false;
	$("#check").on("click", function(){
		var uid=$(frm.uid).val();
		if(uid==""){
			alert("아이디를 입력하세요!");
			$(frm.uid).focus();
			return;
		}
		
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {uid:uid},
			success: function(data){
				if(data==0){
					alert("사용할수 있는 아이디입니다!");
					check=true;
				}else {
					alert("이미 사용중인 아이디입니다!");
				}
			}
		});
	});
	
	$(frm.uid).on("change", function(){
		check=false;	
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		
		if(!check){
			alert("아이디 중복 체크를 하세요!");
			return;
		}
		
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
		}else if(file=="") {
			alert("이미지를 선택하세요!")
		}else{
			if(!confirm("회원을 등록하실래요?")) return;
			frm.submit();
		}
	});
	
	$(frm.file).on("change", function(e){
		var file=$(frm.file)[0].files[0];
		$("#image").attr("src", URL.createObjectURL(file));
	});
	
	$("#image").on("click", function(){
		$(frm.file).click();
	});
	
	$("#search").click(function(){
		 new daum.Postcode({
		 	oncomplete: function(data) {
		 		console.log(data)
		 		$(frm.address).val(data.zonecode);
		 	}
		}).open();
	});
</script>