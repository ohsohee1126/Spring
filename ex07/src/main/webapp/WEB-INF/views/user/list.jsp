<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<div id="page">
	<h1>메시지관리</h1>
	<table>
		<tr class="title">
			<td width=100>아이디</td>
			<td width=200>이름</td>
			<td width=100>포인트</td>
			<td width=200>보낸메시지</td>
			<td width=200>받은메시지</td>
		</tr>
		<c:forEach items="${list}" var="vo">
			<tr>
				<td>${vo.uid}</td>
				<td>${vo.uname}</td>
				<td>${vo.point}</td>
				<td><button onClick="location.href='send?uid=${vo.uid}'">보낸메시지[${vo.sendcnt}]</button></td>
				<td><button onClick="location.href='receive?uid=${vo.uid}'">받은메시지[${vo.rececnt}]</button></td>		
			</tr>
		</c:forEach>
	</table>
</div>