<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#keyword {
		border:none;
		border-bottom:1px solid gray;
	}
	#keyword:focus {
		outline:none;
	}
</style>
<div style="width:800px;margin:0px auto;margin-top:30px;margin-bottom:100px;">
	<h1>게시글 목록</h1>
	<div style="margin-bottom:10px;">
		<input type="text" id="keyword" value="${param.keyword}">
		<input type="button" value="검색" id="search">
	</div>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>No</td>
			<td width=400>Title</td>
			<td width=100>Writer</td>
			<td width=200>Date</td>
		</tr>
		{{#each list}}
			<tr class="row">
				<td class="bno">{{bno}}</td>
				<td>{{title}}</td>
				<td>{{writer}}</td>
				<td>{{regdate}}</td>
			</tr>
		{{/each}}
	</script>
	<div class="pagination"></div>
</div>
<script src="/resources/pagination.js"></script>
<script>
	var page="${param.page==null?1:param.page}";
	var keyword="${param.keyword==null?'':param.keyword}";
	getList();
	
	function getList(){
		keyword = $("#keyword").val();
		$.ajax({
			type: "get",
			url: "/board/list.json",
			data: {page:page, keyword:keyword},
			dataType: "json",
			success: function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				
				//페이지목록출력
				$(".pagination").html(getPagination(data));
			}
		});
	}
	
	//row클릭한 경우
	$("#tbl").on("click", ".row", function(){
		var bno=$(this).find(".bno").html();
		location.href="read?bno=" + bno + "&page=" + page + "&keyword=" + keyword;
	});
	
	//검색버튼을 클릭한 경우
	$("#search").on("click", function(){
		page=1;
		getList();
	});
	
	//검색어상자에서 엔터를 친경우
	$("#keyword").on("keypress", function(e){
		if(e.keyCode==13) $("#search").click();
	})
	
	//페이지 번호를 클릭한 경우
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>

