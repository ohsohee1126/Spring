<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#products {width:900px; overflow:hidden; margin:0px auto;}
	.box {width:200px; float: left; border:1px solid gray; margin-left:20px; height:320px;}
	.subject,.qnt { width 150px; padding:0px 10px; font-weight:bold; font-size: 15px;}
	.price {padding: 0px 10px; font-size:18px; color:green;}
	.qnt {padding: 0px 10px;}
	p {line-height: 15px;}
	#keyword {border:none; font-size: 13px; font-weight:bold;}
	#keyword:focus{outline:none;}
	.search {width: 200px; float:right; margin-right:50px;margin-bottom:20px;
		border:1px solid gray; padding:5px;}
</style>
<div id="page">
	<div class="search">
		<input type="text" id="keyword" placeholder="검색어를 입력해주세요" size=15>
		<img id="search" src="/resources/search.png" width=20 style="padding-top:3px;cursor:pointer;"/>
	</div>
	
	<div id="products"></div>
	<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
			<div class="box">
				<div class="image">
					<img src="/display?fileName={{image}}" code="{{code}}" width=200 style="cursor:pointer;">
				</div>
				<div class="info">
					<p class="ellipsis subject">{{title}}</p>
					<p class="price">{{display price}}원</p>
					<p class="qnt">{{{displayQnt qnt}}}</p>
				</div>
			</div>
		{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(price){
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		});
		Handlebars.registerHelper("displayQnt", function(qnt){
			if(qnt==0) {
				return "<span style='color:red;font-weight:bold;'>품절</span>";
			}else {
				return "재고: "+ qnt.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			}
		});
	</script>
</div>
<div class="pagination"></div>
<script>
	var page=1;
	var keyword="";
	getList();
	
	$("#products").on("click", ".box img", function(){
		var code=$(this).attr("code");
		location.href="/product/read?code="+ code;
	});
	
	//목록출력 함수
	function getList(){
		$.ajax({
			type:"get",
			url: "/product/list.json",
			data: {page:page, keyword:keyword},
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#products").html(template(data));
				$(".pagination").html(getPagination(data));
			}
		});
	}
	
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
	
	$("#search").on("click", function(){
		keyword=$("#keyword").val();
		getList();
	});
	
	//검색어에서 엔터를 친경우
	$("#keyword").on("keypress", function(e){
		if(e.keyCode==13) $("#search").click();
	});
</script>