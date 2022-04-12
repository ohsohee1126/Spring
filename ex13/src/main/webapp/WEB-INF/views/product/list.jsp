<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#tbl{overflow:hidden; width:900px; margin:0px auto;}
	.box {float:left; width:200px; height:250px; margin-left:10px; padding:5px;
		border:1px solid gray;}
	.name {width:200px; font-size:12px;}
</style>
<div id="page">
	<div id="tbl"></div>
	<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
			<div class="box">
				<div><img src="/display?fileName={{image}}" width=200></div>
				<div class="ellipsis name">{{title}}</div>
				<div>{{price}}</div>
			</div>
		{{/each}}
	</script>
	<div class="pagination"></div>
</div>

<script>
	var page=1;
	getList();
	function getList(){
		$.ajax({
			type: "get",
			url: "/product/list.json",
			data: {page:page},
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
				$(".pagination").html(getPagination(data));
			}
		});
	}
	
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>