<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
	#reply {width:100%; padding:10px;}
	#send {margin-top:10px;}
	.reply {border:none; width:100%;padding:1px; line-height:25px;overflow:hidden;}
	.reply:focus {outline: none;border-bottom:0.1px solid gray;}
</style>    
<div style="margin:50px 0px;">
	<h1>게시글 상세정보</h1>
	<a href="list?page=${param.page}&keyword=${param.keyword}">목록이동</a>
	<div style="border:1px dotted gray;padding:10px;border-radius:10px;margin-top:10px;">
		<h3>${vo.title}</h3>
		<h4>
			<fmt:formatDate value="${vo.regdate}" pattern="yyyy-MM-dd HH:mm:ss"/>
			(<b>${vo.writer}</b>)
		</h4>
		<p>${vo.content}</p>
	</div>
	<div style="border:1px dotted gray;padding:10px;border-radius:10px;margin-top:10px;">
		<div>
			<textarea rows=5 cols=120 id="reply" placeholder="내용입력"></textarea>
			<br>
			<input type="button" id="send" value="전송">
		</div>
		<h3>댓글수:<span id="count">${vo.replycnt}</span></h3>
		<div id="replies"></div>
		<script id="temp" type="text/x-handlebars-template">
			{{#each list}}
				<div class="row" rno="{{rno}}" style="border-bottom:1px dotted gray;padding-bottom:10px;">
					<h4>[{{rno}}] {{replydate}} ({{replyer}})</h4>
					<textarea class="reply" rows=3>{{reply}}</textarea>
					<div style="text-align:right;padding-right:20px;">
						<a href="#" class="update">수정</a>
						<a href="#" class="delete">삭제</a>
					</div>
				</div>
			{{/each}}
		</script>
		<div class="pagination"></div>	
	</div>
</div>
<script>
	var bno="${vo.bno}";
	var page=1;
	getList();
	
	//수정을 클릭한 경우
	$("#replies").on("click", ".update" ,function(e){
		e.preventDefault();
		var row=$(this).parent().parent();
		var rno=row.attr("rno");
		var reply=row.find(".reply").val();
		if(!confirm("내용을 수정하실래요?")) return;
		$.ajax({
			type:"post",
			url:"/reply/update",
			data:{reply:reply, rno:rno},
			success:function(){
				alert("수정되었습니다!");
				getList();
			}
		});
	});
	
	//삭제를 클릭한 경우
	$("#replies").on("click", ".delete", function(e){
		e.preventDefault();
		var row=$(this).parent().parent();
		var rno=row.attr("rno");
		if(!confirm("내용을 삭제하실래요?")) return;
		$.ajax({
			type:"post",
			url:"/reply/delete",
			data:{rno:rno},
			success:function(){
				alert("삭제되었습니다!");
				getList();
			}
		});
	});
	
	//글쓰기 버튼을 클릭한 경우
	$("#send").on("click", function(){
		var reply=$("#reply").val();
		
		if(reply==""){
			alert("내용을 입력하세요!");
			$("#reply").focus();
			return;
		}
		
		$.ajax({
			type:"post",
			url:"/reply/insert",
			data:{bno:bno, reply:reply, replyer:'red'},
			success:function(){
				page=1;
				getList();
				$("#reply").val("");
			}
		});
	});
	
	//목록 출력 함수
	function getList(){
		$.ajax({
			type:"get",
			url:"/reply/list.json",
			dataType:"json",
			data:{page:page, bno:bno},
			success: function(data){
				var template = Handlebars.compile($("#temp").html());
				$("#replies").html(template(data));
				$(".pagination").html(getPagination(data));
				$("#count").html(data.pm.totalCount);
			}
		});
	}
	
	$(".pagination").on("click", "a", function(e){
		e.preventDefault();
		page=$(this).attr("href");
		getList();
	});
</script>