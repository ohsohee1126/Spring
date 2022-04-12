<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=000d0d14aa78e3c030b6a4fb4d5a8114"></script>
<div id="page">
	<h1>지역검색</h1>
	<form name="frm" style="width:800px;margin:0px auto;margin-bottom:10px;">
		<input type="text" name="query">
		<button type="submit">검색</button>
	</form>
	<table id="tbl"></table>
	<script id="temp" type="text/x-handlebars-template">
		{{#each documents}}
			<tr>
				<td width=250>{{place_name}}</td>
				<td width=300>{{address_name}}</td>
				<td width=200>{{phone}}</td>
				<td><button class="btnMap" x="{{x}}" y="{{y}}">지도보기</td>
			</tr>
		{{/each}}
	</script>
	<hr>
	<div id="map" style="width:800px;height:400px;margin:0px auto;"></div>
</div>

<script>
	var query="학익동";
	getList();
	
	$("#tbl").on("click", ".btnMap", function(){
		var x=$(this).attr("x");
		var y=$(this).attr("y");
		getMap(x, y);
	});
	
	$(frm).on("submit", function(e){
		e.preventDefault();
		query=$(frm.query).val();
		getList();
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "https://dapi.kakao.com/v2/local/search/keyword.json",
			dataType: "json",
			headers:{"Authorization": "KakaoAK 04ce4bf8002de6c8466523c16b6de483"},
			data: {query:query, size:3},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#tbl").html(template(data));
			}
		});
	}
	
	//지도출력
	function getMap(x, y){
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(y, x),
			level: 3
		};
		var map = new kakao.maps.Map(container, options);
		var marker=new kakao.maps.Marker({position: new kakao.maps.LatLng(y,x)});
		marker.setMap(map);
	}
</script>
