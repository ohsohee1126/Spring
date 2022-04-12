<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page">
	<form name="frm">
		<table>
			<tr>
				<td class="title" width=100>아이디</td>
				<td width=200><input type="text" name="uid"></td>
			</tr>
			<tr>
				<td class="title">비밀번호</td>
				<td><input type="password" name="upass"></td>
			</tr>
			<tr>
				<td colspan=2 style="text-align:center;">
					<input type="submit" value="로그인">
					<input type="checkbox" name="isLogin">로그인 상태유지
				</td>
			</tr>
		</table>
	</form>
</div>
<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var uid=$(frm.uid).val();
		var upass=$(frm.upass).val();
		var isLogin=$(frm.isLogin).is(":checked") ? true: false;
		
		if(uid=="" || upass==""){
			alert("아이디나 비밀번호를 입력하세요!");
			$(frm.uid).focus();
			return;
		}
		
		//로그인 체크
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {uid:uid, upass:upass, isLogin:isLogin},
			success: function(data){
				if(data==0){
					alert("아이디가 존재하지 않습니다!");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다!")
				}else{
					var dest="${dest}";
					if(dest==null || dest=="") dest="/";
					location.href=dest;
				}
			}
		});
	});
</script>