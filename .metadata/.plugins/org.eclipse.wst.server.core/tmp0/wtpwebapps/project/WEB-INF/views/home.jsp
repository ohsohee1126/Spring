<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
	<title>게시판관리</title>
	<link href="/resources/home.css" rel="stylesheet" >
	<link href="/resources/bell.css" rel="stylesheet" >
	<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<script src="/resources/pagination.js"></script>
	<script type="text/javascript" src="/resources/chart.js"></script>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>
	<div id="page">
		<div id="header">
			<img src="/resources/back.jpg" width=960/>
		</div>
		<div id="menu">
			<span><a href="/">Home</a></span>
			
			
			<!-- Login check -->
			<c:if test="${uid==null}">
				<span style="float:right">
				<a href="/user/login">로그인</a></span>
				
			</c:if>
			    <c:if test="${uid!=null}">
               <span><a href="#" id="chat">채팅</a></span>
               <span style="float:right">
                  <span style="padding-right:50px;">
                     <small id="bell">
                        <small id="count">0</small>
                     </small>
                  </span>
                  <span style="color:rgb(81,117,158); font-weight: 900;">${uid} 님</span>
                  <a href="/user/logout">로그아웃</a>
               </span>
            </c:if>
			
		</div>
		<div id="content">
			<jsp:include page="${pageName}"/>
		</div>
		<div id="footer">
			<h3>Copyright 2022. 인천일보 아카데미. All Rights Reserved.</h3>
		</div>
	</div>
</body>
<script>
	$("#chat").on("click",function(e){
		e.preventDefault();
		window.open("/chat","chat","width=500,height=700,top=200,left=900");
	})
</script>
</html>
