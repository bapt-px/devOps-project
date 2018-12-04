package package1;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.http.HttpSession;
import jdk.nashorn.internal.ir.Symbol;
import org.apache.taglibs.standard.tag.el.core.OutTag;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Baptiste
 */
public class DatabaseConnection {
    
    private static Connection connexion = null;
    public static void connect() {
        /* Chargement du driver JDBC pour MySQL */
        try {
            Class.forName("com.mysql.jdbc.Driver");
                        System.out.println("driver OK !");
        } catch ( ClassNotFoundException e ) {
            System.out.println(e.getMessage());
        }
        /* Connexion à la base de données */
        String url = "jdbc:mysql://localhost:3306/cruddb";
        String utilisateur = "root";
        String motDePasse = "123";
        try {
            connexion = DriverManager.getConnection( url, utilisateur, motDePasse );
            System.out.println("Connexion OK !");
            /* Ici, nous placerons nos requêtes vers la BDD */
            /* ... */

        } catch ( SQLException e ) {
            /* Gérer les éventuelles erreurs ici */
        } 
    }
    public static ResultSet request(String req) throws SQLException {
        Statement statement = connexion.createStatement();
        ResultSet resultat = statement.executeQuery( req );

        return resultat;
    }
    public static void execRequest(String req) throws SQLException {
        Statement statement = connexion.createStatement();
        statement.executeUpdate( req );
        }
    
    public static int register(User u) throws SQLException {
        ResultSet user = request("Select * from user where email = '" + u.getEmail() + "'");
        if(user.next()) {
            return 0;
        }
        else {
            execRequest("insert into user(first_name, last_name, password, email) values('" + u.getFirst_name() + 
                    "', '" + u.getLast_name() + "', '" + u.getPassword() + "', '" + u.getEmail() + "')");
            return 1;
        }
    }
        public static int login(String email, String password, HttpSession session) throws SQLException {
        String sql = "Select * from user where email = '" + email + "'";
        System.out.println(sql);
        ResultSet user = request(sql);
        
        if(user.next()) {
            if(password.compareTo(user.getString("password")) == 0) {
                session.setAttribute("first_name",user.getString("first_name"));
                session.setAttribute("last_name", user.getString("last_name"));
                session.setAttribute("email", user.getString("email"));
                int id = user.getInt("id");
                System.out.println("id ! " + id);
                session.setAttribute("id", id);
                return 0;
            }
            else return 2;
        }
        else {
            return 1;
        }
    }
    public static ResultSet getMessages() throws SQLException {
        String sql = "select * from messages m join user u on u.id = m.idUser";
        ResultSet user = request(sql);
        return request(sql);
    }
    public static void letMessage(int id, String message) throws SQLException {
        String sql = "insert into messages(idUser, message) values(" + id + ", '" + message + "');";
        System.out.println(sql);
        execRequest(sql);
    }
    public static void close() {
            if ( connexion != null )
                try {
                    /* Fermeture de la connexion */
                    connexion.close();
                } catch ( SQLException ignore ) {
                    /* Si une erreur survient lors de la fermeture, il suffit de l'ignorer. */
                }
    }
}
