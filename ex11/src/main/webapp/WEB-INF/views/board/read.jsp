<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	.replyer {font-weight: bolod; color: blue;}
	textarea {width: 100%; padding: 10px; border:none; border:1px solid gray; margin-bottom:5px;}
	textarea:focus {outline:none;}
</style>
<div id="page">
	<h1>게시글 정보</h1>
	<h2>[${vo.bno}] ${vo.title}</h2>
	<h4>
		<fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		[${vo.writer}]
	</h4>
	<hr/>
	<p>${vo.content}</p>
	<a href="list?page=${param.page}&keyword=${param.keyword}">목록으로</a>
	<hr><br><br>
	<div>
		<textarea id="reply" rows="3" cols="80" placeholder="내용을 입력하세요"></textarea>
		<button id="insert">댓글등록</button>
	</div>
	<div id="replies"></div>
	<script id="temp" type="text/x-handlebars-template">
	{{#each list}}
		<div class="box">
			<h4>
				<span class="rno">{{rno}}</span> 
				{{replydate}} 
				<span class="replyer">{{replyer}}</span>
			</h4>
			<textarea rows=5 cols=80 class="reply">{{reply}}</textarea>
			<div style="display:{{display replyer}}">
				<button class="update">수정</button>
				<button class="delete">삭제</button>
			</div>
		</div>
	{{/each}}
	</script>
	<script>
		Handlebars.registerHelper("display", function(replyer){
			if(replyer!="${uid}"){
				return "none";
			}
		});
	</script>
	<div class="pagination"></div>
</div>
<script>
	var bno="${vo.bno}";
	var page=1;
	getList();
	
	//댓글 수정
	$("#replies").on("click", ".box .update", function(){
		var box=$(this).parent().parent();
		var rno=box.find(".rno").html();
		var reply=box.find(".reply").val();
		if(!confirm(rno + "번 내용을 수정하실래요?")) retun;
		$.ajax({
			type: "post",
			url: "/reply/update",
			data: {rno:rno, reply:reply},
			success: function(){
				alert("댓글수정 성공!");
				getList();
			}
		});
	});
	//댓글 삭제
	$("#replies").on("click", ".box .delete", function(){
		var box=$(this).parent().parent();
		var rno=box.find(".rno").html();
		if(!confirm(rno + "번 내용을 삭제하실래요?")) retun;
		$.ajax({
			type: "post",
			url: "/reply/delete",
			data: {rno:rno},
			success: function(){
				alert("댓글삭제 성공!");
				getList();
			}
		});
	});
	
	//댓글등록
	$("#insert").on("click", function(){
		var replyer ="${uid}";
		var reply=$("#reply").val();
	
		if(reply == "") {
			alert("댓글 내용을 입력하세요!");
			$("#reply").focus();
			return;
		}

		if(!confirm("댓글을 등록하실래요?")) return;
		$.ajax({
			type: "post",
			url: "/reply/insert",
			data: {bno:bno, replyer:replyer, reply:reply},
			success: function(){
				alert("댓글등록 성공!");
				getList();
				$("#reply").val("");
			}
		});
	});
	
	function getList(){
		$.ajax({
			type: "get",
			url: "/reply/list.json",
			data: {bno:bno, page:page},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#replies").html(template(data));
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