<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Group</title>
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
 <div class="lefter" id="lefter">
    <p class="name"> 
        <input type="text" name="name" id="name" value="." readonly/> 
        <label for="name">Group Name</label> 
    </p> 
   
    <p class="description"> 
        <input type="text" name="description" id="description" value="." readonly/> 
        <label for="description">Description</label> 
    </p> 
    
    <p class="membership"> 
        <input type="text" name="membership" id="membership" value="." readonly/> 
        <label for="name">Membership Count</label> 
    </p>
 </div> 
</body>
<script type="text/javascript">
function setcookie(namevalue){
	   document.cookie="name="+escape(namevalue);
}
/*function setusercookie(namevalue){
	   document.cookie="user="+escape(namevalue);
}*/
function ReadCookie() {
	var name=document.cookie.split(";")[0].split("=")[1];
	return name;
/*	var cookieValue = null;
	var cookies = document.cookie.split(';');
	 for (var i = 0; i < cookies.length; i++) {
	   var cookie = jQuery.trim(cookies[i]);
	   //PYYH=USERNAME=steven&PASSWORD=111111&UserID=1&UserType=1
	   if (cookie.substring(0, name.length + 1) == (name + '=')) {
	 cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
	 //USERNAME=steven&PASSWORD=111111&UserID=1&UserType=1
	 break;
	   }
	 }
	  return cookieValue;*/
}
function delCookie(){     
	   var data=document.cookie;    
    var dataArray=data.split("; ");    
    for(var i=0;i<dataArray.length;i++){    
         var varName=dataArray[i].split("=");    
         document.cookie=varName[0]+"=''; expires="+new Date(0).toGMTString();    
    }                          
		} 

window.onload = function(){	   
	//alert(ReadCookie());
	var cookie=ReadCookie();
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/look/group/"+ReadCookie(),function(result){   
	      $.each(result, function(i, field){
	      document.getElementById("name").value=field['name'];
	      document.getElementById("description").value=field['description'];
	    });
	      });
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/membership/"+ReadCookie(),function(result){	      
      $.each(result, function(i, field){
      document.getElementById("membership").value=field['count(1)'];
    });
      });
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/isjoined/"+cookie,function(result){
	  
	  var b=document.getElementsByTagName("body")[0];
	  $.each(result,function(i,g){
		  if(g!=null){
		  var p1=document.createElement("p");
		  p1.className="leave";
		  //p1.style.cssText="float:right";
		  
		  var form1=document.createElement("form");
		  form1.className="form";
		  form1.method="post";
		  form1.action="http://localhost:8080/WSProjet/chatApp/WSProjet/leave/"+cookie;
		  
		  var button1=document.createElement("input");
		  button1.type="submit";
		  button1.value="Leave";
		  
		  form1.appendChild(button1);
		  p1.appendChild(form1);
		  $(".lefter").append(p1);
		  
		  var p2=document.createElement("p");
		  p2.className="membership";
		  p2.style.cssText="float:right";
		  
		  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/members/"+cookie,function(ms){
			 // alert(cookie);
			  if(result!=undefined){
				   $(".lefter").append("<ul>");
				   $.each(ms,function(i,m){
					   $(".lefter").append("<li><a href=\"http://localhost:8080/WSProjet/userinfo.jsp\" id="+m['uemail']+">"+m['uemail']+"</a></li>");
				   });
				   $(".lefter").append("</ul>");
				   $.each(ms,function(i,m){
					   var obj=document.getElementById(m['uemail']);
					  // alert(obj);
					   obj.onclick=function(){setcookie(m['uemail']);};
				   });
		       }
		  });
		  
		  var div1=document.createElement("div");
		  div1.className="righter";
		  
		  var div2=document.createElement("div");
		  div2.className="main";
		  
		  var p3=document.createElement("p");
		  p3.className="dashboard";
		  
		  var form2=document.createElement("form");
		  form2.className="form";
		  form2.method="post";
		  form2.action="http://localhost:8080/WSProjet/chatApp/WSProjet/comment/"+cookie;
		  
		  var txt=document.createElement("textarea");
		  txt.className="comment";
		  txt.name="comment";
		  
		  var button2=document.createElement("input");
		  button2.type="submit";
		  button2.value="submit";
		  
		  form2.appendChild(txt);
		  form2.appendChild(button2);
		  p3.appendChild(form2);
		  
		  var p4=document.createElement("p");
		  p4.className="dashboard";
		  
		  var ul4=document.createElement("ul");
		  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/dashboard/"+cookie,function(dbs){
			  $.each(dbs,function(i,db){
				  var li=document.createElement("li");
				  
				  var span=document.createElement("span");
				  span.className="time";
				  span.innerText=db['time'];
				  
				  var a=document.createElement("a");
				  a.href="#";
				  a.innerText=db['uemail'];
				  
				  li.innerText=db['content'];
				  
				  li.appendChild(span);
				  li.appendChild(a);
				  ul4.appendChild(li);
			  });
		  });
		  
		  p4.appendChild(ul4);
		  div2.appendChild(p3);
		  div2.appendChild(p4);
		  div1.appendChild(div2);
		  b.appendChild(div1);	  				
	  }
	  });
  });
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/isnotjoined/"+cookie,function(result){	  
	  $.each(result,function(i,g){
		  if(g!=null){
			  //alert("222");
			  var d=document.getElementById("lefter");
			  var p=document.createElement("p");
			  p.className="join";
			  p.style.cssText="float:right";
		  
			  var form=document.createElement("form");
		      form.className="form";
		      form.method="post";
		      form.action="http://localhost:8080/WSProjet/chatApp/WSProjet/join/group/"+cookie;
		  
		     var button=document.createElement("input");
		     button.type="submit";
		     button.value="Join";
		  
		     form.appendChild(button);
		     p.appendChild(form);
		     d.appendChild(p);
		  }
	  });

  });
  //delCookie("name");
  }

</script>
</html>