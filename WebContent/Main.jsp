<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="com.rest.DB.DBClass" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Chat</title>
<link rel="stylesheet" type="text/css" href="res/main/style.css?v=3.9">
<script type="text/javascript" src="res/main/function.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
<div id="top">
	<div class="wrap">
    	<div class="logo"><img src="chat.png?v=3.9" height="30"/></div>
		<div class="navbar">
		  <a href="http://localhost:8080/WSProjet/creategroup.jsp">Create a Group</a>
		  <a href="http://localhost:8080/WSProjet/change.jsp">
		    <img src="Icon.jpg?v=3.9" height="30" alt="">
		  </a>
		</div>
    </div>
</div>
<div id="main" class="wrap">
    <div class="lefter">
		<ul>
			<li class="current" id="yourgroup">
			    <a class="yourgroup" href="#">Your Groups</a>			    
			</li>
			<li id="groupjoined">
			    <a class="groupjoined" href="#">Groups joined</a>
			</li>
		</ul>
	</div>
	<div class="righter">
		<div class="main">
			<h2 class="dicover">Discover</h2>
			<dl class="feed clearfix" id="viewgroup">
			    
			</dl>
		</div>
	</div>
</div>
<div id="footer" class="wrap">
	<div class="copyright">Chat.com</div>
</div>
<script type="text/javascript">
   function setcookie(namevalue){
	   document.cookie="name="+escape(namevalue);
   }
   function ReadCookie() {
		var name=document.cookie.split(";")[0].split("=")[1];
		return name;}
   function delCookie(){     
	   var data=document.cookie;    
       var dataArray=data.split("; ");    
       for(var i=0;i<dataArray.length;i++){    
            var varName=dataArray[i].split("=");    
            document.cookie=varName[0]+"=''; expires="+new Date(0).toGMTString();    
       }                          
		}   
   window.onload = function(){
	  delCookie();
	   $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/your/group",function(result){
		   if(result!=undefined){
			   $("#yourgroup").append("<ul>");
			   $.each(result,function(i,g){
				   $("#yourgroup").append("<li><a href=\"http://localhost:8080/WSProjet/changegroup.jsp\" id="+g['name']+i+">"+g['name']+"</a></li>");
			   });
			   $("#yourgroup").append("</ul>");
			   $.each(result,function(i,g){
				   var obj=document.getElementById(g['name']+i);		   
				   obj.onclick=function(){setcookie(g['name']);
				                           };
			   });
		   }
	   });
	   $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/group/joined",function(result){
		   if(result!=undefined){
			   $("#groupjoined").append("<ul>");
			   $.each(result,function(i,g){
				   $("#groupjoined").append("<li><a href=\"http://localhost:8080/WSProjet/group1.jsp\" id="+1000*i+">"+g['gname']+"</a></li>");
			   });
			   $("#groupjoined").append("</ul>");
			   $.each(result,function(i,g){
				   var obj=document.getElementById(1000*i);
				   
				   obj.onclick=function(){setcookie(g['gname']); };
			   });
		   }
	   });
	   $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/view/group",function(result){
		   if(result!=undefined){
			   $.each(result,function(i,g){
				   $("#viewgroup").append("<a href=\"http://localhost:8080/WSProjet/group1.jsp\" class=\"bold\" id="+g['name']+">"+g['name']+"</a></dd>");
				   $("#viewgroup").append("<dd class=\"photo\"><ul class=\"clearfix\"+><li><img src=\"photo_1_tiny.gif\" /></li></ul></dd><dd class=\"line\"></dd>")
			   });
			   $("#viewgroup").append("</dd>");
			   $.each(result,function(i,g){
				   //alert(g['name']);
				   var obj=document.getElementById(g['name']);
				   //alert(obj);
				   obj.onclick=function(){setcookie(g['name']);
				                         };
			   });
		   }
	   });
   }
</script>
</body>
</html>