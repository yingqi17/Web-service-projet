<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
<title>Edit your group</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script language="JavaScript">
function ReadCookie(name) {
	var name=document.cookie.split(";")[0].split("=")[1];
	return name;
}
function delCookie(){     
	   var data=document.cookie;    
    var dataArray=data.split("; ");    
    for(var i=0;i<dataArray.length;i++){    
         var varName=dataArray[i].split("=");    
         document.cookie=varName[0]+"=''; expires="+new Date(0).toGMTString();    
    }                          
		}              
window.onload=function addEl(){
	//alert(ReadCookie());
	var d=document.getElementsByTagName("body")[0];
	var form1=document.createElement("form");
	form1.className="form";
	form1.method="post";
	form1.action="http://localhost:8080/WSProjet/chatApp/WSProjet/change/group/"+ReadCookie();
	
	var p1=document.createElement("p");
	p1.className="description";
	
	var it=document.createElement("input");
	it.id="description";
	it.type="text";
	it.name="description";
	
	var label=document.createElement("label");
	label.setAttribute("for","description");
	label.innerHTML="Description";
	
	var p2=document.createElement("p");
	p2.className="submit";
	
	var ib1=document.createElement("input");
	ib1.type="submit";
	ib1.value="Send";
	
	var form2=document.createElement("form");
	form2.className="form";
	form2.method="post";
	form2.action="http://localhost:8080/WSProjet/chatApp/WSProjet/delete/group/"+ReadCookie();
	
	var ih=document.createElement("input");
	ih.type="hidden";
	ih.name="_method";
	ih.value="delete";
	
	var p3=document.createElement("p");
	p3.className="submit";
	
	var ib2=document.createElement("input");
	ib2.type="submit";
	ib2.value="Delete this group";
	
	$.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/group/info/"+ReadCookie(),function(result){
	      $.each(result, function(i, field){
	    	  it.value=field['description'];
	      });	      
	    });
	
	p1.appendChild(it);
	p1.appendChild(label);
	p2.appendChild(ib1);
	form1.appendChild(p1);
	form1.appendChild(p2);
	
	p3.appendChild(ib2);
	form2.appendChild(ih);
	form2.appendChild(p3);
	
	d.appendChild(form1);
	d.appendChild(form2);
	
	delCookie("name");
	//alert(ReadCookie("name"));
}
</script>
</head>
<body>

</body>
</html>