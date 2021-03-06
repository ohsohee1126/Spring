<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>

<div id="page">
	<h1>사용자 현황</h1>
	<div>
		<button id="point">사용자별 포인트</button>
		<button id="send">사용자별 보낸 메시지</button>
		<button id="receive">사용자별 받은 메시지</button>
	</div>
	<hr>
	<div id="chart" style="width: 900px; height: 500px;"></div>
</div>
<script>
	$("#point").on("click", function(){
		var title="사용자별 포인트"
		$.ajax({
			type: "get",
			url: "/chart/point.json",
			success: function(data){
				barChart(title, data);
			}
		});
	});
	
	$("#send").on("click", function(){
		var title="사용자별 보낸메시지"
		$.ajax({
			type: "get",
			url: "/chart/send.json",
			success: function(data){
				lineChart(title, data);
			}
		});
	});
	$("#receive").on("click", function(){
		var title="사용자별 받은메시지"
		$.ajax({
			type: "get",
			url: "/chart/send.json",
			success: function(data){
				pieChart(title, data);
			}
		});
	});
	
	function pieChart(chartTitle, chartData) {
		 google.charts.load('current', {'packages':['corechart']});
	     google.charts.setOnLoadCallback(drawChart);
	      function drawChart() {
	        var data = google.visualization.arrayToDataTable(chartData);
	        var options = {
	          title: chartTitle
	        };
	        var chart = new google.visualization.PieChart(document.getElementById('chart'));
	        chart.draw(data, options);
	      }
	}
	
	function lineChart(chartTitle, chartData) {
		google.charts.load('current', {'packages':['line']});
	    google.charts.setOnLoadCallback(drawChart);

	    function drawChart() {
	    	var data = google.visualization.arrayToDataTable(chartData);
	      	var options = {
	        	chart: {
	          	title: chartTitle,
	        	}
	      	};
	      	var chart = new google.charts.Line(document.getElementById('chart'));
	      	chart.draw(data, google.charts.Line.convertOptions(options));
		}
	}
	
	function barChart(chartTitle, chartData){
		google.charts.load('current', {'packages':['bar']});
		google.charts.setOnLoadCallback(drawChart);
		function drawChart() {
		  var data = google.visualization.arrayToDataTable(chartData);
		  var options = {
		    chart: {
		      title: chartTitle,
		    },
		    bars: 'vertical' //horizontal
		  };
		
		  var chart = new google.charts.Bar(document.getElementById('chart'));
		
		  chart.draw(data, google.charts.Bar.convertOptions(options));
		}
	}
</script>