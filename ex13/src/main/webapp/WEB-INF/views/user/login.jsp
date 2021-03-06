<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form name="frm">
	<table>
		<tr>
			<td width=100>아이디</td>
			<td width=300><input type="text" name="uid"></td>
		</tr>
		<tr>
			<td width=100>아이디</td>
			<td width=300><input type="password" name="upass"></td>
		</tr>
		<tr>
			<td colspan="2"><button type="submit">로그인</button></td>
		</tr>
	</table>
</form>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var uid=$(frm.uid).val();
		var upass=$(frm.upass).val();
		
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {uid:uid, upass:upass},
			success: function(data){
				if(data==0) {
					alert("아이디가 존재하지 않습니다.");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다.");
				}else {
					var dest="${dest}";
					if(dest==null || dest==""){
						location.href="/";
					}else{
						location.href=dest;
					}
				}
			}
		});
	});
</script>