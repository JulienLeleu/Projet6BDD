// Servlet Test.java  de test de la configuration
import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;

import java.util.logging.Level;
import java.util.logging.Logger;
import entity.*;

@MultipartConfig
@WebServlet("/servlet/Upload")
public class Upload extends HttpServlet {
	private final static Logger LOGGER = Logger.getLogger(Upload.class.getCanonicalName());

	public void service( HttpServletRequest req, HttpServletResponse res ) throws ServletException, IOException {
    
	HttpSession session = req.getSession();
	if (session.getAttribute("user") == null) {
		res.sendRedirect("../login.html");
	}
	String login = ((Personne)session.getAttribute("user")).getLogin();

    res.setContentType( "text/html" );
    //Creation des composants pour sauver le fichier
	final String path = req.getServletContext().getRealPath("/users/" + login);	//destination
    final Part filePart = req.getPart("file");							//on recupère le fichier
    final String fileName = getFileName(filePart);						//on recupère le nom du fichier

    OutputStream out = null;
    InputStream filecontent = null;
    final PrintWriter writer = res.getWriter();

    try {
        out = new FileOutputStream(new File(path + File.separator + fileName));
        filecontent = filePart.getInputStream();

        int read = 0;
        final byte[] bytes = new byte[1024];

        while ((read = filecontent.read(bytes)) != -1) {
            out.write(bytes, 0, read);
        }
        writer.println("New file " + fileName + " created at " + path);
        LOGGER.log(Level.INFO, "File{0}being uploaded to {1}", new Object[]{fileName, path});
        res.sendRedirect("../cloud.jsp");
    } catch (FileNotFoundException fne) {
        writer.println("Vous n'avez pas spécifiez de fichier à uploader ou vous essayez d'upload un fichier protegé ou inexistant.");
        writer.println("<br/> ERROR: " + fne.getMessage());

        LOGGER.log(Level.SEVERE, "Problemes pendant l'upload du fichier. Error: {0}", new Object[]{fne.getMessage()});
    } finally {
        if (out != null) {
            out.close();
        }
        if (filecontent != null) {
            filecontent.close();
        }
        if (writer != null) {
            writer.close();
        }
    }
  }


  private String getFileName(final Part part) {
	    final String partHeader = part.getHeader("content-disposition");
	    LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
	    for (String content : part.getHeader("content-disposition").split(";")) {
	        if (content.trim().startsWith("filename")) {
	            return content.substring(
	                    content.indexOf('=') + 1).trim().replace("\"", "");
	        }
	    }
	    return null;
	}
}