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
	session.invalidate();
	response.sendRedirect("login.html");
%>
