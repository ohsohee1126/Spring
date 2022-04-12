<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <div id="chart" style="width:900px;height:500px;"></div>"
    
    <script>
    	$.ajax({
    		type:"get",
    		url:"/chart/message",
    		success:function(data){
    			var title="사용자별 메시지현황";
    			barChart(title,data);  			
    		}		
    	})
    </script>