<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<form name="frm">
	<table>
		<tr>
			<td width=100>아이디</td>
			<td width=300><input type="text" name="id"></td>
		</tr>
		
		<tr>
			<td width=100>비밀먼호</td>
			<td width=300><input type="password" name="pass"></td>
		</tr>
		
		<tr>
			<td width=100>비밀먼호체크</td>
			<td width=300><input type="password" name="passCheck"></td>
		</tr>
		
		<tr>
			<td width=100>이미지</td>
			<td width=300><input type="file" name="image"></td>
		</tr>
		
		<tr>
			<td width=100>이름</td>
			<td width=300><input type="text" name="name"></td>
		</tr>
		
		<tr>
			<td width=100>전화</td>
			<td width=300><input type="number" name="tel"></td>
		</tr>
		
		<tr>
			<td width=100>생일</td>
			<td width=300><input type="" name="birthday"></td>
		</tr>
		
		<tr>
			<td width=100>성별</td>
			<td width=300><input type="" name="gender"></td>
		</tr>
		
		<tr>
			<td width=100>이메일</td>
			<td width=300><input type="text" name="email"></td>
		</tr>
		
		<tr>
			<td width=100>우편번호</td>
			<td width=300><input type="" name="zipcode"></td>
		</tr>
		
		<tr>
			<td width=100>주소</td>
			<td width=300><input type="text" name="address"></td>
		</tr>
		
	
		<tr>
			<td colspan=2 style="text-align:center;">
				<input type="submit" value="로그인">
				<input type="checkbox" name="isLogin">로그인 상태유지
			</td>
		</tr>
	</table>
</form>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		var id=$(frm.id).val();//아이디
		var pass=$(frm.pass).val();//비밀번호
		var passCheck=$(frm.passCheck).val();//비밀번호체크
		var image=$(frm.image).val();//이미지
		var name=$(frm.name).val();//이름
		var tel=$(frm.tel).val();//전화
		var birthday=$(frm.birthday).val();//생일
		var gender=$(frm.gender).val();//성별
		var email=$(frm.email).val();//이메일
		var zipcode=$(frm.zipcode).val();//우편변호
		var address=$(frm.address).val();//주소
		
		
		$.ajax({
			type: "post",
			url: "/user/login",
			data: {id:uid, pass:pass,passCheck:passCheck,image:image,name:name,tel:tel,bi},
			success: function(data){
				if(data==0) {
					alert("아이디가 존재하지 않습니다.");
				}else if(data==2){
					alert("비밀번호가 일치하지 않습니다.");
				}else if(data==2){
					alert("이미지를 선택해주세요!");
				}else if(data==2){
					alert("이름을 입력하세요!");
				}else if(data==2){
					alert("전화변호를 입력하세요!");
				}else if(date==2){
				    alert("생일을 입력해주세요!");
				}else if(date==2){
					alert("성별을 클릭해주세요!");
				}else if(date==2){
					alert("이메일을 입력해주세요!");
				}else if(date==2){
					alert("우편번호을 입력해주세요!");
				}else if(date==2){
					alert("주소을 입력해주세요!");
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
