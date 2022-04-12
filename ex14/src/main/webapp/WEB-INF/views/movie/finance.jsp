<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
 	.red {color:red; font-weight:bold;}
 	.blue {color: blue; font-weight: bold;}
 </style>   
<div id="page">
	<table id="tblFinance"></table>
	<script id="tempFinance" type="text/x-handlebars-template">
		<tr>
			<td width=400>{{title}}</td>
			<td width=100 class="{{color}}">{{price}}</td>
			<td width=100 class="{{color}}">{{range}}</td>
			<td width=100 class="{{color}}">{{percent}}</td>
		</tr>
	</script>
</div>

<script>
	getFinance();
	function getFinance(){
		$.ajax({
			type: "get",
			url: "/crawl/finance.json",
			dataType: "json",
			success: function(data){
				//배열에 데이터저장
				var finance = [];
				var i=0;
				$(data).each(function(){
					finance[i]=this;
					i++;
				});
				
				//출력
				var i=0;
				var temp = Handlebars.compile($("#tempFinance").html());
				var interval = setInterval(function(){
					$("#tblFinance").html(temp(finance[i % finance.length]));
					i++;
				},2000);
			}
		});
	}
	
</script>