<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create a Group</title>
<link rel="stylesheet" type="text/css" href="res/signin/signin.css?v=3.9">
</head>
<body>
<form class="form" method="post" action="http://localhost:8080/WSProjet/chatApp/WSProjet/create/group"> 
   
    <p class="name"> 
        <input type="text" name="name" id="name" /> 
        <label for="name">Group Name</label> 
    </p> 
   
    <p class="description"> 
        <input type="text" name="description" id="description" /> 
        <label for="description">Description</label> 
    </p> 

    <p class="submit"> 
        <input type="submit" value="Send" /> 
    </p> 
   
</form>
</body>
</html>