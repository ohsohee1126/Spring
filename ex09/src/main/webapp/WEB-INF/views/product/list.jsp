<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#product .title {width:400px; color: black; padding:5px 0px;}
</style>
<div id="page">
	<h1>상품 목록</h1>
	<table id="product"></table>
	<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<tr class="box">
			<td width=200><img src="/display?fileName={{image}}" width=150></td>
			<td width=400><p class="title ellipsis"><b>[{{code}}]</b> {{title}}</p></td>
			<td width=100><p>{{display price}}원</p></td>
			<td width=50><button class="update" code="{{code}}">수정</button></td>
			<td width=150>
				<small style="color:red;font-weight:bold">{{displayStatus isDelete}}</small>
				<button class="delete" code="{{code}}">{{displayDel isDelete}}</button>
			</td>
		</tr>
	{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(price){
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		});
		
		Handlebars.registerHelper("displayDel", function(isDelete){
			if(isDelete == 0) return "품절";
			else return "입고";
		});
		
		Handlebars.registerHelper("displayStatus", function(isDelete){
			if(isDelete == 0) return "In Stock";
			else return "Sold Out";
		});
	</script>
	<div class="pagination"></div>
</div>

<script>
	var page=${param.page == null? 1:param.page};
	getList();
	
	//삭제버튼을 클릭한 경우
	$("#product").on("click", ".box .delete", function(){
		var code=$(this).attr("code");
		var check=$(this).html();
		if(!confirm(code + "번 상품을 " + check + "처리 하실래요?")) return;
		
		$.ajax({
			type: "get",
			url: "/product/delete",
			data: {code:code, check:check},
			success: function(){
				alert(check + "처리 완료!");
				getList();
			}
		});
	});
	
	$("#product").on("click", ".box .update", function(){
		var code=$(this).attr("code");
		location.href="update?code=" + code + "&page=" + page;
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