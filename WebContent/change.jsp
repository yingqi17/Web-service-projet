<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Change information</title>
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>

</head>
<body>
<form class="form" method="post" action="http://localhost:8080/WSProjet/chatApp/WSProjet/change"> 
   
   <p>
     <label>Edit your information</label>
   </p>
   <p class="Fname"> 
        <input type="text" name="Fname" id="Fname" value="." /> 
        <label for="Fname">First Name</label> 
    </p> 
  
   <p class="Lname"> 
        <input type="text" name="Lname" id="Lname" value="."/> 
        <label for="Lname">Last Name</label> 
    </p> 
 
    <p class="biography"> 
        <textarea id="biography" name="biography"></textarea> 
        <label>Biography</label> 
    </p> 
   
    <p class="submit"> 
        <input type="submit" value="Send" /> 
    </p> 
</form>
<form class="form" method="post" action="http://localhost:8080/WSProjet/chatApp/WSProjet/delete/user">
    <input type="hidden" name="_method" value="delete"/>
    <p class="submit"> 
        <input type="submit" value="Delete your account" /> 
    </p> 
</form>
<script type="text/javascript">
window.onload = function(){
  $.getJSON("http://localhost:8080/WSProjet/chatApp/WSProjet/info",function(result){	      
	      $.each(result, function(i, field){
	      document.getElementById("Fname").value=field['Fname'];
	      document.getElementById("Lname").value=field['Lname'];
	      document.getElementById("biography").value=field['biography'];
	    });
	      });
  }
</script>
</body>
</html>