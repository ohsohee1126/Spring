<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.image, .link, .date, .percent {
		display:none;
	}
</style>
<div id="page">
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr>
			<td><input type="checkbox" id="chkAll"></td>
			<td><button id="insert">선택영화저장</button>
		</tr>
	{{#each array}}
		<tr>
			<td><input type="checkbox" class="chk"></td>
			<td>
				<p class="title">{{title}}</p>
				<p class="image">{{image}}</p>
				<p class="link">{{link}}</p>
				<p class="date">{{date}}</p>
				<p class="percent">{{percent}}</p>
			</td>
		</tr>
	{{/each}}
	</script>
</div>
<script>
	var page=1;
	getList();
	
	$("#tbl").on("click", "#insert", function(){
		if(!confirm("선택한 영화들을 저장하실래요?")) return;
		
		$("#tbl tr td .chk:checked").each(function(){
			var chk=$(this);
			var tr=$(this).parent().parent();
			var title=tr.find(".title").text();
			var image=tr.find(".image").text();
			var link=tr.find(".link").text();
			var odate=tr.find(".date").text();
			var percent=tr.find(".percent").text();
			
			$.ajax({
				type: "post",
				url: "/movie/insert",
				data: {title:title,image:image,link:link,odate:odate,percent:percent},
				success: function(){
					chk.prop("checked",false);
				}
			});
		});
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/crawl/cgv.json",
			dataType: "json",
			data: {page:page},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
			}
		});
	}
</script>