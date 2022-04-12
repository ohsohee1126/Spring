<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div id="page">
	<h1>통장목록</h1>
	<table>
		<tr class="title">
			<td width=100>계좌번호</td>
			<td width=100>계좌주명</td>
			<td width=200>통장개설일</td>
			<td width=100>잔액</td>
			<td width=100>통장내역</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr class="row center">
				<td>${vo.ano}</td>
				<td>${vo.aname}</td>
				<td><fmt:formatDate value="${vo.openDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
				<td><fmt:formatNumber value="${vo.balance}" pattern="#,###"/></td>
				<td><button onClick="location.href='read?ano=${vo.ano}'">통장내역</button>
			</tr>
		</c:forEach>
	</table>
</div>