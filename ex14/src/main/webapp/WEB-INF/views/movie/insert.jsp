<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="page">
	<h1>영화등록</h1>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr>
			<td colspan=3><button id="insert">선택영화저장</button></td>
		</tr>
	{{#each .}}
		<tr>
			<td><input type="checkbox" class="chk"></td>
			<td><img class="image" src="{{image}}" width=100></td>
			<td width=700>
				<div class="link">{{link}}</div>
				<div class="title">{{title}}</div>
				<div>{{percent}}</div>
				<div class="odate">{{date}}</td>
			</td>
		</tr>
	{{/each}}
	</script>
</div>
<script>
	getList();
	
	$("#tbl").on("click", "#insert", function(){
		
		if(!confirm("선택한 항목을 등록하실래요?")) return;
		
		$("#tbl tr td .chk:checked").each(function(){
			var chk=$(this);
			
			var tr=$(this).parent().parent();
			var title=tr.find(".title").text();
			var odate=tr.find(".odate").text();
			var link=tr.find(".link").text();
			odate=odate.substr(0,11);
			var image=tr.find(".image").attr("src");
			
			$.ajax({
				type:"post",
				url: "/movie/insert",
				data: {title:title,image:image,link:link,odate:odate},
				success:function(){
					chk.prop("checked", false);
				}
			});
		});
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/crawl/cgv.json",
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
			}
		});
	}
</script>