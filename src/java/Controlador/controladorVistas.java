package Controlador;

import Modelo.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.charset.StandardCharsets;
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
@WebServlet(name = "controladorVistas", urlPatterns = {"/inicio", "/perfil", "/registro", "/cerrar", "/apuntes", "/asignatura", "/administracion", "/carreras", "/busqueda"})
public class controladorVistas extends HttpServlet {

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
        String accion = "", vista = "", exception = "";
        accion = request.getServletPath();
        HttpSession misesion;

        Asignatura asig = new Asignatura();
        Archivo archivo = new Archivo();
        Usuario user;
        Carrera grado;
        Connection conn;
        PreparedStatement ps;

        Context c;
        ResultSet rs;

        try {

            switch (accion) {
                case "/inicio":
                    vista = "/inicio.jsp";
                    break;

                case "/perfil":
                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    //recoger id de asigs. fav. de SUSCRIPCIONES
                    misesion = request.getSession(false);
                    ps = conn.prepareStatement("SELECT * FROM SUSCRIPCIONES WHERE usuario = ?");
                    if (misesion != null) {

                        user = (Usuario) misesion.getAttribute("usuario");

                        ps.setInt(1, user.getId());
                        rs = ps.executeQuery();
                        ArrayList<Integer> asigs = new ArrayList<Integer>();
                        while (rs.next()) {
                            asigs.add(rs.getInt(2));
                        }

                        //recoger datos de asigs. fav. de ASIGNATURAS
                        ArrayList<Asignatura> favs = new ArrayList<>();
                        for (int i = 0; i < asigs.size(); i++) {
                            ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE id_asig = ?");
                            ps.setInt(1, asigs.get(i));
                            rs = ps.executeQuery();
                            if (rs.next()) {
                                asig = new Asignatura();
                                asig.setId_asig(rs.getInt(1));
                                asig.setNombre(rs.getString(2));
                                asig.setCarrera(rs.getString(3));
                                asig.setCurso(rs.getString(4));
                                asig.setCuatrimestre(rs.getInt(5));
                                favs.add(asig);
                            }
                        }
                        request.setAttribute("favoritos", favs);

                        //cargar notificaciones nuevas
                        ps = conn.prepareStatement("SELECT * FROM NOTIFICACIONES WHERE usuario = ? AND leida = false");
                        ps.setInt(1, user.getId());

                        rs = ps.executeQuery();
                        ArrayList<Notificacion> notificaciones = new ArrayList<>();
                        ArrayList<String> NomAsignaturas = new ArrayList<String>();
                        while (rs.next()) {
                            Notificacion notif = new Notificacion();
                            notif.setId_notif(rs.getInt(1));
                            notif.setUsuario(rs.getInt(2));
                            notif.setAsignatura(rs.getInt(3));
                            notif.setLeida(rs.getBoolean(4));
                            notificaciones.add(notif);

                            ps = conn.prepareStatement("SELECT nombre FROM ASIGNATURAS WHERE id_asig = ?");
                            ps.setInt(1, notif.getAsignatura());

                            ResultSet rsa = ps.executeQuery();

                            while (rsa.next()) {
                                String NomAsigNotif = rsa.getString(1);
                                NomAsignaturas.add(NomAsigNotif);
                            }

                        }
                        request.setAttribute("notifAsignaturas", NomAsignaturas);
                        request.setAttribute("notificaciones", notificaciones);

                        //cargar notificaciones leidas
                        ps = conn.prepareStatement("SELECT * FROM NOTIFICACIONES WHERE usuario = ? AND leida = true");
                        ps.setInt(1, user.getId());

                        rs = ps.executeQuery();
                        ArrayList<Notificacion> notificacionesLeidas = new ArrayList<>();
                        ArrayList<String> NomAsignaturasLeidas = new ArrayList<String>();
                        while (rs.next()) {
                            Notificacion notif = new Notificacion();
                            notif.setId_notif(rs.getInt(1));
                            notif.setUsuario(rs.getInt(2));
                            notif.setAsignatura(rs.getInt(3));
                            notif.setLeida(rs.getBoolean(4));
                            notificacionesLeidas.add(notif);

                            ps = conn.prepareStatement("SELECT nombre FROM ASIGNATURAS WHERE id_asig = ?");
                            ps.setInt(1, notif.getAsignatura());

                            ResultSet rsa = ps.executeQuery();

                            while (rsa.next()) {
                                String NomAsigNotif = rsa.getString(1);
                                NomAsignaturasLeidas.add(NomAsigNotif);
                            }

                        }
                        request.setAttribute("notifAsignaturasLeidas", NomAsignaturasLeidas);
                        request.setAttribute("notificacionesLeidas", notificacionesLeidas);
                    }

                    ps.close();
                    conn.close();
                    vista = "/perfil.jsp";
                    break;

                case "/registro":
                    vista = "/registro.jsp";
                    break;

                case "/apuntes":
                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    String carrera;

                    if (request.getParameter("carrera") != null) {
                        carrera = request.getParameter("carrera");
                    } else {
                        carrera = request.getSession().getAttribute("carrera").toString();
                    }

                    request.setAttribute("carrera", carrera);

                    //Cargar asignaturas de primer curso
                    ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE curso = 'primero' AND carrera = ?");
                    ps.setString(1, carrera);
                    rs = ps.executeQuery();
                    ArrayList<Asignatura> primerCurso = new ArrayList<>();
                    while (rs.next()) {
                        asig = new Asignatura();
                        asig.setId_asig(rs.getInt(1));
                        asig.setNombre(rs.getString(2));
                        asig.setCarrera(rs.getString(3));
                        asig.setCurso(rs.getString(4));
                        asig.setCuatrimestre(rs.getInt(5));
                        primerCurso.add(asig);
                    }
                    request.setAttribute("primerCurso", primerCurso);

                    //Cargar asignaturas de segundo curso
                    ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE curso = 'segundo' AND carrera = ?");
                    ps.setString(1, carrera);
                    rs = ps.executeQuery();
                    ArrayList<Asignatura> segundoCurso = new ArrayList<>();
                    while (rs.next()) {
                        asig = new Asignatura();
                        asig.setId_asig(rs.getInt(1));
                        asig.setNombre(rs.getString(2));
                        asig.setCarrera(rs.getString(3));
                        asig.setCurso(rs.getString(4));
                        asig.setCuatrimestre(rs.getInt(5));
                        segundoCurso.add(asig);
                    }
                    request.setAttribute("segundoCurso", segundoCurso);

                    //Cargar asignaturas de tercer curso
                    ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE curso = 'tercero' AND carrera = ?");
                    ps.setString(1, carrera);
                    rs = ps.executeQuery();
                    ArrayList<Asignatura> tercerCurso = new ArrayList<>();
                    while (rs.next()) {
                        asig = new Asignatura();
                        asig.setId_asig(rs.getInt(1));
                        asig.setNombre(rs.getString(2));
                        asig.setCarrera(rs.getString(3));
                        asig.setCurso(rs.getString(4));
                        asig.setCuatrimestre(rs.getInt(5));
                        tercerCurso.add(asig);
                    }
                    request.setAttribute("tercerCurso", tercerCurso);

                    //Cargar asignaturas de cuarto curso
                    ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE curso = 'cuarto' AND carrera = ?");
                    ps.setString(1, carrera);
                    rs = ps.executeQuery();
                    ArrayList<Asignatura> cuartoCurso = new ArrayList<>();
                    while (rs.next()) {
                        asig = new Asignatura();
                        asig.setId_asig(rs.getInt(1));
                        asig.setNombre(rs.getString(2));
                        asig.setCarrera(rs.getString(3));
                        asig.setCurso(rs.getString(4));
                        asig.setCuatrimestre(rs.getInt(5));
                        cuartoCurso.add(asig);
                    }
                    request.setAttribute("cuartoCurso", cuartoCurso);

                    ps.close();
                    conn.close();
                    vista = "/apuntes.jsp";
                    break;

                case "/cerrar":
                    HttpSession sesion = request.getSession(false);
                    sesion.invalidate();
                    vista = "/inicio.jsp";
                    break;

                case "/asignatura":
                    int id_asig;
                    if (request.getParameter("asigID") != null) {
                        id_asig = Integer.parseInt(request.getParameter("asigID"));
                    } else {
                        id_asig = Integer.parseInt(request.getSession().getAttribute("asigID").toString());
                    }

                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    //cargar datos de asignatura
                    ps = conn.prepareStatement("SELECT * FROM ASIGNATURAS WHERE id_asig = ?");
                    ps.setInt(1, id_asig);
                    rs = ps.executeQuery();
                    if (rs.next()) {
                        asig = new Asignatura();
                        asig.setId_asig(rs.getInt(1));
                        asig.setNombre(rs.getString(2));
                        asig.setCarrera(rs.getString(3));
                        asig.setCurso(rs.getString(4));
                        asig.setCuatrimestre(rs.getInt(5));
                    }
                    request.setAttribute("asignatura", asig);

                    //Cargar apuntes de asignatura
                    ps = conn.prepareStatement("SELECT * FROM APUNTES WHERE asignatura = ? AND examen = false");
                    ps.setInt(1, id_asig);
                    rs = ps.executeQuery();

                    ArrayList<Archivo> apuntes = new ArrayList<>();
                    while (rs.next()) {
                        archivo = new Archivo();
                        archivo.setId(rs.getInt(1));
                        archivo.setNombre(rs.getString(2));
                        archivo.setAsig(rs.getInt(3));
                        archivo.setEnlace(rs.getString(4));
                        apuntes.add(archivo);
                    }
                    request.setAttribute("apuntes", apuntes);

                    //Cargar exámenes de asignatura
                    ps = conn.prepareStatement("SELECT * FROM APUNTES WHERE asignatura = ? AND examen = true");
                    ps.setInt(1, id_asig);
                    rs = ps.executeQuery();

                    ArrayList<Archivo> examenes = new ArrayList<>();
                    while (rs.next()) {
                        archivo = new Archivo();
                        archivo.setId(rs.getInt(1));
                        archivo.setNombre(rs.getString(2));
                        archivo.setAsig(rs.getInt(3));
                        archivo.setEnlace(rs.getString(4));
                        examenes.add(archivo);
                    }
                    request.setAttribute("examenes", examenes);

                    //Comprobar si está suscrito
                    misesion = request.getSession(false);
                    if (misesion.getAttribute("usuario") != null) {
                        user = (Usuario) misesion.getAttribute("usuario");

                        ps = conn.prepareStatement("SELECT * FROM SUSCRIPCIONES WHERE usuario = ? AND asignatura = ?");
                        ps.setInt(1, user.getId());
                        ps.setInt(2, id_asig);
                        rs = ps.executeQuery();

                        boolean suscrito;
                        if (rs.next()) {
                            suscrito = true;
                        } else {
                            suscrito = false;
                        }
                        request.setAttribute("suscrito", suscrito);
                    }

                    ps.close();
                    conn.close();
                    vista = "/asignatura.jsp";
                    break;

                case "/administracion":
                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    //Cargar usuarios
                    ps = conn.prepareStatement("SELECT * FROM USUARIOS");
                    rs = ps.executeQuery();

                    ArrayList<Usuario> usuarios = new ArrayList<>();
                    while (rs.next()) {
                        user = new Usuario();
                        user.setId(rs.getInt(1));
                        user.setNombre(rs.getString(2));
                        user.setCorreo(rs.getString(3));
                        user.setClave(rs.getString(4));
                        user.setAdmin(rs.getBoolean(5));
                        usuarios.add(user);
                    }
                    request.setAttribute("usuarios", usuarios);

                    //Cargar carreras
                    ps = conn.prepareStatement("SELECT * FROM CARRERAS");
                    rs = ps.executeQuery();

                    ArrayList<Carrera> grados = new ArrayList<>();
                    while (rs.next()) {
                        grado = new Carrera();
                        grado.setId_carrera(rs.getInt(1));
                        grado.setNombre(rs.getString(2));
                        grado.setFacultad(rs.getString(3));
                        grado.setTipo(rs.getString(4));
                        grados.add(grado);
                    }
                    request.setAttribute("grados", grados);

                    ps.close();
                    conn.close();
                    vista = "/administracion.jsp";
                    break;

                case "/carreras":
                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    //Cargar grados de Escuela Técnica Superior de Ingeniería
                    ps = conn.prepareStatement("SELECT * FROM CARRERAS WHERE facultad = 'Escuela Técnica Superior de Ingeniería'");
                    rs = ps.executeQuery();

                    ArrayList<Carrera> gradosETSI = new ArrayList<>();
                    while (rs.next()) {
                        grado = new Carrera();
                        grado.setId_carrera(rs.getInt(1));
                        grado.setNombre(rs.getString(2));
                        grado.setFacultad(rs.getString(3));
                        grado.setTipo(rs.getString(4));
                        gradosETSI.add(grado);
                    }
                    request.setAttribute("gradosETSI", gradosETSI);

                    //Cargar grados de Facultad de Derecho
                    ps = conn.prepareStatement("SELECT * FROM CARRERAS WHERE facultad = 'Facultad de Derecho'");
                    rs = ps.executeQuery();

                    ArrayList<Carrera> gradosFD = new ArrayList<>();
                    while (rs.next()) {
                        grado = new Carrera();
                        grado.setId_carrera(rs.getInt(1));
                        grado.setNombre(rs.getString(2));
                        grado.setFacultad(rs.getString(3));
                        grado.setTipo(rs.getString(4));
                        gradosFD.add(grado);
                    }
                    request.setAttribute("gradosFD", gradosFD);

                    //Cargar grados de Facultad de Ciencias Experimentales
                    ps = conn.prepareStatement("SELECT * FROM CARRERAS WHERE facultad = 'Facultad de Ciencias Experimentales'");
                    rs = ps.executeQuery();

                    ArrayList<Carrera> gradosFCE = new ArrayList<>();
                    while (rs.next()) {
                        grado = new Carrera();
                        grado.setId_carrera(rs.getInt(1));
                        grado.setNombre(rs.getString(2));
                        grado.setFacultad(rs.getString(3));
                        grado.setTipo(rs.getString(4));
                        gradosFCE.add(grado);
                    }
                    request.setAttribute("gradosFCE", gradosFCE);

                    ps.close();
                    conn.close();
                    vista = "carreras.jsp";
                    break;

                case "/busqueda":
                    c = new InitialContext();
                    TFG_Pool = (DataSource) c.lookup("jdbc/TFG_Datasource");
                    conn = TFG_Pool.getConnection();

                    String busqueda = request.getParameter("consulta");

                    busqueda = busqueda.replace("!", "!!").replace("%", "!%").replace("_", "!_").replace("[", "![");

                    ps = conn.prepareStatement("SELECT * FROM APUNTES WHERE nombre LIKE ? ESCAPE '!'");
                    ps.setString(1, "%" + busqueda + "%");
                    rs = ps.executeQuery();

                    ArrayList<Archivo> pdfBusqueda = new ArrayList<>();
                    while (rs.next()) {
                        archivo = new Archivo();
                        archivo.setId(rs.getInt(1));
                        archivo.setNombre(rs.getString(2));
                        archivo.setAsig(rs.getInt(3));
                        archivo.setEnlace(rs.getString(4));
                        System.out.println("busqueda ---> " + archivo.getNombre());
                        pdfBusqueda.add(archivo);
                    }
                    request.setAttribute("resultadoBusqueda", pdfBusqueda);

                    ps.close();
                    conn.close();
                    vista = "busqueda.jsp";
                    break;

                default:
                    vista = "/inicio.jsp";
                    break;
            }
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
