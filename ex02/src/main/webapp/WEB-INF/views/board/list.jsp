<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<form name="frm">
	<input type="hidden" name="page" value="${pm.cri.page}">
	<input type="hidden" name="bno">
</form>

<div class="card" style="margin-top:30px; padding:20px;">
	<table class="table">
	  <thead>
	    <tr>
	      <th scope="col">No.</th>
	      <th scope="col">Title</th>
	      <th scope="col">Writer</th>
	      <th scope="col">Date</th>
	    </tr>
	  </thead>
	  <tbody>
	  	<c:forEach items="${list}" var="vo">
	    <tr>
	      <th scope="row">${vo.bno}</th>
	      <td><a href="${vo.bno}">${vo.title}</a></td>
	      <td>${vo.writer}</td>
	      <td><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
	    </tr>
	    </c:forEach>
	  </tbody>
	</table>
	<nav aria-label="Page navigation example" style="margin:0px auto;">
	  <ul class="pagination">
	  	<!-- 이전버튼 -->
	    <li class="page-item">
	    	<c:if test="${pm.prev}">
		      <a class="page-link" href="${pm.startPage-1}" aria-label="Previous">
		        <span aria-hidden="true">&laquo;</span>
		      </a>
	      	</c:if>
	    </li>
	    <c:forEach begin="${pm.startPage}" end="${pm.endPage}" var="i">
	    	<c:if test="${pm.cri.page==i}">
	    		<li class="page-item active"><a class="page-link" href="${i}">${i}</a></li>
	    	</c:if>	
	    	<c:if test="${pm.cri.page!=i}">
	    		<li class="page-item"><a class="page-link" href="${i}">${i}</a></li>
	    	</c:if>
	    </c:forEach>
	    <!-- 다음버튼 -->
		<c:if test="${pm.next}">
		    <li class="page-item">
		      <a class="page-link" href="${pm.endPage+1}" aria-label="Next">
		        <span aria-hidden="true">&raquo;</span>
		      </a>
		    </li>
	    </c:if>
	  </ul>
	</nav>
</div>
<script>
	$(".pagination").on("click", ".page-link", function(e){
		e.preventDefault();
		var page=$(this).attr("href");
		location.href='/board/list?page=' + page;
	});
	
	$(".table").on("click", "tr td a", function(e){
		e.preventDefault();
		var bno=$(this).attr("href");
		$(frm.bno).val(bno);
		frm.action="read";
		frm.submit();
	});
</script>

