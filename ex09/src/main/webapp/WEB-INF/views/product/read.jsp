<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
	.container {
		width:900px;
		margin: 0px auto;
		overflow: hidden;
	}
	
	.image {
		width: 400px;
		float: left;
		padding-top:100px;
	}
	
	.info {
		width: 400px;
		float: left;
		padding: 20px;
	}
	
	.info .content {
		border-top: 1px solid gray;
		padding-top: 10px;
	}
</style>
<div id="page">
	<h1>상품 정보</h1>
	<div class="container">
		<div class="image">
			<img src="/display?fileName=${vo.image}" width=400>
		</div>
		<div class="info">
			<h3>
				${vo.title}
				<c:if test="${vo.isDelete==1}"><span style="color:red;">품절상품</span></c:if>
			</h3>
			<h4><fmt:formatNumber value="${vo.price}" pattern="#,###원"/> </h4>
			<div class="content">${vo.content}</div>
		</div>
		<button onClick="location.href='/?page=${param.page}'">목록으로이동</button>
	</div>
</div>