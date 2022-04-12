<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	select {height: 25px; width:200px;}
</style>
<div id="page">
	<h1>통장 거래 내역</h1>
	<table>
		<tr class="center">
			<td width=100 class="title">계좌번호</td>
			<td width=100>${vo.ano}</td>
			<td width=100 class="title">계좌주명</td>
			<td width=100>${vo.aname}</td>
			<td width=100 class="title">잔액</td>
			<td width=100>
				<span id="balance" style="color:red;font-weight:bold;">
					<fmt:formatNumber value="${vo.balance}" pattern="#,###"/>
				</span>
				<span id="realBalance" style="display:none">${vo.balance}</span>
			</td>
		</tr>
		<tr>
			<td class="title">이체정보</td>
			<td colspan=5>
				<select id="tno">
					<c:forEach items="${list}" var="v">
						<c:if test="${vo.ano != v.ano}">
							<option value="${v.ano}">${v.aname} (${v.ano })</option>
						</c:if>
					</c:forEach>
				</select>
				<input id="amount" type="text"> 원
				<button id="btnTrans" balance="${vo.balance}">계좌이체</button>
			</td>
		</tr>
	</table>
	<table id="tbl" style="margin-top:50px;"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>계좌번호</td>
			<td width=120>계좌주명</td>
			<td width=100>입출금</td>
			<td width=100>금액</td>
			<td width=200>거래일</td>
		</tr>
	{{#each .}}
		<tr class="row center" style="{{style type}}">
			<td>{{tno}}</td>
			<td>{{aname}}</td>
			<td>{{type}}
			<td style="text-align:right;">{{display amount}}</td>
			<td>{{tradeDate}}</td>
		</tr>
	{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(amount){
			return amount.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		});
		
		Handlebars.registerHelper("style", function(type){
			if(type=="입금"){
				return "color: red;";
			}else{
				return "color: blue;";
			}
		});
	</script>
</div>
<script>
	var ano="${vo.ano}";
	getList();
	
	$("#btnTrans").on("click", function(){
		var tno=$("#tno").val();
		var amount=$("#amount").val();
		var realBalance=$("#realBalance").val();
		
		//이체금액이 숫자가 아니거나 입력되지 않은경우
		if(amount.replace(/[0-9]/g,'') || amount==""){
			alert("이체금액을 숫자로 입력하세요!");
			$("#amount").focus();
			return;
		}else if(parseInt(amount)> parseInt(realBalance)){
			alert("잔액이 부족합니다! 현재잔액:" + balance);
			$("#amount").focus();
			return;
		}
		
		//이체하기
		if(!confirm("이체하시겠습니까?")) return;
		$.ajax({
			type: "post",
			url: "/trade/insert",
			data: {ano:ano, tno:tno, amount:amount},
			success: function(){
				$.ajax({
					type: "get",
					url: "/account/getBalance",
					data: {ano:ano},
					success: function(data){
						$("#balance").html(data.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','));
						$("#realBalance").html(data);
						$("#amount").val("")
						alert("이체완료!");
						getList();
					}
				});
			}
		});
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/trade/list",
			data: {ano:ano},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
			}
		});
	}
</script>
