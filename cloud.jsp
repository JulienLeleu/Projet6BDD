<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="java.io.*" %>
<%@ page import="entity.*" %>
<%@ page session="true" %>
<%@ page errorPage="erreur.jsp" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<% 	if (session.getAttribute("user") == null) {
		response.sendRedirect("login.html");
	} 
	else {
%>
<!DOCTYPE html>
<html>
	<head>
		<title>Cloud</title>
	</head>
	<body>
		<h1>Upload</h1>
		<form method="POST" action="servlet/Upload" enctype="multipart/form-data"/>
			<input type="FILE" name="file"/>
			<input type="SUBMIT" value="Upload" />
		</form>		
	</body>
</html>
<%	} %>

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
	String pseudo = ((Personne)session.getAttribute("user")).getLogin();
	
	String [] fichiers = new File(application.getRealPath("/users/" + pseudo)).list();
	out.println("<h1>Vos fichiers : </h1>");
	for (int i = 0; i < fichiers.length; i++) {
		out.println("<p><a href=users/" + pseudo + "/" + fichiers[i] + ">" + fichiers[i] + "</a></p>");
	}
	
	con.close();
%>
