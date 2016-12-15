<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
</head>
<body>
<p class="email"> 
        <input type="text" name="email" id="email" readonly/> 
        <label for="email">E-mail</label> 
    </p> 
   
   <p class="Fname"> 
        <input type="text" name="Fname" id="Fname" readonly/> 
        <label for="Fname">First Name</label> 
    </p> 
  
   <p class="Lname"> 
        <input type="text" name="Lname" id="Lname" readonly/> 
        <label for="Lname">Last Name</label> 
    </p> 
   
    <p class="biography"> 
        <textarea name="biography" readonly/></textarea> 
        <label>Biography</label> 
    </p> 
    
<script type="text/javascript">
function ReadCookie() {
	var name=document.cookie.split(";")[0].split("=")[1];
	return name;
}
function delCookie(n){     
	 var data=document.cookie;     
	 document.cookie=n + "=" + ReadCookie(n) + "; expires="+new Date(0).toGMTString();                       
	}    
window.onload = function(){
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/look/user/"+ReadCookie(),function(result){	      
	      $.each(result, function(i, field){
	    	  document.getElementById("email").value=field['email'];
	          document.getElementById("Fname").value=field['Fname'];
	          document.getElementById("Lname").value=field['Lname'];
	          if(field['biography'!=null]){
	          document.getElementById("biography").value=field['biography'];}
	    });
	      });
  delCookie("name");
  }
</script>
</body>
</html>