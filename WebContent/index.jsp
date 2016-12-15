<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Chat</title>
<link rel="shortcut icon" type="image/x-icon" href="res/homepage/favicon.ico?v=3.9" />
<link href="res/ui/css/screen.css?v=3.9" media="screen, projection" rel="stylesheet" type="text/css" >
<link rel="stylesheet" type="text/css" href="res/ui/css/base.css?v=3.9">
<link rel="stylesheet" type="text/css" href="res/passport/css/login.css?v=3.9">
</head>
<body>
<div class="logina-logo" style="height: 55px">
            <a href="">
                <img src="chat.png?v=3.9" height="60" alt="">
            </a>
        </div>
     <div class="logina-main main clearfix">
            <div class="tab-con">
                <form id="form-login" method="post" action="http://localhost:8080/WSProjet/chatApp/WSProjet/login">
                    <div id='login-error' class="error-tip"></div>
                    <table border="0" cellspacing="0" cellpadding="0">
                        <tbody>
                            <tr>
                                <th>Email</th>
                                <td width="245">
                                    <input id="email" type="text" name="email" placeholder="email address" autocomplete="off" value=""></td>
                                    
                                    <%
                                      String e=request.getParameter("email");
                                      request.getSession().setAttribute("email", e);
                                    %>
                                    
                                <td>
                                </td>
                            </tr>
                            <tr>
                                <th>Password</th>
                                <td width="245">
                                    <input id="password" type="password" name="pwd" placeholder="Please enter your password" autocomplete="off">
                                </td>
                                <td>
                                </td>
                            </tr>
                             <tr>
                                <th></th>
                                <td width="245"><input class="confirm" type="submit" value="Log in"></td>
                                <td></td>
                            </tr>
                        </tbody>
                    </table>
                    <input type="hidden" name="refer" value="site/">
                </form>
            </div>
            <div class="reg">
                <p>You don't have an account?<br>Register one!</p>
                <a class="reg-btn" href="signin.jsp">Register</a>
            </div>
        </div>
        <div id="footer">
            <div class="copyright">Chat.com</div>
        </div> 
</body>
</html>