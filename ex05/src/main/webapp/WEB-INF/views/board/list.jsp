<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>게시글 목록</h1>
	<div style="width:880px;margin:0px auto;margin-bottom:10px;">
		<input type="text" id="keyword" value="${param.keyword}">
		<input type="button" id="search" value="검색">
	</div>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>No.</td>
			<td width=300>Title</td>
			<td width=100>Writer</td>
			<td width=200>Date</td>
			<td width=100>View</td>
			<td width=100>Reply</td>
		</tr>
		{{#each list}}
			<tr class="row" bno="{{bno}}">
				<td>{{bno}}</td>
				<td width=400 class="ellipsis">{{title}}</td>
				<td>{{writer}}</td>
				<td>{{regdate}}</td>
				<td>{{viewcnt}}</td>
				<td>{{replycnt}}</td>
			</tr>
		{{/each}}
	</script>
	<div class="pagination"></div>
</div>
<script>
	var page="${param.page==null ? 1: param.page}";
	var keyword="${param.keyword==null ? '': param.keyword}";
	getList();
	
	$("#tbl").on("click", ".row", function(){
		var bno=$(this).attr("bno");
		location.href="read?bno="+ bno + "&page=" + page + "&keyword="+keyword;
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/board/list.json",
			dataType: "json",
			data: {page:page, keyword:keyword},
			success: function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				$(".pagination").html(getPagination(data));
			}
		});
	}
	
	//페이지번호를 클릭한 경우
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
	//검색버튼을 클릭한 경우
	$("#search").on("click", function(){
		keyword=$("#keyword").val();
		page=1;
		getList();
	});
	//검색어 입력상자에서 엔터를 친경우
	$("#keyword").on("keypress", function(e){
		if(e.keyCode==13) $("#search").click();
	});
</script>