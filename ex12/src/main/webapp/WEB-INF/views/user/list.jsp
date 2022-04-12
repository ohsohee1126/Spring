<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div id="page">
	<h1>사용자 목록</h1>
	<table>
		<c:forEach items="${list}" var="vo">
			<tr>
				<td width=150><img src="/display?fileName=${vo.image}" width=150></td>
				<td width=50>${vo.uid}</td>
				<td width=400><b>${vo.zipcode}</b><br>${vo.address1}<br>${vo.address2}</td>
				<td width=100>${vo.uname}</td>
			</tr>
		</c:forEach>
	</table>
</div>