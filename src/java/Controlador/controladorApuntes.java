package Controlador;

import Modelo.Archivo;
import Modelo.Asignatura;
import Modelo.Usuario;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import javax.annotation.Resource;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import javax.sql.DataSource;

/**
 *
 * @author Yassin
 */
@WebServlet(name = "controladorApuntes", urlPatterns = {"/subirContenido", "/favoritos", "/borrarPdf", "/borrarFavoritos", "/borrarNotif", "/marcarLeida", "/borrarGrado", "/borrarAsig", "/añadirAsig", "/añadirGrado"})
@MultipartConfig
public class controladorApuntes extends HttpServlet {

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
            throws ServletException, IOException {
        String accion = "", vista = "", exception = "", subida, tipo;
        int insercion = 0;
        accion = request.getServletPath();
        HttpSession misesion;

        Usuario user;
        Archivo archivo;
        Asignatura asig = new Asignatura();
        Connection conn;
        PreparedStatement ps;
        ResultSet rs;
        int id_asig = -1;
        int id_pdf;

        try {
            Context c = new InitialContext();
            String nombre, enlace = "";
            TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
            conn = TFG_Pool.getConnection();

            switch (accion) {
                case "/subirContenido":
                    nombre = request.getParameter("nombre");
                    id_asig = Integer.parseInt(request.getParameter("asig"));
                    subida = request.getParameter("eleccionSubida");
                    tipo = request.getParameter("tipo");
                    
                    if (subida.equals("Archivo")) {
                        Part filePart = request.getPart("archivo");
                        InputStream fileContent = filePart.getInputStream();
                        File fileLocation = new File("C:/Users/Yassin/Desktop/versiones TFG/ApunShare_18/web/apuntes");
                        File file = new File(fileLocation, nombre + ".pdf");
                        Files.copy(fileContent, file.toPath());

                        enlace = "apuntes/" + nombre + ".pdf";
                    } else if (subida.equals("Enlace")) {
                        enlace = request.getParameter("enlace");
                    } else {
                        enlace = "enlace_erroneo";
                    }

                    archivo = new Archivo();
                    archivo.setNombre(nombre);
                    archivo.setAsig(id_asig);
                    archivo.setEnlace(enlace);
                    if("apuntes".equals(tipo)){
                        archivo.setExamen(false);
                    } else if ("examen".equals(tipo)){
                        archivo.setExamen(true);
                    }
                    System.out.println("-<-<-<-<-< archivo.examen ---> " + archivo.isExamen());
                    ps = conn.prepareStatement("INSERT INTO APUNTES (nombre, asignatura, enlace, examen) VALUES (?, ?, ?, ?)");
                    ps.setString(1, archivo.getNombre());
                    ps.setInt(2, archivo.getAsig());
                    ps.setString(3, archivo.getEnlace());
                    ps.setBoolean(4, archivo.isExamen());

                    insercion = ps.executeUpdate();
                    boolean subido;
                    if (insercion > 0) {
                        subido = true;
                    } else {
                        subido = false;
                    }

                    request.setAttribute("subido", subido);

                    //Generar notificaciones
                    int asig_notif = id_asig;
                    ps = conn.prepareStatement("SELECT usuario FROM SUSCRIPCIONES WHERE asignatura = ?");
                    ps.setInt(1, asig_notif);
                    rs = ps.executeQuery();

                    ArrayList<Integer> usuarios_notif = new ArrayList<Integer>();
                    while (rs.next()) {
                        usuarios_notif.add(rs.getInt(1));
                    }

                    for (int i = 0; i < usuarios_notif.size(); i++) {
                        ps = conn.prepareStatement("INSERT INTO NOTIFICACIONES (usuario, asignatura) VALUES (?, ?)");
                        ps.setInt(1, usuarios_notif.get(i));
                        ps.setInt(2, asig_notif);

                        insercion = ps.executeUpdate();
                    }

                    ps.close();

                    //guardar id de asig para ir al controlador asignautra
                    request.getSession().setAttribute("asigID", id_asig);

                    vista = "/asignatura";
                    break;

                case "/favoritos":
                    misesion = request.getSession();
                    user = (Usuario) misesion.getAttribute("usuario");
                    id_asig = Integer.parseInt(request.getParameter("asigID"));

                    ps = conn.prepareStatement("INSERT INTO SUSCRIPCIONES VALUES (?, ?)");
                    ps.setInt(1, user.getId());
                    ps.setInt(2, id_asig);

                    insercion = ps.executeUpdate();
                    boolean suscrito;
                    if (insercion > 0) {
                        suscrito = true;
                    } else {
                        suscrito = false;
                    }

                    request.setAttribute("suscrito", suscrito);
                    ps.close();

                    vista = "/asignatura";
                    break;

                case "/borrarPdf":
                    id_pdf = Integer.parseInt(request.getParameter("idPdf"));

                    //guardar asig del pdf a borrar para mandar posteriormente al controlador "/asignatura" nuevamente
                    ps = conn.prepareStatement("SELECT asignatura FROM APUNTES WHERE id_pdf = ?");
                    ps.setInt(1, id_pdf);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        id_asig = rs.getInt(1);
                    }
                    //fin

                    //borrar pdf de la aplicación
                    ps = conn.prepareStatement("SELECT nombre FROM APUNTES WHERE id_pdf = ?");
                    ps.setInt(1, id_pdf);
                    rs = ps.executeQuery();

                    String nomPdf = "";
                    if (rs.next()) {
                        nomPdf = rs.getString(1);
                        File pdfBorrado = new File("C:/Users/Yassin/Desktop/versiones TFG/ApunShare_18/web/apuntes/" + nomPdf + ".pdf");
                        if (pdfBorrado.delete()) {
                            System.out.println("-----------Fichero borrado correctamente---------");
                        }
                    }

                    //borrar pdf de la BD
                    ps = conn.prepareStatement("DELETE FROM APUNTES WHERE id_pdf = ?");
                    ps.setInt(1, id_pdf);
                    insercion = ps.executeUpdate();

                    ps.close();
                    request.getSession().setAttribute("asigID", id_asig);
                    vista = "/asignatura";
                    break;

                case "/borrarFavoritos":
                    misesion = request.getSession();
                    user = (Usuario) misesion.getAttribute("usuario");
                    id_asig = Integer.parseInt(request.getParameter("asigID"));

                    ps = conn.prepareStatement("DELETE FROM SUSCRIPCIONES WHERE usuario = ? AND asignatura = ?");
                    ps.setInt(1, user.getId());
                    ps.setInt(2, id_asig);

                    insercion = ps.executeUpdate();

                    ps.close();
                    vista = "/perfil";
                    break;

                case "/borrarNotif":
                    int idNotif = Integer.parseInt(request.getParameter("notifID"));

                    ps = conn.prepareStatement("DELETE FROM NOTIFICACIONES where id_notif = ?");
                    ps.setInt(1, idNotif);

                    insercion = ps.executeUpdate();
                    vista = "perfil";
                    break;

                case "/marcarLeida":
                    int notifLeida = Integer.parseInt(request.getParameter("notifLeida"));

                    ps = conn.prepareStatement("UPDATE NOTIFICACIONES SET leida = true WHERE id_notif = ?");
                    ps.setInt(1, notifLeida);

                    insercion = ps.executeUpdate();
                    vista = "perfil";
                    break;

                case "/borrarGrado":
                    String grado = request.getParameter("nomGrado");
                    
                    //borrar asignaturas de la carrera
                    ps = conn.prepareStatement("DELETE FROM ASIGNATURAS WHERE carrera = ?");
                    ps.setString(1, grado);
                    insercion = ps.executeUpdate();
                    
                    //borrar carrera
                    ps = conn.prepareStatement("DELETE FROM CARRERAS WHERE nombre = ?");
                    ps.setString(1, grado);
                    insercion = ps.executeUpdate();
                    
                    ps.close();
                    vista = "administracion";
                    break;
                    
                case "/borrarAsig":
                    id_asig = Integer.parseInt(request.getParameter("asigID"));
                    String nomCarrera = "";
                            
                    //guardar carrera de la asig a borrar para mandar posteriormente al controlador "/apuntes" nuevamente
                    ps = conn.prepareStatement("SELECT carrera FROM ASIGNATURAS WHERE id_asig = ?");
                    ps.setInt(1, id_asig);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        nomCarrera = rs.getString(1);
                    }
                    //fin
                    
                    //borrar asig
                    ps = conn.prepareStatement("DELETE FROM ASIGNATURAS WHERE id_asig = ?");
                    ps.setInt(1, id_asig);
                    insercion = ps.executeUpdate();           
                    
                    ps.close();
                    request.getSession().setAttribute("carrera", nomCarrera);
                    vista = "apuntes";
                    break;
                    
                case "/añadirAsig":
                    nombre = request.getParameter("nombre");
                    String carrera = request.getParameter("carrera");
                    String curso = request.getParameter("curso");
                    int cuatrimestre = Integer.parseInt(request.getParameter("cuatrimestre"));
                    
                    ps = conn.prepareStatement("INSERT INTO ASIGNATURAS (nombre, carrera, curso, cuatrimestre) VALUES (?, ?, ?, ?)");
                    ps.setString(1, nombre);
                    ps.setString(2, carrera);
                    ps.setString(3, curso);
                    ps.setInt(4, cuatrimestre);
                    insercion = ps.executeUpdate();  
                    
                    ps.close();
                    request.getSession().setAttribute("carrera", carrera);
                    vista = "apuntes";
                    break;
                    
                case "/añadirGrado":
                    nombre = request.getParameter("nombre");
                    String facultad = request.getParameter("facultad");
                    tipo = request.getParameter("tipo");
                    
                    ps = conn.prepareStatement("INSERT INTO CARRERAS (nombre, facultad, tipo) VALUES (?, ?, ?)");
                    ps.setString(1, nombre);
                    ps.setString(2, facultad);
                    ps.setString(3, tipo);
                    insercion = ps.executeUpdate();  
                    
                    ps.close();
                    vista = "administracion";
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
            out.println("<h1>Respusta del controlador de apuntes</h1>");
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
        processRequest(request, response);
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
        processRequest(request, response);
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
