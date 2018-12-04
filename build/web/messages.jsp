<%-- 
    Document   : messages
    Created on : 25 nov. 2018, 16:23:04
    Author     : Baptiste
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="package1.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
     <div class="row">
    <form class="col s12" method="POST" action="?type=letMessage">
      <div class="row">
        <div class="input-field col s12">
            <textarea id="textarea1" class="materialize-textarea" placeholder="Write here !" name="message"></textarea>
          <label for="textarea1">Your comment</label>
        </div>
      </div>
          <button class="btn waves-effect waves-light" type="submit" name="action">Submit
            <i class="material-icons right">send</i>
          </button>    </form>
  </div>
    <%  
        int id = (Integer) session.getAttribute("id");
        System.out.println(id);
        try {
        if( type != null && type.compareTo("letMessage") == 0) DatabaseConnection.letMessage(id, request.getParameter("message"));
        ResultSet messages = DatabaseConnection.getMessages();
        while (messages.next()) {
            %><h4><% out.println(messages.getString("first_name") + " " + messages.getString("last_name")); %></h4>
            <blockquote><% out.println(messages.getString("message")); %><br>
            <% out.println(messages.getString("date")); %><br>
            <hr>
            </blockquote>
        <% }
        }catch(SQLException e) {

        } %>
       
    </body>
</html>
