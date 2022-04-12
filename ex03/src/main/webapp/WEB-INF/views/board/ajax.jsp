<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div>
	<h1>게시판목록(Ajax)</h1>
	
	<form name="frm" style="margin-bottom:10px;">
		<input type="hidden" name="bno">
		<input type="text" name="keyword" value="${cri.keyword}">
		<input type="hidden" name="page" value="${cri.page}">
		<input type="submit" value="검색" id="search">
	</form>
	
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr class="title">
			<td width=100>No</td>
			<td width=500>Title</td>
			<td width=100>Writer</td>
			<td width=250>Date</td>
		</tr>
		{{#each list}}
		<tr class="row" bno="{{bno}}">
			<td>{{bno}}</td>
			<td>{{title}}</td>
			<td>{{writer}}</td>
			<td>{{regdate}}</td>
		</tr>
		{{/each}}
	</script>
	<div class="pagination"></div>
</div>
<script>
	var page=$(frm.page).val();
	var keyword=$(frm.keyword).val();
	getList();
	
	function getList(){
		keyword = $(frm.keyword).val();
		$.ajax({
			type: "get",
			url: "/board/list.json",
			dataType: "json",
			data: {page:page, keyword:keyword},
			success: function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#tbl").html(temp(data));
				
				//페이지목록출력
				var str="";
				if(data.pm.prev) str+="<a href='"+(data.pm.startPage-1)+"'>&laquo;</a>";
				for(var i=data.pm.startPage; i<=data.pm.endPage; i++){
					var active = data.pm.cri.page==i ? 'active':'';
					str += "<a href='" + i + "' class=" + active + ">" + i + "</a>";
				}
				if(data.pm.next) str+="<a href='"+(data.pm.endPage+1)+ "'>&raquo;</a>";
				$(".pagination").html(str);
			}
		});
	}
	
	$("#tbl").on("click",".row", function(){
		var bno=$(this).attr("bno");
		$(frm.bno).val(bno);
		frm.action="read";
		frm.submit();
	});
	
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		$(frm.page).val(page);
		getList();
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		getList();
	})
</script>
