<%@page import="package1.DatabaseConnection"%>
<%@page import="package1.User"%>
<div class="row">
    <div class="col s6">
         <h2>Login</h2>
        <form class="col s12" method="POST" action="?type=login">
            <div class="row">
              <div class="input-field col s12">
                <input id="emaill" name="email" type="email" class="validate">
                <label for="emaill">Email</label>
              </div>
            </div>
            <div class="row">
              <div class="input-field col s12">
                <input id="passwordl" name="password" type="password" class="validate">
                <label for="passwordl">Password</label>
              </div>
            </div>

              <button class="btn waves-effect waves-light" type="submit" name="action">Submit
                <i class="material-icons right">send</i>
              </button>
          </form>
                        <% 
    if(type != null && type.compareTo("login") == 0) {
        String password = request.getParameter( "password" );
        String email = request.getParameter( "email" );
        if(password == null) { %> <p>Please choose a password</p><% }
        if(email == null) { %> <p>Please choose an e-mail</p><% }
        if (password != null && email != null) {
            int loginResult = DatabaseConnection.login(email, password, session);
            if(loginResult == 0) { %> <p>You are now connected page wil refresh soon...</p>               
            <meta http-equiv="refresh" content="2; URL=/Practice_4"> <%  }
            else if(loginResult == 1) { %> <p>There is no account using this e-mail</p> <%  }
            else { %> <p>Wrong password !</p> <%  }
        }
    }
    %>
    </div>
    <h2>Register</h2>
    <div class="col s6">
       <form class="col s12" method="POST" action="?type=register">
        <div class="row">
          <div class="input-field col s6">
            <input placeholder="Placeholder" name="first_name" id="first_name" type="text" class="validate">
            <label for="first_name">First Name</label>
          </div>
          <div class="input-field col s6">
            <input id="last_name" name="last_name" type="text" class="validate">
            <label for="last_name">Last Name</label>
          </div>
        </div>
        <div class="row">
          <div class="input-field col s6">
            <input id="password" name="password" type="password" class="validate">
            <label for="password">Password</label>
          </div>
          <div class="input-field col s6">
            <input id="email" name="email" type="email" class="validate">
            <label for="email">Email</label>
          </div>
        </div>

          <button class="btn waves-effect waves-light" type="submit" name="action">Submit
            <i class="material-icons right">send</i>
          </button>
      </form>
  <% 
    if(type != null && type.compareTo("register") == 0) {
        String first_name = request.getParameter( "first_name" );
        String last_name = request.getParameter( "last_name" );
        String password = request.getParameter( "password" );
        String email = request.getParameter( "email" );
        request.setAttribute("name", request.getParameter("name"));
        if(first_name == null) { %> <p>Please choose a first name</p><% }
        if(last_name == null) { %> <p>Please choose a last name</p><% }
        if(password == null) { %> <p>Please choose a password</p><% }
        if(email == null) { %> <p>Please choose an e-mail</p><% }
        DatabaseConnection.connect();
        if (first_name != null && last_name != null && password != null && email != null) {
            User u = new User(first_name, last_name, email, password);
            if(DatabaseConnection.register(u) == 0) { %> <p>There is already an account using this e-mail</p> <%  }
            else { %> <p>Successful register !</p> <%  }
        }
    }
    %>
    </div>
</div>