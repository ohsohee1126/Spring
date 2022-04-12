<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<style>
	.image, .link, .date, .percent{
		display:none;
	}
</style>
<h1>영화등록</h1>
<div id="page">
	<table id="tbl"></table>
		<script id="temp" type="text/x-handlebars-template">
			
					<tr>
						<td><input type="checkbox" id="chkAll"></td>
						<td><button id="insert">선택영화저장</button></td>
					</tr>
			{{#each array}}
					<tr>
					<td><input type="checkbox" class="chk"</td>
					<td>
						<p class="title">{{title}}</p>
						<p class="image">{{image}}</p>
						<p class="link">{{tlink}}</p>
						<p class="date">{{date}}</p>
						<p class="percent">{{percent}}</p>			
					</td>
				</tr>
				{{/each}}
		</script>
	</div>
	
	<div id="pagination"></div>
	
	<script>
		getList();
		function getList(){
			$.ajax({
				type:"get",
				url:"/crawl/cgv.json",
				dataType: "json",
				success:function(data)
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
				$(".pagination").html(getPagination(data));
			})			
		}
		
		$(".pagination").on("click","a",function(e){
		e.preventDefault();	
		})
	</script>