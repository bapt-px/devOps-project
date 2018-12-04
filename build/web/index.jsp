<%@page import="package1.DatabaseConnection"%>
<%@page import="package1.User"%>
<!DOCTYPE html>
<!--
To change this license header, choose License Headers in Project Properties.
To change this template file, choose Tools | Templates
and open the template in the editor.
-->
<html>
    <head>
        <title>JEE Practice 4</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>

    </head>
    <body>
        
            <div class="container">
            <%
                        DatabaseConnection.connect();
                String type = request.getParameter("type");  

                String emailS = (String) session.getAttribute("email");
                System.out.println(emailS);
                if(emailS != null) { %> <p>Vous êtes log as <% out.println(emailS); %> </p> <% } %>
            <h1>My PAGE</h1>
            <a href="?type=logout">Logout</a>
            <% if(emailS == null) { %>  
                <%@ include file="register.jsp"%>
            <% } else if(type != null && type.compareTo("logout") == 0)  { %>  
                <% session.invalidate(); %>
                <p>Déconnexion effectué !</p>
                <meta http-equiv="refresh" content="2; URL=/Practice_4">
            <%  } else { %>  
                <%@ include file="messages.jsp"%>
            <% } %>
            <br>
            </div>
        
    </body>
</html>
