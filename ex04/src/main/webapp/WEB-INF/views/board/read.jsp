<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
    
<div style="width:800px;margin:0px auto;margin-bottom:100px;">
	<h1>게시글 상세정보</h1>
	<a href="list?page=${param.page}&keyword=${param.keyword}">목록이동</a>
	<hr/>
	<h3>${vo.title}</h3>
	<h4><fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		(${vo.writer})</h4>
	<hr/>
	<p>${vo.content}</p>
	<hr/>
	<div>
		<div id="replies"></div>
		<script id="temp" type="text/x-handlebars-template">
			{{#each list}}
				<h4>{{replydate}} ({{replyer}})</h4>
				<div class="box">
					{{reply}}
				</div>
			{{/each}}
		</script>
	</div>
	<div class="pagination"></div>
</div>
<script src="/resources/pagination.js"></script>
<script>
	var bno="${vo.bno}";
	var page=1;
	getList();
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/reply/list.json",
			dataType:"json",
			data:{bno:bno, page:page},
			success:function(data){
				var temp=Handlebars.compile($("#temp").html());
				$("#replies").html(temp(data));
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
