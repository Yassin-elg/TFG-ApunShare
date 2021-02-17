package Controlador;

import Modelo.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

/**
 *
 * @author Yassin
 */
@WebServlet(name = "controladorUsuarios", urlPatterns = {"/Insertar", "/Login", "/bajaUsuario", "/darAdmin", "/quitarAdmin", "/loginGmail"})
public class controladorUsuarios extends HttpServlet {

    @Resource(name = "TFG_Pool")
    private DataSource TFG_Pool;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, NoSuchAlgorithmException {
        String accion = "", vista = "", exception = "";
        //accion = request.getPathInfo();
        accion = request.getServletPath();

        Usuario user;
        int id_usu;
        Connection conn;
        PreparedStatement ps;

        MessageDigest md;
        byte[] claveBytes;
        byte[] digested;

        try {
            Context c = new InitialContext();
            String correo, clave, nombre;
            TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
            conn = TFG_Pool.getConnection();

            switch (accion) {
                case "/Insertar":
                    nombre = request.getParameter("nombre");
                    correo = request.getParameter("correo");
                    clave = request.getParameter("clave");

                    //Encriptación con MD5
                    md = MessageDigest.getInstance("MD5");
                    md.reset();

                    claveBytes = clave.getBytes();
                    digested = md.digest(claveBytes);

                    StringBuffer sb = new StringBuffer();
                    for (int i = 0; i < digested.length; i++) {
                        sb.append(Integer.toHexString(0xff & digested[i]));
                    }
                    clave = sb.toString();
                    //Fin encriptación con MD5

                    user = new Usuario();
                    user.setNombre(nombre);
                    user.setCorreo(correo);
                    user.setClave(clave);

                    ps = conn.prepareStatement("INSERT INTO USUARIOS (nombre, correo, clave) VALUES (?, ?, ?)");
                    ps.setString(1, user.getNombre());
                    ps.setString(2, user.getCorreo());
                    ps.setString(3, user.getClave());

                    int insercion = 0;
                    insercion = ps.executeUpdate();
                    boolean registrado;
                    if (insercion > 0) {
                        registrado = true;
                    } else {
                        registrado = false;
                    }

                    request.setAttribute("register", registrado);
                    vista = "/registro.jsp";
                    ps.close();
                    break;

                case "/Login":
                    correo = request.getParameter("correo");
                    clave = request.getParameter("clave");

                    //Encriptación con MD5
                    md = MessageDigest.getInstance("MD5");
                    md.reset();

                    claveBytes = clave.getBytes();
                    digested = md.digest(claveBytes);

                    sb = new StringBuffer();
                    for (int i = 0; i < digested.length; i++) {
                        sb.append(Integer.toHexString(0xff & digested[i]));
                    }
                    clave = sb.toString();
                    //Fin encriptación con MD5

                    user = new Usuario();
                    user.setCorreo(correo);
                    user.setClave(clave);

                    ps = conn.prepareStatement("SELECT * FROM USUARIOS WHERE correo = ? AND clave = ?");
                    ps.setString(1, user.getCorreo());
                    ps.setString(2, user.getClave());

                    ResultSet rs = ps.executeQuery();
                    boolean login;
                    if (rs.next()) {
                        HttpSession misesion = request.getSession();
                        login = true;
                        user.setId(rs.getInt(1));
                        user.setNombre(rs.getString(2));
                        user.setAdmin(rs.getBoolean(5));
                        misesion.setAttribute("login", login);
                        misesion.setAttribute("usuario", user);
                    } else {
                        login = false;
                        request.setAttribute("login", login);
                    }

                    vista = "/inicio.jsp";
                    ps.close();
                    break;

                case "/bajaUsuario":
                    id_usu = Integer.parseInt(request.getParameter("idUSU"));

                    ps = conn.prepareStatement("DELETE FROM USUARIOS WHERE id_usuario = ?");
                    ps.setInt(1, id_usu);

                    insercion = ps.executeUpdate();
                    if (insercion > 0) {
                        System.out.println("------->>>>>> Borrado correctamente");
                    } else {
                        System.out.println("------->>>>>> error");
                    }

                    //borrar suscripciones del usuario que se ha borrado
                    ps = conn.prepareStatement("DELETE FROM SUSCRIPCIONES WHERE usuario = ?");
                    ps.setInt(1, id_usu);
                    insercion = ps.executeUpdate();

                    //borrar notificaciones del usuario que se ha borrado
                    ps = conn.prepareStatement("DELETE FROM NOTIFICACIONES WHERE usuario = ?");
                    ps.setInt(1, id_usu);
                    insercion = ps.executeUpdate();

                    vista = "/administracion";
                    ps.close();
                    break;

                case "/darAdmin":
                    id_usu = Integer.parseInt(request.getParameter("idUSU"));
                    ps = conn.prepareStatement("UPDATE USUARIOS SET admin = true WHERE id_usuario = ?");
                    ps.setInt(1, id_usu);

                    insercion = ps.executeUpdate();
                    if (insercion > 0) {
                        System.out.println("------->>>>>> dar admin correctamente");
                    } else {
                        System.out.println("------->>>>>> error");
                    }
                    vista = "/administracion";
                    ps.close();
                    break;

                case "/quitarAdmin":
                    id_usu = Integer.parseInt(request.getParameter("idUSU"));
                    ps = conn.prepareStatement("UPDATE USUARIOS SET admin = false WHERE id_usuario = ?");
                    ps.setInt(1, id_usu);

                    insercion = ps.executeUpdate();
                    if (insercion > 0) {
                        System.out.println("------->>>>>> quitar admin correctamente");
                    } else {
                        System.out.println("------->>>>>> error");
                    }
                    vista = "/administracion";
                    ps.close();
                    break;

                case "/loginGmail":
                    nombre = request.getParameter("nombre");
                    correo = request.getParameter("correo");

                    user = new Usuario();
                    user.setNombre(nombre);
                    user.setCorreo(correo);

                    //Comprobar si existe en la BD
                    ps = conn.prepareStatement("SELECT * FROM USUARIOS WHERE correo = ?");
                    ps.setString(1, user.getCorreo());

                    rs = ps.executeQuery();
                    if (rs.next()) {//Si existe, hacemos login
                        HttpSession misesion = request.getSession();
                        login = true;
                        user.setId(rs.getInt(1));
                        user.setNombre(rs.getString(2));
                        user.setAdmin(rs.getBoolean(5));
                        misesion.setAttribute("login", login);
                        misesion.setAttribute("usuario", user);

                        vista = "/inicio.jsp";
                    } else {//Si no existe, lo insertamos en la BD antes de hacer login
                        ps = conn.prepareStatement("INSERT INTO USUARIOS (nombre, correo) VALUES (?, ?)");
                        ps.setString(1, user.getNombre());
                        ps.setString(2, user.getCorreo());

                        insercion = ps.executeUpdate();

                        ps = conn.prepareStatement("SELECT * FROM USUARIOS WHERE correo = ?");
                        ps.setString(1, user.getCorreo());

                        rs = ps.executeQuery();
                        if (rs.next()) {
                            HttpSession misesion = request.getSession();
                            login = true;
                            user.setId(rs.getInt(1));
                            user.setNombre(rs.getString(2));
                            user.setAdmin(rs.getBoolean(5));
                            misesion.setAttribute("login", login);
                            misesion.setAttribute("usuario", user);
                        }
                    }

                    vista = "/inicio.jsp";
                    ps.close();
                    break;

                default:
                    vista = "/inicio.jsp";
                    break;
            }

            conn.close();
            RequestDispatcher rd = request.getRequestDispatcher(vista);
            rd.forward(request, response);

        } catch (NamingException ex) {
            exception = "<p>ERROR: Recurso no disponible</p>";
            System.out.println(ex);
        } catch (SQLException ex) {
            exception = "<p>ERROR: Base de Datos no disponible</p>";
            System.out.println(ex);
        } catch (NumberFormatException ex) {
            exception = "<p>ERROR: Parámetros no Válidos</p>";
            System.out.println(ex);
        }

        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>ApunShare</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Respusta del controlador de usuarios</h1>");
            out.println("<h2>Error ocurrido</h2>");
            out.println(exception);
            out.println("<p><a href=\"inicio.jsp\">Volver</a>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(controladorUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(controladorUsuarios.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
