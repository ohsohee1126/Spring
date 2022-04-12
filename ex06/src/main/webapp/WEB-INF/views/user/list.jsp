<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	td {text-align:center;}
	#box {margin:50px 0px;}
</style>
<div id="box">
	<table id="tbl">
		<tr class="title">
			<td width=200>아이디</td>
			<td width=200>성명</td>
			<td width=100>포인트</td>
			<td width=200>보낸메시지</td>
			<td width=200>받은메시지</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr>
				<td class="uid">${vo.uid}</td>
				<td>${vo.uname}</td>
				<td>${vo.point}</td>
				<td><button class="send">보낸메시지</button></td>
				<td><button class="receive">받은메시지</button></td>
			</tr>
		</c:forEach>
	</table>
</div>
<script>
	$("#tbl").on("click", ".send", function(){
		var uid=$(this).parent().parent().find(".uid").html();
		location.href="read?uid="+ uid;
	});
	$("#tbl").on("click", ".receive", function(){
		var uid=$(this).parent().parent().find(".uid").html();
		location.href="receive?uid="+ uid;
	});
</script>