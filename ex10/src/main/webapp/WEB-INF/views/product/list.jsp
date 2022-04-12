<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.subject {width:300px; color:gray;}
</style>
<div id="page">
	<h1>상품목록</h1>
	<div style="border-bottom:1px dotted gray;padding-bottom:10px;">
		<input type="text" placeholder="검색어" id="keyword">
		<input type="button" value="검색" id="search">
	</div>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		{{#each list}}
			<tr class="row">
				<td width=50 class="code">{{code}}</td>
				<td width=150><img src="/display?fileName={{image}}" width=150></td>
				<td width=300><p class="subject ellipsis">{{title}}</td>
				<td width=100>{{display price}}</td>
				<td width=100><button code="{{code}}" class="update">수정</td>
				<td width=200>
					<input class="qnt" type="text" value="{{qnt}}" size=3>
					<button class="qntUpdate">수량변경</button>
				</td>
			</tr>
		{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(price){
			return price.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		});
	</script>
	<div class="pagination"></div>
</div>
<script>
	var page="${param.page == null ? 1: param.page}";
	var keyword="${param.keyword ==null ? "" : param.keyword}";
	$("#keyword").val(keyword);
	
	getList();
	//수량변경 버튼을 클릭한 경우
	$("#tbl").on("click", ".row .qntUpdate", function(){
		var row=$(this).parent().parent();
		var code=row.find(".code").html();
		var qnt=row.find(".qnt").val();
		
		if(qnt<0 || qnt.replace(/[0-9]/g,'')){
			alert("변경 수량은 숫자로 입력하세요!");
			row.find(".qnt").focus();
			return;
		}
		
		if(!confirm(code + "번 상품의 수량을 " + qnt + "개로 수정하실래요?")) return;
		$.ajax({
			type: "post",
			url: "/product/qntUpdate",
			data: {code:code, qnt:qnt},
			success: function(){
				alert("수량변경 완료!");
				getList();
			}
		});
	});
	
	//수정버튼을 클릭한 경우
	$("#tbl").on("click", ".row .update", function(){
		var code=$(this).attr("code");
		location.href="update?code="+code+"&page="+page+"&keyword="+keyword;
	});
	//검색어에서 엔터를 친경우
	$("#keyword").on("keypress", function(e){
		if(e.keyCode==13) $("#search").click();
	});
	
	//검색버튼을 클릭한 경우
	$("#search").on("click", function(){
		keyword = $("#keyword").val();
		page=1;
		getList();
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
				$("#tbl").html(template(data));
				$(".pagination").html(getPagination(data));
			}
		});
	}
	
	//각 페이지 번호를 클릭한 경우
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>
