<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div>
	<h1>게시글 목록</h1>
	<form name="frm">
		<input type="hidden" name="page" value="${page}">
		<input type="text" name="keyword" value="${keyword}">
		<input type="submit" value="검색">
		<span>검색수: ${pm.totalCount}</span>
	</form>	
	<table>
		<tr class="title">
			<td width=100>No</td>
			<td width=500>Title</td>
			<td width=100>Writer</td>
			<td width=250>Date</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr class="row">
				<td>${vo.bno}</td>
				<td>${vo.title}</td>
				<td>${vo.writer}</td>
				<td><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mmd:ss"/></td>
			</tr>	
		</c:forEach>
	</table>
	<div class="pagination">
		<c:if test="${pm.prev}">
			<a href="${pm.startPage-1}">&laquo;</a>
		</c:if>
		<c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
			<a href="${i}" class=<c:out value="${page==i?'active':''}"/>>${i}</a>
		</c:forEach>
		<c:if test="${pm.next}">
			<a href="${pm.endPage+1}">&raquo;</a>
		</c:if>
	</div>
</div>

<script>
	$(frm).on("submit", function(e){
		e.preventDefault();
		$(frm.page).val(1);
		frm.submit();
	});
	
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		var page=$(this).attr("href");
		$(frm.page).val(page);
		frm.action="list";
		frm.submit();
	})
</script>