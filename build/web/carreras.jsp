<%-- 
    Document   : carreras
    Created on : 29-oct-2020, 17:33:35
    Author     : Yassin
--%>

<%@page import="java.nio.charset.StandardCharsets"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>ApunShare</title>
        <link href="estilos/css1.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
    </head>
    <body>
        <header>
            <h1 class="titulo"> ApunShare </h1>
        </header>

        <hr/>

        <nav class="navbar navbar-expand-lg navbar-expand-md navbar-light bg-light">
            <button class="navbar-toggler bg-light navbar-light" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav mx-auto">
                    <li class="nav-item active">
                        <a class="nav-link text-primary" href="inicio"> INICIO<span class="sr-only">(current)</span></a>
                    </li>
                    <li class="nav-item active">
                        <a class="nav-link text-primary" href="carreras">APUNTES</a>
                    </li>
                    <c:choose>
                        <c:when test="${sessionScope.login == null}">
                            <li class="nav-item">
                                <a class="nav-link text-primary" href="registro">REGISTRARSE</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <a class="nav-link text-primary" href="perfil">PERFIL</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </nav>

        <hr/>

        <div class="container">
            <div class="row">
                <div class="col-3">
                    <c:if test="${sessionScope.usuario.isAdmin()}">
                        <form method="post" action="administracion">
                            <button type="submit" class="btn btn-dark">
                                <p class="d-none d-sm-none d-md-inline d-lg-inline d-xl-inline">Administración</p>
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-lines-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm7 1.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm-2-3a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm0-3a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5zm2 9a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5z"/>
                                </svg>
                            </button>
                        </form>
                    </c:if>
                </div>
                <div class="col-6 busqueda">
                    <form action="busqueda" method="post" class="b">
                        <table>
                            <tr>
                                <td><input type="text" name="consulta" class="form-control"/></td>     
                                <td>
                                    <button type="submit" class="btn btn-dark">
                                        <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-search" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path fill-rule="evenodd" d="M10.442 10.442a1 1 0 0 1 1.415 0l3.85 3.85a1 1 0 0 1-1.414 1.415l-3.85-3.85a1 1 0 0 1 0-1.415z"/>
                                        <path fill-rule="evenodd" d="M6.5 12a5.5 5.5 0 1 0 0-11 5.5 5.5 0 0 0 0 11zM13 6.5a6.5 6.5 0 1 1-13 0 6.5 6.5 0 0 1 13 0z"/>
                                        </svg>
                                    </button>
                                </td>
                            </tr>
                        </table>
                    </form>
                </div>
                <div class="col-3">
                    <c:if test="${sessionScope.login}">
                        <form method="post" action="cerrar" onclick="return confirmarCerrarSesion();">
                            <button type="submit" class="btn btn-dark">
                                <p class="d-none d-sm-none d-md-inline d-lg-inline d-xl-inline">Cerrar sesión</p>
                                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-person-x-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                <path fill-rule="evenodd" d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6zm6.146-2.854a.5.5 0 0 1 .708 0L14 6.293l1.146-1.147a.5.5 0 0 1 .708.708L14.707 7l1.147 1.146a.5.5 0 0 1-.708.708L14 7.707l-1.146 1.147a.5.5 0 0 1-.708-.708L13.293 7l-1.147-1.146a.5.5 0 0 1 0-.708z"/>
                                </svg>
                            </button>
                        </form>
                    </c:if>
                </div>
            </div>
        </div>

        <hr/>

        <div class="container-fluid">
            <div class="row">
                <div class="col-xl-2 col-lg-2 col-md-3 col-sm-12">
                    <img src="images/logo_uhu.jpg" alt=""/>
                </div>
                <div class="col-xl-6 col-lg-6 col-md-9 col-sm-12">
                    <br/><br/>
                    <ul>
                        <li><h3>Escuela Técnica Superior de Ingeniería</h3><br/>
                            <ul>
                                <c:forEach var="a" items="${requestScope.gradosETSI}">
                                    <li><a href="apuntes?carrera=${a.nombre}">${a.nombre}</a></li><br/>
                                    </c:forEach>
                            </ul>
                        </li><br/>
                        <li><h3>Facultad de Derecho</h3><br/>
                            <ul>
                                <c:forEach var="a" items="${requestScope.gradosFD}">
                                    <li><a href="apuntes?carrera=${a.nombre}">${a.nombre}</a></li><br/>
                                    </c:forEach>
                            </ul>
                        </li><br/>
                        <li><h3>Facultad de Ciencias Experimentales</h3><br/>
                            <ul>
                                <c:forEach var="a" items="${requestScope.gradosFCE}">
                                    <li><a href="apuntes?carrera=${a.nombre}">${a.nombre}</a></li><br/>
                                    </c:forEach>
                            </ul>
                        </li>
                    </ul>
                </div>
                <div class="col-xl-4 col-lg-4 col-md col-sm">
                    <br/><br/><img src="images/carreras-1.PNG"  class="img-fluid" alt="Responsive image" style="min-width: 200px;"/>
                </div>
            </div>
        </div><br/><br/>

        <hr/>

        <footer>
            <p> &copy; Yassin El Ghazouani Azzouzi 2020 </p>
        </footer>
        <script src="funciones/js1.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </section>
</body>
</html>
