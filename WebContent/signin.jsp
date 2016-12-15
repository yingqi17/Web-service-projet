<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sign in</title>
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
</head>
<body>
<form class="form" method="post" action="http://localhost:8080/WSProjet/chatApp/WSProjet/signin"> 
   
    <p class="email"> 
        <input type="text" name="email" id="email" /> 
        <label for="email">E-mail</label> 
    </p> 
   
     <p class="pwd"> 
        <input type="password" name="pwd" id="pwd" /> 
        <label for="pwd">Password</label> 
    </p> 
    
   <p class="Fname"> 
        <input type="text" name="Fname" id="Fname" /> 
        <label for="Fname">First Name</label> 
    </p> 
  
   <p class="Lname"> 
        <input type="text" name="Lname" id="Lname" /> 
        <label for="Lname">Last Name</label> 
    </p> 
   
    <p class="biography"> 
        <textarea name="biography"></textarea> 
        <label>Biography</label> 
    </p> 
   
    <p class="submit"> 
        <input type="submit" value="Send" /> 
    </p> 
   
</form>
</body>
</html>