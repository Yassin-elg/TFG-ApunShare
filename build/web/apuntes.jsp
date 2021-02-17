<%-- 
    Document   : apuntes
    Created on : 08-jul-2020, 18:33:10
    Author     : Yassin
--%>

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


        <h2>${requestScope.carrera}</h2>

        <ul class="listado">
            <li>
                <input type="checkbox" name="list" id="nivel-1"/><label for="nivel-1">Primero</label>
                <ul class="interior">
                    <li>
                        <div>
                            <c:choose>
                                <c:when test="${!empty requestScope.primerCurso}">
                                    <table class="table table-striped table-sm col-xl-7 col-lg-8 col-md-9">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th style="width: 45%">NOMBRE</th>
                                                <th style="width: 20%">CURSO</th>
                                                <th style="width: 20%; text-align: center;">CUATRIMESTRE</th>
                                                    <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <th style="width: 15%; text-align: center;">BORRAR</th>
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <c:forEach var="asig" items="${requestScope.primerCurso}">
                                            <tr>
                                                <td><a href="asignatura?asigID=${asig.id_asig}" title="Ver apuntes de ${asig.nombre}">${asig.nombre}</a></td>
                                                <td>${asig.curso}</td>
                                                <td style="text-align: center;">${asig.cuatrimestre}</td>
                                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <td style="text-align: center"><a href="borrarAsig?asigID=${asig.id_asig}" onclick="return confirmarBorrarAsig('${asig.nombre}');">
                                                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                            </svg>
                                                        </a></td>
                                                    </c:if>  
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <p>No hay asignaturas disponibles para este curso</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>
                </ul>
            </li>
            <li>
                <input type="checkbox" name="list" id="nive2-1"/><label for="nive2-1">Segundo</label>
                <ul class="interior">    
                    <li>
                        <div>
                            <c:choose>
                                <c:when test="${!empty requestScope.segundoCurso}">
                                    <table class="table table-striped table-sm col-xl-7 col-lg-8 col-md-9">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th style="width: 45%">NOMBRE</th>
                                                <th style="width: 20%">CURSO</th>
                                                <th style="width: 20%; text-align: center;">CUATRIMESTRE</th>
                                                    <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <th style="width: 15%; text-align: center;">BORRAR</th>
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <c:forEach var="asig" items="${requestScope.segundoCurso}">
                                            <tr>
                                                <td><a href="asignatura?asigID=${asig.id_asig}" title="Ver apuntes de ${asig.nombre}">${asig.nombre}</a></td>
                                                <td>${asig.curso}</td>
                                                <td style="text-align: center;">${asig.cuatrimestre}</td>
                                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <td style="text-align: center"><a href="borrarAsig?asigID=${asig.id_asig}" onclick="return confirmarBorrarAsig('${asig.nombre}');">
                                                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                            </svg>
                                                        </a></td>
                                                    </c:if> 
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <p>No hay asignaturas disponibles para este curso</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>   
                </ul>
            </li>
            <li>
                <input type="checkbox" name="list" id="nive3-1"/><label for="nive3-1">Tercero</label>
                <ul class="interior">    
                    <li>
                        <div>
                            <c:choose>
                                <c:when test="${!empty requestScope.tercerCurso}">
                                    <table class="table table-striped table-sm col-xl-7 col-lg-8 col-md-9">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th style="width: 45%">NOMBRE</th>
                                                <th style="width: 20%">CURSO</th>
                                                <th style="width: 20%; text-align: center;">CUATRIMESTRE</th>
                                                    <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <th style="width: 15%; text-align: center">BORRAR</th>
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <c:forEach var="asig" items="${requestScope.tercerCurso}">
                                            <tr>
                                                <td><a href="asignatura?asigID=${asig.id_asig}" title="Ver apuntes de ${asig.nombre}">${asig.nombre}</a></td>
                                                <td>${asig.curso}</td>
                                                <td style="text-align: center;">${asig.cuatrimestre}</td>
                                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <td style="text-align: center"><a href="borrarAsig?asigID=${asig.id_asig}" onclick="return confirmarBorrarAsig('${asig.nombre}');">
                                                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                            </svg>
                                                        </a></td>
                                                    </c:if> 
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <p>No hay asignaturas disponibles para este curso</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>   
                </ul>
            </li>
            <li>
                <input type="checkbox" name="list" id="nive4-1"/><label for="nive4-1">Cuarto</label>
                <ul class="interior">    
                    <li>
                        <div>
                            <c:choose>
                                <c:when test="${!empty requestScope.cuartoCurso}">
                                    <table class="table table-striped table-sm col-xl-7 col-lg-8 col-md-9">
                                        <thead class="thead-dark">
                                            <tr>
                                                <th style="width: 45%">NOMBRE</th>
                                                <th style="width: 20%">CURSO</th>
                                                <th style="width: 20%; text-align: center;">CUATRIMESTRE</th>
                                                    <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <th style="width: 15%; text-align: center;">BORRAR</th>
                                                    </c:if>
                                            </tr>
                                        </thead>
                                        <c:forEach var="asig" items="${requestScope.cuartoCurso}">
                                            <tr>
                                                <td><a href="asignatura?asigID=${asig.id_asig}" title="Ver apuntes de ${asig.nombre}">${asig.nombre}</a></td>
                                                <td>${asig.curso}</td>
                                                <td style="text-align: center;">${asig.cuatrimestre}</td>
                                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                                    <td style="text-align: center">
                                                        <a href="borrarAsig?asigID=${asig.id_asig}" onclick="return confirmarBorrarAsig('${asig.nombre}');">
                                                            <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                                            <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                                            <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                                            </svg>
                                                        </a>
                                                    </td>
                                                </c:if> 
                                            </tr>
                                        </c:forEach>
                                    </table>
                                </c:when>
                                <c:otherwise>
                                    <p>No hay asignaturas disponibles para este curso</p>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </li>   
                </ul>
            </li>
        </ul>

        <br/><br/>

        <c:if test="${sessionScope.usuario.isAdmin()}">
            <div class="col-xl-5 col-lg-6 col-md-7">
                <button onclick="añadirAsig()" class="btn btn-dark">+ añadir asignautra</button>
                <form style="display: none;" id="formAsig" action="añadirAsig" method="post" >
                    <div class="form-group">
                        <label for="nombre">Nombre: </label>
                        <input type="text" name="nombre" class="form-control"/>                  
                    </div>                       
                    <input type="text" name="carrera" value="${requestScope.carrera}" style="display: none;"/>                  
                    <div class="form-group">
                        <label for="curso">Curso: </label>
                        <input type="text" name="curso" class="form-control"/>                  
                    </div>
                    <div class="form-group">
                        <label for="cuatrimestre">Cuatrimestre: </label>
                        <input type="number" name="cuatrimestre" class="form-control"/>                   
                    </div>
                    <input type="submit" value="Enviar" class="btn btn-primary"/>       
                </form>
                <button id="cancelAsig" onclick="cancelAsig()" style="display: none;" class="btn btn-danger">Cancelar</button><br/>
            </div>
        </c:if>

        <hr/>

        <footer>
            <p> &copy; Yassin El Ghazouani Azzouzi 2020 </p>
        </footer>

        <script src="funciones/js1.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    </body>
</html>
