<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
   select {height:30px; width:200px; font-size:15px;line-height:20px;}
   #box {margin: 50px 0px;}
   td {border: 1px solid black;}
   #message {width:100%;border:none;border-bottom:1px solid gray; font-size:15px;}
   #message:focus{outline:none;}
   #btnsend {float:left; margin:5px;}
</style> 
<div id="box">  
   <table>
      <tr>
         <td class="title" width=100>보낸이</td>
         <td width=200>${vo.uid}</td>
         <td class="title" width=100>성명</td>
         <td width=200>${vo.uname}</td>
         <td class="title" width=100>포인트</td>
         <td width=200>${vo.point}</td>
      </tr>
      <tr>
         <td width=100 class="title">받은이</td>
         <td colspan=5>
            <select id="receiver">
               <c:forEach items="${list}" var="v">
                  <c:if test="${vo.uid != v.uid}">
                     <option value="${v.uid}">${v.uname}(${v.uid})</option>
                  </c:if>
               </c:forEach>
            </select>
         </td>
      </tr>
      <tr>
         <td width=100 class="title">보낼내용</td>
         <td colspan=5>
            <input type="text" id="message"/>
            <button id="btnsend">보내기</button>
         </td>
      </tr>
   </table>
   <hr/>
   <!-- 보낸 메시지 목록 -->
   <table id="tblsend"></table>
   <script id="temp" type="text/x-handlebars-template">
      <tr class="title">
         <td width=100>No.</td>
         <td width=100>받은이</td>
         <td width=500>내용</td>
         <td width=200>보낸날짜</td>
      </tr>
      {{#each .}}
         <tr>
            <td>{{mno}}</td>
            <td>{{uname}} ({{receiver}})</td>
            <td>{{message}}</td>
            <td>{{date}}</td>
         </tr>
      {{/each}}
   </script>
</div> 
<script>
   var uid="${vo.uid}";
   getList();
   
   //메시지 상자에서 엔터를 눌린경우
   $("#message").on("keypress",function(e){
      if(e.keyCode==13) $("#btnsend").click();
   })
   //보내기 버튼을 클릭한 경우
   $("#btnsend").on("click", function(){
      var message=$("#message").val();
      if(message=="") {
         alert("보낼 내용을 입력하세요!");
         $("#message").focus();
         return;
      }
      if(!confirm("메시지를 전송하실래요?")) return;
      
      var receiver=$("#receiver").val();
      console.log(message);
      $.ajax({
         type: "post",
         url: "/message/sendMessage",
         data: {sender:uid, receiver:receiver, message:message},
         success:function(){
            alert(data);
            alert("메시지 전송 완료!");
            $("#point").html(data);
            $("#message").val("");
            $("#message").focus();
            getList();
            console.log(message);
            
         }
      });
   });
   
   function getList(){
      $.ajax({
         type: "get",
         url: "/message/send",
         data: {uid:uid},
         dataType: "json",
         success:function(data){
            var template = Handlebars.compile($("#temp").html());
            $("#tblsend").html(template(data));
         }
      });
   }
</script>



