<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.subject {width: 400px;}
</style>
<div id="page">
	<h1>게시판 목록</h1>
	<div style="padding-left:30px;border-bottom:1px solid gray;">
		<form name="frm">
			<input type="text" name="keyword" value="${param.keyword}">
			<input type="submit" value="검색">
			검색수: <span id="count"></span>
		</form>
	</div>
	
	<table id="tbl" width=900></table>
	<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<tr class="row">
			<td class="bno">{{bno}}</td>
			<td><p class="ellipsis subject">{{title}}</p></td>
			<td>{{writer}}</td>
			<td>{{regdate}}</td>
		</tr>
	{{/each}}
	</script>
	<div class="pagination"></div>
</div>
<script>
	var page="${param.page==null ? 1: param.page}";
	var keyword=$(frm.keyword).val();
	getList();
	
	$("#tbl").on("click", ".row", function(){
		var bno=$(this).find(".bno").html();
		location.href="read?bno=" + bno + "&page=" + page + "&keyword=" + keyword;
	});
	function getList(){
		$.ajax({
			type: "get",
			url: "/board/list.json",
			data: {page:page, keyword:keyword},
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
				$(".pagination").html(getPagination(data));
				$("#count").html(data.pm.totalCount + "건")
			}
		});
	}
	
	$(".pagination").on("click","a",function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		page=1;
		keyword=$(frm.keyword).val();
		getList();
	});
</script>
