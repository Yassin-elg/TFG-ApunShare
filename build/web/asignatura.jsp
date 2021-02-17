<%-- 
    Document   : asignatura
    Created on : 13-oct-2020, 17:38:44
    Author     : Yassin
--%>

<%@page import="Modelo.Asignatura"%>
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


        <h2> ${requestScope.asignatura.getNombre()} </h2><br/>

        <c:if test="${sessionScope.login == true && requestScope.suscrito == false}">
            <a href="favoritos?asigID=${asignatura.getId_asig()}" onclick="AsigFav('${requestScope.asignatura.getNombre()}');">
                <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-star-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                <path d="M3.612 15.443c-.386.198-.824-.149-.746-.592l.83-4.73L.173 6.765c-.329-.314-.158-.888.283-.95l4.898-.696L7.538.792c.197-.39.73-.39.927 0l2.184 4.327 4.898.696c.441.062.612.636.283.95l-3.523 3.356.83 4.73c.078.443-.36.79-.746.592L8 13.187l-4.389 2.256z"/>
                </svg>
                Añadir a favoritos.
            </a>
        </c:if>

        <c:if test="${requestScope.suscrito == true}">
            <p>Esta asignatura pertenece a su lista de favoritos.</p>
        </c:if>

        <br/><br/><h4>Datos de la asignatura:</h4><br/>
        <table class="table table-striped table-sm col-lg-6 col-md-8">
            <thead class="thead-dark">
                <tr>
                    <th>CARRERA</th>
                    <th>CURSO</th>
                    <th style="text-align: center">CUATRIMESTRE</th>
                </tr>
            </thead>
            <tr>
                <td>${requestScope.asignatura.getCarrera()}</td>
                <td>${requestScope.asignatura.getCurso()}</td>
                <td style="text-align: center">${requestScope.asignatura.getCuatrimestre()}</td>
            </tr>
        </table><br/>

        <div class="container-fluid">
            <div class="row">
                <div class="col-sm-12 col-md-12 col-lg-6 col-xl-6">
                    <h3>Apuntes:</h3>

                    <c:forEach var="a" items="${requestScope.apuntes}">
                        <table class="table-borderless w-100">
                            <tr>
                                <td style="width: 60%">
                                    <a href="${a.enlace}" target="_blank">
                                        <svg width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-file-earmark-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4 0h5.5v1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5h1V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
                                        <path d="M9.5 3V0L14 4.5h-3A1.5 1.5 0 0 1 9.5 3z"/>
                                        <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                        </svg><br/>
                                        ${a.nombre}.pdf
                                    </a>
                                </td><br/>
                            <td style="width: 40%">
                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                    <a href="borrarPdf?idPdf=${a.id}" onclick="return confirmarBorrarPdf('${a.nombre}', '${requestScope.asignatura.getNombre()}');">
                                        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                        </svg>
                                    </a>
                                </c:if>
                            </td>
                            </tr><br/>
                        </table>
                    </c:forEach><br/>

                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#">1<span class="sr-only">(current)</span></a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                    <br/><h3>Exámenes</h3><br/>

                    <c:forEach var="a" items="${requestScope.examenes}">
                        <table class="table-borderless w-100">
                            <tr>
                                <td style="width: 60%"><a href="${a.enlace}" target="_blank">
                                        <svg width="3em" height="3em" viewBox="0 0 16 16" class="bi bi-file-earmark-text" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M4 0h5.5v1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5h1V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2z"/>
                                        <path d="M9.5 3V0L14 4.5h-3A1.5 1.5 0 0 1 9.5 3z"/>
                                        <path fill-rule="evenodd" d="M5 11.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5zm0-2a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5z"/>
                                        </svg><br/>
                                        ${a.nombre}.pdf
                                    </a>
                                </td><br/>
                            <td style="width: 40%">
                                <c:if test="${sessionScope.usuario.isAdmin()}">
                                    <a href="borrarPdf?idPdf=${a.id}" onclick="return confirmarBorrarPdf('${a.nombre}', '${requestScope.asignatura.getNombre()}');">
                                        <svg width="2em" height="2em" viewBox="0 0 16 16" class="bi bi-trash" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
                                        <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z"/>
                                        <path fill-rule="evenodd" d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z"/>
                                        </svg>
                                    </a>
                                </c:if>
                            </td>
                            </tr><br/>
                        </table>
                    </c:forEach><br/>

                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item disabled">
                                <a class="page-link" href="#" aria-label="Previous">
                                    <span aria-hidden="true">&laquo;</span>
                                </a>
                            </li>
                            <li class="page-item active" aria-current="page">
                                <a class="page-link" href="#">1<span class="sr-only">(current)</span></a>
                            </li>
                            <li class="page-item"><a class="page-link" href="#">2</a></li>
                            <li class="page-item"><a class="page-link" href="#">3</a></li>
                            <li class="page-item">
                                <a class="page-link" href="#" aria-label="Next">
                                    <span aria-hidden="true">&raquo;</span>
                                </a>
                            </li>
                        </ul>
                    </nav>

                </div>
                <div class="col-sm col-md  offset-xl-1">
                    <img src="images/subida-contenido.PNG" class="img-fluid" alt="Responsive image"/><br/><br/>

                    <c:if test="${sessionScope.login}">
                        <form action="subirContenido" onsubmit="return validarSubida();" method="post" enctype="multipart/form-data" class="col-xl-9" id="formSubida">
                            <label for="eleccionSubida">¿ Quieres subir un archivo o un enlace ? (Seleccione una opción) </label><br/>
                            <div class="form-check d-inline">
                                <input type="radio" name="eleccionSubida" value="Archivo" onchange="subidaArchivo()" class="form-check-input" id="radioArchivo"/>
                                <label class="form-check-label" for="eleccionSubida">
                                    Archivo
                                </label>
                            </div>
                            <div class="form-check d-inline">
                                <input type="radio" name="eleccionSubida" value="Enlace" onchange="subidaEnlace()" class="form-check-input" id="radioEnlace"/>
                                <label class="form-check-label" for="eleccionSubida">
                                    Enlace
                                </label>
                            </div>
                            <div class="form-group">
                                <span id="spanTipo" class="text-danger"></span>
                            </div>
                            <div class="form-group" id="archivo" style="display: none">
                                <label for="archivo">Archivo: </label>
                                <input type="file" name="archivo" class="form-control-file"/>
                                <span id="spanArchivo" class="text-danger"></span>
                            </div>
                            <div class="form-group" id="enlace" style="display: none">
                                <label for="enlace">Enlace: </label>
                                <input type="text" name="enlace" class="form-control form-control-sm" placeholder="Insertar enlace"/>
                                <span id="spanEnlace" class="text-danger"></span>
                            </div>                  
                            <div class="form-group">
                                <label for="nombre">Nombre: </label>
                                <input type="text" name="nombre"  class="form-control form-control-sm" placeholder="Insertar nombre"/>
                                <span id="spanNombre" class="text-danger"></span>
                            </div>
                            <div class="form-group">
                                <label for="tipo">Categoría:</label>
                                <select name="tipo">
                                    <option value='apuntes'>Apuntes</option>
                                    <option value='examen'>Examen</option>
                                </select>
                            </div>
                            <input type="text" name="asig" value="${requestScope.asignatura.getId_asig()}" style="display: none;"/>
                            <input type="submit" value="Enviar" onclick="return confirmarSubidaApuntes();" class="btn btn-dark"/>
                        </form>

                        <c:choose>
                            <c:when test="${requestScope.subido == null}">

                            </c:when>
                            <c:otherwise>
                                <c:choose>
                                    <c:when test="${requestScope.subido}">
                                        <p> Su archivo ha sido subido correctamente. </p>
                                    </c:when>
                                    <c:otherwise>
                                        <p> Error al subir el archivo. </p>
                                    </c:otherwise>
                                </c:choose>
                            </c:otherwise>
                        </c:choose>

                    </c:if>
                    <c:if test="${!sessionScope.login}">
                        <p>Regístrate e inicia sesión para tener poder subir tus apuntes.</p>
                    </c:if>

                </div>
            </div>
        </div><br/><br/><br/>

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
