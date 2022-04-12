<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<div style="width:900px; margin:0px auto; margin-top:50px;margin-bottom:200px;">
	<form name="frm">
		<input type="text" name="page" value="${cri.page}">
		<input type="text" name="keyword" value="${cri.keyword}">
	</form>
	
	<h1>게시글 정보</h1>
	<span><a href="#" id="go">목록이동</a></span>
	<hr/>
	<h3>${vo.title}</h3>
	<h4>
		<fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mmd:ss"/> 
		(${vo.writer})
	</h4>
	<hr/>
	<p>${vo.content}</p>
</div>
<script>
	$("#go").on("click", function(e){
		e.preventDefault();
		frm.action="ajax";
		frm.submit();
	});
</script>