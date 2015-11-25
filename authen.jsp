<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="entity.*" %>
<%@ page session="true" %>
<%@ page errorPage="erreur.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%
	String url = "jdbc:postgresql://psqlserv/da2i";
	String nom = "leleuj";
	String mdp = "moi";
	Connection con=null;

	String login = request.getParameter("login");
	String password = request.getParameter("password");
	
	Class.forName("org.postgresql.Driver");
	
	con = DriverManager.getConnection(url,nom,mdp);
	Statement stmt = con.createStatement();
	
	stmt.executeUpdate("CREATE TABLE IF NOT EXISTS personne (nom TEXT, login TEXT, mdp TEXT, CONSTRAINT pk_personne PRIMARY KEY (login));");
	
	ResultSet rs = stmt.executeQuery("SELECT * FROM personne WHERE login='" + login + "' AND mdp='" + password + "';");
	
	if (rs.next()) {
		session.setAttribute("user", new Personne(rs.getString("nom"), rs.getString("login"), rs.getString("mdp")));
		out.println("<h1>Vous êtes désormais connectés</h1>");
		response.sendRedirect("cloud.jsp");
	}
	else {
		out.println("<h1>Identifiant ou mot de passe incorrect</h1>");
		out.println("<a href=\"login.html\">Page de connexion</a>");
	}
	con.close();
%>
