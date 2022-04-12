<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="page">
	<h1>상품등록</h1>
	
	<form name="frm" style="width:800px;margin:0px auto;margin-bottom:10px;">
		<input type="text" name="query">
		<button type="submit">검색</button>
	</form>
	
	<table id="tbl" width=800></table>
	<script id="temp" type="text/x-handlebars-template">
		<tr>
			<td colspan=3><button id="insert">선택상품저장</button></td>
		</tr>
	{{#each items}}
		<tr>
			<td><input type="checkbox" class="chk"></td>
			<td><img src="{{image}}" width=100></td>
			<td>
				<div class="pid">{{productId}}</div>
				<div class="image">{{image}}</div>
				<div class="title">{{{title}}}</div>
				<div class="price">{{lprice}}</div>
			</td>
		</tr>
	{{/each}}
	</script>
</div>
<script>
	var query="냉장고";
	getList();
	
	$("#tbl").on("click", "#insert", function(){
		if(!confirm("선택한 상품들을 저장하실래요?")) return;
		
		$("#tbl tr .chk:checked").each(function(){
			var chk=$(this);
			var row=$(this).parent().parent();
			var pid=row.find(".pid").html();
			var title=row.find(".title").text();
			var image=row.find(".image").html();
			var price=row.find(".price").html();
			var intPrice = parseInt(price);
			
			$.ajax({
				type: "post",
				url: "/product/insert",
				data:{pid:pid, title:title, image:image, price:intPrice},
				success:function(){
					chk.prop("checked", false);
				}
			});
		});
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getList();
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/product/shop.json",
			dataType: "json",
			data: {query:query},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
			}
		});
	}
</script>