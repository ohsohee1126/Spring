<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	#movies {width:900px; overflow:hidden; margin:0px auto;}
	.movie {width: 200px; float:left; margin:10px;}
	.name, .odate, .cdate{width:150px; font-size:12px; font-weight:bold; padding:5px;}
</style>
<div id="page">
	<div id="movies"></div>
	<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<div class="movie">
			<div><img src="/display?fileName={{image}}" width=150></div>
			<div><p class="ellipsis name">{{title}}</p></div>
			<div><p class="ellipsis odate">{{display odate}}</p></div>
			<div><p class="ellipsis cdate">{{display cdate}}</p></div>
		</div>
	{{/each}}
	</script>
	<div class="pagination"></div>
	<script>
		Handlebars.registerHelper("display", function(odate){
			return odate.substr(0,11);
		})
	</script>
</div>

<script>
	var page=1;
	getList();
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/movie/list.json",
			data: {page:page},
			dataType: "json",
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#movies").html(template(data));
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