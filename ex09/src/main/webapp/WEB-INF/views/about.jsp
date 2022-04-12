<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#product {
		width: 900px;
		margin: 0px auto;
		overflow: hidden;
	}
	.box {
		width: 180px;
		margin: 10px;
		float: left;
		border: 1px solid gray;
		padding: 10px;
		border-radius: 5px;
		height: 250px;
	}
	.title {
		width: 150px;
	}
	img {
		display: block;
		margin: 0px auto;
		cursor: pointer;
	}
</style>
<div id="page">
	<h1>상품 목록</h1>
	<div id="product"></div>
	<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<div class="box">
			<img src="/display?fileName={{image}}" width=150 code="{{code}}">
			<p class="title ellipsis"><b>[{{code}}]</b> {{title}}</p>
			<p>{{display price}}원 <span style="color:red;font-size:12px;">{{displayStatus isDelete}}</span></p>
		</div>
	{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(price){
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		});
		
		Handlebars.registerHelper("displayStatus", function(isDelete){
			if(isDelete == 1) return "품절";
		});
	</script>
	<div class="pagination"></div>
</div>

<script>
	var page=${param.page==null ? 1: param.page};
	getList();
	
	$("#product").on("click", ".box img", function(){
		var code=$(this).attr("code");
		location.href="/product/read?code=" + code + "&page=" + page;
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/product/list.json",
			data: {page: page},
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#product").html(template(data));
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