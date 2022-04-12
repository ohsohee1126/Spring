<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.content {width: 960px; margin:0px auto; overflow: hidden; margin-bottom: 30px;}
	.image {width: 450px; float: left;}
	.info {width: 450px; float: left;}
	.item {width: 200px; display: block; float:left; border:1px solid gray; padding: 10px;}
</style>
<div id="page">
	<div class="content">
		<div class="image">
			<img src="/display?fileName=${vo.image}" width=400>
		</div>
		<div class="info">
			<h2>${vo.title}</h2>
			<h2><fmt:formatNumber value="${vo.price}" pattern="#,###"/></h2>
			<c:if test="${vo.qnt ==0}">
				<h2 style="color:red;">품절상품</h2>
			</c:if>
			<c:if test="${vo.qnt !=0}">
				<h2><fmt:formatNumber value="${vo.qnt}" pattern="#,###"/>개</h2>
			</c:if>
		</div>
	</div>
	<hr/>
	<div style="width:900px; margin:0px auto; overflow:hidden;padding:10px 0px;">
		<span class="item detail"><a href="#">상세페이지</a></span>
		<span class="item review"><a href="#">후기/문의</a></span>
		<span class="item delivery"><a href="#">배송정보</a></span>
	</div>
	<div id="detail" style="padding-top:30px;">
		<p>${vo.content}</p>
	</div>
	<div id="review" style="display:none;">
		<h1>후기/문의</h1>
	</div>
	<div id="delivery" style="display:none;">
		<h1>배송정보</h1>
		<img src="/resources/delivery.jpg"/>
	</div>
</div>

<script>
	$(".review").on("click", "a", function(e){
		e.preventDefault();
		$("#detail").hide();
		$("#delivery").hide();
		$("#review").show();
	});
	
	$(".detail").on("click", "a", function(e){
		e.preventDefault();
		$("#detail").show();
		$("#delivery").hide();
		$("#review").hide();
	});
	
	$(".delivery").on("click", "a", function(e){
		e.preventDefault();
		$("#detail").hide();
		$("#delivery").show();
		$("#review").hide();
	});
</script>